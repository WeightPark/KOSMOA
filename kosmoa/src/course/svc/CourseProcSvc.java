package course.svc;

import static db.JdbcUtil.*;
import java.util.*;
import javax.sql.*;
import java.sql.*;
import course.dao.*;
import course.vo.*;
import place.vo.PlaceInfo;


public class CourseProcSvc {
	public int courseProc(String wtype, CourseInfo course) {
		Connection conn = getConnection();
		CourseProcDao courseProcDao = CourseProcDao.getInstance();
		courseProcDao.setConnection(conn);
		int result = 0;
		if (wtype.equals("in")) {
			result = courseProcDao.courseInsert(course);
		} else {
			result = courseProcDao.courseUpdate(course);
		} 

		if (result == 1)	commit(conn);	// ���, ���� ���� �۾��� �Ͼ ���ڵ尡 �ϳ��� ������ �����Ŵ
		else				rollback(conn);	// �۾��� �Ͼ ���ڵ尡 ������ ���� ������ ����ϰ�, ó������ �ǵ���
		close(conn);

		return result;
	}
	
	public ArrayList<PlaceInfo> getPlaceInfo(String pi_id, String pi_name) {
		ArrayList<PlaceInfo> placeInfo = new ArrayList<PlaceInfo>();
		Connection conn = getConnection();
		CourseProcDao courseProcDao = CourseProcDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		courseProcDao.setConnection(conn);
		placeInfo = courseProcDao.getPlaceInfo(pi_id, pi_name);
		close(conn);
		
		return placeInfo;
	}
}
