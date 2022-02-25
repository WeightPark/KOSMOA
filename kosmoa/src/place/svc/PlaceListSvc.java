package place.svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용하겠다는 의미, import해두면 클래스명.메소드명 안해도 사용 가능함 
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
		// 선택된 상품의 전체 개수를 리턴하는 메소드
			int rcnt = 0;	// 전체 상품 개수를 저장할 변수 
			Connection conn = getConnection();
			PlaceDao placeDao = PlaceDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
			placeDao.setConnection(conn);
			rcnt = placeDao.getPlaCount(where);
			close(conn);
			
			return rcnt;
	}
	
	public ArrayList<PlaceInfo> getPlaceList(String where, String order, int cpage, int psize){
		// 검색된 상품 목록을 ArrayList<ProductInfo>에 담아 리턴하는 메소드 
		ArrayList<PlaceInfo>  placeList = new ArrayList<PlaceInfo>();
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		placeDao.setConnection(conn);
		placeList = placeDao.getPlaceList(where, order, cpage, psize);
		close(conn);
		
		return placeList;
		
	}
	
	public int tagTrigger(String tag) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		placeDao.setConnection(conn);
		result = placeDao.tagTrigger(tag);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int keyTrigger(String key) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		placeDao.setConnection(conn);
		result = placeDao.keyTrigger(key);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	
	

}
