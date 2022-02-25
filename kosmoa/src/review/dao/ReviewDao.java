package review.dao;

import static db.JdbcUtil.*;
import javax.sql.*;

import place.dao.PlaceDao;
import place.vo.PlaceInfo;

import java.sql.*;
import java.util.*;
import review.vo.*;

public class ReviewDao {
	private static ReviewDao reviewDao;
	private Connection conn;
	
	private ReviewDao() {}
	
	public static ReviewDao getInstance() {
		if (reviewDao == null)	reviewDao =  new ReviewDao();
		return reviewDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getPreviewCnt(String where) {		// 占쏙옙체  占쏙옙占� 占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙 占쌨아울옙
		Statement stmt = null;	 
		ResultSet rs = null;	
		int rcnt = 0;
		try {
			String sql = "select count(*) from t_place_review_list " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	rcnt = rs.getInt(1);
			
		}catch (Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 getPlaceList() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return rcnt;	
	}
	
	public ArrayList<PlaceReviewInfo> getPlaceReviewList(String where, int cpage, int psize){
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		ArrayList<PlaceReviewInfo> pReview = new ArrayList<PlaceReviewInfo> ();
		PlaceReviewInfo ri = null;
		try {
			String sql = "select * from t_place_review_list " + where + " order by prl_date desc limit " + ((cpage - 1) * psize) +", " + psize;;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				ri = new PlaceReviewInfo();
				ri.setPrl_idx(rs.getInt("prl_idx"));
				ri.setPi_id(rs.getString("pi_id"));
				ri.setPm_id(rs.getString("pm_id"));
				ri.setCr_id(rs.getString("pr_id")); 
				ri.setPrl_title(rs.getString("prl_title"));
				ri.setPrl_content(rs.getString("prl_content"));
				ri.setPrl_img1(rs.getString("prl_img1"));
				ri.setPrl_score(rs.getInt("prl_score"));
				ri.setPrl_isview(rs.getString("prl_isview"));
				ri.setPrl_date(rs.getString("prl_date"));
				
				pReview.add(ri);
			}
			
		}catch (Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 ReviewListSvc() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return pReview;
	}
	
	
	
	public int getCreviewCnt(String where) {		// 占쏙옙체  占쌘쏙옙 占쏙옙占쏙옙 占쏙옙 占쏙옙占쏙옙 占쌨아울옙
		Statement stmt = null;	 
		ResultSet rs = null;	
		int rcnt = 0;
		try {
			String sql = "select count(*) from t_course_review_list " + where;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	rcnt = rs.getInt(1);
			
		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getCreviewCnt() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return rcnt;	
	}
	
	public ArrayList<CourseReviewInfo> getCourseReviewList(String where, int cpage, int psize){
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		ArrayList<CourseReviewInfo> cReview = new ArrayList<CourseReviewInfo> ();
		CourseReviewInfo ci = null;
		try {
			String sql = "select * from t_course_review_list " + where + " order by crl_date desc limit " + ((cpage - 1) * psize) +", " + psize;
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
				ci.setCrl_good(rs.getInt("crl_good"));
				
				cReview.add(ci);
			}
			
		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getCourseReviewList() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
 
		return cReview;
	}
	
	public ReviewInFormInfo getPreserved(String crid) {		// 占쏙옙占� 占식깍옙占쌜쇽옙占쏙옙 占쏙옙占�, t_place_reserve 占쏙옙占쏙옙 占싱몌옙 占쏙옙占쏙옙占쏙옙
		ReviewInFormInfo rinfo = new ReviewInFormInfo();
		Statement stmt = null;		 
		ResultSet rs = null;		 
		try {
			String sql = "select * from t_place_reserve where pr_id = '" + crid +"' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				rinfo.setTitle(rs.getString("pi_name"));
				rinfo.setIdnum(rs.getString("pi_id"));
				rinfo.setCrid(rs.getString("pr_id"));
				rinfo.setKind("p");
			}
			
		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getPreserved() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return rinfo;
	}
	
	public ReviewInFormInfo getCreserved(String crid) {		// 占쌘쏙옙 占식깍옙占쌜쇽옙占쏙옙 占쏙옙占�,  t_course_reserve 占쏙옙占쏙옙 占싱몌옙 占쏙옙占쏙옙占쏙옙
		ReviewInFormInfo rinfo = new ReviewInFormInfo();
		Statement stmt = null;		 
		ResultSet rs = null;		 
		try {
			String sql = "select * from t_course_reserve where cr_id = '" + crid +"' ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if(rs.next()) {
				rinfo.setTitle(rs.getString("ci_name"));
				rinfo.setIdnum(rs.getString("ci_id"));
				rinfo.setCrid(rs.getString("cr_id"));
				rinfo.setKind("c");
			}
			
		}catch (Exception e) {
			System.out.println("PlaceDao 클占쏙옙占쏙옙占쏙옙 getCreserved() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return rinfo;
	}
	
	public int getPmaxNum( ReviewInFormInfo rivInfo) {		// 占쏙옙占� 占쏙옙占쏙옙占쏙옙 占쌍댐옙 idx占쏙옙 占쏙옙占쏙옙
		int idx = 0;
		int result = 0;
		double avg = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select max(prl_idx) from t_place_review_list";
			rs = stmt.executeQuery(sql);
			if (rs.next())	idx = rs.getInt(1) + 1;
			System.out.println("占쌜뱄옙호占쏙옙 : " + idx);
			sql = "insert into t_place_review_list (prl_idx, pi_id, pm_id, pr_id, prl_title, prl_content, prl_img1, prl_score) " +
					" values(" + idx + " , '" + rivInfo.getIdnum()  + "' , '" + rivInfo.getMiid()  + "' , '" + rivInfo.getCrid() +
					 "', '" + rivInfo.getRiv_title() + "', '" + rivInfo.getContent() + "', '" + rivInfo.getImg1() + "', " + rivInfo.getScroe() + " ) "; 
			
			System.out.println(sql);			
			result = stmt.executeUpdate(sql);
			System.out.println("insert review list : " + result);
			if (result == 1) {
				sql = "select  avg(prl_score) from t_place_review_list group by '" + rivInfo.getIdnum() + "'";
				System.out.println("avg sql : " + sql);
				rs = stmt.executeQuery(sql);
				if (rs.next())	avg = rs.getDouble(1);
				
				sql = "update t_place_info set pi_score = " + avg + " where pi_id = '" + rivInfo.getIdnum() + "' ";
				System.out.println("updaet sql : " + sql);
				result = stmt.executeUpdate(sql);
				System.out.println("after update : " + result);
			} 		

		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getPmaxNum() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs); 	close(stmt);
		}
		
		return result;
	}

	public int getCmaxNum(ReviewInFormInfo rivInfo) {
		int idx = 0;
		int result = 0;
		double avg = 0;
		Statement stmt = null;
		ResultSet rs = null;
		try {
			stmt = conn.createStatement();
			String sql = "select max(crl_idx) from  t_course_review_list";
			rs = stmt.executeQuery(sql);
			if (rs.next())	idx = rs.getInt(1) + 1;
			System.out.println("占쌜뱄옙호占쏙옙 : " + idx);
			sql = "insert into t_course_review_list (crl_idx, ci_id, pm_id, cr_id, crl_title, crl_content, crl_img1, crl_score) " +
					" values(" + idx + " , '" + rivInfo.getIdnum()  + "' , '" + rivInfo.getMiid()  + "' , '" + rivInfo.getCrid() +
					 "', '" + rivInfo.getRiv_title() + "', '" + rivInfo.getContent() + "', '" + rivInfo.getImg1() + "', " + rivInfo.getScroe() + " ) "; 
			
			System.out.println(sql);			
			result = stmt.executeUpdate(sql);
			System.out.println("insert review list : " + result);
			if (result == 1) {
				sql = "select  avg(crl_score) from t_course_review_list group by '" + rivInfo.getIdnum() + "'";
				System.out.println("avg sql : " + sql);
				rs = stmt.executeQuery(sql);
				if (rs.next())	avg = rs.getDouble(1);
				
				sql = "update t_course_info set ci_score = " + avg + " where ci_id = '" + rivInfo.getIdnum() + "' ";
				System.out.println("updaet sql : " + sql);
				result = stmt.executeUpdate(sql);
				System.out.println("after update : " + result);
			} 		
			

		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getCmaxNum() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs); 	close(stmt);
		}
		
		return idx;
	}
	
	
	public ArrayList<PlaceReviewInfo> getMypReviewList(String pmid, int cpage, int psize){
		// 占쏙옙占� 占식깍옙 占쏙옙 占쏙옙占쏙옙占쏙옙
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		ArrayList<PlaceReviewInfo> mypReview = new ArrayList<PlaceReviewInfo> ();
		PlaceReviewInfo ri = null;
		try {
			stmt = conn.createStatement();
			String sql = "";
			sql = " select * from t_place_review_list where pm_id = '" + pmid +"' order by prl_idx desc limit " + ((cpage - 1) * psize) +", " + psize;
			System.out.println("sql : " + sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				do {
					ri = new PlaceReviewInfo();
					ri.setPrl_idx(rs.getInt("prl_idx"));
					ri.setPi_id(rs.getString("pi_id"));
					ri.setPm_id(rs.getString("pm_id"));
					ri.setCr_id(rs.getString("pr_id"));
					ri.setPrl_title(rs.getString("prl_title"));
					ri.setPrl_content(rs.getString("prl_content"));
					ri.setPrl_img1(rs.getString("prl_img1"));
					ri.setPrl_score(rs.getInt("prl_score"));
					ri.setPrl_isview(rs.getString("prl_isview"));
					ri.setPrl_date(rs.getString("prl_date"));

					mypReview.add(ri);
				}while (rs.next());
			}
		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getPlaceReviewList() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs); 	close(stmt);
		}
		
		return mypReview;
		
	}
	
