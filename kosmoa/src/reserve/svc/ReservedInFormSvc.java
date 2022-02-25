package reserve.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import place.vo.*;
import java.sql.*;
import reserve.dao.*;
import reserve.vo.*;

public class ReservedInFormSvc {
	public ArrayList<PlaceInfo> getPlaceList (String ciid) {
		System.out.println("reservedinfrom svc 진입");
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		ArrayList<PlaceInfo> placeList = reservedDao.getPlaceList(ciid);
		
		close(conn);
		System.out.println("placeList의 크기는 : " + placeList.size());
		return placeList;
	}
	
	public PlaceInfo getPlaceInfo (String piid) {
		Connection conn = getConnection();
		ReservedDao reservedDao = ReservedDao.getInstance();
		reservedDao.setConnection(conn);
		PlaceInfo placeInfo = reservedDao.getPlaceInfo(piid);
		
		close(conn);
		
		return placeInfo;
	}
}
