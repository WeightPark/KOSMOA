package place.dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰڴٴ� �ǹ�
import java.util.*;
import javax.sql.*;
import java.sql.*;
import place.vo.*;
import place.vo.PlaceInfo;
import vo.*;

public class PlaceUpProcDao {
	private static PlaceUpProcDao placeUpProcDao;
	private Connection conn;

	private PlaceUpProcDao()	{}
	
	public static PlaceUpProcDao getInstance() {
	// �̱��� ������� �ν��Ͻ� ���� ����
		if (placeUpProcDao == null)	placeUpProcDao = new PlaceUpProcDao();
		return placeUpProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int placeUpdate(PlaceInfo placeInfo) {
		// ��� �������� ���� �ϴ� �޼ҵ�
		Statement stmt = null;
		int result = 0;

		try {
			stmt = conn.createStatement();
			String sql = "update t_place_info set " + 
				"pi_name = '"		+ placeInfo.getPi_name()	+ "' " + 
				"pi_bigcata = '"	+ placeInfo.getPi_bigcata()	+ "' " +
				"pi_smallcata = '"	+ placeInfo.getPi_smallcata()	+ "' " +
				"st_id = '"			+ placeInfo.getSt_id()	+ "' " +
				"st_name = '"		+ placeInfo.getSt_name()	+ "' " +
				"pi_img1 = '"		+ placeInfo.getPi_img1()	+ "' " +
				"pi_img2 = '"		+ placeInfo.getPi_img1()	+ "' " +
				"pi_img3 = '"		+ placeInfo.getPi_img1()	+ "' " +
				"pi_img4 = '"		+ placeInfo.getPi_img1()	+ "' " +
				"pi_desc = '"		+ placeInfo.getPi_desc()	+ "' " +
				"pi_descimg = '"	+ placeInfo.getPi_descimg()	+ "' " +
				"pi_time = '"		+ placeInfo.getPi_time()	+ "' " +
				"pi_service = '"	+ placeInfo.getPi_service()	+ "' " +
				"pi_person = '"		+ placeInfo.getPi_person()	+ "' " +
				"pi_isr = '"		+ placeInfo.getPi_isr()	+ "' " +
				"pi_isop = '"		+ placeInfo.getPi_isop()	+ "' " +
				"pi_ismain = '"		+ placeInfo.getPi_ismain()	+ "' " +
				"pi_zip = '"		+ placeInfo.getPi_zip()	+ "' " +
				"pi_addr1 = '"		+ placeInfo.getPi_addr1()	+ "' " +
				"pi_addr2 = '"		+ placeInfo.getPi_addr2()	+ "' " +
				"pi_phone = '"		+ placeInfo.getPi_phone()	+ "' " +
				"pi_area = '"		+ placeInfo.getPi_area()	+ "' " +
				"sk_id = '"			+ placeInfo.getSk_id()	+ "' ";
				
				result = stmt.executeUpdate(sql);

		} catch(Exception e) {
			System.out.println("PlaceUpProcDao Ŭ������ placeUpdate() �޼ҵ� ����");
			e.printStackTrace();
		}

		return result;
	}
}
