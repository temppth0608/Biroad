<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.sql.*,member.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
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
<link href="style2.css" rel="stylesheet">

<jsp:useBean id="Member" class="member.Member" />

<%
	Member mem = (Member) session.getAttribute("member");
	String memId = (String) request.getAttribute("member");
	String boardRoad = (String) request.getAttribute("boardRoad");
	String fileName = (String) request.getAttribute("fileName");
	
	DecimalFormat df = new DecimalFormat("00");
	Calendar currentCalendar = Calendar.getInstance();
	String strYear = Integer.toString(currentCalendar
			.get(Calendar.YEAR));
	String strMonth = df
			.format(currentCalendar.get(Calendar.MONTH) + 1);
	String strDay = df.format(currentCalendar.get(Calendar.DATE));
	String strDate = strYear + "-" + strMonth + "-" + strDay;
%>

</head>
<body>
	<div class="header" id="header">
		<div class="container">
			<div class="header-logo">
				<h1>BI ROAD</h1>
			</div>
			<div class="top-nav">
				<span class="menu"><img src="../image/menu-icon.png" alt="" /></span>
				<ul class="nav1">
					<li><a href="main.jsp">도로검색</a></li>
					<li><a href="#">도로추천</a></li>
					<li><a href="bistory.jsp">BI STORY</a></li>
					<li><a href="inform.jsp">서비스소개</a></li>
				</ul>
				<!-- script-for-menu -->
				<script>
					$("span.menu").click(function() {
						$("ul.nav1").slideToggle(300, function() {
							// Animation complete.
						});
					});
				</script>
				<!-- /script-for-menu -->
			</div>

			<!-- login button event(Modal) -->
			<div class="social-icons">
				<button type="button" class="btn btn-default btn-xs" data-toggle="modal" data-target="#myModal">
					<section>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>&nbsp
						<%=mem.getMemberId() + "님"%>
					</section>
				</button>

				<!-- Modal -->
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="my-content">
							<div id="loggit">
								<h1>
									<i class="fa fa-lock"> </i> <img src="../image/lock_icon.png" width="30" height="35">&nbsp My Page
								</h1>
								<h3>
									<strong>Logout</strong> " or " <strong>Edit</strong>
								</h3>
								<div class="row">
									<div class="col-md-2"></div>
									<div class="col-md-3">
										<form action="biroad_control.jsp" id="logout" method="post" class="form-horizontal" style="display: block;">
											<input type=hidden name="action" value="logout">
											<div class="form-group formSubmit">
												<div class="register_login">
													<div class="login">
														<button type="submit" class="btn btn-primary btn-lg">Logout</button>
													</div>
												</div>
											</div>
										</form>
									</div>
									<div class="col-md-2"></div>
									<div class="col-md-3">

										<input type=hidden name="action" value="edit">
										<div class="form-group formSubmit">
											<div class="register_login">
												<div class="login">
													<button type="submit" class="btn btn-primary btn-lg">Edit &nbsp</button>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-2"></div>

									<div class="form-group formNotice">
										<div class="col-xs-6 col-xs-offset-6">
											<h5 class="text-center">
												<span>Withdrawal from membership</span>
											</h5>
										</div>
									</div>
								</div>

								<form action="biroad_control.jsp" name=form2 id="regForm" method="post" class="form-horizontal" style="display: none;">
									<input type=hidden name="action" value="edit">
									<div class="form-group">
										<div class="col-xs-12">
											<div class=input-group>
												<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">
												</span>
												<div class="col-sm-10">
													<p class="form-control-static">
														<input type=hidden name="memberId" value="<%=mem.getMemberId()%>">
														<%=mem.getMemberId()%></p>
												</div>
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
											<a href="main.jsp" class="btn btn-primary btn-lg">Cancel</a>
										</div>
										<div class="col-sm-2"></div>
										<div class="col-sm-3">
											<input onclick="checkfield2()" type="button" class="btn btn-primary btn-lg" value="Edit">
										</div>
										<div class="col-sm-2"></div>
									</div>
								</form>

								<!-- with form -->
								<form action="biroad_control.jsp" id="withForm" method="post" class="form-horizontal" style="display: none;">
									<input type=hidden name="action" value="withdrawal"> <input type=hidden name="memberId" value="<%=mem.getMemberId()%>">
									<div class="form-group">
										<div class="col-xs-12">
											<div class=input-group>
												<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">
												</span> <input type="password" name="memberPass" class="form-control input-lg" placeholder="Password" autocomplete="off">
											</div>
										</div>
									</div>
									<div class="form-group formSubmit">
										<div class="col-xs-4"></div>
										<div class="col-xs-4">
											<button type="submit" class="btn btn-danger btn-lg">&nbsp 탈퇴 &nbsp</button>
										</div>
										<div class="col-xs-4"></div>
									</div>
								</form>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="clearfix"></div>
	</div>

	<div class="writeForm">
		<div class="header_name">
			<br>
			<h2>&nbsp &nbsp &nbsp BI STORY FORUM</h2>
		</div>
		<div class="container">
			<div class="formStruct">
				<div class="container">
					<form name="fileForm" name="action" id="fileForm" method="POST" action="fileUpload.jsp" enctype="multipart/form-data">
					<input type=hidden name="action" value="upload1" >
						<div class="row">
							<div class="col-md-1">
								<h5>사진올리기</h5>
							</div>
							<div class="col-md-6">
								<input type="hidden" value="newFile" name="title" id="title"> 
								<input type=hidden name="boardMemb" value="<%=memId%>"> 
								<input type=hidden name="boardRoad" value="<%=boardRoad%>"> 
								<input type="file" name="uploadFile" id="uploadFile"> 
								<input type="submit" value="등록" class="btn btn-danger">
							</div>
							<div class="col-md-5"></div>
						</div>
					</form>
					<br>

					<form action="biroad_control.jsp" name=form3 id="writeForm" method="POST" class="form-horizontal">
						<input type=hidden name="action" value="writeBoard">
						<div class="row">

							<input type=hidden name="boardRoad" value="<%=boardRoad%>"> 
							<input type=hidden name="image" value="<%=fileName%>">
							<div class="col-md-1 ">
								<h5>Category</h5>
							</div>
							<div class="col-md-6">
								<h5><%=boardRoad%></h5>
							</div>
							<div class="col-md-5"></div>
						</div>
						<br>
						<div class="row">
							<input type=hidden name="boardMemb" value="<%=memId%>">
							<div class="col-md-1">
								<h5>글쓴이</h5>
							</div>
							<div class="col-md-6">
								<h5><%=memId%></h5>
							</div>
							<div class="col-md-5"></div>
						</div>
						<br>
						<div class="row">
							<input type=hidden name="boardDate" value="<%=strDate%>">
							<div class="col-md-1">
								<h5>날짜</h5>
							</div>
							<div class="col-md-6">
								<h5><%=strDate%></h5>
							</div>
							<div class="col-md-5"></div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<h5>제목</h5>
							</div>
							<div class="col-md-6">
								<input type="text" name="boardTitle" class="form-control" placeholder="제목을 입력하세요." autocomplete="off">
							</div>
							<div class="col-md-5"></div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1">
								<h5>비밀번호</h5>
							</div>
							<div class="col-md-6">
								<input type="password" name="boardPass"placeholder="비밀번호를 입력하세요." class="form-control">
							</div>
							<div class="col-md-5"></div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-10 col-md-offset-1">
								<textarea class="form-control" name="boardText" placeholder="내용을 입력하세요." rows="10"></textarea>
							</div>
							<div class="col-md-1"></div>
						</div>
						<br>
						<div class="row">
							<div class="col-md-1"></div>
							<div class="col-md-8"></div>
							<div class="col-md-1">
								<a href="bistory.jsp" class="btn btn-primary">취소</a>
							</div>
							<div class="col-md-1">
								<input onclick="writeCheck()" type="button" class="btn btn-primary" value="등록">
							</div>
							<div class="col-md-1"></div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
		function writeCheck() {
			if(document.form3.boardTitle.value == "") {
				alert("제목을 입력해주세요");
				document.form3.boardTitle.focus();
				return;
			}else if(document.form3.boardPass.value == "") {
				alert("비밀번호를 입력해주세요");
				document.form3.boardPass.focus();
				return;
			}
			document.form3.submit();
		}
	
		function checkfield2() {
			var exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

			if (document.form2.memberPass.value == "") {
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
				exit;
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
			$('.formSubmit button').click(function() {
				$("#logForm").toggle();
				$("#regForm").toggle();
			});
		});

		$(document).ready(function() {
			$('.formNotice span').click(function() {
				$("#logForm").toggle();
				$("#withForm").toggle();
			});
		});
	</script>
</body>
</html>