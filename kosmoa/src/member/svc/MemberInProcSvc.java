package member.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import member.dao.*;
import member.vo.*;

public class MemberInProcSvc {
	public int memberInsert(PriMemberInfo priMemberInfo) {
		Connection conn = getConnection();
		MemberInProcDao memberInProcDao = MemberInProcDao.getInstance();
		memberInProcDao.setConnection(conn);
		
		int result = 0;
			result = memberInProcDao.memberInsert(priMemberInfo);
		
			
		if(result == 1) { 
			commit(conn);		// 가입, 수정, 탈퇴 등의 작업이 일어난 레코드가 하나면 쿼리를 적용시킴 
		}else {
			rollback(conn);		// 작업이 일어난 레코드가 없으면 쿼리 적용을 취소하고, 처음으로 되돌림 
		}
		
		close(conn);
		return result;
	}
}
