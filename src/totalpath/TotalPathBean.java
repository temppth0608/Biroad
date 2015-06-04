package totalpath;

import java.sql.*;
import java.util.*;



public class TotalPathBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	Statement st = null;
	ResultSet rs = null;
	
	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/biroad2?useUnicode=true&characterEncoding=UTF-8";
	
	void connect(){
		try{
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url,"root","654321");
		
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	void disconnect(){
		if(pstmt != null){
			try{
				pstmt.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
		if(conn != null){
			try{
				conn.close();
			}catch(SQLException e){
				e.printStackTrace();
			}
		}
	}
	
	public boolean insertTPDB(TotalPath Tpath) {
		connect();

		String sql = "insert into totalpath values(?,?,?,?,?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Tpath.getTotalPathId());
			pstmt.setString(2, Tpath.getTotalPathName());
			pstmt.setString(3, Tpath.getTotalPathStarX());
			pstmt.setString(4, Tpath.getTotalPathEndX());
			pstmt.setString(5, Tpath.getTotalPathStarY());
			pstmt.setString(6, Tpath.getTotalPathEndY());
			pstmt.setString(7, Tpath.getTotalPathStart());
			pstmt.setString(8, Tpath.getTotalPathEnd());
			pstmt.setString(9, Tpath.getTotalPathThour());
			pstmt.setString(10, Tpath.getTotalPathAvgd());
			pstmt.setString(11, Tpath.getTotalPathText());

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

		String sql = "select * from totalpath where TPATH_ID='" + id + "'";

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

		String sql = "select * from totalpath where TPATH_NAME='" + name + "'";

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

	public ArrayList<TotalPath> getTPDBList() { // 전체도로 정보출력
		connect(); // (리스트 출력)
		ArrayList<TotalPath> datas = new ArrayList<TotalPath>();

		String sql = "select * from totalpath order by TPATH_ID asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				TotalPath tpath = new TotalPath();

				tpath.setTotalPathId(rs.getString("TPATH_ID"));
				tpath.setTotalPathName(rs.getString("TPATH_NAME"));
				tpath.setTotalPathStarX(rs.getString("TPATH_STARX"));
				tpath.setTotalPathEndX(rs.getString("TPATH_ENDX"));
				tpath.setTotalPathStarY(rs.getString("TPATH_STARY"));
				tpath.setTotalPathEndY(rs.getString("TPATH_ENDY"));
				tpath.setTotalPathStart(rs.getString("TPATH_START"));
				tpath.setTotalPathEnd(rs.getString("TPATH_END"));
				tpath.setTotalPathThour(rs.getString("TPATH_THOUR"));
				tpath.setTotalPathAvgd(rs.getString("TPATH_AVGD"));
				tpath.setTotalPathText(rs.getString("TPATH_TEXT"));

				datas.add(tpath);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	public ArrayList<TotalPath> findInfo(String req, int index) { // 도로검색
		connect();
		ArrayList<TotalPath> list = new ArrayList<TotalPath>();
		String sql = "";
		if (index == 0) {
			sql = "select * from totalpath where TPATH_ID like ? order by TPATH_NAME asc";
		} else if (index == 1){
			sql = "select * from totalpath where TPATH_NAME like ? order by TPATH_NAME asc";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			String setReq = "%" + req + "%";

			pstmt.setString(1, setReq);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				
				TotalPath tpath = new TotalPath();

				tpath.setTotalPathId(rs.getString("TPATH_ID"));
				tpath.setTotalPathName(rs.getString("TPATH_NAME"));
				tpath.setTotalPathStarX(rs.getString("TPATH_STARX"));
				tpath.setTotalPathEndX(rs.getString("TPATH_ENDX"));
				tpath.setTotalPathStarY(rs.getString("TPATH_STARY"));
				tpath.setTotalPathEndY(rs.getString("TPATH_ENDY"));
				tpath.setTotalPathStart(rs.getString("TPATH_START"));
				tpath.setTotalPathEnd(rs.getString("TPATH_END"));
				tpath.setTotalPathThour(rs.getString("TPATH_THOUR"));
				tpath.setTotalPathAvgd(rs.getString("TPATH_AVGD"));
				tpath.setTotalPathText(rs.getString("TPATH_TEXT"));

				list.add(tpath);
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;

	}
	
	public boolean deleteTPDB(String TPATH_ID) {		//전체도로 삭제
		connect();

		String sql = "delete from totalpath where TPATH_ID = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, TPATH_ID);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
	
	public TotalPath getTPDB(String TPATH_ID) { // 도로 한 개 정보 가져오기
		connect();
		String sql = "select * from totalpath where TPATH_ID=?";
		
		TotalPath tpath = new TotalPath();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, TPATH_ID);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			
			tpath.setTotalPathId(rs.getString("TPATH_ID"));
			tpath.setTotalPathName(rs.getString("TPATH_NAME"));
			tpath.setTotalPathStarX(rs.getString("TPATH_STARX"));
			tpath.setTotalPathEndX(rs.getString("TPATH_ENDX"));
			tpath.setTotalPathStarY(rs.getString("TPATH_STARY"));
			tpath.setTotalPathEndY(rs.getString("TPATH_ENDY"));
			tpath.setTotalPathStart(rs.getString("TPATH_START"));
			tpath.setTotalPathEnd(rs.getString("TPATH_END"));
			tpath.setTotalPathThour(rs.getString("TPATH_THOUR"));
			tpath.setTotalPathAvgd(rs.getString("TPATH_AVGD"));
			tpath.setTotalPathText(rs.getString("TPATH_TEXT"));

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			disconnect();
		}
		return tpath;
	}
	public boolean updateTPathDB(TotalPath tpath) { // 도로 수정
		connect();

		String sql = "update totalpath set  TPATH_NAME=?, TPATH_STARX=?, TPATH_STARY=?, TPATH_ENDX=?, TPATH_ENDY=?"
				+ ",TPATH_START=?, TPATH_END=?, TPATH_THOUR=?, TPATH_AVGD=?, TPATH_TEXT=? where TPATH_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, tpath.getTotalPathName());
			pstmt.setString(2, tpath.getTotalPathStarX());
			pstmt.setString(3, tpath.getTotalPathStarY());
			pstmt.setString(4, tpath.getTotalPathEndX());
			pstmt.setString(5, tpath.getTotalPathEndY());
			pstmt.setString(6, tpath.getTotalPathStart());
			pstmt.setString(7, tpath.getTotalPathEnd());
			pstmt.setString(8, tpath.getTotalPathThour());
			pstmt.setString(9, tpath.getTotalPathAvgd());
			pstmt.setString(10, tpath.getTotalPathText());
			pstmt.setString(11, tpath.getTotalPathId());
				
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();

		}
		return true;
	}
}
