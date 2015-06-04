<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="member.*"%>

<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>BIROAD</title>

<!-- Bootstrap -->
<link href="../bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>

	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<h2>회원정보수정</h2>
					</div>
					<div class="col-md-3"></div>
				</div>
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<u><a href=admin_main.jsp?mode=1%context=1>되돌아가기</a></u>
					</div>
					<div class="col-md-3"></div>
				</div>
				<jsp:useBean id="member" scope="request" class="member.Member" />

				<form name=form1 method=post action=biroad_control.jsp>
					<input type=hidden name="memberId" value="<%=member.getMemberId()%>"> <input type=hidden name="action" value="mupdate">
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">
								</span>
								<div class="col-sm-10">
									<p class="form-control-static">
										<%=member.getMemberId()%></p>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">
								</span> <input value="<%=member.getMemberPass()%>" type="password" name="memberPass" class="form-control input-lg" placeholder="Password"
									autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/name.png" width="15" height="15">
								</span> <input value="<%=member.getMemberName()%>" type="text" name="memberName" class="form-control input-lg" placeholder="홍길동" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/email.png" width="15" height="15">
								</span> <input value="<%=member.getMemberEmail()%>" type="text" name="memberEmail" class="form-control input-lg" placeholder="xxx.google.com"
									autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/gender.png" width="15" height="15">
								</span> <input value="<%=member.getMemberGender()%>" type="text" name="memberGender" class="form-control input-lg" placeholder="남 or 여"
									autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/bicycle.png" width="15" height="15">
								</span> <input value="<%=member.getModel()%>" type="text" name="model" class="form-control input-lg" placeholder="MTB" autocomplete="off"> <input
									type=hidden name="isManager">
							</div>
						</div>
					</div>
					<div class="form-group formSubmit">
						<div class="col-sm-2"></div>
						<div class="col-sm-3">
							<input class="btn btn-primary btn-lg" type="reset" value="취소">
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-3">
							<input onclick="writeCheck()" class="btn btn-primary btn-lg" type="button" value="저장">
						</div>
						<div class="col-sm-2"></div>
					</div>

					<script type="text/javascript">
						function writeCheck() {
							var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

							if (document.form1.memberPass.value == "") {
								alert("비밀번호를 입력하세요");
								document.form1.memberPass.focus();
								return;

							} else if (document.form1.memberName.value == "") {
								alert("이름을 입력하세요");
								document.form2.memberName.focus();
								return;
							} else if (exptext
									.test(document.form1.memberEmail.value) == false) {
								alert("이메일 형식이 올바르지 않습니다.");
								document.form1.memberEmail.focus();
								exit;
							}
							if (document.form1.memberGender.value != "남"
									&& document.form1.memberGender.value != "여") {
								alert("성별 형식이 올바르지 않습니다.");
								document.form1.memberGender.focus();
								return;
							}
							document.form1.submit();
						}
					</script>
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

</body>
</html>