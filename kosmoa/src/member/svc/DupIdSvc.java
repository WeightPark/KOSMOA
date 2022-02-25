package member.svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용하겠다는 의미
import java.sql.*;
import java.util.*;
import vo.*;
import member.vo.*;
import dao.*;
import member.dao.*;

public class DupIdSvc {
	public int chkDupId(String uid) {
		Connection conn = getConnection();
		DupIdDao dupIdDao = DupIdDao.getInstance();
		dupIdDao.setConnection(conn);
		int result = dupIdDao.chkDupId(uid);
		
		close(conn);
		
		return result;
	}
}
