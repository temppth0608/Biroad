<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.sql.*,totalpath.*,totalpath.*"%>
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
	TotalPathBean dao = new TotalPathBean();
	ArrayList<TotalPath> list = new ArrayList<TotalPath>();
	ArrayList<TotalPath> reqlist = (ArrayList<TotalPath>)request.getAttribute("list");;
	if(reqlist==null){
		list = dao.getTPDBList();
	}else{
		list = reqlist;	
	}
%>
</head>
<body>
	<div align="center">
		<h2>전체도로 수정</h2>
		<hr>

		<jsp:useBean id="totalpath" scope="request" class="totalpath.TotalPath" />

		<form name=form2 method=post action=biroad_control.jsp>
			<input type=hidden name="action" value="TPsel1"> <select name="how1">
				<option value="ID1">ID</option>
				<option value="NAME">NAME</option>

			</select>&nbsp; <input type="text" size="20" name="obj1"><input type="submit" value="검색">
		</form>
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
					for(TotalPath tp : (ArrayList<TotalPath>)list){
				%>
				<tr>
					<td><%=tp.getTotalPathId()%></td>
					<td><%=tp.getTotalPathName()%></td>
					<td><%=tp.getTotalPathStart()%></td>
					<td><%=tp.getTotalPathEnd()%></td>


					<td><a href="javascript:delcheck('<%=tp.getTotalPathId()%>')">수정</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<script language=JavaScript>
				function delcheck(TotalPathId) {
					result = confirm("도로를 수정합니다.");

					if (result) {
						document.form1.action.value = "goTup1";
						document.form1.id.value = TotalPathId;
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