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
		// ���õ� ��ǰ�� ��ü ������ �����ϴ� �޼ҵ�
			int rcnt = 0;	// ��ü ��ǰ ������ ������ ���� 
			Connection conn = getConnection();
			CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
			courseDao.setConnection(conn);
			rcnt = courseDao.getCourseCount(where);
			close(conn);
			
			return rcnt;
	}
	
	public ArrayList<CourseInfo> getCourseList(String where, String order, int cpage, int psize){
		// �˻��� ��ǰ ����� ArrayList<ProductInfo>�� ��� �����ϴ� �޼ҵ� 
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		courseList = courseDao.getCourseList(where, order, cpage, psize);
		close(conn);
		
		return courseList;
		
	}
	// �ڽ� �˻��� �±�, Ű���� ��� Ʈ����  �Լ�
	public int tagTrigger(String tag) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		result = courseDao.tagTrigger(tag);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int keyTrigger(String key) {
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseDao.setConnection(conn);
		result = courseDao.keyTrigger(key);
		
		if(result == 1) commit(conn);	 
		else			rollback(conn);	
		return result;
	}
	
	public int getTotalCount (String wheresql, String order ,int start,  int end) {		// �ش� ���ǿ� �´� �ڽ����� ���ڵ� ������ ���� 
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	 
		courseDao.setConnection(conn);
		System.out.println("getTotalCount ����");
		result = courseDao.getTotalCount(wheresql, order ,start, end);
		close(conn);
		return result;
		
	}
	
	public int getStlimitCount(String wheresql, String order , int start) {		// ���������� ���ڵ��� �������� ������
		int result = 0;
		Connection conn = getConnection();
		CourseDao courseDao = CourseDao.getInstance();	 
		courseDao.setConnection(conn);
		result = courseDao.getStlimitCount(wheresql, order, start);
		close(conn);
		return result;
	}
	

	

}
