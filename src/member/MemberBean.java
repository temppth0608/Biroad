package member;

import java.sql.*;
import java.util.*;

import board.Board;

public class MemberBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	Statement st = null;
	ResultSet rs;

	String jdbc_driver = "com.mysql.jdbc.Driver";
	String jdbc_url = "jdbc:mysql://localhost/biroad2?useUnicode=true&characterEncoding=UTF-8";

	//데이터 베이스 연결
	void connect() {
		try {
			Class.forName(jdbc_driver);
			conn = DriverManager.getConnection(jdbc_url, "root", "654321");

		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//데이터 베이스 연결 헤제
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
	
	//관리자 여부 검사
	public boolean isManager(String id, String password) {
		
		connect();
		
		String sql = "select * from MEMBER where memb_id='"+id+"' and memb_pass='"+password+"' and A_CHECK = 1";
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				return true;
			} else {
				return false;
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}	
		return false;
	}

	//아이디 존재 여부 체크
	public int isExistId(String id) {
		
		connect();
		
		String sql = "select * from MEMBER where MEMB_ID='"+id+"'";
		
		try {
			st = conn.createStatement();
			rs = st.executeQuery(sql);
			if(rs.next()) {
				return 1;
			} else {
				return 2;
			}
		} catch(SQLException e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	//로그인 체크
	public int loginCheck(String id, String password) {

		connect();

		String sql = "select * from MEMBER where MEMB_ID='" + id
				+ "'and MEMB_PASS='" + password + "'";

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

	// 회원 DB삽입
	public boolean insertMemDB(Member mem) { 
		connect();

		String sql = "insert into member values(?,?,?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mem.getMemberId());
			pstmt.setString(2, mem.getMemberPass());
			pstmt.setString(3, mem.getMemberName());
			pstmt.setString(4, mem.getMemberEmail());
			pstmt.setString(5, mem.getMemberGender());
			pstmt.setString(6, mem.getModel());
			pstmt.setInt(7, 0);

			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// 회원 수정
	public boolean updateMemDB(Member mem) { 
		connect();

		String sql = "update member set  MEMB_PASS=?, MEMB_NM=?, MEMB_EMAIL=?, MEMB_GENDER=?, MODEL=? where MEMB_ID=?";

		try {
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, mem.getMemberPass());
			pstmt.setString(2, mem.getMemberName());
			pstmt.setString(3, mem.getMemberEmail());
			pstmt.setString(4, mem.getMemberGender());
			pstmt.setString(5, mem.getModel());
			pstmt.setString(6, mem.getMemberId());
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();

		}
		return true;
	}
	
	//사용자 회원탈퇴기능
	public boolean deleteUser(String id, String password) {
		
		connect();

		String sql = "delete from member where MEMB_ID = '"+id+"' and MEMB_PASS ='"+password+"'";

		try {
			int state;
			pstmt = conn.prepareStatement(sql);
			state = pstmt.executeUpdate(sql);
			System.out.print(state);
			if (state == 1) {
				return true;
			} else {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return false;
	}
	
	//관리회원삭제기능
	public boolean deleteMemDB(String MEMB_ID) {
		connect();

		String sql = "delete from member where MEMB_ID = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MEMB_ID);
			pstmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}

	// 회원 한 명 정보 가져오기
	public Member getMemDB(String MEMB_ID) { 
		connect();
		String sql = "select * from member where MEMB_ID=?";
		Member mem = new Member();

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, MEMB_ID);
			ResultSet rs = pstmt.executeQuery();

			rs.next();
			mem.setMemberId(rs.getString("MEMB_ID"));
			mem.setMemberPass(rs.getString("MEMB_PASS"));
			mem.setMemberName(rs.getString("MEMB_NM"));
			mem.setMemberEmail(rs.getString("MEMB_EMAIL"));
			mem.setMemberGender(rs.getString("MEMB_GENDER"));
			mem.setModel(rs.getString("MODEL"));

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();

		} finally {
			disconnect();
		}
		return mem;
	}

	// 회원전체 정보출력
	public ArrayList<Member> getMemDBList() { 
		connect(); 
		// (리스트 출력)
		ArrayList<Member> datas = new ArrayList<Member>();

		String sql = "select * from member order by MEMB_ID asc";
		try {
			pstmt = conn.prepareStatement(sql);

			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Member mem = new Member();

				mem.setMemberId(rs.getString("MEMB_ID"));
				mem.setMemberPass(rs.getString("MEMB_PASS"));
				mem.setMemberName(rs.getString("MEMB_NM"));
				mem.setMemberEmail(rs.getString("MEMB_EMAIL"));
				mem.setMemberGender(rs.getString("MEMB_GENDER"));
				mem.setModel(rs.getString("MODEL"));

				datas.add(mem);
			}
			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return datas;
	}

	// 회원검색
	public ArrayList<Member> findInfo(String req, int index) { 
		connect();
		ArrayList<Member> list = new ArrayList<Member>();
		String sql = "";
		if (index == 0) {
			sql = "select * from member where MEMB_ID like ? order by MEMB_NM asc";
		} else if (index == 1) {
			sql = "select * from member where MEMB_NM like ? order by MEMB_NM asc";
		} else {
			sql = "select * from member where MEMB_EMAIL like ? order by MEMB_NM asc";
		}

		try {
			pstmt = conn.prepareStatement(sql);
			String setReq = "%" + req + "%";

			pstmt.setString(1, setReq);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Member mem = new Member();

				mem.setMemberId(rs.getString("MEMB_ID"));
				mem.setMemberPass(rs.getString("MEMB_PASS"));
				mem.setMemberName(rs.getString("MEMB_NM"));
				mem.setMemberEmail(rs.getString("MEMB_EMAIL"));
				mem.setMemberGender(rs.getString("MEMB_GENDER"));
				mem.setModel(rs.getString("MODEL"));
				list.add(mem);
			}

			rs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			disconnect();
		}
		return list;

	}

	public Member mset(String memberId, String memberPass, String memberName,
			String memberEmail, String memberGender, String Model) {
		Member mem = new Member();
		mem.setMemberId(memberId);
		mem.setMemberPass(memberPass);
		mem.setMemberName(memberName);
		mem.setMemberEmail(memberEmail);
		mem.setMemberGender(memberGender);
		mem.setModel(Model);
		return mem;
	}

}
