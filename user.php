<?php
/**
 * Logic xu ly cua module thanh vien
 * Quyen user co 3 quyen
 * 1. useristrator: Co tat ca cac quyen
 * 2. manager-site: Quan ly user tren site
 * 3. user-site: Co quyen tren site (order)
 * 
 * I. Chuc nang list user: List tat ca user voi dieu kien check quyen user:
 * 		1. Neu la super-user: list tat ca user khac chinh no
 * 		1. Neu la user: Thi list ra tat ca user co id > 1 va khac no
 * 		2. Neu la manager-site: List tat ca user theo dieu kien site-id va khac no
 * 		3. Neu la user-site: Khong list duoc ra ban ghi nao
 */
$page = "user";
$page_title = "Quản trị thành viên";
include "header.php";

$task = PGRequest::getCmd('task', 'view');
if ($task=='cancel') $task='view';

$objAcl = new PGAcl();
if (!$objAcl->checkPermission($page, $task)) {
	$objAcl->showErrorPage($smarty);
}

switch ($task) {
	case "view":
		$page_title = "Quản trị thành viên";
		$filter_group = PGRequest::getInt('filter_group', 0, 'POST');
		$filter_status = PGRequest::getInt('filter_status', 0, 'POST');
		$search = strtolower( PGRequest::getString('search', '', 'POST') );
		
		$p = PGRequest::getInt('p', 1, 'POST');
		$limit = PGRequest::getInt('limit', $setting['setting_list_limit'], 'POST');
		
		$userId = $user->user_info['user_id'];
		
		if ($user->user_super) {
			$where[] = " user_id>1";
		}
		elseif ($user->user_info['user_group'] == 1) {
			$where[] = " user_id>1 AND user_group>1 AND user_id<>".$userId;
		}
		elseif ($user->user_info['user_group'] == 2) {
			$sql2 = "SELECT user_id FROM ".TBL_USER." WHERE user_created=".$userId;
			$results2 = $database->getCol($database->db_query($sql2));
			
			$result = array_unique(array_merge_recursive((array)$results1, (array)$results2));
			$struserId = (count($result)) ? join(",", $result) : 0;
			$where[] = " user_id>1 AND user_group>2 AND user_id IN(".$struserId.") AND user_id<>".$userId;
		}
		else {
			$where[] = " user_group>3";
		}
		
		//LOC THEO TU KHOA
		if ($search){
			$where[] = "(user_name LIKE '%".$search."%' OR user_email LIKE '%".$search."%' OR user_username LIKE '%".$search."%')";
		}
		//CHON TAT CA USER THEO GROUP
		if ($filter_group) {			
			$where[] = " user_group=".$filter_group;
		}
		//CHON TAT CA USER TRANG THAI KICH HOAT
		if ($filter_status) {			
			$where[] = " user_enabled=".($filter_status-1);
		}
		
		// BUILD THE WHERE CLAUSE OF THE CONTENT RECORD QUERY
		$where = (count($where) ? ' WHERE '.implode(' AND ', $where) : '');
		
		// GET THE TOTAL NUMBER OF RECORDS
		$query = "SELECT COUNT(*) AS total FROM ".TBL_USER." $where";
		$results = $database->db_fetch_assoc($database->db_query($query));
		
		// PHAN TRANG
		$pager = new pager($limit, $results['total'], $p);
		$offset = $pager->offset;
		
		// LAY DANH SACH CHI TIET
		$query = "SELECT * FROM ".TBL_USER." $where LIMIT $offset, $limit";
		$results = $database->db_query($query);
		
		//ARRAY GROUP USERS
		$objAcl = new PGAcl();
		$arrGroup = $objAcl->apl;
		$arrPermiss = $objAcl->atl;
		
		$arySiteId = $user->get_list_sites();
		while ($row = $database->db_fetch_assoc($results)){
			$row['user_registerDate'] = $datetime->datetimeDisplay($row['user_registerDate']);
			$row['user_lastvisitDate']	= $datetime->datetimeDisplay($row['user_lastvisitDate']);
			$row['user_user_group'] = $row['user_group'];
			$row['user_group']	= $arrGroup[$row['user_group']];
			$row['user_site'] = array();
			if ($row['user_access']) {
				$aryAccess = unserialize($row['user_access']);
				
				$pageAccess = array();
				foreach ($aryAccess as $key=>$access) {
					if (count($access) && is_array($access)) {
						foreach ($access as $kp=>$perm) {
							$pageAccess[$key][$kp] = $arrPermiss[$perm];
						}
						$pageAccess[$key] = join(", ", $pageAccess[$key]);
					}
				}
				$row['user_access'] = $pageAccess;
			}
			foreach ($arySiteId as $keyS=>$itemS) {
				if ($row['user_id'] == $itemS['user_id']) {
					$row['user_site'][] = $itemS['site_name'];
				}
			}
			$users[] = $row;
		}

		if (isset($users)) $smarty->assign('users', $users);
		$smarty->assign('totalRecords', $results['total']);
		$smarty->assign('filter_status', $filter_status);
		$smarty->assign('filter_group', $filter_group);
		$smarty->assign('search', $search);
		$smarty->assign('arrGroup', $arrGroup);
		$smarty->assign('datapage', $pager->page_link());
		$smarty->assign('p', $p);
		break;
		
	case "add":
		$page_title = "Thêm mới thành viên";
		
		//ARRAY GROUP USERS
		$objAcl = new PGAcl();
		$arrGroup = $objAcl->apl;
		$arrPermiss = $objAcl->atl;
		$pages = $objAcl->pages;
		
		$userAccess = ($user->user_info['user_access']) ? unserialize($user->user_info['user_access']) : array();
		
		$ajax = PGRequest::getInt('ajax', 0);
		if ($ajax) {
			$aryInput['user_name'] = PGRequest::getVar('user_name', '', 'POST');
			$aryInput['user_email'] = PGRequest::getVar('user_email', '', 'POST');
			$aryInput['user_username'] = PGRequest::getVar('user_username', '', 'POST');
			$aryInput['user_password'] = PGRequest::getVar('user_password', '', 'POST');
			$aryInput['user_group'] = PGRequest::getInt('cbo_group', 0, 'POST');
			$aryInput['user_site'] = PGRequest::getVar('cbo_site', '', 'POST');
			
			$pageAccess = array();
			foreach ($pages as $key1=>$ps1) {
				$pageAccess[$key1] = PGRequest::getVar($key1, '', 'POST');
			}
			
			$aryOutput = array();
			$aryOutput['intOK'] = 1;
			
			//THUC HIEN CHECK THONG TIN INPUT
			$user->check_user_input($aryInput);
			
			if (!$user->is_error) {
				$username = $aryInput['user_username'];
				$password = $aryInput['user_password'];
				$name = $database->db_real_escape_string($aryInput['user_name']);
				$email = $aryInput['user_email'];
				$password = $aryInput['user_password'];
				$group = $aryInput['user_group'];
				
				$access = (count($pageAccess)) ? serialize($pageAccess) : '';
				if ($group == 1) $access = '';
				
		    	if (!$user->user_create($username, $password, $name, $email, $group, $access)) {
		    		$aryOutput['strError'] = "Lỗi hệ thống";
		    		$aryOutput['intOK'] = 0;
		    	}
		    	else {
		    		if ($group > 1) {
		    			$userId = $database->db_insert_id();
		    			$user->insertuserSite($userId, $aryInput['user_site']);
		    		}
		    	}
		  	}
		  	else {
		  		$aryOutput['strError'] = (is_array($user->is_error))?join("<br>", $user->is_error):"";
		  		$aryOutput['intOK'] = 0;
		  	}
		  	echo json_encode($aryOutput);
			exit();
		}
		
		$aryPages = array();
		foreach ($pages as $key1=>$ps1) {
			foreach ($ps1 as $key2=>$ps2) {
				$aryPages[$key1][$ps2] = $arrPermiss[$ps2];
			}
		}
	
		$smarty->assign('arrGroup', $arrGroup);
		$smarty->assign('userInfo', $user->user_info);
		$smarty->assign('arrPermiss', $arrPermiss);
		$smarty->assign('userAccess', $userAccess);
		$smarty->assign('aryPages', $aryPages);
		
		break;
		
	case "edit":
		$page_title = "Sửa thông tin thành viên";
		
		//ARRAY GROUP USERS
		$objAcl = new PGAcl();
		$arrGroup = $objAcl->apl;
		$arrPermiss = $objAcl->atl;
		$pages = $objAcl->pages;

		$userId = PGRequest::getInt('id', 0);
		$ajax = PGRequest::getInt('ajax', 0);
		
		$userEdit = new PGuser($userId);

		$query = "SELECT * FROM ".TBL_USER." WHERE user_id>1 AND user_id=".$userId;
		if ($user->user_info['user_group'] > 1) {
			$query .= " AND user_group>".$user->user_info['user_group'];
		}
		$aryuser = $database->getRow($database->db_query($query));
		
		if (!$aryuser) cheader($uri->base().'user_users.php');

		if ($userId) {
			$arySiteId = $database->getCol($database->db_query("SELECT site_id FROM ".TBL_USER_SITE." WHERE user_id=".$userId));
		}

		$aryAccess = array();
		if ($aryuser['user_access']) {
			$aryAccess = unserialize($aryuser['user_access']);
		}

		if ($ajax) {
			$aryInput['user_id'] = $userId;
			$aryInput['user_name'] = PGRequest::getVar('user_name', '', 'POST');
			$aryInput['user_email'] = PGRequest::getVar('user_email', '', 'POST');
			$aryInput['user_username'] = PGRequest::getVar('user_username', '', 'POST');
			$aryInput['user_password'] = PGRequest::getVar('user_password', '', 'POST');
			$aryInput['user_group'] = PGRequest::getInt('cbo_group', 0, 'POST');
			$aryInput['user_enabled'] = PGRequest::getInt('user_enabled', 0, 'POST');
			$aryInput['user_site'] = PGRequest::getVar('cbo_site', '', 'POST');
			
			$pageAccess = array();
			foreach ($pages as $key1=>$ps1) {
				$pageAccess[$key1] = PGRequest::getVar($key1, '', 'POST');
			}
			$aryInput['user_access'] = (count($pageAccess)) ? serialize($pageAccess) : '';
			if ($aryInput['user_group'] == 1) $aryInput['user_access'] = '';
			
			$aryOutput = array();
			$aryOutput['intOK'] = 1;
			
			//THUC HIEN CHECK THONG TIN INPUT
			$userEdit->check_user_input($aryInput, true);
			
			if (!$userEdit->is_error) {
		    	if (!$userEdit->update_user($aryInput)) {
		    		$aryOutput['strError'] = "Lỗi hệ thống";
		    		$aryOutput['intOK'] = 0;
		    	}
		    	else {
					if ( $aryInput['user_site'] )
	    				$userEdit->insertuserSite($userId, $aryInput['user_site'], $aryInput['user_group']);
		    	}
		  	}
		  	else {
		  		$aryOutput['strError'] = (is_array($userEdit->is_error))?join("<br>", $userEdit->is_error):"";
		  		$aryOutput['intOK'] = 0;
		  	}
		  	
		  	echo json_encode($aryOutput);
			exit();
		}
		
		$aryPages = array();
		foreach ($pages as $key1=>$ps1) {
			foreach ($ps1 as $key2=>$ps2) {
				$aryPages[$key1][$ps2] = $arrPermiss[$ps2];
			}
		}
		$userAccess = ($user->user_info['user_access']) ? unserialize($user->user_info['user_access']) : array();
		$smarty->assign('userAccess', $userAccess);
		$smarty->assign('arrGroup', $arrGroup);
		$smarty->assign('arySiteId', $arySiteId);
		$smarty->assign('aryAccess', $aryAccess);
		$smarty->assign('arrPermiss', $arrPermiss);
		$smarty->assign('userId', $userId);
		$smarty->assign('users', $aryuser);
		$smarty->assign('aryPages', $aryPages);
		$smarty->assign('userInfo', $user->user_info);
		break;

	case "remove":
		$cid = PGRequest::getVar( 'cid', array(), 'post', 'array' );
		if (count($cid)) {
		  	$database->db_query("DELETE FROM ".TBL_USER." WHERE user_id IN(".implode(",", $cid).")");
		  	$database->db_query("DELETE FROM ".TBL_USER_SITE." WHERE user_id IN(".implode(",", $cid).")");
		}
		cheader($uri->base().'user_user.php');
		
		break;
	
	case "delcache":
		memcacheLib::clear();
		cheader($_SERVER['HTTP_REFERER']);
		break;

    case "change_group":
        $group_id = PGRequest::getVar('group_id', '', 'POST');
        $userId = PGRequest::getInt('user_id', 0);
        $objAcl = new PGAcl();
        $arrGroup = $objAcl->apl;
        $arrPermiss = $objAcl->atl;
        $pages = array();
        $userInfo = $user->user_info;

        $group_pages_default = $objAcl->group_manager_site_pages;
        if ( $group_id ){
            if ( $group_id == 2 ) // Manager School
                $pages = $objAcl->group_manager_site_pages;
            else if ( $group_id == 3 ) // User School
                $pages = $objAcl->group_user_site_pages;
            else if ( $group_id == 4 ) // All School
                $pages = $objAcl->group_manager_all_site_pages;
            else if ( $group_id == 5 ) // Sale Manager
                $pages = $objAcl->group_manager_sale_pages;
            else if ( $group_id == 6 ) // Sale
                $pages = $objAcl->group_sale_pages;
            else if ( $group_id == 7 ) // Reconciliation
                $pages = $objAcl->group_reconciliation_pages;
            else if ( $group_id == 8 ) // Support
                $pages = $objAcl->group_support_pages;
            else if ( $group_id == 9 ) // Translator
                $pages = $objAcl->group_translator_pages;
            else
                $pages = $objAcl->group_translator_pages;

        }

        $aryPages = array();//Conver type acl
        foreach ($pages as $key1=>$ps1) {
            foreach ($ps1 as $key2=>$ps2) {
                $aryPages[$key1][$ps2] = $arrPermiss[$ps2];
            }
        }

        $userAccess = array();
        $aryAccess = array();
        if($userId) {
            $userAccess = ($user->user_info['user_access']) ? unserialize($user->user_info['user_access']) : array();
            $query = "SELECT * FROM " . TBL_USER . " WHERE user_id>1 AND user_id=" . $userId;
            if ($user->user_info['user_group'] > 1) {
                $query .= " AND user_group>" . $user->user_info['user_group'];
            }
            $aryuser = $database->getRow($database->db_query($query));
            if (!$aryuser) cheader($uri->base() . 'user_users.php');
            $aryAccess = array();
            if ($aryuser['user_access']) {
                $aryAccess = unserialize($aryuser['user_access']);
            }
        }

        $group_pages = $objAcl->group_pages;
        $html = get_pages_by_group_id($group_id,$userInfo,$aryPages,$userAccess,$aryAccess);
        if($html){
            $request['status'] = true;
            $request['html'] = $html;
        }else{
            $request['status'] = false;
            $request['html'] = '';
        }
        echo json_encode($request);
        exit();
        break;
}

