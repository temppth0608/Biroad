<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"  import="java.util.*,java.sql.*,totalpath.*,totalpath.*,path.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
	TotalPathBean dao = new TotalPathBean();
	ArrayList<TotalPath> list = new ArrayList<TotalPath>();
	ArrayList<TotalPath> reqlist = (ArrayList<TotalPath>)request.getAttribute("list");
	if(reqlist==null){
		list = dao.getTPDBList();
	}else{
		list = reqlist;	
	}
	
	PathBean dao2 = new PathBean();
	ArrayList<Path> plist = new ArrayList<Path>();
	ArrayList<Path> preqlist = (ArrayList<Path>)request.getAttribute("plist");
	if(reqlist==null){
		plist = dao2.getPDBList();
	}else{
		plist = preqlist;	
	}
%>
</head>
<body><table class="table table-striped">
				<tr>
					<th>ID</th>
					<th>Name</th>
					<th>Start</th>
					<th>End</th>
					<th>상세보기</th>
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
					<td><a href="javascript:go('<%=tp.getTotalPathId()%>')">경로확인</a></td>

					<td><a href="javascript:delcheck('<%=tp.getTotalPathId()%>')">삭제</a></td>
				</tr>
				<%
					}
				%>
				<%
					for(Path p : (ArrayList<Path>)plist){
				%>
				<tr>
					<td><%=p.getPathId()%></td>
					<td><%=p.getPathName()%></td>
					<td><%=p.getPathStart()%></td>
					<td><%=p.getPathEnd()%></td>
					<td><a href="javascript:go('<%=p.getPathId()%>')">경로확인</a></td>

					<td><a href="javascript:delcheck('<%=p.getPathId()%>')">삭제</a></td>
				</tr>
				<%
					}
				%>
			</table></body>
</html>