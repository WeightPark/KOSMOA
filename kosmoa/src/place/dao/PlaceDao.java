package place.dao;

import static db.JdbcUtil.*;
import javax.sql.*;
import java.sql.*;
import java.util.*;
import place.vo.*;
import review.vo.PlaceReviewInfo;


public class PlaceDao {
	private static PlaceDao placeDao;
	private Connection conn;
	
	private PlaceDao() {}
	
	public static PlaceDao getInstance() {
		if (placeDao == null)	placeDao =  new PlaceDao();
		return placeDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getPlaCount( String where) {
		Statement stmt = null;		// ������ ������ stmt��ü
		ResultSet rs = null;		// select���� �̿��ϱ� ���� ��ü
		int rcnt = 0;				// �ߺ��� ���̵��� ������ ������ ����, �ߺ��� ������1, �ƴϸ� 0�� ����
		try {
			String sql = "select count(*) from t_place_info " + where; 
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			rs.next();	
			rcnt = rs.getInt(1);
			
		}catch (Exception e) {
			System.out.println("PlaceDao Ŭ������ getPlaCount() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		System.out.println("rcnt : " + rcnt);
		return rcnt;
	}
	
	public ArrayList<PlaceInfo> getPlaceList( String where, String order, int cpage, int psize){
		Statement stmt = null;		// ������ ������ stmt��ü
		ResultSet rs = null;		// select���� �̿��ϱ� ���� ��ü
		ArrayList<PlaceInfo> plaList = new ArrayList<PlaceInfo>();
		// ��ǰ����� ������ ArrayList�� ���� ProductInfo �ν��Ͻ��� ������ �� ���� 
		PlaceInfo pla = null;
		// pdtList�� ������  ProductInfo�� �ν��Ͻ�
		
		try {
			String sql = "select * from t_place_info " + where + order + " limit " + ((cpage - 1) * psize) +", " + psize;
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pla = new PlaceInfo();
				// pdtList�� ������ �ϳ��� ��ǰ ������ ���� �ν��Ͻ� ����
				pla.setOi_id(rs.getString("oi_id"));						pla.setPi_id(rs.getString("pi_id"));
				pla.setPi_name(rs.getString("pi_name"));					pla.setPi_isview(rs.getString("pi_isview"));
				pla.setPi_la(rs.getString("pi_la"));						pla.setPi_lo(rs.getString("pi_lo"));
				pla.setSt_name(rs.getString("st_name"));					pla.setSk_name(rs.getString("sk_name"));
				pla.setPi_img1(rs.getString("pi_img1"));					pla.setPi_img2(rs.getString("pi_img2"));
				pla.setPi_img3(rs.getString("pi_img3"));					pla.setPi_img4(rs.getString("pi_img4"));
				pla.setPi_desc(rs.getString("pi_desc"));					pla.setPi_descimg(rs.getString("pi_descimg"));
				pla.setPi_time(rs.getString("pi_time"));					pla.setPi_score(rs.getDouble("pi_score"));
				pla.setPi_service(rs.getString("pi_service"));				pla.setPi_person(rs.getInt("pi_person"));
				pla.setPi_isr(rs.getString("pi_isr"));						pla.setPi_isop(rs.getString("pi_isop"));
				pla.setPi_isshow(rs.getString("pi_isshow"));				pla.setPi_ismain(rs.getString("pi_ismain"));
				pla.setSt_id(rs.getString("st_id"));						pla.setSk_id(rs.getString("sk_id"));
				pla.setPi_area(rs.getString("pi_area"));					pla.setPi_zip(rs.getString("pi_zip"));
				pla.setPi_addr1(rs.getString("pi_addr1"));					pla.setPi_addr2(rs.getString("pi_addr2"));
				pla.setPi_phone(rs.getString("pi_phone"));					pla.setPi_bigcata(rs.getString("pi_bigcata"));
				pla.setPi_smallcata(rs.getString("pi_smallcata"));			pla.setPi_date(rs.getString("pi_date"));

				plaList.add(pla);
				// �ϳ��� ��ǰ ������ ���� �ν��Ͻ� pla�� pdtList�� ���� 
			}
			
		}catch (Exception e) {
			System.out.println("PlaceDao Ŭ������ getPlaceList() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return plaList;
	}
	
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
			return result;
		
						
		}catch (Exception e) {
			System.out.println("PlaceDao Ŭ������ tagTrigger() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		return result;
		
	}
	
	public int keyTrigger(String key) {
		int result = 0;
		Statement stmt = null;
		String[] keys = key.substring(1).split(",");
		try {
			stmt = conn.createStatement();
			String sql = "";
			for (int i=0; i<keys.length; i++) {
				System.out.println(sql);
				sql = "insert into t_sch_keyword (sk_id) values ('" + keys[i] +"') ";
				result = stmt.executeUpdate(sql);
			}
			return result;
		
						
		}catch (Exception e) {
			System.out.println("PlaceDao Ŭ������ keyTrigger() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		return result;
		
	}
	
	public PlaceInfo getplaInfo(String piid) {
		Statement stmt = null;
		ResultSet rs = null;
		PlaceInfo pla = null;

		try {
			stmt = conn.createStatement();
			String sql = " select * from t_place_info where pi_id ='" +piid +"' ";
			System.out.println("sql : " + sql);
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				pla = new PlaceInfo();
				pla.setOi_id(rs.getString("oi_id"));
				pla.setPi_id(rs.getString("pi_id"));
				pla.setPi_name(rs.getString("pi_name"));
				pla.setPi_isview(rs.getString("pi_isview"));
				pla.setPi_la(rs.getString("pi_la"));
				pla.setPi_lo(rs.getString("pi_lo"));
				pla.setSt_name(rs.getString("st_name"));
				pla.setSk_name(rs.getString("sk_name"));
				pla.setPi_img1(rs.getString("pi_img1"));
				pla.setPi_img2(rs.getString("pi_img2"));
				pla.setPi_img3(rs.getString("pi_img3"));
				pla.setPi_img4(rs.getString("pi_img4"));
				pla.setPi_desc(rs.getString("pi_desc"));
				pla.setPi_descimg(rs.getString("pi_descimg"));
				pla.setPi_time(rs.getString("pi_time"));
				pla.setPi_score(rs.getDouble("pi_score"));
				pla.setPi_service(rs.getString("pi_service"));
				pla.setPi_person(rs.getInt("pi_person"));
				pla.setPi_isr(rs.getString("pi_isr"));
				pla.setPi_isop(rs.getString("pi_isop"));
				pla.setPi_isshow(rs.getString("pi_isshow"));
				pla.setPi_ismain(rs.getString("pi_ismain"));
				pla.setSt_id(rs.getString("st_id"));
				pla.setSk_id(rs.getString("sk_id"));
				pla.setPi_area(rs.getString("pi_area"));
				pla.setPi_zip(rs.getString("pi_zip"));
				pla.setPi_addr1(rs.getString("pi_addr1"));
				pla.setPi_addr2(rs.getString("pi_addr2"));
				pla.setPi_phone(rs.getString("pi_phone"));
				pla.setPi_bigcata(rs.getString("pi_bigcata"));
				pla.setPi_smallcata(rs.getString("pi_smallcata"));
				pla.setPi_date(rs.getString("pi_date"));
			}
			
		}catch(Exception e) {
			System.out.println("PlaceDao Ŭ������ getplaInfo() �޼ҵ� ����");
			e.printStackTrace();
			
		}finally {
			close(rs);	close(stmt);
		}
		return pla;
		
	}
	
	public int insertPlaceStat(String piid) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		try {
			stmt = conn.createStatement();
			String sql = "insert into t_admin_stat_place (pi_id, ap_place_sch ) values ('" + piid +"' , 1)";
			result = stmt.executeUpdate(sql);
			if(result ==1) {
				result = 0;
				sql = " insert into t_own_member_stat (osi_id, os_view) values ('"+piid + "' , 1)";
				result = stmt.executeUpdate(sql);
			}
			
		}catch(Exception e) {
			System.out.println("PlaceDao Ŭ������ insertPlaceStat() �޼ҵ� ����");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}
		return result;
	}
	
	public int isSaved(String pmid, String piid) {
		Statement stmt = null;
		ResultSet rs = null;
		int saved = 0;
		try {
			stmt = conn.createStatement();
			String sql = "select count(*) from where pm_id = '" + pmid + "' and pi_id = '" + piid + "' ";
			rs = stmt.executeQuery(sql);
			rs.next();		saved = rs.getInt(1);
		}catch(Exception e) {
			System.out.println("PlaceDao Ŭ������ isSaved() �޼ҵ� ����");
			e.printStackTrace();
			
		}finally {
			close(stmt);
		}	
		return saved;
	}
	
	public ArrayList<PlaceReviewInfo> getPlaceReviewList(String piid){
		Statement stmt = null;		// ������ ������ stmt��ü
		ResultSet rs = null;		// select���� �̿��ϱ� ���� ��ü
		ArrayList<PlaceReviewInfo> pReview = new ArrayList<PlaceReviewInfo> ();
		PlaceReviewInfo ri = null;
		try {
			String sql = "select * from t_place_review_list where pi_id = '" + piid + "' order by prl_date desc limit 0, 3"; 
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
			System.out.println("PlaceDao Ŭ������ ReviewListSvc() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return pReview;
	}
}
