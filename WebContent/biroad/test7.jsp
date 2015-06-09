<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.sql.*,totalpath.*,totalpath.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="biroad_control.jsp" name=form2 method=post>
		<input type="hidden" name="action" value="recommand"> 난이도
		<input type="text" name="Diff"> 시간
		<input type="text" name="Time"> 시작
		<input type="text" name="Start"> 끝
		<input type="text" name="End"> 
		<input class="btn btn-primary" type="submit" value="검색">

	</form>
</body>
</html>