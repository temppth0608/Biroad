package board;

import java.sql.*;
import java.util.*;

import member.Member;
import totalpath.TotalPath;

public class BoardBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement st = null;
	ResultSet rs;

	/*
	 * state 1 -> 성공 state 2 -> 실패
	 */

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/biroad2?useUnicode=true&characterEncoding=UTF-8";

	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "654321");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	void disconnect() {
		if (pstmt != null) {
			try {
				pstmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		if (conn != null) {
			try {
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	public int insertBoardDB(String boardTitle, String boardText,
			String boardMemb, String boardPass, String boardDate,
			String boardRoad, String image) {

		connect();
		String sql = "insert into BOARD(BOARD_TITLE, BOARD_TEXT, BOARD_MEMB, BOARD_PASS,BOARD_DATE,heart,BOARD_ROAD,image) values(?,?,?,?,?,?,?,?)";

		System.out.println(boardRoad);

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardText);
			pstmt.setString(3, boardMemb);
			pstmt.setString(4, boardPass);
			pstmt.setString(5, boardDate);
			pstmt.setInt(6, 0);
			pstmt.setString(7, boardRoad);
			pstmt.setString(8, image);

			pstmt.execute();
			return 1;
		} catch (SQLException e) {
			e.printStackTrace();
			return 2;
		} finally {
			disconnect();
		}
	}

	public ArrayList<Board> getBoardDBList1() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%아라자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList2() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%한강종주자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList3() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%남한강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList4() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%북한강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList5() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%세제자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList6() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%낙동강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList7() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%금강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList8() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%영산강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList9() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%섬진강자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> getBoardDBList10() {
		connect();
		// (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board where board_road like '%오천자전거길%' order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Board board = new Board();

				board.setBoardId(rs.getInt("BOARD_ID"));
				board.setBoardDate(rs.getString("BOARD_DATE"));
				board.setBoardMemb(rs.getString("BOARD_MEMB"));
				board.setBoardPass(rs.getString("BOARD_PASS"));
				board.setBoardRoad(rs.getString("BOARD_ROAD"));
				board.setBoardText(rs.getString("BOARD_TEXT"));
				board.setBoardTitle(rs.getString("BOARD_TITLE"));
				board.setHeart(rs.getInt("heart"));
				board.setImage(rs.getString("IMAGE"));

				datas.add(board);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public boolean addHeart(int boardId) {

		connect();
		String sql = "update board set heart = heart+1 where board_id='"
				+ boardId + "'";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean updateBoardDB(int boardId, String boardTitle,
			String boardText, String boardPass, String boardDate) {

		connect();
		String sql = "update board set BOARD_TITLE=?, BOARD_TEXT=?,BOARD_PASS=?,BOARD_DATE=? WHERE BOARD_ID = '"
				+ boardId + "'";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardText);
			pstmt.setString(3, boardPass);
			pstmt.setString(4, boardDate);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public boolean deleteBoard(int boardId) {

		connect();
		String sql = "delete from board where board_id = '" + boardId + "'";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public Board getBDB(String BOARD_ID) { // 게시물 한개 정보 가져오기
		connect();
		String sql = "select * from board where BOARD_ID=?";
		Board bo = new Board();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, BOARD_ID);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			bo.setBoardId(rs.getInt("BOARD_ID"));
			bo.setBoardMemb(rs.getString("BOARD_MEMB"));
			bo.setBoardTitle(rs.getString("BOARD_TITLE"));
			bo.setBoardText(rs.getString("BOARD_TEXT"));
			bo.setBoardPass(rs.getString("BOARD_PASS"));
			bo.setBoardDate(rs.getString("BOARD_DATE"));
			bo.setHeart(rs.getInt("heart"));
			bo.setBoardRoad(rs.getString("BOARD_ROAD"));
			bo.setImage(rs.getString("image"));

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			disconnect();
		}
		return bo;
	}

	public boolean updateBoDB(Board bo) { // 게시물 수정
		connect();

		String sql = "update board set  BOARD_PASS=?, BOARD_TITLE=?, BOARD_DATE=?, BOARD_TEXT=? where BOARD_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, bo.getBoardPass());
			pstmt.setString(2, bo.getBoardTitle());
			pstmt.setString(3, bo.getBoardDate());
			pstmt.setString(4, bo.getBoardText());
			pstmt.setInt(5, bo.getBoardId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();

		}
		return true;
	}

	public ArrayList<Board> getBDBList() { // 게시물전체 정보출력
		connect(); // (리스트 출력)
		ArrayList<Board> datas = new ArrayList<Board>();

		String sql = "select * from board order by board_id asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				Board bo = new Board();

				bo.setBoardId(rs.getInt("BOARD_ID"));
				bo.setBoardMemb(rs.getString("BOARD_MEMB"));
				bo.setBoardTitle(rs.getString("BOARD_TITLE"));
				bo.setBoardText(rs.getString("BOARD_TEXT"));
				bo.setBoardPass(rs.getString("BOARD_PASS"));
				bo.setBoardDate(rs.getString("BOARD_DATE"));
				bo.setHeart(rs.getInt("heart"));
				bo.setBoardRoad(rs.getString("BOARD_ROAD"));
				bo.setImage(rs.getString("image"));

				datas.add(bo);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<Board> findInfo(String req, int index) { // 게시물검색
		connect();
		ArrayList<Board> list = new ArrayList<Board>();
		String sql = "";
		if (index == 0) {
			sql = "select * from board where BOARD_MEMB like ? order by BOARD_TITLE asc";
		} else if (index == 1) {
			sql = "select * from board where BOARD_ROAD like ? order by BOARD_TITLE asc";
		} else {
			sql = "select * from board where BOARD_TITLE like ? order by BOARD_TITLE asc";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			String setReq = "%" + req + "%";

			pstmt.setString(1, setReq);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {

				Board bo = new Board();

				bo.setBoardId(rs.getInt("BOARD_ID"));
				bo.setBoardMemb(rs.getString("BOARD_MEMB"));
				bo.setBoardTitle(rs.getString("BOARD_TITLE"));
				bo.setBoardText(rs.getString("BOARD_TEXT"));
				bo.setBoardPass(rs.getString("BOARD_PASS"));
				bo.setBoardDate(rs.getString("BOARD_DATE"));
				bo.setHeart(rs.getInt("heart"));
				bo.setBoardRoad(rs.getString("BOARD_ROAD"));
				bo.setImage(rs.getString("image"));

				list.add(bo);
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;

	}
}
