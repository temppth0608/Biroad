<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>관리자 도로추가</title>
</head>
<body>
	<div align="center">
		<h2>도로추가</h2>
		<hr>
	</div>
	<table>
		<tr>
			<td>도로이름</td>
			<td rowspan="18">
				<div class="map_wrap">
					<div id="map"
						style="width: 800px; height: 500px; position: relative; overflow: hidden;"></div>
					<div id="menu_wrap" class="bg_white">
						<div class="option">
							<p>
							<form onsubmit="searchPlaces(); return false;">
								키워드 : <input type="text" value="한강" id="keyword" size="15">
								<button type="submit">검색하기</button>
								</p>
						</div>
						<hr>
						<ul id="placesList"></ul>
						<div id="pagination"></div>
					</div>
				</div> <script type="text/javascript"
					src="//apis.daum.net/maps/maps3.js?apikey=fcb3ae25b4db5e57b25f055332ddeea4&libraries=services"></script>


				<script>
					// 마커를 담을 배열입니다
					var markers = [];

					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					mapOption = {
						center : new daum.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
						level : 1
					// 지도의 확대 레벨
					};

					// 지도를 생성합니다    
					var map = new daum.maps.Map(mapContainer, mapOption);

					// 장소 검색 객체를 생성합니다
					var ps = new daum.maps.services.Places();

					// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
					var infowindow = new daum.maps.InfoWindow({
						zIndex : 1
					});

					// 키워드로 장소를 검색합니다
					searchPlaces();

					// 키워드 검색을 요청하는 함수입니다
					function searchPlaces() {

						var keyword = document.getElementById('keyword').value;

						if (!keyword.replace(/^\s+|\s+$/g, '')) {
							alert('키워드를 입력해주세요!');
							return false;
						}

						// 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
						ps.keywordSearch(keyword, placesSearchCB);
					}

					// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
					function placesSearchCB(status, data, pagination) {
						if (status === daum.maps.services.Status.OK) {

							// 정상적으로 검색이 완료됐으면
							// 검색 목록과 마커를 표출합니다
							displayPlaces(data.places);

							// 페이지 번호를 표출합니다
							displayPagination(pagination);

						} else if (status === daum.maps.services.Status.ZERO_RESULT) {

							alert('검색 결과가 존재하지 않습니다.');
							return;

						} else if (status === daum.maps.services.Status.ERROR) {

							alert('검색 결과 중 오류가 발생했습니다.');
							return;

						}
					}

					// 검색 결과 목록과 마커를 표출하는 함수입니다
					function displayPlaces(places) {

						var listEl = document.getElementById('placesList'), menuEl = document
								.getElementById('menu_wrap'), fragment = document
								.createDocumentFragment(), bounds = new daum.maps.LatLngBounds(), listStr = '';

						// 검색 결과 목록에 추가된 항목들을 제거합니다
						removeAllChildNods(listEl);

						// 지도에 표시되고 있는 마커를 제거합니다
						removeMarker();

						for (var i = 0; i < places.length; i++) {

							// 마커를 생성하고 지도에 표시합니다
							var placePosition = new daum.maps.LatLng(
									places[i].latitude, places[i].longitude), marker = addMarker(
									placePosition, i), itemEl = getListItem(i,
									places[i], marker); // 검색 결과 항목 Element를 생성합니다

							// 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
							// LatLngBounds 객체에 좌표를 추가합니다
							bounds.extend(placePosition);

							// 마커와 검색결과 항목에 mouseover 했을때
							// 해당 장소에 인포윈도우에 장소명을 표시합니다
							// mouseout 했을 때는 인포윈도우를 닫습니다
							(function(marker, latitude, longitude) {
								daum.maps.event.addListener(marker, 'click',
										function() {
											displayInfowindow(marker, latitude,
													longitude);
										});

								/* daum.maps.event.addListener(marker, 'mouseout', function() {
									infowindow.close();
								}); */

								itemEl.onclick = function() {
									displayInfowindow(marker, latitude,
											longitude);
								};

								/* itemEl.onmouseout = function() {
									infowindow.close();
								}; */
							})(marker, places[i].latitude, places[i].longitude);

							fragment.appendChild(itemEl);
						}

						// 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
						listEl.appendChild(fragment);
						menuEl.scrollTop = 0;

						// 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
						map.setBounds(bounds);
					}

					// 검색결과 항목을 Element로 반환하는 함수입니다
					function getListItem(index, places) {

						var el = document.createElement('li'), itemStr = '<span class="markerbg marker_'
								+ (index + 1)
								+ '"></span>'
								+ '<div class="info">'
								+ '   <h5>'
								+ places.title + '</h5>';

						if (places.newAddress) {
							itemStr += '    <span>' + places.newAddress
									+ '</span>'
									+ '   <span class="jibun gray">'
									+ places.address + '</span>';
						} else {
							itemStr += '    <span>' + places.address
									+ '</span>';
						}

						itemStr += '  <span class="tel">' + places.phone
								+ '</span>' + '</div>';

						el.innerHTML = itemStr;
						el.className = 'item';

						return el;
					}

					// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
					function addMarker(position, idx, latutude) {
						var imageSrc = 'http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
						imageSize = new daum.maps.Size(36, 37), // 마커 이미지의 크기
						imgOptions = {
							spriteSize : new daum.maps.Size(36, 691), // 스프라이트 이미지의 크기
							spriteOrigin : new daum.maps.Point(0,
									(idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
							offset : new daum.maps.Point(13, 37)
						// 마커 좌표에 일치시킬 이미지 내에서의 좌표
						}, markerImage = new daum.maps.MarkerImage(imageSrc,
								imageSize, imgOptions), marker = new daum.maps.Marker(
								{
									position : position, // 마커의 위치
									image : markerImage
								});

						marker.setMap(map); // 지도 위에 마커를 표출합니다
						markers.push(marker); // 배열에 생성된 마커를 추가합니다

						return marker;
					}

					// 지도 위에 표시되고 있는 마커를 모두 제거합니다
					function removeMarker() {
						for (var i = 0; i < markers.length; i++) {
							markers[i].setMap(null);
						}
						markers = [];
					}

					// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
					function displayPagination(pagination) {
						var paginationEl = document
								.getElementById('pagination'), fragment = document
								.createDocumentFragment(), i;

						// 기존에 추가된 페이지번호를 삭제합니다
						while (paginationEl.hasChildNodes()) {
							paginationEl.removeChild(paginationEl.lastChild);
						}

						for (i = 1; i <= pagination.last; i++) {
							var el = document.createElement('a');
							el.href = "#";
							el.innerHTML = i;

							if (i === pagination.current) {
								el.className = 'on';
							} else {
								el.onclick = (function(i) {
									return function() {
										pagination.gotoPage(i);
									}
								})(i);
							}

							fragment.appendChild(el);
						}
						paginationEl.appendChild(fragment);
					}

					// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
					// 인포윈도우에 장소명을 표시합니다
					function displayInfowindow(marker, latitude, longitude) {
						var content = '<div style="position:relative; height:40px; padding:5px;">'
								+ "위도 : "
								+ latitude
								+ " 경도 : "
								+ longitude
								+ '</div>';

						infowindow.setContent(content);
						infowindow.open(map, marker);
					}

					// 검색결과 목록의 자식 Element를 제거하는 함수입니다
					function removeAllChildNods(el) {
						while (el.hasChildNodes()) {
							el.removeChild(el.lastChild);
						}
					}
				</script>
				</form>
			</td>
		</tr>
		<form name=form1 method=post action=biroad_control.jsp>
			<input type=hidden name="action" value="Trinsert"> <input
				type=hidden name="totalPathId">
			<tr>
				<td><input type=hidden name="totalPathName"> <select
					name="TID" id="TID" onchange="comm()">
						<option value="ab2" selected="selected">--선택--</option>
						<option value="아라자전거길">아라자전거길</option>
						<option value="한강종주자전거길">한강종주자전거길</option>
						<option value="남한강자전거길">남한강자전거길</option>
						<option value="북한강자전거길">북한강자전거길</option>
						<option value="세재자전거길">세재자전거길</option>
						<option value="낙동강자전거길">낙동강자전거길</option>
						<option value="금강자전거길">금강자전거길</option>
						<option value="영산강자전거길">영산강자전거길</option>
						<option value="섬진강자전거길">섬진강자전거길</option>
						<option value="오천자전거길">오천자전거길</option>
				</select></td>

			</tr>
			<tr>
				<td>총 시간</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathThour"></td>
			</tr>
			<tr>
				<td>평균 난이도</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathAvgd"></td>
			</tr>
			<tr>
				<td>시작지점</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathStart"></td>
			</tr>
			<tr>
				<td>도착지점</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathEnd"></td>
			</tr>
			<tr>
				<td>시작위도</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathStarX"></td>
			</tr>
			<tr>
				<td>시작경도</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathStarY"></td>
			</tr>
			<tr>
				<td>도착위도</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathEndX"></td>
			</tr>
			<tr>
				<td>도착경도</td>
			</tr>
			<tr>
				<td><input type="text" name="totalPathEndY"></td>
			</tr>
			<tr>
				<td>도로설명</td>
				<td><textarea name="totalPathText" cols="100" rows="13"></textarea></td>
			</tr>

			<tr>
				<td colspan="2" align=center><input type="button" value="저장"
					onClick="writeCheck()"><input type="reset" name="a"
					value="취소"></td>
				<script language=JavaScript>
					function comm() {
						var abc = document.getElementById("TID").value;
						//var abc1 = document.getElementById("TPID").value;
						var id = "";

						document.form1.totalPathName.value = abc;
						//document.form1.totalPathId.value = abc1;
						if (abc == "아라자전거길") {
							id = "path1";
						} else if (abc == "한강종주자전거길") {
							id = "path2";
						} else if (abc == "남한강자전거길") {
							id = "path3";
						} else if (abc == "북한강자전거길") {
							id = "path4";
						} else if (abc == "세재자전거길") {
							id = "path5";
						} else if (abc == "낙동강자전거길") {
							id = "path6";
						} else if (abc == "금강자전거길") {
							id = "path7";
						} else if (abc == "영산강자전거길") {
							id = "path8";
						} else if (abc == "섬진강자전거길") {
							id = "path9";
						} else if (abc == "오천자전거길") {
							id = "path10";
						}
						document.form1.totalPathId.value = id;

					}

					function writeCheck() {
						//var a = document.getElementById("TPID").value;
						var b = document.getElementById("TID").value;

						/*if (a == "ab") {
							alert("도로아이디를 선택해주세요");
							return;
						}*/

						if (b == "ab2") {
							alert("도로이름을 선택해주세요");
							return;
						}

						if (!document.form1.totalPathStarX.value) {
							alert("시작점위도를 입력해주세요");
							document.form1.totalPathStarX.focus();
							return;
						}
						if (!document.form1.totalPathStarY.value) {
							alert("시작점경도를 입력해주세요");
							document.form1.totalPathStarY.focus();
							return;
						}
						if (!document.form1.totalPathEndX.value) {
							alert("도착점위도를 입력해주세요");
							document.form1.totalPathEndX.focus();
							return;
						}
						if (!document.form1.totalPathEndY.value) {
							alert("도착점경도를 입력해주세요");
							document.form1.totalPathEndY.focus();
							return;
						}
						if (!document.form1.totalPathStart.value) {
							alert("시작점을 입력해주세요");
							document.form1.totalPathStart.focus();
							return;
						}
						if (!document.form1.totalPathEnd.value) {
							alert("도착점을 입력해주세요");
							document.form1.totalPathEnd.focus();
							return;
						}
						if (!document.form1.totalPathAvgd.value) {
							alert("평균 난이도를 입력해주세요");
							document.form1.totalPathAvgd.focus();
							return;
						}
						if (!document.form1.totalPathThour.value) {
							alert("총 시간을 입력해주세요");
							document.form1.totalPathThour.focus();
							return;
						}
						if (!document.form1.totalPathText.value) {
							alert("도로설명을 입력해주세요");
							document.form1.totalPathText.focus();
							return;
						}
						comm();
						form1.submit();
					}
				</script>
	</table>
	</form>
</body>

<style>
.map_wrap, .map_wrap * {
	margin: 0;
	padding: 0;
	font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	font-size: 12px;
}

.map_wrap a, .map_wrap a:hover, .map_wrap a:active {
	color: #000;
	text-decoration: none;
}

.map_wrap {
	position: relative;
	width: 100%;
	height: 500px;
}

#menu_wrap {
	position: absolute;
	top: 0;
	left: 0;
	bottom: 0;
	width: 250px;
	margin: 10px 0 30px 10px;
	padding: 5px;
	overflow-y: auto;
	background: rgba(255, 255, 255, 0.7);
	z-index: 1;
	font-size: 12px;
	border-radius: 10px;
}

.bg_white {
	background: #fff;
}

#menu_wrap hr {
	display: block;
	height: 1px;
	border: 0;
	border-top: 2px solid #5F5F5F;
	margin: 3px 0;
}

