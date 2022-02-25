package review.svc;

import static db.JdbcUtil.*;	
import java.util.*;

import course.dao.CourseDao;

import java.sql.*;
import review.dao.*;
import review.vo.*;

public class ReviewListSvc {
	public int getPreviewCnt(String where) {
		int rcnt = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		rcnt = reviewDao.getPreviewCnt(where);
		close(conn);
		
		return rcnt;
	}
	public ArrayList<PlaceReviewInfo> getPlaceReviewList(String where, int cpage, int psize){
		ArrayList<PlaceReviewInfo> preview = new  ArrayList<PlaceReviewInfo>();
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		preview = reviewDao.getPlaceReviewList(where, cpage, psize);
		close(conn);
		return preview;
	}
	
	public int getCreviewCnt(String where) {
		int crcnt = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		crcnt = reviewDao.getCreviewCnt(where);
		close(conn);
		
		return crcnt;
	}
	
	
	public ArrayList<CourseReviewInfo> getCourseReviewList(String where, int ccpage, int cpsize){
		 ArrayList<CourseReviewInfo> creview = new  ArrayList<CourseReviewInfo>();
		 Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		creview = reviewDao.getCourseReviewList(where, ccpage, cpsize);
		close(conn); 
		return creview;
	}
	
	public int doLike(int rvid, String kind) {
		int result = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		reviewDao.setConnection(conn);
		if (kind.equals("p"))
			result = reviewDao.doPLike(rvid);
		else
			result = reviewDao.doCLike(rvid);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		close(conn);
		
		return result;
		
	}

}
