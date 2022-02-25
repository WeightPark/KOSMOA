package member.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;
import member.vo.*;

public class DupIdDao {
	private static DupIdDao dupIdDao;
	private Connection conn;
	
	private DupIdDao() {}	// 외부에서 함부로 인스턴스를 생성하지 못하게 private로 생성자를 선언 
	
	public static DupIdDao getInstance() {	// 싱글톤 방식으로 인스턴스 낭비를 줄임
		if (dupIdDao == null)	 dupIdDao = new DupIdDao();	// 기존의 인스턴스가 존재하면 새롭게 만들지 않고, 없을 경우에만 새로 생성하게 함 
		return dupIdDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int chkDupId(String uid) { // 회원 가입시 사용자가 사용할 아이디의 중복 여부를 리턴할 메서드 
		Statement stmt = null;	// 코드를 db에 옮기고 받아올 객체 
		ResultSet rs = null;	// select로 받아온 코드를 저장할 객체 
		int result = 0; // 중복된 아이디 개수를 저장할 변수(중복되었으면 : 1 , 안되었으면 : 0) 
			try {
				stmt = conn.createStatement();
				String sql = "select count(*) from t_pri_member_info where pm_id = '"+ uid +"'";
System.out.println("아이디 중복체크 sql : " + sql);
				rs = stmt.executeQuery(sql); // stmt 객체로 쿼리를 sql 쿼리를 실행해서 받아온 값을 rs에 넣어준다. 
				rs.next();
				result = rs.getInt(1);
				
			} catch (Exception e) {
				System.out.println("DupIdDao 클래스의 chkDupId() 메소드 오류");
				e.printStackTrace();
			} finally {
				close(rs);
				close(stmt);
			}
			return result;
		}
}
