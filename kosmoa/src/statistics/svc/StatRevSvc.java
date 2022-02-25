package statistics.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import statistics.dao.*;
import statistics.vo.*;

public class StatRevSvc {
	public ArrayList<ViewStatInfo> getRevStat (String where, String kind){
		ArrayList<ViewStatInfo> revStat = new ArrayList<ViewStatInfo>();
		Connection conn = getConnection();
		StatDao statDao = StatDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		statDao.setConnection(conn);
		if (kind.equals("c")) {			// 코스 통계  일 경우
			revStat = statDao.getCouStat(where);
		}else if (kind.equals("p")) {	// 장소 통계 일 경우
			revStat = statDao.getPlaStat(where);
		}
		close(conn);
		return revStat;
	}
}
