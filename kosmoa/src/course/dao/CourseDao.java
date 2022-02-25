package course.dao;

import static db.JdbcUtil.close;
import javax.sql.*;
import java.sql.*;
import java.util.*;
import course.vo.*;
import place.vo.PlaceInfo;
import review.vo.CourseReviewInfo;

public class CourseDao {
	private static CourseDao courseDao;
	private Connection conn;
	
	private CourseDao() {}
	
	public static CourseDao getInstance() {
		if (courseDao == null)	courseDao =  new CourseDao();
		return courseDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getCourseCount( String where) {
		// 占쏙옙체 占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙체 占쌘쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占싣억옙占쏙옙 
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		int rcnt = 0;				// 占쌩븝옙占쏙옙 占쏙옙占싱듸옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙, 占쌩븝옙占쏙옙 占쏙옙占쏙옙占쏙옙1, 占싣니몌옙 0占쏙옙 占쏙옙占쏙옙
		try {
			String sql = "select count(distinct ci_id) from v_course_place " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	
			rcnt = rs.getInt(1);
			
		}catch (Exception e) {
			System.out.println("CourseDao 클占쏙옙占쏙옙占쏙옙 getCourseCount() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		System.out.println("rcnt : " + rcnt);
		return rcnt;
	}
	
	
	public int getTotalCount (String wheresql, String order , int start,  int end) {	// 占쌔댐옙 占쏙옙占실울옙 占승댐옙 占쌘쏙옙占쏙옙占쏙옙 占쏙옙占쌘듸옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		int total = 0;
		System.out.println("total : " + total);
		try {
			String sql = "select count(*) from v_course_place " + wheresql + " group by ci_id " + order + " limit " + start +" , " + end;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				do {
					total += rs.getInt(1);
				}while(rs.next());
			}
			
			
		}catch (Exception e) {
			System.out.println("CourseDao 클占쏙옙占쏙옙占쏙옙 getTotalCount() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		System.out.println("rcnt : " + total);
		return total;
	}
	
	public int getStlimitCount(String wheresql, String order , int start) {	
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		int stlimit = 0;
		try {
			String sql = "select count(*) from v_course_place " + wheresql + " group by ci_id " + order + " limit " + 0 +" , " + start;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				do {
					stlimit += rs.getInt(1);
				}while(rs.next());
			}
			
			
		}catch (Exception e) {
			System.out.println("CourseDao 클占쏙옙占쏙옙占쏙옙 getStlimitCount() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		System.out.println("stlimit : " + stlimit);
		return stlimit;
	}
	
	
	public ArrayList<CourseInfo> getCourseList( String where, String order, int stlimit, int endlimit){
		// 占쌘쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 ArrayList<CourseInfo> 占쏙옙티占� 占쏙옙占쏙옙占싹댐옙 占쌨소듸옙 (占쌘쏙옙 占쏙옙占쏙옙트)
		Statement stmt = null;		 
		ResultSet rs = null;		 
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		CourseInfo cur = null;		
		try {
			String sql = "select * from v_course_place " + where + order +" limit " + stlimit + ", " + endlimit;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				cur = new CourseInfo();
				cur.setCi_idx(rs.getInt("ci_idx"));						cur.setCi_name(rs.getString("ci_name"));
				cur.setCi_id(rs.getString("ci_id"));					//cur.setCi_kind(rs.getString("ci_kind"));
				cur.setCi_date(rs.getString("ci_date"));				cur.setCi_img(rs.getString("ci_img"));
				cur.setCi_time(rs.getInt("ci_time"));					cur.setCi_desc(rs.getString("ci_desc"));
				cur.setCi_st_id(rs.getString("ci_st_id"));				cur.setCi_score(rs.getDouble("ci_score"));
				cur.setCi_like(rs.getInt("ci_like"));					//cur.setPm_id(rs.getString("pm_id"));
				cur.setAi_idx(rs.getInt("ai_idx"));						cur.setCi_st_name(rs.getString("ci_st_name"));
				cur.setCi_sk_id(rs.getString("ci_sk_id"));				cur.setCi_sk_name(rs.getString("ci_sk_name"));
				cur.setPi_id(rs.getString("pi_id"));					cur.setPi_name(rs.getString("pi_name"));
				cur.setCp_order(rs.getInt("cp_order"));					cur.setCp_stime(rs.getString("cp_stime"));
				cur.setCp_etime(rs.getString("cp_etime"));				cur.setPi_img1(rs.getString("pi_img1"));
				cur.setPi_area(rs.getString("pi_area"));
				
				courseList.add(cur);
				// 占싹놂옙占쏙옙 占쏙옙품 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙 占싸쏙옙占싹쏙옙 pla占쏙옙 pdtList占쏙옙 占쏙옙占쏙옙 
			}
			
		}catch (Exception e) {
			System.out.println("CourseDao 클래스의 getPlaceList() 메서드에러");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return courseList;
	}
	
	public ArrayList<CourseInfo> getCourseInfo(String ciid) {			// 占쌔댐옙 占쌘쏙옙占쏙옙호占쏙옙  占쌘쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙占쏙옙 占쌨소듸옙
		Statement stmt = null;
		ResultSet rs = null;
		CourseInfo cur = null;
		ArrayList<CourseInfo> courseInfo = new ArrayList<CourseInfo>();
		try {
			stmt = conn.createStatement();
			String sql = " select * from v_course_place where ci_id ='" +ciid +"' ";
			System.out.println("sql : " + sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {	
				cur = new CourseInfo();
				cur.setCi_idx(rs.getInt("ci_idx"));
				cur.setCi_name(rs.getString("ci_name"));
				cur.setCi_id(rs.getString("ci_id"));
				//cur.setCi_kind(rs.getString("ci_kind"));
				cur.setCi_date(rs.getString("ci_date"));
				cur.setCi_img(rs.getString("ci_img"));
				cur.setCi_time(rs.getInt("ci_time"));
				cur.setCi_desc(rs.getString("ci_desc"));
				cur.setCi_st_id(rs.getString("ci_st_id"));
				cur.setCi_score(rs.getDouble("ci_score"));
				cur.setCi_like(rs.getInt("ci_like"));
				//cur.setPm_id(rs.getString("pm_id"));
				cur.setAi_idx(rs.getInt("ai_idx"));
				cur.setCi_st_name(rs.getString("ci_st_name"));
				cur.setCi_sk_id(rs.getString("ci_sk_id"));
				cur.setCi_sk_name(rs.getString("ci_sk_name"));
				cur.setPi_id(rs.getString("pi_id"));
				cur.setPi_name(rs.getString("pi_name"));
				cur.setCp_order(rs.getInt("cp_order"));
				cur.setCp_stime(rs.getString("cp_stime"));
				cur.setCp_etime(rs.getString("cp_etime"));
				cur.setPi_img1(rs.getString("pi_img1"));
				cur.setPi_area(rs.getString("pi_area"));
				cur.setPi_la(rs.getDouble("pi_la"));
				cur.setPi_lo(rs.getDouble("pi_lo"));
				cur.setPi_desc(rs.getString("pi_desc"));
				
				
				courseInfo.add(cur);
			}
			
		}catch(Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 getplaInfo() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		return courseInfo;
		
	}
	
	// 占쏙옙占� 占쏙옙占쏙옙 트占쏙옙占쏙옙 占쌨소듸옙
	// 占승깍옙 占싯삼옙占쏙옙 占쏙옙占싱븝옙 占쌩곤옙
	public int tagTrigger(String tag) {
		int result = 0;
		Statement stmt = null;
		String[] tags = tag.substring(1).split(",");
		try {
			stmt = conn.createStatement();
			String sql = "";
			for (int i=0; i<tags.length; i++) {
				System.out.println(sql);
				sql = "insert into t_sch_tag (st_id) values ('" + tags[i] +"') ";
				result = stmt.executeUpdate(sql);
			}			
		}catch (Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 tagTrigger() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		return result;
		
	}
	// 키占쏙옙占쏙옙 占싯삼옙占쏙옙 占쏙옙占싱븝옙 占쌩곤옙 
	public int keyTrigger(String key) {
		int result = 0;
		Statement stmt = null;
		String[] keys = key.substring(1).split(",");
		try {
			stmt = conn.createStatement();
			String sql = "";
			for (int i=0; i<keys.length; i++) {
				sql = "insert into t_sch_keyword (sk_id) values ('" + keys[i] +"') ";
				result = stmt.executeUpdate(sql);
			}
		}catch (Exception e) {
			System.out.println("CourseDao 클占쏙옙占쏙옙占쏙옙 keyTrigger() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		return result;
	}

	
	public int insertCourseStat(String ciid) {
		Statement stmt = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "insert into t_admin_stat_course (ci_id, ac_course_sch ) values ('" + ciid +"' , 1)";
			result = stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 insertPlaceStat() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}
		return result;
	}
	
	public int isSaved(String pmid, String ciid) {
		int saved = 0;
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체			// 占쌩븝옙占쏙옙 占쏙옙占싱듸옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙, 占쌩븝옙占쏙옙 占쏙옙占쏙옙占쏙옙1, 占싣니몌옙 0占쏙옙 占쏙옙占쏙옙
		try {
			String sql = "select count(*) from t_course_saved where pm_id = '" + pmid + "' ci_id = '" + ciid + "' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	
			saved = rs.getInt(1);
			
		}catch (Exception e) {
			System.out.println("CourseDao 클占쏙옙占쏙옙占쏙옙 isSaved() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return saved;
	}
	
	public ArrayList<CourseReviewInfo> getCourseReviewList(String ciid){
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		ArrayList<CourseReviewInfo> cReview = new ArrayList<CourseReviewInfo> ();
		CourseReviewInfo ci = null;
		try {
			String sql = "select * from t_course_review_list where ci_id = '" + ciid + "' order by crl_date desc limit 0, 3"; 
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ci = new CourseReviewInfo();
				ci.setCrl_idx(rs.getInt("crl_idx"));
				ci.setCi_id(rs.getString("ci_id"));
				ci.setPm_id(rs.getString("pm_id"));
				ci.setCr_id(rs.getString("cr_id"));
				ci.setCrl_title(rs.getString("crl_title"));
				ci.setCrl_content(rs.getString("crl_content"));
				ci.setCrl_img1(rs.getString("crl_img1"));
				ci.setCrl_score(rs.getInt("crl_score"));
				ci.setCrl_isview(rs.getString("crl_isview"));
				ci.setCrl_date(rs.getString("crl_date"));
				
				cReview.add(ci);
			}
			
		}catch (Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 getCourseReviewList() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		System.out.println("pReview, size before return :  " + cReview.size());
		return cReview;
	}
	
	public int doLike(String ciid) {
		Statement stmt = null;	
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "update t_course_info set ci_like = ci_like + 1 where ci_id = '" + ciid + "' "; 
			System.out.println("update like : " + sql);
			result = stmt.executeUpdate(sql);
			System.out.println("update result = " + result);
		}catch(Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 insertPlaceStat() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}
		
		return result;
	}
}
