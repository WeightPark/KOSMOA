package review.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import review.dao.*;
import review.vo.*;

public class MyReviewListSvc {
	public ArrayList<PlaceReviewInfo> getMyReviewListAct(String kind, String pmid,  int cpage, int psize){
		ArrayList<PlaceReviewInfo> myReview = new  ArrayList<PlaceReviewInfo>();
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		if (kind.equals("p")) 	myReview = reviewDao.getMypReviewList(pmid, cpage, psize);
		else if(kind.equals("c")) myReview = reviewDao.getMycReviewList(pmid, cpage, psize);
		close(conn);
		
		return myReview;
	}
	
	public int getRcnt(String kind, String where) {		// 장소 후기 코스 글 갯수 리턴 
		int rcnt = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		
		if (kind.equals("p")) 	rcnt = reviewDao.getPreviewCnt(where);
		else if(kind.equals("c")) rcnt = reviewDao.getCreviewCnt(where);
		
		close(conn);
		return rcnt;
	}
	
	public int delReview(String kind, String where) {
		int result = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		
		if (kind.equals("p")) 		result = reviewDao.delPreview(where);
		else if(kind.equals("c")) 	result = reviewDao.delCreview(where);
		
		if(result >= 1)	commit(conn);
		else			rollback(conn);
		
		close(conn);
		
		return result;
	}

}
