package member.svc;

import static db.JdbcUtil.close;
import static db.JdbcUtil.getConnection;
import java.sql.Connection;
import member.dao.*;
import member.vo.*;

public class LoginSvc {
	public PriMemberInfo  getMemberInfo(String uid , String pwd) {
		Connection conn = getConnection();
		LoginDao loginDao = LoginDao.getInstance();
		loginDao.setConnection(conn);
		PriMemberInfo priMemberInfo = null;
	
		priMemberInfo =loginDao.getPriMemberInfo(uid, pwd); 

		close(conn);
		return priMemberInfo;
		
		
	}
}
