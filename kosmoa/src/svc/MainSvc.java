package svc;

import static db.JdbcUtil.*;	
import java.util.*;
import course.vo.*;
import place.vo.*;
import review.vo.*;
import java.sql.*;
import dao.*;

public class MainSvc {
	public ArrayList<CourseInfo> getCourseList(String where) {
		Connection conn = getConnection();
		MainDao mainDao = MainDao.getInstance();
		mainDao.setConnection(conn);
		
		ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		courseList = mainDao.getCourseList(where);
		
		close(conn);
		
		return courseList;
	}
	
	public ArrayList<PlaceInfo> getPlaceList() {
		Connection conn = getConnection();
		MainDao mainDao = MainDao.getInstance();
		mainDao.setConnection(conn);
		
		ArrayList<PlaceInfo> courseList = new ArrayList<PlaceInfo>();
		courseList = mainDao.getPlaceList();
		
		close(conn);
		
		return courseList;
	}
	
	public ArrayList<CourseReviewInfo> getReviewList() {
		Connection conn = getConnection();
		MainDao mainDao = MainDao.getInstance();
		mainDao.setConnection(conn);
		
		ArrayList<CourseReviewInfo> reviewList = new ArrayList<CourseReviewInfo>();
		reviewList = mainDao.getReviewList();
		
		close(conn);
		
		return reviewList;
	}
	
	public ArrayList<String> getTagList() {
		Connection conn = getConnection();
		MainDao mainDao = MainDao.getInstance();
		mainDao.setConnection(conn);
		
		ArrayList<String> tagList = new ArrayList<String>();
		tagList = mainDao.getTagList();
		
		close(conn);
		
		return tagList;
	}
}
