<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="board.*"%>

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

	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>
			<div class="col-md-6">
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						<h2>게시물 상세보기</h2>
					</div>
					<div class="col-md-3"></div>
				</div>
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<u><a href=admin_main.jsp?mode=3&context=14>되돌아가기</a></u>
					</div>
					<div class="col-md-3"></div>
				</div>
				<jsp:useBean id="board" scope="request" class="board.Board" />
				<br> <br>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">&nbsp 도로&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span> <input class="form-control input-lg" type="text" value="<%=board.getBoardRoad()%>">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">&nbsp 유저&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span> <input class="form-control input-lg" type="text" value="<%=board.getBoardMemb()%>">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">&nbsp 비번&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span> <input class="form-control input-lg" type="text" value="<%=board.getBoardPass()%>">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/name.png" width="15" height="15">&nbsp 제목&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span>
								<input class="form-control input-lg" type="text" value="<%=board.getBoardTitle()%>">
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/email.png" width="15" height="15">&nbsp 내용&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span>
								<textarea class="form-control input-lg" type="text" rows = "10"><%=board.getBoardText()%></textarea>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-xs-12">
						<div class=input-group>
							<span class="input-group-addon"> <img src="../image/gender.png" width="15" height="15">&nbsp 날짜&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
							</span>
								<input class="form-control input-lg" type="text" value="<%=board.getBoardDate()%>">
						</div>
					</div>
				</div>



			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

</body>
</html>