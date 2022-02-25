package course.dao;

import static db.JdbcUtil.*;
import java.util.*;
import javax.sql.*;
import java.sql.*;
import course.vo.*;
import place.vo.PlaceInfo;

public class CourseProcDao {
	private static CourseProcDao courseProcDao;
	private Connection conn;
	
	private CourseProcDao() {}
	
	public static CourseProcDao getInstance() {
		if (courseProcDao == null)	 courseProcDao = new CourseProcDao();
		return courseProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int courseInsert(CourseInfo course) {
		// ����ڰ� �Է��� ������� �ڽ� ����� �ϴ� �޼ҵ�
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			String sql = "insert into t_course_info (ci_name, ci_id, ci_img, ci_time, ci_desc, ci_isview, ci_st_id, " +
					"ci_st_name, ci_sk_id, ci_sk_name, pi_id, pi_name, ai_idx) values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, course.getCi_name());
			pstmt.setString(2, course.getCi_id());
			pstmt.setString(3, course.getCi_img());
			pstmt.setInt(4, course.getCi_time());
			pstmt.setString(5, course.getCi_desc());
			pstmt.setString(6, course.getCi_isview());
			pstmt.setString(7, course.getCi_st_id());
			pstmt.setString(8, course.getCi_st_name());
			pstmt.setString(9, course.getCi_sk_id());
			pstmt.setString(10, course.getCi_sk_name());
			pstmt.setString(11, course.getPi_id());
			pstmt.setString(12, course.getPi_name());
			pstmt.setInt(13, course.getAi_idx());
			result = pstmt.executeUpdate();
					
		} catch(Exception e) {
			System.out.println("CourseDao Ŭ������ courseInsert() �޼ҵ� ����");
			e.printStackTrace();
		}

		return result;
	}
	
	public int courseUpdate(CourseInfo course) {
		// �ڽ� �������� ���� �ϴ� �޼ҵ�
			Statement stmt = null;
			int result = 0;

			try {
				stmt = conn.createStatement();
				String sql = "update t_course_info set " + 
						"ci_name = '"		+ course.getCi_name()		+ "' " +
						"ci_id = '"			+ course.getCi_id()			+ "' " +
						"ci_img = '"		+ course.getCi_img()		+ "' " +
						"ci_desc = '"		+ course.getCi_desc()		+ "' " +
						"ci_isview = '"		+ course.getCi_isview()		+ "' " +
						"ci_st_id = '"		+ course.getCi_st_id()		+ "' " +
						"ci_st_name = '"	+ course.getCi_st_name()	+ "' " +
						"ci_sk_id = '"		+ course.getCi_sk_id()		+ "' " +
						"ci_sk_name = '"	+ course.getCi_sk_name()	+ "' " +
						"ci_time = '"		+ course.getCi_time()		+ "' " +
						"pi_id = '"			+ course.getPi_id()			+ "' " +
						"pi_name = '"		+ course.getPi_name()		+ "' " +
						"ai_idx = '"		+ course.getAi_idx()		+ "' "; 
					
				
						result = stmt.executeUpdate(sql);
						
			} catch(Exception e) {
				System.out.println("CourseDao Ŭ������ courseUpdate() �޼ҵ� ����");
				e.printStackTrace();
			}

			return result;
		}
	
	public ArrayList<PlaceInfo> getPlaceInfo(String piid, String piname) {
	      Statement stmt = null;       
	      ResultSet rs = null;   
	      PlaceInfo pif = null;
	      ArrayList<PlaceInfo> placeInfo = new ArrayList<PlaceInfo>();
	         
	         try {
	            String sql = "select * from t_place_info where pi_id = '" + piid + "' pi_name = '" + piname + "' ";
	            System.out.println(sql);
	            stmt = conn.createStatement();
	            rs = stmt.executeQuery(sql);
	            while(rs.next()) {
	               pif = new PlaceInfo();
	               pif.setPi_id(rs.getString("pi_id"));
	               pif.setPi_name(rs.getString("pi_name"));
	               
	               placeInfo.add(pif);
	            }
	            
	         }catch(Exception e) {
	            System.out.println("CourseProcDao의 인스턴스 getPlaceInfo() 등록 오류");
	            e.printStackTrace();
	            
	         }finally {
	            close(rs);   close(stmt);
	         }
	         return placeInfo;
	      
	}
	
}