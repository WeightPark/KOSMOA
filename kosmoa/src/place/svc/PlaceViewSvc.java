package place.svc;

import static db.JdbcUtil.*;	// JdbcUtil 클래스의 모든 멤버들을 자유롭게 사용하겠다는 의미, import해두면 클래스명.메소드명 안해도 사용 가능함 
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
	// 상세보기 정보를 가져오는 svc
	public PlaceInfo getplaInfo(String piid) {
		PlaceInfo pi = new PlaceInfo();
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		placeDao.setConnection(conn);
		pi = placeDao.getplaInfo(piid);
		close(conn);
		
		return pi;
		
	}
	
	// 통계 테이블에 추가하는 svc
	public int insertPlaceStat(String piid) {
		int result = 0;
		Connection conn = getConnection();
		PlaceDao placeDao = PlaceDao.getInstance();	
		placeDao.setConnection(conn);
		result = placeDao.insertPlaceStat(piid);
		
		if(result == 1) commit(conn);		// 통계에 기입됬을 경을 경우에는 쿼리 적용
		else			rollback(conn);		// 통계에 기입이 안됬을 경을 경우에는 쿼리 적용안함
		close(conn);
		
		return result;
 
	}
	
	public int isSaved(String pmid, String piid) {
		int saved = 0;		// count(*)의 개수를 받아올 변수
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
