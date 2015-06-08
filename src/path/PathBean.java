package path;

import java.sql.*;
import java.util.*;

public class PathBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement st = null;
	ResultSet rs = null;

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

	public boolean insertPDB(Path path) {
		connect();

		String sql = "insert into path(PATH_ID, PATH_NAME, PATH_STARX,PATH_ENDX,PATH_STARY,PATH_ENDY,PATH_START,PATH_END,"
				+ "PATH_HOUR,PATH_DIFF,TPATH_ID,PATH_TEXT)"
				+ " values(?,?,?,?,?,?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, path.getPathId());
			pstmt.setString(2, path.getPathName());
			pstmt.setString(3, path.getPathStarX());
			pstmt.setString(4, path.getPathEndX());
			pstmt.setString(5, path.getPathStarY());
			pstmt.setString(6, path.getPathEndY());
			pstmt.setString(7, path.getPathStart());
			pstmt.setString(8, path.getPathEnd());
			pstmt.setString(9, path.getPathHour());
			pstmt.setString(10, path.getPathDiff());
			pstmt.setString(11, path.getTpathId());
			pstmt.setString(12, path.getPathText());
			// pstmt.setBinaryStream(parameterIndex, x);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// 아이디 존재 여부 체크
	public int isExistId(String id) {

		connect();

		String sql = "select * from path where PATH_ID='" + id + "'";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				return 1;
			} else {
				return 2;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}

	// 이름 존재 여부 체크
	public int isExistName(String name) {

		connect();

		String sql = "select * from path where PATH_NAME='" + name + "'";

		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if (rs.next()) {
				return 1;
			} else {
				return 2;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<Path> getPDBList(String tPathId) { // 세부도로 정보출력
		connect(); // (리스트 출력)
		ArrayList<Path> datas = new ArrayList<Path>();

		String sql = "select * from path where tpath_id = '"+tPathId+"' order by PATH_ID asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				Path path = new Path();

				path.setPathId(rs.getString("PATH_ID"));
				path.setPathName(rs.getString("PATH_NAME"));
				path.setPathStarX(rs.getString("PATH_STARX"));
				path.setPathStarY(rs.getString("PATH_STARY"));
				path.setPathEndX(rs.getString("PATH_ENDX"));
				path.setPathEndY(rs.getString("PATH_ENDY"));
				path.setPathStart(rs.getString("PATH_START"));
				path.setPathEnd(rs.getString("PATH_END"));
				path.setPathHour(rs.getString("PATH_HOUR"));
				path.setPathDiff(rs.getString("PATH_DIFF"));
				path.setTpathId(rs.getString("TPATH_ID"));
				path.setPathText(rs.getString("PATH_TEXT"));
				// path.setPathImage(pathImage);

				datas.add(path);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}
	
	public ArrayList<Path> getPDBList() { // 세부도로 정보출력
		connect(); // (리스트 출력)
		ArrayList<Path> datas = new ArrayList<Path>();

		String sql = "select * from path order by PATH_ID asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {

				Path path = new Path();

				path.setPathId(rs.getString("PATH_ID"));
				path.setPathName(rs.getString("PATH_NAME"));
				path.setPathStarX(rs.getString("PATH_STARX"));
				path.setPathStarY(rs.getString("PATH_STARY"));
				path.setPathEndX(rs.getString("PATH_ENDX"));
				path.setPathEndY(rs.getString("PATH_ENDY"));
				path.setPathStart(rs.getString("PATH_START"));
				path.setPathEnd(rs.getString("PATH_END"));
				path.setPathHour(rs.getString("PATH_HOUR"));
				path.setPathDiff(rs.getString("PATH_DIFF"));
				path.setTpathId(rs.getString("TPATH_ID"));
				path.setPathText(rs.getString("PATH_TEXT"));
				// path.setPathImage(pathImage);

				datas.add(path);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}
	
	

	public ArrayList<Path> findInfo(String req, int index) { // 도로검색
		connect();
		ArrayList<Path> list = new ArrayList<Path>();
		String sql = "";
		if (index == 0) {
			sql = "select * from path where PATH_ID like ? order by PATH_NAME asc";
		} else if (index == 1) {
			sql = "select * from path where PATH_NAME like ? order by PATH_NAME asc";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			String setReq = "%" + req + "%";

			pstmt.setString(1, setReq);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Path path = new Path();

				path.setPathId(rs.getString("PATH_ID"));
				path.setPathName(rs.getString("PATH_NAME"));
				path.setPathStarX(rs.getString("PATH_STARX"));
				path.setPathStarY(rs.getString("PATH_STARY"));
				path.setPathEndX(rs.getString("PATH_ENDX"));
				path.setPathEndY(rs.getString("PATH_ENDY"));
				path.setPathStart(rs.getString("PATH_START"));
				path.setPathEnd(rs.getString("PATH_END"));
				path.setPathHour(rs.getString("PATH_HOUR"));
				path.setPathDiff(rs.getString("PATH_DIFF"));
				path.setTpathId(rs.getString("TPATH_ID"));
				path.setPathText(rs.getString("PATH_TEXT"));
				// path.setPathImage(pathImage);
				list.add(path);
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;

	}

	public boolean deletePDB(String PATH_ID) { // 세부도로 삭제
		connect();

		String sql = "delete from path where PATH_ID = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, PATH_ID);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	public Path getPDB(String PATH_ID) { // 도로 한 개 정보 가져오기
		connect();
		String sql = "select * from path where PATH_ID=?";

		Path path = new Path();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, PATH_ID);
			ResultSet rs = pstmt.executeQuery();

			rs.next();

			path.setPathId(rs.getString("PATH_ID"));
			path.setPathName(rs.getString("PATH_NAME"));
			path.setPathStarX(rs.getString("PATH_STARX"));
			path.setPathStarY(rs.getString("PATH_STARY"));
			path.setPathEndX(rs.getString("PATH_ENDX"));
			path.setPathEndY(rs.getString("PATH_ENDY"));
			path.setPathStart(rs.getString("PATH_START"));
			path.setPathEnd(rs.getString("PATH_END"));
			path.setPathHour(rs.getString("PATH_HOUR"));
			path.setPathDiff(rs.getString("PATH_DIFF"));
			path.setTpathId(rs.getString("TPATH_ID"));
			path.setPathText(rs.getString("PATH_TEXT"));
			// path.setPathImage(pathImage);

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			disconnect();
		}
		return path;
	}

	public boolean updatePathDB(Path path) { // 도로 수정
		connect();

		String sql = "update path set  PATH_NAME=?, PATH_STARX=?, PATH_STARY=?, PATH_ENDX=?, PATH_ENDY=?"
				+ ",PATH_START=?, PATH_END=?, PATH_HOUR=?, PATH_DIFF=?, TPATH_ID=?, PATH_TEXT=? where PATH_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, path.getPathName());
			pstmt.setString(2, path.getPathStarX());
			pstmt.setString(3, path.getPathStarY());
			pstmt.setString(4, path.getPathEndX());
			pstmt.setString(5, path.getPathEndY());
			pstmt.setString(6, path.getPathStart());
			pstmt.setString(7, path.getPathEnd());
			pstmt.setString(8, path.getPathHour());
			pstmt.setString(9, path.getPathDiff());
			pstmt.setString(10, path.getTpathId());
			pstmt.setString(11, path.getPathText());
			pstmt.setString(12, path.getPathId());

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();

		}
		return true;
	}
	
	public String getTotalPathName(String pathId) {
		
		connect();
		String sql = "select TotalPath.TPATH_NAME from TotalPath,Path where Path.Tpath_id = TotalPath.TPATH_ID and Path.PATH_ID = '"+pathId+"'";
		String retVal = "";
		
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			if(rs.next()) {
				retVal = rs.getString(1);
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return retVal;
	}
}
