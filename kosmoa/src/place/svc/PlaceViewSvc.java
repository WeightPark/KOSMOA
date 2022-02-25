package place.svc;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰڴٴ� �ǹ�, import�صθ� Ŭ������.�޼ҵ�� ���ص� ��� ������ 
import java.util.*;
import java.sql.*;
import place.dao.*;
import place.vo.*;
import review.vo.PlaceReviewInfo;

import java.io.*;
import place.svc.*;
import place.vo.*;
import vo.*;
import act.*;


public class PlaceViewSvc {
	// �󼼺��� ������ �������� svc
	public PlaceInfo getplaInfo(String piid) {
		PlaceInfo pi = new PlaceInfo();
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		placeDao.setConnection(conn);
		pi = placeDao.getplaInfo(piid);
		close(conn);
		
		return pi;
		
	}
	
	// ��� ���̺� �߰��ϴ� svc
	public int insertPlaceStat(String piid) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	
		placeDao.setConnection(conn);
		result = placeDao.insertPlaceStat(piid);
		
		if(result == 1) commit(conn);		// ��迡 ���ԉ��� ���� ��쿡�� ���� ����
		else			rollback(conn);		// ��迡 ������ �ȉ��� ���� ��쿡�� ���� �������
		close(conn);
		
		return result;
 
	}
	
	public int isSaved(String pmid, String piid) {
		int saved = 0;		// count(*)�� ������ �޾ƿ� ����
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	
		placeDao.setConnection(conn);
		saved = placeDao.isSaved(pmid,  piid);
		
		close(conn);
		return saved;
	}
	
	public ArrayList<PlaceReviewInfo> getPlaceReviewList(String piid){
		ArrayList<PlaceReviewInfo> preview = new  ArrayList<PlaceReviewInfo>();
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	
		placeDao.setConnection(conn);
		preview = placeDao.getPlaceReviewList(piid);
		
		close(conn);
		return preview;
	}	
}
