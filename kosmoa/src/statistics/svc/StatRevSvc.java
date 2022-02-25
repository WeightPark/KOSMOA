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
		StatDao statDao = StatDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		statDao.setConnection(conn);
		if (kind.equals("c")) {			// �ڽ� ���  �� ���
			revStat = statDao.getCouStat(where);
		}else if (kind.equals("p")) {	// ��� ��� �� ���
			revStat = statDao.getPlaStat(where);
		}
		close(conn);
		return revStat;
	}
}
