package member.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import member.vo.*;

public class LoginDao {
	private static LoginDao loginDao;
	private Connection conn;

	private LoginDao() {}

	public static LoginDao getInstance() {
		if (loginDao == null)	loginDao = new LoginDao();
		return loginDao;
	}

	public void setConnection(Connection conn) {
		this.conn = conn;
	}

	public PriMemberInfo getPriMemberInfo(String uid, String pwd) {
		Statement stmt = null;
		ResultSet rs = null;
		PriMemberInfo priMemberInfo = null;	

		try {
			stmt = conn.createStatement();
			String sql = 
				"select"+ 
				"		pm_id"+
				"	  , pm_pwd"+
				"	  , pm_name"+
				"	  , pm_nikname"+
				"	  , pm_mail"+
				"	  , pm_phone"+
				"	  , pm_sbandate"+
				"	  , pm_ebandate"+
				"	  , ai_idx"+
				"	  , pm_isad"+
				"	  , pm_isact "+
				"	from t_pri_member_info"+
				" where 1=1"+
				"  and pm_id = '" + uid + 
				"' and pm_pwd ='" + pwd + 
				"' and pm_isact = 'y'";
		
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				priMemberInfo = new PriMemberInfo();	
				priMemberInfo.setPm_id(rs.getString("pm_id"));
				priMemberInfo.setPm_pwd(rs.getString("pm_pwd"));
				priMemberInfo.setPm_name(rs.getString("pm_name"));
				priMemberInfo.setPm_nikname(rs.getString("pm_nikname"));
				priMemberInfo.setPm_mail(rs.getString("pm_mail"));
				priMemberInfo.setPm_phone(rs.getString("pm_phone"));
				priMemberInfo.setPm_sbandate(rs.getString("pm_sbandate"));
				priMemberInfo.setPm_ebandate(rs.getString("pm_ebandate"));
				priMemberInfo.setPm_isact(rs.getString("pm_isact"));
				priMemberInfo.setPm_isad(rs.getString("pm_isad"));

			}	

		} catch(Exception e) {
			System.out.println("LoginDao 클래스의 getPriMemberInfo() 메서드 에러");
			e.printStackTrace();
		}
		return priMemberInfo;
	}
}
