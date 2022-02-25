package member.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import place.vo.*;
import java.sql.*;
import member.dao.*;
import reserve.dao.ReservedDao;
import reserve.vo.*;

public class MemberReserveListSvc {
	public ReservedListInfo getReserveList (String where) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		
		ArrayList<CourseReservedInfo> courseList = new ArrayList<CourseReservedInfo>();
		courseList = reservedDao.getCourseReserveList(where);
		
		ArrayList<PlaceReservedInfo> placeList = new ArrayList<PlaceReservedInfo>();
		placeList = reservedDao.getPlaceReserveList(where);
		
		ReservedListInfo rList = new ReservedListInfo();
		
		rList.setCourseList(courseList);	rList.setPlaceList(placeList);
		close(conn);
		
		return rList;
	}
	
	public ArrayList<PlaceReservedInfo> getPlaceList(String crid) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		
		ArrayList<PlaceReservedInfo> placeList = new ArrayList<PlaceReservedInfo>();
		placeList = reservedDao.getReservePlaceList(crid);
		
		close(conn);
		
		return placeList;
	}
	
	public PlaceReservedInfo getPlaceInfo (String prid) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		
		PlaceReservedInfo placeInfo = new PlaceReservedInfo();
		placeInfo = reservedDao.getReservePlaceInfo(prid);
		
		close(conn);
		
		return placeInfo;
	}
}
