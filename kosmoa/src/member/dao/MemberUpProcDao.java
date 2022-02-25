package member.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;
import member.vo.*;

public class MemberUpProcDao {
	private static MemberUpProcDao memberUpProcDao;
	private Connection conn;
	
	private MemberUpProcDao() {}
	
	public static MemberUpProcDao getInstance() {
		if (memberUpProcDao == null)	 memberUpProcDao = new MemberUpProcDao();
		return memberUpProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int memberUpdate(PriMemberInfo priMemberInfo) {
		CallableStatement cstmt = null;
		Statement stmt = null;
		int result = 0;
		try {
			String sql = "{call sp_primember_manage(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)}";
			cstmt = conn.prepareCall(sql);
			
			cstmt.setString(1, "u");
			cstmt.setString(2, priMemberInfo.getPm_id());
			cstmt.setString(3, priMemberInfo.getPm_pwd());
			cstmt.setString(4, null);
			cstmt.setString(5, priMemberInfo.getPm_nikname());
			cstmt.setString(6, priMemberInfo.getPm_mail());
			cstmt.setString(7, priMemberInfo.getPm_phone());
			cstmt.setString(8, priMemberInfo.getPm_isad());
			cstmt.setString(9, null);
			cstmt.setString(10, null);
			cstmt.setString(11, null);
			cstmt.setString(12, null);
			
//				String sql = "update t_pri_member_info set "
//							+ "pm_pwd = '"		+ priMemberInfo.getPm_pwd() + "', "
//							+ "pm_nikname = '"	+ priMemberInfo.getPm_nikname() + "', " 
//							+ "pm_mail = '"		+ priMemberInfo.getPm_mail() + "', " 
//							+ "pm_phone = '"	+ priMemberInfo.getPm_phone() + "', "
//							+ "pm_isad = '"		+ priMemberInfo.getPm_isad() + "' "
//							+ "where pm_id = '" + priMemberInfo.getPm_id() + "'";
		
			result = cstmt.executeUpdate();
			System.out.println(result);
			
		} catch (Exception e) {
			System.out.println("MemberInProcDao 클래스의 memberUpdate() 메소드 오류");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		return result;
	}
}
