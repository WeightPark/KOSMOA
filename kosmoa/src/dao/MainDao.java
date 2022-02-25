package dao;

import static db.JdbcUtil.*;
import java.sql.*;

import javax.naming.spi.DirStateFactory.Result;
import javax.sql.*;
import java.util.*;
import vo.*;
import act.*;
import course.vo.CourseInfo;
import member.*;
import place.vo.PlaceInfo;
import reserve.dao.ReservedDao;
import reserve.vo.*;
import review.vo.CourseReviewInfo;

public class MainDao {
	private static MainDao mainDao;
	private Connection conn;
	
	private MainDao() {}
	
	public static MainDao getInstance() {
		if (mainDao == null)	 mainDao = new MainDao();
		return mainDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<CourseInfo> getCourseList(String where) {
	// 筌롫뗄�뵥占쎌넅筌롫똻肉됵옙苑� 癰귣똻肉т빳占� �굜遺용뮞 占쎌젟癰귣�占쏙옙 獄쏆룇釉섓옙�궞 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		CourseInfo ci = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_course_info " + where + " order by ci_score desc limit 8";
			System.out.println("sql : " + sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ci = new CourseInfo();
				
				ci.setCi_id(rs.getString("ci_id"));		ci.setCi_name(rs.getString("ci_name"));
				ci.setCi_img(rs.getString("ci_img"));
				ci.setCourse_place_list(getCoursePlaceList(rs.getString("ci_id")));
				
				courseList.add(ci);
			}
			
		} catch(Exception e) {
			System.out.println("MainDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getCourseList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return courseList;
	}
	
	public ArrayList<PlaceInfo> getCoursePlaceList(String ci_id) {
	// �굜遺용뮞占쎈퓠 占쎈７占쎈맙占쎈쭆 占쎌삢占쎈꺖占쎌벥 筌뤴뫖以됵옙�뱽 獄쏆룇釉섓옙�궞 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		PlaceInfo pi = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from v_course_place where ci_id = '" + ci_id + "' order by cp_order";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new PlaceInfo();
				
				pi.setPi_name(rs.getString("pi_name"));		pi.setPi_img1(rs.getString("pi_img1"));
				placeList.add(pi);
			}
			
		} catch(Exception e) {
			System.out.println("MainDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getCoursePlaceList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return placeList;
	}
	
	public ArrayList<PlaceInfo> getPlaceList() {
	// 筌롫뗄�뵥占쎌넅筌롫똻肉됵옙苑� 癰귣똻肉т빳占� 占쎌삢占쎈꺖 占쎌젟癰귣�占쏙옙 獄쏆룇釉섓옙�궞 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		PlaceInfo pi = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_place_info order by pi_score desc limit 8";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				pi = new PlaceInfo();
				
				pi.setPi_id(rs.getString("pi_id"));
				pi.setPi_name(rs.getString("pi_name"));		pi.setPi_img1(rs.getString("pi_img1"));
				placeList.add(pi);
			}
			
		} catch(Exception e) {
			System.out.println("MainDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getPlaceList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return placeList;
	}
	
	public ArrayList<CourseReviewInfo> getReviewList() {
	// 筌롫뗄�뵥占쎌넅筌롫똻肉됵옙苑� 癰귣똻肉т빳占� �뵳�됰윮 占쎌젟癰귣�占쏙옙 獄쏆룇釉섓옙�궞 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<CourseReviewInfo> reviewList = new ArrayList<CourseReviewInfo>();
		CourseReviewInfo ci = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_course_review_list order by crl_date desc limit 4";
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				ci = new CourseReviewInfo();
				
				ci.setCrl_idx(rs.getInt("crl_idx"));	
				ci.setCrl_title(rs.getString("crl_title"));	
				ci.setCrl_img1(rs.getString("crl_img1"));
				ci.setCrl_score(rs.getInt("crl_score"));
				reviewList.add(ci);
			}
			
		} catch(Exception e) {
			System.out.println("MainDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getReviewList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return reviewList;
	}
	
	public ArrayList<String> getTagList() {
	// 筌롫뗄�뵥 占쎌넅筌롫똻肉됵옙苑� 癰귣똻肉т빳占� 占쎌뵥疫뀐옙 占쎄묶域밸챶占쏙옙 獄쏆룇釉섓옙�궎占쎈뮉 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<String> tagList = new ArrayList<String>();
		String tname = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_admin_stat_tag order by as_tag desc limit 5";
System.out.println("tagList sql : " + sql);
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				tname = rs.getString("st_name");
				
				tagList.add(tname);
			}
			
		} catch(Exception e) {
			System.out.println("MainDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getTagList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return tagList;
	}
}
