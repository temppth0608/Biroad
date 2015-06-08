<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="totalpath" scope="request" class="totalpath.TotalPath" />
<%
	String starx = totalpath.getTotalPathStarX();
	String stary = totalpath.getTotalPathStarY();
	String endx = totalpath.getTotalPathEndX();
	String endy = totalpath.getTotalPathEndY();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>simpleMap</title>
<script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=178fb3c8-f067-37ad-882b-bc1fdc8cd031"></script>
<script type="text/javascript">
	var pr_3857 = new Tmap.Projection("EPSG:3857");

	//pr_4326 인스탄스 생성.
	var pr_4326 = new Tmap.Projection("EPSG:4326");

	var lonlat2 = new Tmap.LonLat(
<%=stary%>
	,
<%=starx%>
	).transform(pr_4326,
			pr_3857);
	var lonlat1 = new Tmap.LonLat(
<%=endy%>
	,
<%=endx%>
	).transform(pr_4326,
			pr_3857);
	//var a = 37.41176072487254;
	//var b = 126.68014734789062;

	/* function get3857LonLat(coordX){
	     return new Tmap.LonLat(coordX).transform(pr_4326, pr_3857);
	 }*/

	var c = lonlat1
	var d = lonlat2
	function go() {
		alert(c);
		alert(d);
		document.form1.start.value = d;
		document.form1.end.value = c;
	}
</script>
</head>
<form name=form1 method=post action=test3.jsp>
	<input type=hidden name="start" id="start" value=""> <input type=hidden name="end" id="end" value=""> <input type="submit"
		onclick="go()" value="id 중복확인">
</form>

<body onload="initTmap()">

	<div id="map_div"></div>

</body>



</html>
