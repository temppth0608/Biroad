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
<link href="style3.css" rel="stylesheet">
</head>
<body>
</head>
<body>
	<div class="header">
		<div class="container ">
			<div class="header-logo">
				<a href="admin_main.jsp">
					<h1>BIROAD</h1>
				</a>
			</div>
			<div class="top-nav">
				<span class="menu"></span>
				<ul class="nav1">
					<li><a href="admin_main.jsp">HOME</a></li>
					<li><a href="#">About</a></li>
					<li><a href="#">Contact</a></li>
				</ul>
				<script>
					$("span.menu").click(function() {
						$("ul.nav1").slideToggle(300, function() {
							// Animation complete.
						});
					});
				</script>
			</div>
			<div class="clearfix"></div>
		</div>
	</div>
	<hr>
	
	<div class="container">

      <div class="starter-template">
        <h1>가천대학교 Gachon University</h1>
        <p class="lead"><br><br>(461-701)경기도 성남시 수정구 성남대로 1342<br>TEL.031-750-5114<br><br>메디컬캠퍼스 | (406-799)인천광역시 연수구 함박뫼로 191<br>TEL.032-820-4000<br><br>  박태현 | HP.010-3462-2977<br><br>안정근 | HP.010-2913-3702</p>
      </div>

    </div><!-- /.container -->
	
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>