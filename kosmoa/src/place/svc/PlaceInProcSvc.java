package place.svc;

import static db.JdbcUtil.*;
import java.util.*;
import javax.sql.*;
import java.sql.*;
import place.dao.*;
import place.vo.*;

public class PlaceInProcSvc {
	public int placeInsert(PlaceInfo place) {
		int result = 0;
		Connection conn = getConnection();
		PlaceInProcDao placeInProcDao = PlaceInProcDao.getInstance();
		placeInProcDao.setConnection(conn);
		result = placeInProcDao.placeInsert(place);
		
		if (result >= 1)	commit(conn);
		else				rollback(conn);
		close(conn);
		
		return result;
	}
}	
