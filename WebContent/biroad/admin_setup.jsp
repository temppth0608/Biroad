<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<h2>도로 수정</h2>
		<hr>
		
			<table>
				<tr>
					<td align=center>
					<form name=form2 method=post action=biroad_control.jsp>
					<input type=hidden name="action" value="goTup">
					<input class="btn btn-primary" type="submit" value="전체도로수정">&nbsp&nbsp
					</form></td>
					<td>
					<form name=form3 method=post action=biroad_control.jsp>
					<input type=hidden name="action" value="goPup">
						<input class="btn btn-primary" type="submit" value="세부도로수정"></form></td>
				</tr>
			</table>
		
</body>
</html>