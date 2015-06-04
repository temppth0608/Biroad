<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8" import="
java.util.*,
java.sql.*,
board.*,
member.*"%>

<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.*"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>

<jsp:useBean id="board" scope="page" class="board.BoardBean" />
<jsp:useBean id="Board" class="board.Board" />
<jsp:setProperty name="Board" property="*" />

<%
	request.setCharacterEncoding("utf-8");

	// 10Mbyte 제한
	int maxSize = 1024 * 1024 * 10;

	// 웹서버 컨테이너 경로
	String root = request.getSession().getServletContext()
			.getRealPath("/");

	String root2 = "/Users/ParkTaeHyun/Documents/workspace/BIROAD/WebContent/";

	// 파일 저장 경로(ex : /home/tour/web/ROOT/upload)
	String savePath = root2 + "upload";

	// 업로드 파일명
	String uploadFile = "";

	// 실제 저장할 파일명
	String newFileName = "";

	String memberId = "";
	String boardRoad = "";

	int read = 0;
	byte[] buf = new byte[1024];
	FileInputStream fin = null;
	FileOutputStream fout = null;
	long currentTime = System.currentTimeMillis();
	SimpleDateFormat simDf = new SimpleDateFormat("yyyyMMddHHmmss");

	try {

		MultipartRequest multi = new MultipartRequest(request,
				savePath, maxSize, "utf-8",
				new DefaultFileRenamePolicy());

		// 전송받은 parameter의 한글깨짐 방지
		String title = multi.getParameter("title");
		/* title = new String(title.getBytes("ISO-8859-1"), "UTF-8"); */
		boardRoad = multi.getParameter("boardRoad");
		/* boardRoad = new String(boardRoad.getBytes("ISO-8859-1"),"UTF-8"); */
		memberId = multi.getParameter("boardMemb");
		/* memberId = new String(memberId.getBytes("8859_1"), "UTF-8"); */

		// 파일업로드
		uploadFile = multi.getFilesystemName("uploadFile");

		// 실제 저장할 파일명(ex : 20140819151221.zip)
		newFileName = simDf.format(new Date(currentTime)) + "."
				+ uploadFile.substring(uploadFile.lastIndexOf(".") + 1);

		// 업로드된 파일 객체 생성
		File oldFile = new File(savePath + uploadFile);

		// 실제 저장될 파일 객체 생성
		File newFile = new File(savePath + newFileName);

		// 파일명 rename
		if (!oldFile.renameTo(newFile)) {

			// rename이 되지 않을경우 강제로 파일을 복사하고 기존파일은 삭제

			buf = new byte[1024];
			fin = new FileInputStream(oldFile);
			fout = new FileOutputStream(newFile);
			read = 0;
			while ((read = fin.read(buf, 0, buf.length)) != -1) {
				fout.write(buf, 0, read);
			}

			fin.close();
			fout.close();
			oldFile.delete();
		}

	} catch (Exception e) {
		e.printStackTrace();
	}

	request.setAttribute("member", memberId);
	request.setAttribute("boardRoad", boardRoad);
	request.setAttribute("fileName", uploadFile);
	
	out.println(memberId);
	out.println(boardRoad);
	out.println(uploadFile);
%>

<script>
	alert('이미지 등록에 성공하셧습니다.');
</script>
<%
		pageContext.forward("write.jsp");
%>
