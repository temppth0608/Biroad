<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.sql.*,member.*, board.*"%>
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
<jsp:useBean id="Board" class="board.Board" />

<%
	Member mem = (Member) session.getAttribute("member");

	BoardBean dao = new BoardBean();
	ArrayList<Board> list = new ArrayList<Board>();
	ArrayList<Board> reqlist = ((ArrayList<Board>)request.getAttribute("list"));
	if(reqlist == null) {
		list = dao.getBoardDBList8();
	} else {
		list = reqlist;
	}
	Board.setBoardRoad("영산강자전거길");
%>

</head>
<body>
	<div class="header" id="header">
		<div class="container">
			<a href="main.jsp">
			<div class="header-logo">
				<h1>BI ROAD</h1>
			</div>
			</a>
			<div class="top-nav">
				<span class="menu"><img src="../image/menu-icon.png" alt="" /></span>
				<ul class="nav1">
					<li><a href="main.jsp">도로검색</a></li>
					<li><a href="recommend.jsp">도로추천</a></li>
					<li><a href="#">BI STORY</a></li>
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
												<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">
												</span> <input type="password" name="memberPass2" class="form-control input-lg" placeholder="비밀번호확인" autocomplete="off">
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

	<div class="banner">
		<div class="container">
			<div class="row-fluid">
				<div class="nav-tab">
					<div class="col-md-1">
						<div class="writeBoard">
							<div class="row">
								<form action="biroad_control.jsp" id="write">
									<input type=hidden name="action" value="write"> <input TYPE="IMAGE" src="../image/write.png" width="50" height="50" name="Submit"
										value="Submit" align="absmiddle">
									<%-- 										<input type=hidden name="memberId" value="<%=mem.getMemberId()%>">
 --%>
									<input type=hidden name="memberId" value="<%=mem.getMemberId()%>"> <input type=hidden name="boardRoad"
										value="<%=Board.getBoardRoad()%>">
								</form>
							</div>
							<div class="row">
								<p>글쓰기</p>
							</div>
						</div>
					</div>
					<div class="col-md-10">
						<div class="tab">
							<ul class="nav nav-tabs">
								<li role="presentation"><a href="bistory.jsp">아라<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory2.jsp">한강종주<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory3.jsp">남한강<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory4.jsp">북한강<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory5.jsp">세제<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory6.jsp">낙동강<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory7.jsp">금강<br>자전거길
								</a></li>
								<li role="presentation" class="active"><a href="#">영산강<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory9.jsp">섬진강<br>자전거길
								</a></li>
								<li role="presentation"><a href="bistory10.jsp">오천<br>자전거길
								</a></li>
							</ul>
						</div>
					</div>
					<div class="col-md-1"></div>
				</div>
			</div>


			<div class="row">
				<div class="col-md-1"></div>
				<div class="col-md-10">
					<div class="contents">

						<div class="row">
							<%
								for(Board board : (ArrayList<Board>)list){
							%>
							<div class="col-md-4">
								<div class="post-pannel post_pannel">
									<a target="_blank"></a>
									<div class="post-title">
										<p>
											<a href="view.jsp?idx=<%=board.getBoardId()%>"> <strong><%=board.getBoardTitle()%></strong>
											</a> <span class="sceret"> </span>
										</p>
									</div>
									<div class="post-img" style="background-color: rgb(230, 189, 205);">

										<img src="../upload/<%=board.getImage()%>" width="300" height="140">

									</div>
									<div class="post-description">
										<p class="mobile-post-desc">
											<weak><%=board.getBoardText()%> </weak>
										</p>
									</div>
									<div class="post-bottom-bar">
										<div class="post-heart-button">
											<form action="biroad_control.jsp" name=form2 id="writeForm" method="POST" class="form-horizontal">
												<input type=hidden name="action" value="heart"> <input type=hidden name="boardId" value="<%=board.getBoardId()%>">
												<div class="heart-box">
													<button type="submit" class="btn btn-default btn-xs" style="float: left; position: relative;">
														<i class="glyphicon glyphicon-heart"></i>
													</button>
													<span>&nbsp <%=board.getHeart()%></span>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
							<%
								}
							%>
						</div>

					</div>
				</div>
				<div class="col-md-1"></div>
			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
	<script type="text/javascript">
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
			if (document.form2.memberPass.value != document.form2.memberPass2.value) {
				alert("비밀번호가 일치하지 않습니다.");
				document.form2.memberPass2.focus();
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