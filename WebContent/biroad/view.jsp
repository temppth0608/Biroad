<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.sql.*,member.*,comment.*"%>
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
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement st = null;
	ResultSet rs;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/biroad2?useUnicode=true&characterEncoding=UTF-8";

	Member mem = (Member) session.getAttribute("member");
	int idx = Integer.parseInt(request.getParameter("idx"));
	String boardDate = "";
	String boardTitle = "";
	String boardText = "";
	String boardPass = "";
	int heart = 0;
	String boardMemb = "";
	String boardRoad = "";
	
	String commMemb = "";
	String commText = "";
	int numOfComment = 0;

	try {
		Class.forName(jdbc_driver);
		conn = DriverManager.getConnection(jdbc_url, "root", "654321");

	} catch (Exception e) {
		e.printStackTrace();
	}

	try {
		st = conn.createStatement();
		String sql = "SELECT BOARD_DATE, BOARD_MEMB, BOARD_TITLE, BOARD_TEXT,BOARD_PASS, HEART,BOARD_ROAD FROM board WHERE board_id="
		+ idx;
		rs = st.executeQuery(sql);
		if (rs.next()) {
	boardDate = rs.getString(1);
	boardMemb = rs.getString(2);
	boardTitle = rs.getString(3);
	boardText = rs.getString(4);
	boardPass = rs.getString(5);
	heart = rs.getInt(6);
	boardRoad = rs.getString(7);
		}
	} catch (SQLException e) {
		e.printStackTrace();
	}
	
	ArrayList<Comment> datas = new ArrayList<Comment>();
	
	try {
		st = conn.createStatement();
		String sql = "select COMM_MEMB, COMM_TEXT FROM COMMENT WHERE BOARD_ID = " + idx;
		rs = st.executeQuery(sql);
		
		while (rs.next()) {
	Comment comment = new Comment();
	comment.setCommentMemb(rs.getString(1));
	comment.setText(rs.getString(2));
	
	datas.add(comment);
		} 
		rs.close();
	} catch(SQLException e) {
		e.printStackTrace();
	}
	
	try {
		st = conn.createStatement();
		String sql = "select count(*) from comment where BOARD_ID = '"+idx+"'";
		rs = st.executeQuery(sql);
		
		if(rs.next()) {
	numOfComment = rs.getInt(1);
		} 
	}catch(SQLException e) {
		e.printStackTrace();
	}
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

	<div class="view_Form">
		<div class="container">
			<div class="view_container">
				<div class="row">
					<div class="col-md-4"></div>
					<div class="col-md-4">
						<h2><%=boardTitle%></h2>
					</div>
					<div class="col-md-3"></div>
					<div class="col-md-1">
						<div class="dropdown">
							<button class="btn btn-default btn-lg" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-expanded="true">
								<span class="glyphicon glyphicon-menu-down" aria-hidden="true"></span>
							</button>
							<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
								<li><img src="../image/cancel.png" width="30" height="30"> &nbsp
									<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal2">게시물 수정</button></li>
								<li role="presentation">&nbsp <img src="../image/write.png" width="30" height="30">
									<button type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModal3">게시물 삭제</button>
								</li>
							</ul>

							<!-- Modal -->
							<div class="modal fade" id="myModal2" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">게시물 수정</h4>
										</div>
										<div class="modal-body">
											<form action="biroad_control.jsp" name=form4 method="post" class="form-horizontal">
												<input type="hidden" name="action" value="checkPassword"> <input type=hidden name="boardId" value="<%=idx%>"> <input
													type="hidden" name="boardPass" value="<%=boardPass%>"> <input type="hidden" name="boardRoad" value="<%=boardRoad%>"> <input
													type="hidden" name="boardText" value="<%=boardText%>"> <input type="hidden" name="boardTitle" value="<%=boardTitle%>">
												<div class="row">
													<input type="password" name="inputPassword" class="form-control" autocomplete="off" placeholder="게시물 비밀번호를 입력해주세요..">
												</div>
												<br>
												<div class="row">
													<div class="col-md-5"></div>
													<div class="col-md-4">
														<input type="submit" class="btn btn-primary btn-lg" value="수정">
													</div>
													<div class="col-md-3"></div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>

							<div class="modal fade" id="myModal3" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
								<div class="modal-dialog">
									<div class="modal-content">
										<div class="modal-header">
											<button type="button" class="close" data-dismiss="modal" aria-label="Close">
												<span aria-hidden="true">&times;</span>
											</button>
											<h4 class="modal-title" id="myModalLabel">게시물 삭제</h4>
										</div>
										<div class="modal-body">
											<form action="biroad_control.jsp" name=form4 method="post" class="form-horizontal">
												<input type="hidden" name="action" value="deleteBoard"> <input type=hidden name="boardId" value="<%=idx%>"> <input
													type="hidden" name="boardPass" value="<%=boardPass%>">
												<div class="row">
													<input type="password" name="inputPassword" class="form-control" autocomplete="off" placeholder="게시물 비밀번호를 입력해주세요..">
												</div>
												<br>
												<div class="row">
													<div class="col-md-5"></div>
													<div class="col-md-4">
														<input type="submit" class="btn btn-danger btn-lg" value="삭제">
													</div>
													<div class="col-md-3"></div>
												</div>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<hr>
				<div class="inform_text">
					&nbsp <img src="../image/view_calander.png" width="20" height="20"> &nbsp
					<%=boardDate%>
					&nbsp &nbsp<img src="../image/view_user.png" width="20" height="20"> &nbsp
					<%=boardMemb%>
					<hr>
					&nbsp <img src="../image/view_comment.png" width="20" height="20"> &nbsp
					<%=numOfComment%>
					<hr>
					&nbsp <img src="../image/view_heart.png" width="20" height="20"> &nbsp
					<%=heart%>
					<hr>
				</div>
				<div class="row">
					<div class="text_area">
						<div class="contents">
							<p class="lead">
								&nbsp
								<%=boardText%></p>
						</div>
						<div class="comment_form">
							&nbsp <img src="../image/view_comment.png" width="20" height="20">
							<hr>
							<%
								for(Comment comment : (ArrayList<Comment>)datas) {
							%>
							&nbsp &nbsp
							<%=comment.getCommentMemb()%>
							: &nbsp
							<%=comment.getText()%><br>
							<%
								}
							%>
						</div>
						<div class="writeComment">
							<form action="biroad_control.jsp" name=form2 method="post" class="form-horizontal">
								<input type=hidden name="action" value="comment"> <input type=hidden name="boardId" value="<%=idx%>"> <input type=hidden
									name="commMemb" value=<%=mem.getMemberId()%>>
								<div class="row">
									<div class="col-md-1"></div>
									<div class="col-md-8">
										<input type="text" name="text1" id="text1" placeholder="댓글을 입력하세요..." class="form-control" autocomplete="off">
									</div>
									<div class="col-md-3">
										<input type="submit" class="btn btn-info" value="작성">
									</div>
								</div>
							</form>
						</div>
					</div>
				</div>
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