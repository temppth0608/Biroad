<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,java.sql.*,totalpath.*,totalpath.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
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
<form name=form1 method=post action=biroad_control.jsp>
			<input type=hidden name="action"> <input type=hidden name="id">
			<table>
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


					<td><a href="javascript:delcheck('<%=tp.getTotalPathId()%>')">테스트</a></td>
				</tr>
				<%
					}
				%>
			</table>
			<script language=JavaScript>
				function delcheck(TotalPathId) {
					result = confirm("테스트용");

					if (result) {
						document.form1.action.value = "show";
						document.form1.id.value = TotalPathId;
						document.form1.submit();
					} else
						return;
				}
			</script>
		</form>

</body>
</html>