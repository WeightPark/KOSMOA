package place.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import place.dao.*;
import place.vo.*;
import place.vo.PlaceInfo;
import vo.*;

public class PlaceUpProcSvc {
	public int placeUpdate(PlaceInfo placeInfo) {
		Connection conn = getConnection();
		PlaceUpProcDao placeUpProcDao = PlaceUpProcDao.getInstance();
		placeUpProcDao.setConnection(conn);
		int result = 0;
		
		result = placeUpProcDao.placeUpdate(placeInfo);
		
		if (result == 1)	commit(conn);	// 정보 수정 작업이 일어난 레코드가 하나면 쿼리를 적용시킴
		else				rollback(conn);	// 작업이 일어난 레코드가 없으면 쿼리 적용을 취소하고, 처음으로 되돌림
		close(conn);
		
		return result;
	}
}
