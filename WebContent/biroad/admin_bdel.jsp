<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*,java.sql.*,board.*"%>

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
	BoardBean dao = new BoardBean();
	ArrayList<Board> list = new ArrayList<Board>();
	ArrayList<Board> reqlist = (ArrayList<Board>)request.getAttribute("list");
	if(reqlist==null){
		list = dao.getBDBList();
	}else{
		list = reqlist;	
	}
%>
</head>
<body>
	<div class="container">

		<jsp:useBean id="board" scope="request" class="board.Board" />

		<form name=form2 method=post action=biroad_control.jsp>
			<input type=hidden name="action" value="bsel1">
			<div class="row">
				<div class="col-md-1 col-md-offset-1">
					<select name="how">
						<option value="ID">사용자</option>
						<option value="ROAD">길</option>
						<option value="TITLE">제목</option>
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
			<div class="col-md-10">
				<form name=form1 method=post action=biroad_control.jsp>
					<input type=hidden name="action"> <input type=hidden name="id1">
					<table class="table table-striped">
						<tr>
							<th>길</th>
							<th>제목</th>
							<th>사용자</th>
							<th>날짜</th>
							<th>좋아요</th>
							<th>&nbsp</th>
							<th>&nbsp</th>
						</tr>

						<%
							for(Board bo : (ArrayList<Board>)list){
						%>
						<tr>
							<td><%=bo.getBoardRoad()%></td>
							<td><%=bo.getBoardTitle()%></td>

							<td><%=bo.getBoardMemb()%></td>
							<td><%=bo.getBoardDate()%></td>
							<td><%=bo.getHeart()%></td>
							<td><input type="button" value="상세보기" onClick="gocontent('<%=bo.getBoardId()%>')" class="btn btn-danger"></td>

							<td><input type="button" value="삭제" onClick="delcheck('<%=bo.getBoardId()%>')" class="btn btn-danger"></td>
						</tr>
						<%
							}
						%>
					</table>
					<script language=JavaScript>
						function delcheck(BoardId) {
							result = confirm("게시물을 삭제하시겠습니까");

							if (result) {
								document.form1.action.value = "bdel";
								document.form1.id1.value = BoardId;
								document.form1.submit();
							} else
								return;
						}
						function gocontent(BoardId) {

							document.form1.action.value = "content";
							document.form1.id1.value = BoardId;
							document.form1.submit();
						}
					</script>
				</form>
			</div>
			<div class="col-md-2"></div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>
</body>
</html>