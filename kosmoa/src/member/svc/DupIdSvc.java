package member.svc;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰڴٴ� �ǹ�
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
