package admin.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;
import java.sql.Connection;
import admin.dao.*;
import admin.vo.*;

public class AdminLoginSvc {
	public AdminInfo  getAdminInfo(String uid , String pwd) {
		Connection conn = getConnection();
		AdminLoginDao adminLoginDao = AdminLoginDao.getInstance();
		adminLoginDao.setConnection(conn);
		AdminInfo adminInfo = null;
	
		adminInfo = adminLoginDao.getAdminMemberInfo(uid, pwd); 

		close(conn);
		return adminInfo;
	}
}
