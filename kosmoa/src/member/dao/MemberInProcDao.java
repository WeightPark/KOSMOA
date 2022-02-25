package member.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;
import member.vo.*;

public class MemberInProcDao {
	private static MemberInProcDao memberInProcDao;
	private Connection conn;
	
	private MemberInProcDao() {}
	
	public static MemberInProcDao getInstance() {
		if (memberInProcDao == null)	 memberInProcDao = new MemberInProcDao();
		return memberInProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int memberInsert(PriMemberInfo priMemberInfo) {
		Statement stmt = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "call sp_primember_manage('i', '" + 
						priMemberInfo.getPm_id() + "', '" +
						priMemberInfo.getPm_pwd() + "', '" +
						priMemberInfo.getPm_name() + "' ,'" +
						priMemberInfo.getPm_nikname() + "', '" +
						priMemberInfo.getPm_mail() + "', '" +
						priMemberInfo.getPm_phone() + "', '" +  
						priMemberInfo.getPm_isad()+ "', '', '', 'y', 0)";
			
			result = stmt.executeUpdate(sql);
						
		} catch (Exception e) {
			System.out.println("MemberInProcDao 클래스의 memberInsert() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		
		return result;
	}
}
