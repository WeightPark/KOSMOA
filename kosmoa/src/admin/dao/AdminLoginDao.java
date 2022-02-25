package admin.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import admin.dao.*;
import admin.vo.*;

public class AdminLoginDao {
	private static AdminLoginDao adminLoginDao;
	private Connection conn;

	private AdminLoginDao() {}

	public static AdminLoginDao getInstance() {
		if (adminLoginDao == null)	adminLoginDao = new AdminLoginDao();
		return adminLoginDao;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public AdminInfo getAdminMemberInfo(String uid, String pwd) {
		Statement stmt = null;
		ResultSet rs = null;
		AdminInfo adminInfo = null;	

		try {
			stmt = conn.createStatement();
			String sql = 
				"select * from t_admin_info where 1=1 and ai_id = '" + uid + "' and ai_pw ='" + pwd + "' and ai_isrun = 'y'";
		
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				adminInfo = new AdminInfo();
				adminInfo.setAi_id(uid);	adminInfo.setAi_pw(pwd);
				adminInfo.setAi_name(rs.getString("ai_name"));			}	

		} catch(Exception e) {
			System.out.println("AdminLoginDao 클래스의 getAdminMemberInfo() 메소드 오류");
			e.printStackTrace();
		}
		return adminInfo;
	}
}
