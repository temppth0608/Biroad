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
						<h2>게시물정보수정</h2>
					</div>
					<div class="col-md-3"></div>
				</div>
				<div class="row">
					<div class="col-md-3"></div>
					<div class="col-md-6">
						&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<u><a href=admin_main.jsp?mode=3&context=13>되돌아가기</a></u>
					</div>
					<div class="col-md-3"></div>
				</div>
				<br>
				<br>
				<jsp:useBean id="board" scope="request" class="board.Board" />

				<form name=form1 method=post action=biroad_control.jsp>
					<input type=hidden name="boardId" value="<%=board.getBoardId()%>"> <input type=hidden name="action" value="bupdate">
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">&nbsp 도로&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								</span>
								
								<p class="form-control-static">&nbsp&nbsp	<%=board.getBoardRoad()%></p>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
									<span class="input-group-addon"> <img src="../image/user.png" width="15" height="15">&nbsp 유저&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
									</span>
								<div class="col-sm-10">
									<p class="form-control-static"> <%=board.getBoardMemb()%></p>
								</div>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/key.png" width="15" height="15">&nbsp 비번&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								</span> <input value="<%=board.getBoardPass()%>" type="text" name="boardPass" class="form-control input-lg" placeholder="Password" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/name.png" width="15" height="15">&nbsp 제목&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								</span> <input value="<%=board.getBoardTitle()%>" type="text" name="boardTitle" class="form-control input-lg" placeholder="제목" autocomplete="off">
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/email.png" width="15" height="15">&nbsp 내용&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								</span>
								<textarea name="boardText" class="form-control" rows="13"><%=board.getBoardText()%></textarea>
							</div>
						</div>
					</div>
					<div class="form-group">
						<div class="col-xs-12">
							<div class=input-group>
								<span class="input-group-addon"> <img src="../image/gender.png" width="15" height="15">&nbsp 날짜&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp
								</span> <input value="<%=board.getBoardDate()%>" type="text" name="boardDate" class="form-control input-lg" placeholder="남 or 여" autocomplete="off">
							</div>
						</div>
					</div>
					<br><br>
					<div class="form-group formSubmit">
						<div class="col-sm-2"></div>
						<div class="col-sm-3">
							<input class="btn btn-primary btn-lg" type="reset" value="취소">
						</div>
						<div class="col-sm-2"></div>
						<div class="col-sm-3">
							<input onclick="writeCheck()" class="btn btn-primary btn-lg" type="button" value="수정">
						</div>
						<div class="col-sm-2"></div>
					</div>

					<script type="text/javascript">
						function writeCheck() {

							if (document.form1.boardPass.value == "") {
								alert("비밀번호를 입력하세요");
								document.form1.boardPass.focus();
								return;

							} else if (document.form1.boardTitle.value == "") {
								alert("제목을 입력하세요");
								document.form2.boardTitle.focus();
								return;
							} else if (document.form1.boardText.value == "") {
								alert("내용을 입력하세요");
								document.form2.boardText.focus();
								return;
							} else if (document.form1.boardDate.value == "") {
								alert("날짜를 입력하세요");
								document.form2.boardDate.focus();
								return;
							}
							document.form1.submit();
						}
					</script>
				</form>

			</div>
			<div class="col-md-3"></div>
		</div>
	</div>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
	<script src="../bootstrap/js/bootstrap.js"></script>

</body>
</html>