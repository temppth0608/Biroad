<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.sql.*,member.*"%>

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
	MemberBean dao = new MemberBean();
	ArrayList<Member> list = new ArrayList<Member>();
	ArrayList<Member> reqlist = (ArrayList<Member>)request.getAttribute("list");;
	if(reqlist==null){
		list = dao.getMemDBList();
	}else{
		list = reqlist;	
	}
%>
</head>
<body>
	<div class="container">
		<jsp:useBean id="member" scope="request" class="member.Member" />

		<form name=form2 method=post action=biroad_control.jsp>
			<input type=hidden name="action" value="msel">
			<div class="row">
				<div class="col-md-1 col-md-offset-1">
					<select name="how">
						<option value="ID">ID</option>
						<option value="NAME">NAME</option>
						<option value="EMAIL">EMAIL</option>
					</select>
				</div>
				<div class="col-md-3">
					<input type="text" class="form-control" size="20" name="obj">
				</div>
				<div class="col-md-1">
					<input class="btn btn-primary" type="submit" value="검색">
				</div>
				<div class="col-md-2"></div>
			</div>
		</form>
		<br>

		<div class="row">
			<div class="col-md-5 col-md-offset-1">
				<form name=form1 method=post action=biroad_control.jsp>
					<input type=hidden name="action"> <input type=hidden name="id">
					<table class="table table-striped">
						<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Email</th>
							<th></th>
						</tr>

						<%
							for(Member mb : (ArrayList<Member>)list){
						%>
						<tr>
							<td><%=mb.getMemberId()%></td>
							<td><%=mb.getMemberName()%></td>
							<td><%=mb.getMemberEmail()%></td>

							<td><a href="javascript:delcheck('<%=mb.getMemberId()%>')">
									<button type="button" class="btn btn-danger">삭제</button>
							</a></td>
						</tr>
						<%
							}
						%>
					</table>
					<script language=JavaScript>
						function delcheck(MemberId) {
							result = confirm("정말 삭제 하시겠습니까?");

							if (result) {
								document.form1.action.value = "mdel";
								document.form1.id.value = MemberId;
								document.form1.submit();
							} else
								return;
						}
					</script>
				</form>
			</div>
			<div class="col-md-6"></div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>