function get_pages_by_group_id($group_id=null,$userInfo,$aryPages,$userAccess,$aryAccess){
    $html = '';
    if(count($aryPages)&&$group_id) {
        foreach ($aryPages as $kp => $pages) {
            $html .= '<b>' . $kp . '</b><br>';
            foreach ($pages as $kp1 => $access) {
                $html .= '<label style="font-size: 13px;" for="' . $kp . '_' . $kp1 . '">';
                if ($userInfo . user_group > 1) {
                    foreach ($userAccess as $kp2 => $access2) {
                        if ($kp == $kp2) {
                            foreach ($access2 as $kp3 => $access3) {
                                if ($access3 == $kp1) {
                                    $html .= '<span class="lbl">' . $access . '</span>&nbsp;&nbsp;';
                                    $html .= '<input type="checkbox" value="' . $kp1 . '" name="' . $kp . '[]" id="' . $kp . '_' . $kp1 . '"';
                                    foreach ($aryAccess[$kp] as $kp2 => $access2) {
                                        if ($access2 == $kp1) {
                                            $html .= 'checked';
                                        }
                                    }
                                }
                            }
                        }
                    }
                } else {
                    $html .= '<span class="lbl">' . $access . '</span>&nbsp;&nbsp;';
                    $html .= '<input type="checkbox" value="' . $kp1 . '" name="' . $kp . '[]" id="' . $kp . '_' . $kp1 . '"';
                    foreach ($aryAccess[$kp] as $kp2 => $access2) {
                        if ($access2 == $kp1) {
                            $html .= 'checked';
                        }
                    }
                }
                $html .= '></label> &nbsp;';
            }
            $html .= '<br><br>';
        }
    }else{
        $html = '<h4>Chưa tồn tại quyền cho nhóm này!</h4>';
    }
    return $html;
}

$smarty->assign('sites', $sites);

if ($task == 'view') {	
	$toolbar = createToolbarAce('add','remove');
}
elseif ($task == 'edit' || $task == 'add') {
	$toolbar = createToolbarAce('save','cancel');
}

include "footer.php";
?>