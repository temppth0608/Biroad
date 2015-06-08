<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<%

request.setCharacterEncoding("UTF-8");

	String st="n";
	String st1="t";

	
	String a = request.getParameter("start");
	String b = request.getParameter("end");
	int io_lon = a.indexOf(st);
	int io_lon1 = a.indexOf(st1);
	int e_lon =b.indexOf(st);
	int e_lon1 = b.indexOf(st1);
	
	String slon;
	String slan;
	String elon;
	String elan;
	slon= a.substring(io_lon+st.length()+1,(a.substring(io_lon).indexOf(",")+io_lon));
	slan= a.substring(io_lon1+st.length()+1);
	
	elon = b.substring(e_lon+st.length()+1,(b.substring(e_lon).indexOf(",")+e_lon));
	elan = b.substring(e_lon1+st.length()+1);
	
	
%>
</head>
<body>
 <jsp:forward page="test6.jsp" >

       <jsp:param name="startx" value="<%= slon %>" />
<jsp:param name="starty" value="<%= slan %>" />
<jsp:param name="endx" value="<%= elon %>" />
<jsp:param name="endy" value="<%= elan %>" />
     </jsp:forward>

</body>
</html>