	public ArrayList<PlaceReviewInfo> getMycReviewList(String pmid, int cpage, int psize){
		// 占쌘쏙옙 占식깍옙占� 占쏙옙占쏙옙占쏙옙 
		Statement stmt = null;		// 占쏙옙占쏙옙占쏙옙 占쏙옙占쏙옙占쏙옙 stmt占쏙옙체
		ResultSet rs = null;		// select占쏙옙占쏙옙 占싱울옙占싹깍옙 占쏙옙占쏙옙 占쏙옙체
		ArrayList<PlaceReviewInfo> mycReview = new ArrayList<PlaceReviewInfo> ();
		PlaceReviewInfo ri = null;
		try {
			stmt = conn.createStatement();
			String sql = "";
			sql = " select * from t_course_review_list where pm_id = '" + pmid +"' order by crl_idx desc limit " + ((cpage - 1) * psize) +", " + psize;
			System.out.println("sql : " + sql);
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				do {
					ri = new PlaceReviewInfo();
					ri.setPrl_idx(rs.getInt("crl_idx"));
					ri.setPi_id(rs.getString("ci_id"));
					ri.setPm_id(rs.getString("pm_id"));
					ri.setCr_id(rs.getString("cr_id"));
					ri.setPrl_title(rs.getString("crl_title"));
					ri.setPrl_content(rs.getString("crl_content"));
					ri.setPrl_img1(rs.getString("crl_img1"));
					ri.setPrl_score(rs.getInt("crl_score"));
					ri.setPrl_isview(rs.getString("crl_isview"));
					ri.setPrl_date(rs.getString("crl_date"));		

					mycReview.add(ri);
				}while (rs.next());
			}
		}catch (Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 getMycReviewList() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		}finally {
			close(rs); 	close(stmt);
		}
		