#menu_wrap .option {
	text-align: center;
}

#menu_wrap .option p {
	margin: 10px 0;
}

#menu_wrap .option button {
	margin-left: 5px;
}

#placesList li {
	list-style: none;
}

#placesList .item {
	position: relative;
	border-bottom: 1px solid #888;
	overflow: hidden;
	cursor: pointer;
	min-height: 65px;
}

#placesList .item span {
	display: block;
	margin-top: 4px;
}

#placesList .item h5, #placesList .item .info {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}

#placesList .item .info {
	padding: 10px 0 10px 55px;
}

#placesList .info .gray {
	color: #8a8a8a;
}

#placesList .info .jibun {
	padding-left: 26px;
	background:
		url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png)
		no-repeat;
}

#placesList .info .tel {
	color: #009900;
}

#placesList .item .markerbg {
	float: left;
	position: absolute;
	width: 36px;
	height: 37px;
	margin: 10px 0 0 10px;
	background:
		url(http://i1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png)
		no-repeat;
}

#placesList .item .marker_1 {
	background-position: 0 -10px;
}

#placesList .item .marker_2 {
	background-position: 0 -56px;
}

#placesList .item .marker_3 {
	background-position: 0 -102px
}

#placesList .item .marker_4 {
	background-position: 0 -148px;
}

#placesList .item .marker_5 {
	background-position: 0 -194px;
}

#placesList .item .marker_6 {
	background-position: 0 -240px;
}

#placesList .item .marker_7 {
	background-position: 0 -286px;
}

#placesList .item .marker_8 {
	background-position: 0 -332px;
}

#placesList .item .marker_9 {
	background-position: 0 -378px;
}

#placesList .item .marker_10 {
	background-position: 0 -423px;
}

#placesList .item .marker_11 {
	background-position: 0 -470px;
}

#placesList .item .marker_12 {
	background-position: 0 -516px;
}

#placesList .item .marker_13 {
	background-position: 0 -562px;
}

#placesList .item .marker_14 {
	background-position: 0 -608px;
}

#placesList .item .marker_15 {
	background-position: 0 -654px;
}

#pagination {
	margin: 10px auto;
	text-align: center;
}

#pagination a {
	display: inline-block;
	margin-right: 10px;
}

#pagination .on {
	font-weight: bold;
	cursor: default;
	color: #777;
}
</style>
</html>