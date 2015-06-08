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

<%
	String mode = request.getParameter("mode");
	String menu = "";

	if (mode == null) {
		mode = "0";
	}

	int no = Integer.parseInt(mode);
	switch (no) {

		case 0 :
			menu = "admin_menu.jsp";
			break;
		case 1 :
			menu = "admin_msubmenu.jsp";
			break;
		case 2 :
			menu = "admin_rsubmenu.jsp";
			break;
		case 3 :
			menu = "admin_bsubmenu.jsp";
			break;

	}

	String context = request.getParameter("context");
	String Context = "";

	if (context == null) {
		context = "0";
	}
	int num = Integer.parseInt(context);
	switch (num) {
		case 0 :
			Context = "admin_basic.jsp";
			break;
		case 1 :
			Context = "admin_medit.jsp";
			break;
		case 2 :
			Context = "admin_mdel.jsp";
			break;
		case 3 :
			Context = "admin_Trinsert.jsp";
			break;
		case 4 :
			Context = "admin_Trdel.jsp";
			break;
		case 5 :
			Context = "admin_rinsert.jsp";
			break;
		case 6 :
			Context = "admin_seldel.jsp";
			break;
		case 7 :
			Context = "admin_Prdel.jsp";
			break;
		case 8 :
			Context = "admin_setup.jsp";
			break;
		case 9 :
			Context = "admin_TPup.jsp";
			break;
		case 10 :
			Context = "admin_Pup.jsp";
			break;
		case 11 :
			Context = "admin_TPupdate.jsp";
			break;
		case 12 :
			Context = "admin_Pupdate.jsp";
			break;
		case 13 :
			Context = "admin_boardup.jsp";
			break;
		case 14 :
			Context = "admin_bdel.jsp";
			break;
	}

	String action = request.getParameter("action");
%>

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
					<li><a href="#">HOME</a></li>
					<li><a href="#">About</a></li>
					<li><a href="admin_contact.jsp">Contact</a></li>
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
	<div class="main">
		<div class="container-fluid">
			<div class="menu">
				<div class="col-md-3">
					<div class="sideMenu">
						<jsp:include page="<%=menu%>"></jsp:include>
					</div>
				</div>
				<div class="col-md-9">
					<div class="context">
						<jsp:include page="<%=Context%>"></jsp:include>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>