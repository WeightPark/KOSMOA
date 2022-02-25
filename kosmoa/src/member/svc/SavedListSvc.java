package member.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import member.dao.*;
import member.svc.*;
import member.vo.*;
import vo.*;

public class SavedListSvc {
	
	public int getSaveCount(String id, String wtype) {
		// 寃��깋�맂 �긽�뭹�쓽 �쟾泥� 媛쒖닔瑜� 由ы꽩�븯�뒗 硫붿꽌�뱶 
		int rcnt = 0; // �쟾泥� �긽�뭹 媛쒖닔瑜� ���옣�븷 蹂��닔 
		Connection conn = getConnection();
		SavedDao savedListDao = SavedDao.getInstance();
		savedListDao.setConnection(conn);
		rcnt = savedListDao.getSaveCount(id, wtype);
		close(conn);

		return rcnt;
	}
	
	public ArrayList<SavedCourseInfo> getCosList(String where, int cpage, int psize) {
		Connection conn = getConnection();
		SavedDao savedListDao = SavedDao.getInstance();
		savedListDao.setConnection(conn);
		ArrayList<SavedCourseInfo> cosList = savedListDao.getCosList(where, cpage, psize);
		close(conn);
		System.out.println("size of cosList : " + cosList.size());
		return cosList;
	}
	
	public ArrayList<SavedPlaceInfo> getPlsList(String where, int cpage, int psize) {
		Connection conn = getConnection();
		SavedDao savedListDao = SavedDao.getInstance();
		savedListDao.setConnection(conn);
		ArrayList<SavedPlaceInfo> plsList = savedListDao.getPlsList(where, cpage, psize);
		close(conn);
		
		System.out.println("size of plsList : " + plsList.size());
		return plsList;
	}
	

}
