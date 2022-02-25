package reserve.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import reserve.dao.*;
import reserve.vo.*;

public class ReservedCancelProcSvc {
	public int reservedCancel(String rtype, String rid) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		int result = 0;
		
		result = reservedDao.reservedCancel(rtype, rid);
		
		if (result > 0)	commit(conn);		
		else				rollback(conn);		
		close(conn);
		
		return result;
	}
}
