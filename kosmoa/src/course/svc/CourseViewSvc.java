package course.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import course.dao.*;
import vo.*;
import course.vo.*;
import place.dao.PlaceDao;
import review.vo.CourseReviewInfo;
import review.vo.PlaceReviewInfo;


public class CourseViewSvc {
	public  ArrayList<CourseInfo> getCourseInfo(String ciid) {
		ArrayList<CourseInfo> courseInfo = new ArrayList<CourseInfo>();
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		courseInfo = courseDao.getCourseInfo(ciid);
		close(conn);
		return courseInfo;
	}
	// ��� ���� �˻���� �߰��޼ҵ� 
	public int insertCourseStat(String ciid) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		result = courseDao.insertCourseStat(ciid);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
		
	}
	
	public int isSaved(String pmid, String ciid) {
		int saved = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		saved = courseDao.isSaved(pmid, ciid);
		
		close(conn);
		return saved;
	}
	
	public ArrayList<CourseReviewInfo> getCourseReviewList(String ciid){
		ArrayList<CourseReviewInfo> creview = new  ArrayList<CourseReviewInfo>();
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	
		courseDao.setConnection(conn);
		creview = courseDao.getCourseReviewList(ciid);
		
		close(conn);
		return creview;
	}	
	
	public int doLike(String ciid) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	
		courseDao.setConnection(conn);
		result = courseDao.doLike(ciid);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		close(conn);
		return result;
	}
}
