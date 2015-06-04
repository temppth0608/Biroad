package comment;

import java.sql.*;
import java.util.*;

public class CommentBean {
	Connection conn = null;
	PreparedStatement pstmt = null;
	
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
	
	public boolean insertComment(int boardId, String text, String commMemb) {
		
		connect();
		
		String sql = "insert into comment(board_id,comm_memb,COMM_TEXT) values(?,?,?)";
		System.out.println(text);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardId);
			pstmt.setString(2, commMemb);
			pstmt.setString(3, text);
			pstmt.execute();
		} catch(SQLException e) {
			e.printStackTrace();
			return false;
		} finally {
			disconnect();
		}
		return true;
	}
}