		return mycReview;
		
	}
	
	public int delPreview(String where) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "delete from t_place_review_list " + where;
			System.out.println("delpReview : " + sql);
			result = stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 delPreview() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		} finally {
			close(stmt);
		}

		return result;
	}
	
	public int delCreview(String where) {
		int result = 0;
		Statement stmt = null;
		try {
			stmt = conn.createStatement();
			String sql = "delete from t_course_review_list " + where;
			System.out.println("delCreview : " + sql);
			result = stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 delCreview() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
		} finally {
			close(stmt);
		}

		return result;
	}
	
	public int doPLike(int rvid) {
	// 占쏙옙占싣울옙 처占쏙옙占싹댐옙 ajax
		Statement stmt = null;	
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = " update t_place_review_list set prl_good = prl_good + 1  where prl_idx = " + rvid;
			System.out.println(sql);
			result = stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 doLike() 占쌨소듸옙 占쏙옙占쏙옙");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int doCLike(int rvid) {
		// 占쏙옙占싣울옙 처占쏙옙占싹댐옙 ajax
			Statement stmt = null;	
			int result = 0;
			try {
				stmt = conn.createStatement();
				String sql = " update t_course_review_list set crl_good = crl_good + 1  where crl_idx = " + rvid;
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
				
			}catch(Exception e) {
				System.out.println("ReviewDao 클占쏙옙占쏙옙占쏙옙 doLike() 占쌨소듸옙 占쏙옙占쏙옙");
				e.printStackTrace();
				
			}finally {
				close(stmt);
			}
			
			return result;
		}
	

}
