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
	String ab = request.getParameter("id1");
	
 	//사용자 로그인 모듈 
	 if(action.equals("login")) {
		if(member.isExistId(Member.getMemberId()) == 2) {
			out.println("<script>alert('등록되지 않은 아이디 입니다.');history.go(-1);</script>");
		} else {
			if(member.isManager(Member.getMemberId(), Member.getMemberPass())) {
			response.sendRedirect("admin_main.jsp");
			} else {
				if(member.loginCheck(Member.getMemberId(), Member.getMemberPass()) == 1) {
				Member mem = member.getMemDB(Member.getMemberId());
/* 	request.setAttribute("mem", mem);
 */				session.setAttribute("member", Member);
				pageContext.forward("main.jsp");		
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
		
	} else if (action.equals("show")) {
        
        TotalPath tpath = totalpath.getTPDB(id);
        request.setAttribute("totalpath",tpath);
        pageContext.forward("test5.jsp");
        
    } else if(action.equals("imageIndex")) {
    	String index = request.getParameter("index");
    	TotalPath tp = totalpath.getTPDB(index);
    	request.setAttribute("tp", tp);
    	pageContext.forward("total_path.jsp");
    	
    } else if (action.equals("subPathView")) {
    	String pathId = request.getParameter("pathId");
    	String tPathName = path.getTotalPathName(pathId);
    	String tPathId = request.getParameter("tPathId");

    	Path selectedPath = path.getPDB(pathId);
    	request.setAttribute("path",selectedPath);
    	request.setAttribute("tPathId", tPathId);
    	request.setAttribute("tPathName", tPathName);

    	pageContext.forward("path.jsp");
    	
    } else if (action.equals("bsel")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj");
		how = (String) request.getParameter("how");
		if (how.equals("ID")) {
			index = 0;
		} else if (how.equals("ROAD")) {
			index = 1;
		} else {
			index = 2;
		}
		ArrayList<Board> list = board.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=3&context=13");
	}
	//게시물 삭제검색
	else if (action.equals("bsel1")) {
		int index = 0;
		String req = null;
		String how = null;
		req = (String) request.getParameter("obj");
		how = (String) request.getParameter("how");
		if (how.equals("ID")) {
			index = 0;
		} else if (how.equals("ROAD")) {
			index = 1;
		} else {
			index = 2;
		}
		ArrayList<Board> list = board.findInfo(req, index);
		request.setAttribute("list", list);

		pageContext.forward("admin_main.jsp?mode=3&context=14");
	}
	//수정버튼클릭시 이동
	else if (action.equals("bedit")) {
		/*Member mem = member.getMemDB(id);
		request.setAttribute("member", mem);
		pageContext.forward("admin_edit.jsp");*/
		Board bo = board.getBDB(id);
		request.setAttribute("board", bo);
		pageContext.forward("admin_bedit.jsp");

	}
 	
 	else if (action.equals("bupdate")) {
 		
		if(board.updateBoDB(Board)){
			out.println("<script>alert('수정에 성공하셧습니다.'); location.href='admin_main.jsp?mode=3&context=13'; </script>");
		} else {
			out.println("<script>alert('수정에 실패하셧습니다.');history.go(-1);</script>");
		}
	
	} else if (action.equals("bdel")) {
		int id1 = Integer.parseInt((String) request.getParameter("id1"));
		if (board.deleteBoard(id1)) {
			out.println("<script>alert('게시물삭제 성공.'); location.href='admin_main.jsp?mode=3&context=14'; </script>");
		} else {
			out.println("<script>alert('게시물삭제 실패.');history.go(-1);</script>");
		}
		
	} else if (action.equals("content")){
		
		Board bo = board.getBDB(ab);
		request.setAttribute("board", bo);
		pageContext.forward("admin_content.jsp");
		
	} else if (action.equals("recommand")) {
		
		int index = 0;
		String start = null;
		String end = null;
		String diff = null;
		String time = null;
		String req = null;
		String req2 = null;
		String req3 = null;
		String req4 = null;
		String category = null;
		
		start = (String) request.getParameter("Start");
		end = (String) request.getParameter("End");
		diff = (String) request.getParameter("rating-input-1");
		time = (String) request.getParameter("Time");
		category = (String) request.getParameter("category");
		
		if(diff == null) {
			out.println("<script>alert('난이도를 선택해주세요!.');history.go(-1);</script>");
		}
		
		if ((start==null && end == null && diff == null) || (start==null && end==null && time==null) || 
				(start==null && diff==null && time==null) || (diff==null && end==null && time==null) ){
			if(start != null){
				index = 0;
				req = start;
			}else if (end != null){
				index = 1;
				req = end;
			}else if (diff != null){
				index = 2;
				req = diff;
			}else{
				index = 3;
				req = time;
			}
			
			if (category.equals("1")) {
				ArrayList<TotalPath> list = totalpath.recommand(req, index);
				request.setAttribute("list", list);
				pageContext.forward("recommendShow.jsp");
			} else if (category.equals("2")) {
				ArrayList<Path> plist = path.recommand(req, index);
				request.setAttribute("plist", plist);
				pageContext.forward("recommendShow2.jsp");
			}
			
		} else if ((start==null && end == null) || (start==null && time==null) || (start==null && diff==null) || (end==null && time==null)
				|| (end==null && diff==null) || (diff==null && time==null)){
			if((start != null) && (end != null)){
				index = 0;
				req = start;
				req2 = end;
			}else if ((start != null) && (diff != null)){
				index = 1;
				req = start;
				req2 = diff;
			}else if ((start != null) && (time != null)){
				index = 2;
				req = start;
				req2 = time;
			}else if ((end != null) && (diff != null)){
				index = 3;
				req = end;
				req2 = diff;
			}else if ((end != null) && (time != null)){
				index = 4;
				req = end;
				req2 = time;
			}else if ((diff != null) && (time != null)){
				index = 5;
				req = diff;
				req2 = time;
			}
			
			if (category.equals("1")) {
				ArrayList<TotalPath> list = totalpath.recommand2(req, req2,index);
				request.setAttribute("list", list);
				pageContext.forward("recommendShow.jsp");
			} else if (category.equals("2")) {
				ArrayList<Path> plist = path.recommand2(req,req2 ,index);
				request.setAttribute("plist", plist);
				pageContext.forward("recommendShow2.jsp");
			}
			
		}else if ((start==null)&&(end==null)&&(diff==null)&&(time==null)){
			if(time == null){
				index = 0;
				req = start;
				req2 = end;
				req3 = diff;
			} else if(diff == null) {
				index = 1;
				req = start;
				req2 = end;
				req3 = time;
			} else if(end == null) {
				index = 2;
				req = start;
				req2 = diff;
				req3 = time;
			} else if(start == null) {
				index = 3;
				req = end;
				req2 = diff;
				req3 = time;
			}
			if (category.equals("1")) {
				ArrayList<TotalPath> list = totalpath.recommand3(req,req2,req3, index);
				request.setAttribute("list", list);
				pageContext.forward("recommendShow.jsp");
			} else if (category.equals("2")) {
				ArrayList<Path> plist = path.recommand3(req,req2,req3, index);
				request.setAttribute("plist", plist);
				pageContext.forward("recommendShow2.jsp");
			}
			
		}else if(start != null && end != null && diff != null && time !=null){
			req = start;
			req2 = end;
			req3 = diff;
			req4 = time;
			
			if (category.equals("1")) {
				ArrayList<TotalPath> list = totalpath.recommand4(req, req2, req3, req4);
				request.setAttribute("list", list);
				pageContext.forward("recommendShow.jsp");
			} else if (category.equals("2")) {
				ArrayList<Path> plist = path.recommand4(req, req2, req3, req4);
				request.setAttribute("plist", plist);
				pageContext.forward("recommendShow2.jsp");
			}
		} 
	}
 	
	 /*if (board.updateBoardDB(Board.getBoardId(),
		Board.getBoardTitle(), Board.getBoardText(),
		Board.getBoardPass(), Board.getBoardDate())) {
		out.println("<script>alert('수정에 성공하셧습니다.'); location.href='admin_main.jsp?mode=3&context=13.jsp'; </script>");
	} else {
		out.println("<script>alert('수정에 실패하셧습니다.');history.go(-1);</script>");
	}*/

	/*TotalPath tpath = totalpath.getTPDB(id);
	request.setAttribute("totalpath", tpath);
	pageContext.forward("admin_detail.jsp");*/
%>