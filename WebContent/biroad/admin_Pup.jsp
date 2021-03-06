<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.sql.*,path.*,path.*"%>
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
	PathBean dao = new PathBean();
	ArrayList<Path> list = new ArrayList<Path>();
	ArrayList<Path> reqlist = (ArrayList<Path>)request.getAttribute("list");;
	if(reqlist==null){
		list = dao.getPDBList();
	}else{
		list = reqlist;	
	}
%>
</head>
<body>
	<div align="center">
		<h2>세부도로 수정</h2>
		<hr>

		<jsp:useBean id="path" scope="request" class="path.Path" />

		<div class="row">
			<form name=form2 method=post action=biroad_control.jsp>
				<input type=hidden name="action" value="Psel1">
				<div class="col-md-4">
					<select class="form-control" id="sel1" name="how1">
						<option value="ID1">ID</option>
						<option value="NAME">NAME</option>

					</select>&nbsp;
				</div>
				<div class="col-md-6">
					<input class="form-control" type="text" size="20" name="obj1">
				</div>
				<div class="col-md-2">
					<input class="btn btn-primary" type="submit" value="검색">
				</div>
			</form>
		</div>

		<br>
		<form name=form1 method=post action=biroad_control.jsp>
			<input type=hidden name="action"> <input type=hidden name="id">
			<table class="table table-striped">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Start</th>
					<th>End</th>

					<th></th>
				</tr>

				<%
					for(Path tp : (ArrayList<Path>)list){
				%>
				<tr>
					<td><%=tp.getPathId()%></td>
					<td><%=tp.getPathName()%></td>
					<td><%=tp.getPathStart()%></td>
					<td><%=tp.getPathEnd()%></td>


					<td><a href="javascript:delcheck('<%=tp.getPathId()%>')">수정</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<script language=JavaScript>
				function delcheck(PathId) {
					result = confirm("도로를 수정합니다.");

					if (result) {
						document.form1.action.value = "goPup1";
						document.form1.id.value = PathId;
						document.form1.submit();
					} else
						return;
				}
			</script>
		</form>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>