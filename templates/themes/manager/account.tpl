{include file='header.tpl'}
{if $errorTxt}
	<fieldset class="userform">
		<legend>
		{if $errFlag} Xảy ra lỗi sau {else} Thông báo{/if}</legend>
		<table class="usertable" width="100%">
			<tr>
				<td><font color="Red">{$errorTxt}</font></td>
			</tr>
		</table>
	</fieldset>
{/if}
<div class="row">
	<div class="col-xs-12">
		<form class="form-horizontal" role="form" action="{$page}.php" method="post" name="userForm" id="userForm">
			<div class="row">
				<div class="tabbable">
					<div class="row">
						<div class="col-xs-5">
							<div class="widget-box">
								<div class="widget-header">
									<h4>Sửa thông tin cá nhân</h4>
								</div>
								<div class="widget-body">
									<div class="widget-body-inner">
										<div class="widget-main">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-fullname"> Họ và tên </label>
												<div class="col-sm-9">
													<input type="text" name="user_name" id="user_name" value="{$users.user_name|escape:'html'}" placeholder="Họ và tên" class="col-xs-12">
												</div>
											</div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-fullname"> Avatar </label>
												<div class="col-sm-9 avatar_home_user">
													{*<div class="image_preview_camera"><i class="icon-camera"></i></div>*}
													<img class="my_avatar my_avatar_event" data-toggle="modal" data-target="#myModal" src="{$avatar_arr.user_avatar_url_crop}" width="150" height="150" style="cursor: pointer;"/>
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-email"> Địa chỉ Email</label>
												<div class="col-sm-9">
													<input type="text" name="user_email" id="user_email" value="{$users.user_email|escape:'html'}" class="col-xs-12" placeholder="Địa chỉ email">
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-username"> Tên đăng nhập</label>
												<div class="col-sm-9">
													{$users.user_username|escape:'html'}
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-username"> Nhóm</label>
												<div class="col-sm-9">
													{$users.user_group|escape:'html'}
												</div>
											</div>
											{if $users.user_group > 1}
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-username"> Quyền hạn</label>
												<div class="col-sm-9">
													{$users.user_access}
												</div>
											</div>
											{/if}
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-username"> Ngày đăng ký</label>
												<div class="col-sm-9">
													{$users.user_registerDate}
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-username"> Lần truy cập cuối</label>
												<div class="col-sm-9">
													{$users.user_lastvisitDate}
												</div>
											</div>
											<input type="hidden" name="user_group" value="{$users.user_group}">
											<input type="hidden" name="user_username" value="{$users.user_username}">
											<input type="hidden" name="user_registerDate" value="{$users.user_registerDate}">
											<input type="hidden" name="user_lastvisitDate" value="{$users.user_lastvisitDate}">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-xs-5">
							<div class="widget-box">
								<div class="widget-header">
									<h4>Thay đổi mật khẩu</h4>
								</div>
								<div class="widget-body">
									<div class="widget-body-inner" style="display: block;">
										<div class="widget-main">
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-password"> Nhập mật khẩu cũ</label>
												<div class="col-sm-9">
													<input type="password" name="user_password_old" id="user_password_old" value="{$users.user_password_old}" class="col-xs-12">
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-password"> Nhập mật khẩu mới</label>
												<div class="col-sm-9">
													<input type="password" name="user_password_new" id="user_password_new" value="{$users.user_password_new}" class="col-xs-12">
												</div>
											</div>
											<div class="space-4"></div>
											<div class="form-group">
												<label class="col-sm-3 control-label no-padding-right" for="form-field-password"> Nhập lại mật khẩu mới</label>
												<div class="col-sm-9">
													<input type="password" name="user_password_conf" id="user_password_conf" value="{$users.user_password_conf}" class="col-xs-12">
												</div>
											</div>
											<div class="space-4"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		   	<input type="hidden" value="{$task}" name="task">
			<input type="hidden" value="{$userId}" name="userId" id="userId">
		</form>
	</div>
</div>



{include file='footer.tpl'}