<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="totalpath.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>지도상세보기</title>

</head>
<body>

	<div align="center">
		<h2>지도 상세보기</h2>
		<hr>
		[<a href=admin_main.jsp?mode=2&context=4>되돌아가기</a>]
		<p>
			<jsp:useBean id="totalpath" scope="request"
				class="totalpath.TotalPath" />
			<%
				String starx = totalpath.getTotalPathStarX();
				String stary = totalpath.getTotalPathStarY();
				String endx = totalpath.getTotalPathEndX();
				String endy = totalpath.getTotalPathEndY();
				String start = totalpath.getTotalPathStart();
				String end = totalpath.getTotalPathEnd();
			%>
		
		<table border="1">

			<div id="map" style="width: 100%; height: 500px;"></div>

			<script type="text/javascript"
				src="//apis.daum.net/maps/maps3.js?apikey=fcb3ae25b4db5e57b25f055332ddeea4"></script>


			<script>
			
			var foo = new Array();
			var starx = "<%=starx%>";
			var stary = "<%=stary%>";
			var endx = "<%=endx%>";
			var endy = "<%=endy%>";
				starx = parseFloat(starx);
				stary = parseFloat(stary);
				endx = parseFloat(endx);
				endy = parseFloat(endy);
			

				var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
				mapOption = {
					center : new daum.maps.LatLng(starx, stary), // 지도의 중심좌표
					level : 8
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

				foo[0] = '<p style="margin:7px 22px 7px 10px;font:10px/1.5 sans-serif">시작점입니다 : "<%=start%>"</p>';
				foo[1] = '<p style="margin:7px 22px 7px 10px;font:10px/1.5 sans-serif">도착점입니다 : "<%=end%>"</p>';
				for (var i = 0; i < positions.length; i++) {

					// 마커 이미지의 이미지 크기 입니다
					var imageSize = new daum.maps.Size(24, 35);

					// 마커 이미지를 생성합니다    
					var markerImage = new daum.maps.MarkerImage(imageSrc,
							imageSize);

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

		</table>

	</div>

</body>
</html>