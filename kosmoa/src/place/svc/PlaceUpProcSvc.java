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
		
		if (result == 1)	commit(conn);	// ���� ���� �۾��� �Ͼ ���ڵ尡 �ϳ��� ������ �����Ŵ
		else				rollback(conn);	// �۾��� �Ͼ ���ڵ尡 ������ ���� ������ ����ϰ�, ó������ �ǵ���
		close(conn);
		
		return result;
	}
}
