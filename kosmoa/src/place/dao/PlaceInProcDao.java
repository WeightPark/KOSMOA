package place.dao;

import static db.JdbcUtil.*;	// JdbcUtil Ŭ������ ��� ������� �����Ӱ� ����ϰڴٴ� �ǹ�
import java.util.*;
import javax.sql.*;
import java.sql.*;
import place.vo.*;

public class PlaceInProcDao {
	private static PlaceInProcDao placeInProcDao;
	private Connection conn;
	
	private PlaceInProcDao() {}
	
	public static PlaceInProcDao getInstance() {
		if (placeInProcDao == null)	 placeInProcDao = new PlaceInProcDao();
		return placeInProcDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int placeInsert(PlaceInfo place) {
		// ����ڰ� �Է��� ������� ��� ����� �ϴ� �޼ҵ�
			PreparedStatement pstmt = null;
			int result = 0;

			try {
				String sql = "insert into t_place_info (pi_id, pi_name, pi_bigcata, pi_smallcata, st_id, st_name, sk_id, sk_name, " + 
					"pi_isview, pi_la, pi_lo, pi_img1, pi_img2, pi_img3, pi_img4, pi_desc, pi_descimg, pi_time, pi_service, pi_person, " + 
					"pi_isr, pi_isop, pi_isshow, pi_ismain, pi_zip, pi_addr1, pi_addr2, pi_phone, pi_area) " +
					"values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, place.getPi_id());
				pstmt.setString(2, place.getPi_name());
				pstmt.setString(3, place.getPi_bigcata());
				pstmt.setString(4, place.getPi_smallcata());
				pstmt.setString(5, place.getSt_id());
				pstmt.setString(6, place.getSt_name());
				pstmt.setString(7, place.getSk_id());
				pstmt.setString(8, place.getSk_name());
				pstmt.setString(9, place.getPi_isview());
				pstmt.setString(10, place.getPi_la());
				pstmt.setString(11, place.getPi_lo());
				pstmt.setString(12, place.getPi_img1());
				pstmt.setString(13, place.getPi_img2());
				pstmt.setString(14, place.getPi_img3());
				pstmt.setString(15, place.getPi_img4());
				pstmt.setString(16, place.getPi_desc());
				pstmt.setString(17, place.getPi_descimg());
				pstmt.setString(18, place.getPi_time());
				pstmt.setString(19, place.getPi_service());
				pstmt.setInt(20, place.getPi_person());
				pstmt.setString(21, place.getPi_isr());
				pstmt.setString(22, place.getPi_isop());
				pstmt.setString(23, place.getPi_isshow());
				pstmt.setString(24, place.getPi_ismain());
				pstmt.setString(25, place.getPi_zip());
				pstmt.setString(26, place.getPi_addr1());
				pstmt.setString(27, place.getPi_addr2());
				pstmt.setString(28, place.getPi_phone());
				pstmt.setString(29, place.getPi_area());
				
				result = pstmt.executeUpdate();

			} catch(Exception e) {
				System.out.println("PlaceInProcDao Ŭ������ placeInsert() �޼ҵ� ����");
				e.printStackTrace();
			}

			return result;
		}
}
