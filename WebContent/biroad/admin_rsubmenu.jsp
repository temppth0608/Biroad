<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
	<ul class="nav nav-pills nav-stacked">
		<li role="presentation">
			<a href="admin_main.jsp?mode=1">
				<button class="btn btn-default" type="submit">
					&nbsp 
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span> &nbsp 회원관리 &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
					<span class="glyphicon glyphicon-menu-right" aria-hidden="true">
					</span>
				</button>
			</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=2">
				<button class="btn btn-default" type="submit">
					&nbsp 
					<span class="glyphicon glyphicon-road" aria-hidden="true"></span> &nbsp 도로관리 &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
					<span class="glyphicon glyphicon-menu-right" aria-hidden="true">
					</span>
				</button>
			</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=2&context=3">국토종주도로추가</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=2&context=5">세부도로추가</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=2&context=6">도로삭제</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=2&context=8">도로수정</a>
		</li>
		<li role="presentation">
			<a href="admin_main.jsp?mode=3">
				<button class="btn btn-default" type="submit">
					&nbsp 
					<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> &nbsp 게시물관리 &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp &nbsp 
					<span class="glyphicon glyphicon-menu-right" aria-hidden="true">
					</span>
				</button>
			</a>
		</li>
	</ul>
</body>
</html>