<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"
	import="java.util.*,java.sql.*,board.*,member.*,comment.*,totalpath.*,path.*"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLDecoder"%>
<%
	request.setCharacterEncoding("utf-8");
/* 	response.setContentType("text/html; charset=euc-kr"); */
%>
<jsp:useBean id="board" scope="page" class="board.BoardBean" />
<jsp:useBean id="Board" class="board.Board" />
<jsp:setProperty name="Board" property="*" />

<jsp:useBean id="member" scope="page" class="member.MemberBean" />
<jsp:useBean id="Member" class="member.Member" />
<jsp:setProperty name="Member" property="*" />

<jsp:useBean id="comment" scope="page" class="comment.CommentBean" />
<jsp:useBean id="Comment" class="comment.Comment" />
<jsp:setProperty name="Comment" property="*" />

<jsp:useBean id="totalpath" scope="page" class="totalpath.TotalPathBean" />
<jsp:useBean id="Totalpath" class="totalpath.TotalPath" />
<jsp:setProperty name="Totalpath" property="*" />

<jsp:useBean id="path" scope="page" class="path.PathBean" />
<jsp:useBean id="Path" class="path.Path" />
<jsp:setProperty name="Path" property="*" />
<%
	String action = request.getParameter("action");
	String id = request.getParameter("id");
	
 	//사용자 로그인 모듈 
	 if(action.equals("login")) {
		if(member.isExistId(Member.getMemberId()) == 2) {
	out.println("<script>alert('등록되지 않은 아이디 입니다.');history.go(-1);</script>");
		} else {
	if(member.isManager(Member.getMemberId(), Member.getMemberPass())) {
	response.sendRedirect("admin_main.jsp");
	} else {
		if(member.loginCheck(Member.getMemberId(), Member.getMemberPass()) == 1) {
		session.setAttribute("member", Member);	
		response.sendRedirect("main.jsp");
		} else {
		out.println("<script>alert('비밀번호가 틀립니다.');history.go(-1);</script>");
		}
	}
		}
	//사용자 회원가입 모듈	
	} else if(action.equals("register")) {
		if(member.isExistId(Member.getMemberId()) == 1) {
	out.println("<script>alert('기존에 등록된 아이디입니다.');history.go(-1);</script>");
		} else {
	if(member.insertMemDB(Member)) {
		out.println("<script>alert('가입에 성공하셧습니다.'); location.href='index.jsp'; </script>");
	} else {
		out.println("<script>alert('회원가입에 실패하셧습니다.');history.go(-1);</script>");
	}	
		}
	//사용자 로그아웃 모듈		
	} else if(action.equals("logout")) {
		session.removeAttribute("memberID");
		response.sendRedirect("index.jsp");
		
	} else if(action.equals("edit")) {
		if(member.updateMemDB(Member)) {
	out.println("<script>alert('수정에 성공하셧습니다.'); location.href='main.jsp'; </script>");
		} else {
	out.println("<script>alert('수정에 실패하엿습니다(수정값 확인)');history.go(-1);</script>");
		}
	//사용자 회원탈퇴 
	}else if(action.equals("withdrawal")) {
		if(member.deleteUser(Member.getMemberId(), Member.getMemberPass())) {
	out.println("<script>alert('탈퇴에 성공하셧습니다.'); location.href='index.jsp';</script>");
		} else {
	out.println("<script>alert('비밀번호가 틀립니다.'); location.href='main.jsp';</script>");
		}
	//관리자 회원 검색 모듈
		
	} else if(action.equals("write")) {
		String boardRoad = new String(request.getParameter("boardRoad").getBytes("iso-8859-1"), "UTF-8");
		request.setAttribute("member", Member.getMemberId());
		request.setAttribute("boardRoad", boardRoad);
		pageContext.forward("write.jsp");
		
	} else if(action.equals("writeBoard")) {
		
	 	if(board.insertBoardDB(Board.getBoardTitle(), Board.getBoardText(), Board.getBoardMemb(), Board.getBoardPass(), Board.getBoardDate(), Board.getBoardRoad(), Board.getImage()) == 1) {
	out.println("<script>alert('등록에 성공하셧습니다.'); location.href='bistory.jsp'; </script>");
		} else {
	out.println("<script>alert('등록에 실패하셧습니다.'); location.href='bistory.jsp'; </script>");
		}
	 	
	} else if(action.equals("heart")) {
		if(board.addHeart(Board.getBoardId())) {
	out.println("<script>location.href='bistory.jsp'; </script>");
		}
		
	} else if(action.equals("comment")) {
		int boardId = Integer.parseInt((String) request.getParameter("boardId"));
		String text = (String) request.getParameter("text1");
		String commMemb = (String) request.getParameter("commMemb");
		
		if(comment.insertComment(boardId, text, commMemb)) {
	out.println("<script>alert('등록에 성공하셧습니다.'); </script>");
	pageContext.forward("view.jsp?idx="+boardId);
		} else {
	out.println("<script>alert('등록에 실패하셧습니다.'); </script>");
	pageContext.forward("view.jsp?idx="+boardId);
		}
		
	} else if(action.equals("checkPassword")) {
		int boardId = Integer.parseInt((String) request.getParameter("boardId"));
		String boardPass = (String) request.getParameter("boardPass");
		String inputPassword = (String) request.getParameter("inputPassword");
		String boardRoad = (String) request.getParameter("boardRoad");
		String boardText = (String) request.getParameter("boardText");
		String boardTitle = (String) request.getParameter("boardTitle");
		
		if(boardPass.equals(inputPassword)) {
			request.setAttribute("boardId", boardId);
			request.setAttribute("boardRoad", boardRoad);
			request.setAttribute("boardText", boardText);
			request.setAttribute("boardTitle", boardTitle);
			
			pageContext.forward("edit.jsp");
		} else {
			out.println("<script>alert('비밀번호가 일치하지 않습니다.');history.go(-1);</script>");
		}
		
	}else if(action.equals("editBoard")) {
		 
		if(board.updateBoardDB(Board.getBoardId(), Board.getBoardTitle(), Board.getBoardText(), Board.getBoardPass(), Board.getBoardDate())) {
			out.println("<script>alert('수정에 성공하셧습니다.'); location.href='bistory.jsp'; </script>");
		} else {
			out.println("<script>alert('수정에 실패하셧습니다.'); location.href='bistory.jsp'; </script>");
		}
		
	} else if(action.equals("deleteBoard")) {
		int boardId = Integer.parseInt((String) request.getParameter("boardId"));
		String boardPass = (String) request.getParameter("boardPass");
		String inputPassword = (String) request.getParameter("inputPassword");
		
		if(boardPass.equals(inputPassword)) {
	board.deleteBoard(boardId);
	out.println("<script>alert('게시물을 삭제하였습니다.'); location.href='bistory.jsp'; </script>");
		} else { 
	out.println("<script>alert('비밀번호가 일치하지 않습니다.');location.href='bistory.jsp';</script>");
		}
		
		
	}//회원검색삭제파트
	else if (action.equals("msel")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj");
		how = (String) request.getParameter("how");
		if (how.equals("ID")) {
	index = 0;
		} else if (how.equals("NAME")) {
	index = 1;
		} else {
	index = 2;
		}
		ArrayList<Member> list = member.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=1&context=2");
	}

	//회원검색수정파트
	else if (action.equals("msel1")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj");
		how = (String) request.getParameter("how");
		if (how.equals("ID")) {
	index = 0;
		} else if (how.equals("NAME")) {
	index = 1;
		} else {
	index = 2;
		}
		ArrayList<Member> list = member.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=1&context=1");
	}
	//전체도로검색삭제파트
	else if (action.equals("TPsel")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj1");
		how = (String) request.getParameter("how1");
		if (how.equals("ID1")) {
	index = 0;
		} else {
	index = 1;
		}
		//ArrayList<Member> list = member.findInfo(req, index);
		ArrayList<TotalPath> list = totalpath.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=2&context=4");
	}
	else if (action.equals("TPsel1")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj1");
		how = (String) request.getParameter("how1");
		if (how.equals("ID1")) {
	index = 0;
		} else {
	index = 1;
		}
		//ArrayList<Member> list = member.findInfo(req, index);
		ArrayList<TotalPath> list = totalpath.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=2&context=9");
	}
	//세부도로검색삭제파트
	else if (action.equals("Psel")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj1");
		how = (String) request.getParameter("how1");
		if (how.equals("ID1")) {
	index = 0;
		} else {
	index = 1;
		}
		ArrayList<Path> list = path.findInfo(req, index);
		//ArrayList<Path> list = path.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=2&context=7");
	}else if (action.equals("Psel1")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj1");
		how = (String) request.getParameter("how1");
		if (how.equals("ID1")) {
	index = 0;
		} else {
	index = 1;
		}
		ArrayList<Path> list = path.findInfo(req, index);
		//ArrayList<Path> list = path.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=2&context=10");
	}

	//수정버튼클릭시 이동
	else if (action.equals("medit")) {
		Member mem = member.getMemDB(id);
		request.setAttribute("member", mem);
		pageContext.forward("admin_edit.jsp");

	}
	//수정버튼클릭시 이동
	else if (action.equals("goPup1")) {
		Path pat = path.getPDB(id);
		request.setAttribute("path", pat);
		//Member mem = member.getMemDB(id);
		//request.setAttribute("member", mem);
		pageContext.forward("admin_Pupdate.jsp");

	}
	//수정버튼클릭시 이동
	else if (action.equals("goTup1")) {
		//Member mem = member.getMemDB(id);
		//request.setAttribute("member", mem);
		TotalPath tp = totalpath.getTPDB(id);
		request.setAttribute("totalpath",tp);
		pageContext.forward("admin_TPupdate.jsp");

	}
	//상세보기
	else if (action.equals("TPdetail")) {
		TotalPath tpath = totalpath.getTPDB(id);
		request.setAttribute("totalpath", tpath);
		pageContext.forward("admin_detail.jsp");
	}
	//상세보기
	else if (action.equals("Pdetail")) {
		Path path1 = path.getPDB(id);
		request.setAttribute("path", path1);
		pageContext.forward("admin_pdetail.jsp");
	} else if (action.equals("goTdel")) {
		pageContext.forward("admin_main.jsp?mode=2&context=4");
	} else if (action.equals("goPdel")) {
		pageContext.forward("admin_main.jsp?mode=2&context=7");
	} else if (action.equals("goTup")) {
		pageContext.forward("admin_main.jsp?mode=2&context=9");
	} else if (action.equals("goPup")) {
		pageContext.forward("admin_main.jsp?mode=2&context=10");
	}

	//회원 수정
	else if (action.equals("mupdate")) {
		if (member.updateMemDB(Member)) {
	out.println("<script>alert('회원수정 성공.'); location.href='admin_main.jsp?mode=1&context=1'; </script>");
		} else {
	out.println("<script>alert('회원수정 실패.');history.go(-1);</script>");
		}
	}

	//도로 삽입
	else if (action.equals("Trinsert")) {
		if (totalpath.isExistId(Totalpath.getTotalPathId()) == 1) {
	out.println("<script>alert('도로가 중복됩니다.');history.go(-1);</script>");
		} else {
	if (totalpath.insertTPDB(Totalpath)) {
		out.println("<script>alert('도로추가 성공.'); location.href='admin_main.jsp?mode=2&context=3'; </script>");
	} else {
		out.println("<script>alert('도로추가 실패.');history.go(-1);</script>");
	}
		}
	}

	else if (action.equals("mdel")) {
		if (member.deleteMemDB(id)) {
	out.println("<script>alert('회원삭제 성공.'); location.href='admin_main.jsp?mode=1&context=2'; </script>");
		} else {
	out.println("<script>alert('회원삭제 실패.');history.go(-1);</script>");
		}
	}

	//전체도로삭제
	else if (action.equals("TPdel")) {
		if (totalpath.deleteTPDB(id)) {
	out.println("<script>alert('전체도로삭제 성공.'); location.href='admin_main.jsp?mode=2&context=4'; </script>");
		} else {
	out.println("<script>alert('전체도로삭제 실패.');history.go(-1);</script>");
		}
	} else if (action.equals("Pdel")) {
		if (path.deletePDB(id)) {
	out.println("<script>alert('전체도로삭제 성공.'); location.href='admin_main.jsp?mode=2&context=7'; </script>");
		} else {
	out.println("<script>alert('전체도로삭제 실패.');history.go(-1);</script>");
		}
	}

	//세부도로추가
	else if (action.equals("rinsert")) {
		if (path.isExistId(Path.getPathId()) == 1) {
	out.println("<script>alert('도로ID가 중복됩니다.');history.go(-1);</script>");
		} else if (path.isExistName(Path.getPathName()) == 1) {
	out.println("<script>alert('도로이름 중복됩니다.');history.go(-1);</script>");
		} else {
	if (path.insertPDB(Path)) {
		out.println("<script>alert('도로추가 성공.'); location.href='admin_main.jsp?mode=2&context=5'; </script>");
	} else {
		out.println("<script>alert('도로추가 실패.');history.go(-1);</script>");
	}

		}

	} else if (action.equals("rupdate")) {
		if (path.updatePathDB(Path)) {
	out.println("<script>alert('도로수정 성공.'); location.href='admin_main.jsp?mode=2&context=10'; </script>");
		} else {
	out.println("<script>alert('도로수정 실패.');history.go(-1);</script>");
		}
	}
	else if (action.equals("trupdate")) {
		if (totalpath.updateTPathDB(Totalpath)) {
	out.println("<script>alert('도로수정 성공.'); location.href='admin_main.jsp?mode=2&context=9'; </script>");
		} else {
	out.println("<script>alert('도로수정 실패.');history.go(-1);</script>");
		}
		
	}
%>