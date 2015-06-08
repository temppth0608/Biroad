<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%

request.setCharacterEncoding("UTF-8");	
	String startx = request.getParameter("startx");
	String starty = request.getParameter("starty");
	String endx = request.getParameter("endx");
	String endy = request.getParameter("endy");
	%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        <title>simpleMap</title>
        <script src="https://apis.skplanetx.com/tmap/js?version=1&format=javascript&appKey=178fb3c8-f067-37ad-882b-bc1fdc8cd031"></script>
        <script type="text/javascript">
        var pr_3857 = new Tmap.Projection("EPSG:3857");
        
      //pr_4326 인스탄스 생성.
      var pr_4326 = new Tmap.Projection("EPSG:4326");
      
      var lonlat2 = new Tmap.LonLat(126.68014734789062, 37.41176072487254 ).transform(pr_4326, pr_3857 ); 
var lonlat1 = new Tmap.LonLat(126.68984490748954, 37.42238250275035 ).transform(pr_4326, pr_3857 );
var a = 37.41176072487254;
var b = 126.68014734789062;
      
     /* function get3857LonLat(coordX){
          return new Tmap.LonLat(coordX).transform(pr_4326, pr_3857);
      }*/
    
 
        function initTmap(){
        
        	
            centerLL = new Tmap.LonLat();
            map = new Tmap.Map({div:'map_div',
                                width:'100%', 
                                height:'400px',
                                transitionEffect:"resize",
                                animation:true
                            }); 
            searchRoute();
        };
        //경로 정보 로드
        function searchRoute(){
            var routeFormat = new Tmap.Format.KML({extractStyles:true, extractAttributes:true});
            var startX = <%=startx%>;
            var startY = <%=starty%>;
           	var endX = <%=endx%>;
            var endY = <%=endy%>;
            var urlStr = "https://apis.skplanetx.com/tmap/routes/bicycle?version=1&format=xml";
            urlStr += "&startX="+startX;
            urlStr += "&startY="+startY;
            urlStr += "&endX="+endX;
            urlStr += "&endY="+endY;
            urlStr += "&appKey=178fb3c8-f067-37ad-882b-bc1fdc8cd031";
            var prtcl = new Tmap.Protocol.HTTP({
                                                url: urlStr,
                                                format:routeFormat
                                                });
            var routeLayer = new Tmap.Layer.Vector("route", {protocol:prtcl, strategies:[new Tmap.Strategy.Fixed()]});
            routeLayer.events.register("featuresadded", routeLayer, onDrawnFeatures);
            map.addLayer(routeLayer);
        }
        //경로 그리기 후 해당영역으로 줌
        function onDrawnFeatures(e){
            map.zoomToExtent(this.getDataExtent());
        }

       
        </script>
    </head>
  
    <body onload="initTmap()">

<div id="map_div"></div>
</body>

            
  
</html>