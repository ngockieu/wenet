<?php
$page = "account";
include "header.php";

$task = PGRequest::getCmd('task', 'view');
$page_title = "Thông tin tài khoản";
if ($task=='cancel') $task='view';

$objAcl = new PGAcl();
if (!$objAcl->checkPermission($page, $task)) {
	$objAcl->showErrorPage($smarty);
}

switch ($task) {
	case "view":
	case "save":
		
		$errFlag = 0;
		$query = "SELECT * FROM ".TBL_USER." WHERE user_id=".$user->user_info['user_id'];
		$aryUser = $database->getRow($database->db_query($query));
		
		// DANH SACH QUYEN ADMIN
		$objAcl = new PGAcl();
		$arrGroup = $objAcl->apl;
		$arrPermiss = $objAcl->atl;
		
		$aryUser['user_registerDate'] = $datetime->datetimeDisplay($aryUser['user_registerDate']);
		$aryUser['user_lastvisitDate']	= $datetime->datetimeDisplay($aryUser['user_lastvisitDate']);
		$aryUser['user_group']	= $arrGroup[$aryUser['user_group']];
		if ($aryUser['user_access']) {
			foreach ($arrPermiss as $key=>$perm) {
				$aryUser['user_access'] = str_replace((string)$key, $perm, $aryUser['user_access']);
			}
		}
		
		$userId = PGRequest::getInt('userId', 0, 'POST');
		if ($userId) {
			$aryInput['user_name'] = PGRequest::getVar('user_name', '', 'POST');
			$aryInput['user_email'] = PGRequest::getVar('user_email', '', 'POST');
			$aryInput['user_password_old'] = PGRequest::getVar('user_password_old', '', 'POST');
			$aryInput['user_password_new'] = PGRequest::getVar('user_password_new', '', 'POST');
			$aryInput['user_password_conf'] = PGRequest::getVar('user_password_conf', '', 'POST');
			$aryInput['user_group'] = PGRequest::getVar('user_group', '', 'POST');
			$aryInput['user_username'] = PGRequest::getVar('user_username', '', 'POST');
			$aryInput['user_registerDate'] = PGRequest::getVar('user_registerDate', '', 'POST');
			$aryInput['user_lastvisitDate'] = PGRequest::getVar('user_lastvisitDate', '', 'POST');
			
			//THUC HIEN CHECK THONG TIN INPUT
			$user->check_account_input($aryInput);
			
			if (!$user->is_error) {
				$name = $database->db_real_escape_string($aryInput['user_name']);
				$email = $database->db_real_escape_string($aryInput['user_email']);
				$password = $aryInput['user_password_new'];
				
		    	if (!$user->user_edit($username, $password, $name, $email)) {
		    		$errFlag = 1;
		    		$errorTxt = "Lỗi hệ thống !";
		    	}
		    	else {
		    		$errorTxt = "Sửa thành công. Bạn cần đăng nhập lại để cập nhật được thông tin của mình";
		    	}
		  	}
		  	else {
		    	$errFlag = 1;
		  		$errorTxt = (is_array($user->is_error))?join("<br>", $user->is_error):"";
		  	}
		}else{
			$errorTxt = "";
		}
		if ($errFlag) $aryUser = $aryInput;
		else $aryUser = $aryUser;
		$smarty->assign('users', $aryUser);
		$smarty->assign('userId', $user->user_info['user_id']);
		break;
}

$smarty->assign('errorTxt', $errorTxt);
$smarty->assign('errFlag', $errFlag);

$toolbar = createToolbarAce('save');

include "footer.php";
?>