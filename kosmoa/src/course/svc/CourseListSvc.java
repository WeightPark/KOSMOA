package course.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import course.dao.*;
import course.vo.*;
import place.dao.PlaceDao;
import place.vo.PlaceInfo;

public class CourseListSvc {
	public int getCourseCount( String where) {
		// 선택된 상품의 전체 개수를 리턴하는 메소드
			int rcnt = 0;	// 전체 상품 개수를 저장할 변수 
			Connection conn = getConnection();
			CourseDao courseDao = CourseDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
			courseDao.setConnection(conn);
			rcnt = courseDao.getCourseCount(where);
			close(conn);
			
			return rcnt;
	}
	
	public ArrayList<CourseInfo> getCourseList(String where, String order, int cpage, int psize){
		// 검색된 상품 목록을 ArrayList<ProductInfo>에 담아 리턴하는 메소드 
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		courseDao.setConnection(conn);
		courseList = courseDao.getCourseList(where, order, cpage, psize);
		close(conn);
		
		return courseList;
		
	}
	// 코스 검색시 태그, 키워드 통계 트리거  함수
	public int tagTrigger(String tag) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		courseDao.setConnection(conn);
		result = courseDao.tagTrigger(tag);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int keyTrigger(String key) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		courseDao.setConnection(conn);
		result = courseDao.keyTrigger(key);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int getTotalCount (String wheresql, String order ,int start,  int end) {		// 해당 조건에 맞는 코스들의 레코드 개수를 리턴 
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	 
		courseDao.setConnection(conn);
		System.out.println("getTotalCount 실행");
		result = courseDao.getTotalCount(wheresql, order ,start, end);
		close(conn);
		return result;
		
	}
	
	public int getStlimitCount(String wheresql, String order , int start) {		// 이전까지의 레코드의 개수들을 리턴함
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	 
		courseDao.setConnection(conn);
		result = courseDao.getStlimitCount(wheresql, order, start);
		close(conn);
		return result;
	}
	

	

}
