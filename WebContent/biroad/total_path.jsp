<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="java.util.*,java.sql.*,member.*,totalpath.*,path.*"%>
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
<jsp:useBean id="TotalPath" class="totalpath.TotalPath" />
<jsp:useBean id="Path" class="path.Path" />



<%
	Member mem = (Member) session.getAttribute("member");
	TotalPath tp = (TotalPath) request.getAttribute("tp");
	
	PathBean dao = new PathBean();
	ArrayList<Path> list = new ArrayList<Path>();
	ArrayList<Path> reqlist = (ArrayList<Path>)request.getAttribute("list");;
	if(reqlist==null){
		list = dao.getPDBList(tp.getTotalPathId());
	}else{
		list = reqlist;	
	}
%>

<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=178fb3c8-f067-37ad-882b-bc1fdc8cd031"></script>
<script type="text/javascript">
	var pr_3857 = new Tmap.Projection("EPSG:3857");

	//pr_4326 인스탄스 생성.
	var pr_4326 = new Tmap.Projection("EPSG:4326");

	var lonlat2 = new Tmap.LonLat(<%=tp.getTotalPathStarY()%>,<%=tp.getTotalPathStarX()%>).transform(pr_4326,pr_3857);
	var lonlat1 = new Tmap.LonLat(<%=tp.getTotalPathEndY()%>,<%=tp.getTotalPathEndX()%>).transform(pr_4326,pr_3857);

	var c = lonlat1;
	var d = lonlat2;
	function go() {
		document.form1.start.value = d;
		document.form1.end.value = c;
	}
</script>


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

	<div class="banner">
		<div class="container-fluid">
			<div class="row">
				<div class="col-md-3">
				<br><br>
					<div class="roadInfo">
						<div class="row">
							<h3>
								&nbsp&nbsp<%=tp.getTotalPathName()%></h3>
						</div>
						<br><br>
						<div class="row">
							<h3>&nbsp&nbsp종주코스정보</h3>
						</div>
						<br> <br>
						<div class="row">
							&nbsp&nbsp&nbsp
							<button class="btn btn-default btn-sm">코스</button>
							&nbsp
							<%=tp.getTotalPathStart()%>
							~
							<%=tp.getTotalPathEnd()%>
						</div>
						<br>
						<div class="row">
							&nbsp&nbsp&nbsp
							<button class="btn btn-default btn-sm">시간</button>
							&nbsp 약
							<%=tp.getTotalPathThour()%>시간
						</div>
						<br>
						<div class="row">
							&nbsp&nbsp
							<button class="btn btn-default btn-sm">난이도</button>
							<%
								String rating = tp.getTotalPathAvgd();
																																																															if (rating.equals("1")) {
							%>
							<img src="../image/1star.png" width="160" height="30">
							<%
								} else if (rating.equals("2")) {
							%>
							<img src="../image/2star.png" width="160" height="30">
							<%
								} else if (rating.equals("3")) {
							%>
							<img src="../image/3star.png" width="160" height="30">
							<%
								} else if (rating.equals("4")) {
							%>
							<img src="../image/4star.png" width="160" height="30">
							<%
								} else if (rating.equals("5")) {
							%>
							<img src="../image/5star.png" width="160" height="30">
							<%
								}
							%>
						</div>
						<br>
						<div class="row">
							<form action="biroad_control.jsp" method="post">
								&nbsp&nbsp &nbsp
								<div class="col-md-2">
									<button class="btn btn-default btn-sm">테마</button>
								</div>
								<div class="col-md-5">
									<input type="hidden" name="action" value="subPathView"> <input type="hidden" name="tPathId" value="<%=tp.getTotalPathId()%>">
									<select class="form-control" id="sel1" name="pathId">
										<%
											for(Path path : (ArrayList<Path>)list) {
										%>
										<option value="<%=path.getPathId()%>"><%=path.getPathName()%></option>
										<%
											}
										%>
									</select>
								</div>
								<div class="col-md-4">
									<button type="submit" class="btn btn-info">검색</button>
								</div>
							</form>
						</div>
					</div>
				</div>
				<div class="col-md-3">
					<div class="roadDescription">
						<br> <br>
						<div class="row">
							<h1><%=tp.getTotalPathName()%></h1>
						</div>
						<br>
						<div class="row">
							<p><%=tp.getTotalPathText()%></p>

						</div>
					</div>
				</div>
				<div class="col-md-5 col-md-offset-1">
					<div class="roadImage">
						<!-- 지도를 표시할 div 입니다 -->
						<br>
						<h2>코스지도</h2>
						<br>
						<div id="map" style="width: 80%; height: 350px;"></div>

						<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=44b3d9dc2ecf2d8c7dba2d4faf349c31"></script>
						<script>
						var foo = new Array();
						var starx = "<%=tp.getTotalPathStarX()%>";
						var stary = "<%=tp.getTotalPathStarY()%>";
						var endx = "<%=tp.getTotalPathEndX()%>";
						var endy = "<%=tp.getTotalPathEndY()%>";
							starx = parseFloat(starx);
							stary = parseFloat(stary);
							endx = parseFloat(endx);
							endy = parseFloat(endy);
						

							var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
							mapOption = {
								center : new daum.maps.LatLng(starx, stary), // 지도의 중심좌표
								level : 12
							// 지도의 확대 레벨
							};

							var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

							// 마커를 표시할 위치와 title 객체 배열입니다 
							var positions = [ {
								title : '시작점',
								latlng : new daum.maps.LatLng(starx, stary)
							}, {
								title : '끝점',
								latlng : new daum.maps.LatLng(endx, endy)
							}, ];

							// 마커 이미지의 이미지 주소입니다
							var imageSrc = "http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";

							foo[0] = '<p style="margin:7px 22px 7px 10px;font:10px/1.5 sans-serif">시작점입니다 : "<%= tp.getTotalPathStart() %>"</p>';
						 	foo[1] = '<p style="margin:7px 22px 7px 10px;font:10px/1.5 sans-serif">도착점입니다 : "<%= tp.getTotalPathEnd() %> "</p>';
							for (var i = 0; i < positions.length; i++) {

								// 마커 이미지의 이미지 크기 입니다
								var imageSize = new daum.maps.Size(24, 35);

								// 마커 이미지를 생성합니다    
								var markerImage = new daum.maps.MarkerImage(
										imageSrc, imageSize);

								// 마커를 생성합니다
								var marker = new daum.maps.Marker({
									map : map, // 마커를 표시할 지도
									position : positions[i].latlng, // 마커를 표시할 위치
									title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
									image : markerImage,
									clickable : true
								// 마커 이미지 

								});
								marker.setMap(map);
								var infowindow = new daum.maps.InfoWindow({

									content : foo[i],
									position : positions[i].latlng,
									removable : true
								});

								infowindow.open(map, marker);
							}
						</script>

					</div>
					<div class="bigRoadBtn">
						<form name=form1 method=post action=test3.jsp>
							<input type=hidden name="start" id="start" value=""> 
							<input type=hidden name="end" id="end" value="">
							<input onclick="go()" type="submit" class="btn btn-primary" value="자세히보기">
						</form>
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