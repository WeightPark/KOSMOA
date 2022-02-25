package reserve.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import reserve.dao.*;
import reserve.vo.*;

public class ReservedProcSvc {
	public int reserveSet(String rtype, String id, String ci_name, String uid, String[] pi_name, String[] pr_rdate, String[] rperson) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		int result = 0;
		
		if (rtype.equals("c"))
			result = reservedDao.reserveSet(rtype, id, ci_name, uid, pi_name, pr_rdate, rperson);
		else 
			result = reservedDao.reservePlace(rtype, id, uid, pi_name[0], pr_rdate[0], rperson[0]);
		
		if (result > 0)	commit(conn);		// 등록, 수정, 삭제 등의 작업이 일어난 레코드가 하나면 쿼리를 적용
		else				rollback(conn);		// 작업이 일어난 레코드가 없으면 쿼리 적용을 취소하고, 처음으로 되돌린다.
		close(conn);
		
		return result;
	}
}
