package place.svc;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰڴٴ� �ǹ�, import�صθ� Ŭ������.�޼ҵ�� ���ص� ��� ������ 
import java.util.*;
import java.sql.*;
import place.dao.*;
import place.vo.*;
import java.io.*;
import place.svc.*;
import place.vo.*;
import vo.*;
import act.*;

public class PlaceListSvc {
	public int getPlaCount( String where) {
		// ���õ� ��ǰ�� ��ü ������ �����ϴ� �޼ҵ�
			int rcnt = 0;	// ��ü ��ǰ ������ ������ ���� 
			Connection conn = getConnection();
			PlaceDao placeDao = PlaceDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
			placeDao.setConnection(conn);
			rcnt = placeDao.getPlaCount(where);
			close(conn);
			
			return rcnt;
	}
	
	public ArrayList<PlaceInfo> getPlaceList(String where, String order, int cpage, int psize){
		// �˻��� ��ǰ ����� ArrayList<ProductInfo>�� ��� �����ϴ� �޼ҵ� 
		ArrayList<PlaceInfo>  placeList = new ArrayList<PlaceInfo>();
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		placeDao.setConnection(conn);
		placeList = placeDao.getPlaceList(where, order, cpage, psize);
		close(conn);
		
		return placeList;
		
	}
	
	public int tagTrigger(String tag) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		placeDao.setConnection(conn);
		result = placeDao.tagTrigger(tag);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int keyTrigger(String key) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		placeDao.setConnection(conn);
		result = placeDao.keyTrigger(key);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	
	

}
