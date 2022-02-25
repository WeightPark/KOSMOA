package statistics.svc;

import static db.JdbcUtil.*;	
import java.util.*;


import java.sql.*;
import statistics.dao.*;
import statistics.vo.*;

public class StatSchSvc {
	public ArrayList<SchStatInfo> getSchStat(String where, String kind){
		ArrayList<SchStatInfo> schStat = new ArrayList<SchStatInfo>();
		Connection conn = getConnection();
		StatDao statDao = StatDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		statDao.setConnection(conn);
		if (kind.equals("t")) {			// 태그 통계  일 경우
			schStat = statDao.getTagStat(where);
		}else if (kind.equals("k")) {	// 키워드 통계 일 경우
			schStat = statDao.getKeyStat(where);
		}
		close(conn);
		return schStat;
		
	}
}
