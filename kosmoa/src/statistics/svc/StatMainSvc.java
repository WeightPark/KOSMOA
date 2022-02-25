package statistics.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import statistics.dao.*;
import statistics.vo.*;

public class StatMainSvc {
	public ArrayList<ViewStatInfo>  getMainStat (){
		ArrayList<ViewStatInfo>  mainstat = new ArrayList<ViewStatInfo>();
		Connection conn = getConnection();
		StatDao statDao = StatDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		statDao.setConnection(conn);
		
		mainstat = statDao.getMainStat();
		
		close(conn);
		return mainstat;
	}

}
