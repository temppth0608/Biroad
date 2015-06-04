<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<title>BIROAD</title>

<!-- Bootstrap -->
<link href="../bootstrap/css/bootstrap.css" rel="stylesheet">
</head>
<body>
	<div align="center">
		<h2>도로 삭제</h2>
		<hr>
		
			<table>
				<tr>
					<td align=center>
					<form name=form2 method=post action=biroad_control.jsp>
					<input type=hidden name="action" value="goTdel">
					<input class="btn btn-primary" type="submit" value="전체도로삭제">&nbsp&nbsp
					</form></td>
					<td>
					
					<form name=form3 method=post action=biroad_control.jsp>
					<input type=hidden name="action" value="goPdel">
						<input class="btn btn-primary" type="submit" value="세부도로삭제"></form></td>
				</tr>
			</table>
		
</body>
</html>