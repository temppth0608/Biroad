<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>BIROAD</title>

<!-- Bootstrap -->
<link href="../bootstrap/css/bootstrap.css" rel="stylesheet">
<link href="style.css" rel="stylesheet">

</head>
<body>
	<div id="mainWrap">
		<div id="loggit">
			<h1>
				<i class="fa fa-lock"> </i> <img src="../image/lock_icon.png" width="30" height="35">&nbsp Login
			</h1>
			<h3>
				"Please " <strong>Login</strong> " or " <strong>Register</strong>
			</h3>

			<!-- 로그인폼 -->
			<form action="biroad_control.jsp" name="form1" id="logForm" method="post" class="form-horizontal" style="display: block;">
				<input type=hidden name="action" value="login">
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">
							</span> <input type="text" name="memberId" class="form-control input-lg" placeholder="ID" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">
							</span> <input type="password" name="memberPass" class="form-control input-lg" placeholder="Password" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group formSubmit">
					<div class="register_login">
						<div class="login">
							<div class="col-xs-4"></div>
							<div class="col-xs-4">
								<input onclick="checkfield1()" type="button" class="btn btn-primary btn-lg" value="&nbsp Login &nbsp">
							</div>
							<div class="col-xs-4"></div>
						</div>
					</div>
				</div>
				<div class="form-group formNotice">
					<div class="col-xs-12">
						<p class="text-center">
							"Don't have an account? " <span>Register now</span>
					</div>
				</div>
			</form>
			<!-- 회원가입폼 -->
			<form action="biroad_control.jsp" name="form2" id="regForm" method="post" class="form-horizontal" style="display: none;">
				<input type=hidden name="action" value="register">
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">
							</span> <input type="text" name="memberId" class="form-control input-lg" placeholder="ID" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">
							</span> <input type="password" name="memberPass" class="form-control input-lg" placeholder="Password" autocomplete="off">
						</div>

					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/name.png" width="15" height="15">
							</span> <input type="text" name="memberName" class="form-control input-lg" placeholder="홍길동" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/email.png" width="15" height="15">
							</span> <input type="text" name="memberEmail" class="form-control input-lg" placeholder="xxx.google.com" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/gender.png" width="15" height="15">
							</span> <input type="text" name="memberGender" class="form-control input-lg" placeholder="남 or 여" autocomplete="off">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/bicycle.png" width="15" height="15">
							</span> <input type="text" name="model" class="form-control input-lg" placeholder="MTB" autocomplete="off"> <input type=hidden
								name="isManager">
						</div>
					</div>
				</div>
				<div class="form-group formSubmit">
					<div class="col-sm-2"></div>
					<div class="col-sm-3">
						<a href="index.jsp" class="btn btn-primary btn-lg">Cancel</a>
					</div>
					<div class="col-sm-2"></div>
					<div class="col-sm-3 sumitWrap">
						<input onclick="checkfield2()" type="button" class="btn btn-primary btn-lg" value="Register">
					</div>
					<div class="col-sm-2"></div>
					<div class="form-group formNotice">
						<div class="col-xs-12">
							<p class="hasAccount text-center">
								"Already have an account? " <span>Log in here</span>
							</p>
						</div>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

	<script type="text/javascript">
		function checkfield1() {
			if (document.form1.memberId.value == "") {
				alert("아이디를 입력하세요");
				document.form1.memberId.focus();
				return;
			} else if (document.form1.memberPass.value == "") {
				alert("비밀번호를 입력하세요");
				document.form1.memberPass.focus();
				return;
			}
			document.form1.submit();
		}

		function checkfield2() {
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

			if (document.form2.memberId.value == "") {
				alert("아이디를 입력하세요");
				document.form2.memberId.focus();
				return;
			} else if (document.form2.memberPass.value == "") {
				alert("비밀번호를 입력하세요");
				document.form2.memberPass.focus();
				return;

			} else if (document.form2.memberName.value == "") {
				alert("이름을 입력하세요");
				document.form2.memberName.focus();
				return;
			} else if (exptext.test(document.form2.memberEmail.value) == false) {
				alert("이메일 형식이 올바르지 않습니다.");
				document.form2.memberEmail.focus();
				return;
			}

			if (document.form2.memberGender.value != "남"
					&& document.form2.memberGender.value != "여") {
				alert("성별 형식이 올바르지 않습니다.");
				document.form2.memberGender.focus();
				return;
			}
			document.form2.submit();
		}

		$(document).ready(function() {
			$('.formNotice span').click(function() {
				$("#logForm").toggle();
				$("#regForm").toggle();
			});
		});
	</script>
</html>