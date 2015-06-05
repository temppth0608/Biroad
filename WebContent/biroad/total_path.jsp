<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.sql.*,member.*"%>
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
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-3">
					<div class="roadInfo">
						<div class="row">
							<h3>&nbsp&nbsp아라 자전거길</h3>
						</div>
						<div class="row">
							<h3>&nbsp&nbsp종주코스정보</h3>
						</div>
						<br> <br>
						<div class="row">
							&nbsp&nbsp&nbsp<button class="btn btn-default btn-sm">코스</button>
							&nbsp 팔당댐 ~ 충주댐
						</div>
						<br>
						<div class="row">
							&nbsp&nbsp&nbsp<button class="btn btn-default btn-sm">거리</button>
							&nbsp 136km
						</div>
						<br>
						<div class="row">
							&nbsp&nbsp&nbsp<button class="btn btn-default btn-sm">시간</button>
							&nbsp 약 3시간
						</div>
						<br>
						<div class="row">
						&nbsp&nbsp&nbsp	<button class="btn btn-default btn-sm">난이도</button>
							&nbsp 난이도 이미지
						</div>
						<br>
						<div class="row">
						&nbsp&nbsp	&nbsp<button class="btn btn-default btn-sm">테마</button>
							<select>
								<option value="추억만들기길">추억만들기길</option>
								<option value="행복한소풍길">행복한소풍길</option>
								<option value="생명의노래길">생명의노래길</option>
							</select>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="roadDescription">
						<br> <br>
						<div class="row">
							<h1>아라자전거길</h1>
						</div>
						<br>
						<div class="row">
							<p>국토종주 자전거길은 ‘위대한 향해의 시작’을 알리는 인천 아라서해갑문에 서 시작된다. 서해와 한강을 연결하는 아래뱃길을 따라 조성된 21km 길이의 아라자전 거길은 아디더들에게 환상의 자전거 길로 불린다.</p>

						</div>
					</div>
				</div>
				<div class="col-md-6">
					<div class="roadImage">
						<!-- 지도를 표시할 div 입니다 -->
						<br>
						<h2>코스지도</h2>
						<br>
						<div id="map" style="width: 80%; height: 300px;"></div>

						<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=44b3d9dc2ecf2d8c7dba2d4faf349c31"></script>
						<script>
							var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
							mapOption = {
								center : new daum.maps.LatLng(33.450701,
										126.570667), // 지도의 중심좌표
								level : 3
							// 지도의 확대 레벨
							};

							// 지도를 표시할 div와  지도 옵션으로  지도를 생성합니다
							var map = new daum.maps.Map(mapContainer, mapOption);
						</script>

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