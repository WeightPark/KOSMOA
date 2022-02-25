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
		StatDao statDao = StatDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		statDao.setConnection(conn);
		if (kind.equals("t")) {			// �±� ���  �� ���
			schStat = statDao.getTagStat(where);
		}else if (kind.equals("k")) {	// Ű���� ��� �� ���
			schStat = statDao.getKeyStat(where);
		}
		close(conn);
		return schStat;
		
	}
}
