package member.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import member.vo.*;
import vo.*;

public class SavedDao {
	private static SavedDao savedDao;
	private Connection conn;
	
	private SavedDao() {}
	
	public static SavedDao getInstance() {
		if (savedDao == null)	 savedDao = new SavedDao();
		return savedDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int getSaveCount(String id, String wtype) {
	// 占쎄맒占쎈�뱄옙�벥 占쎌읈筌ｏ옙 揶쏆뮇�땾�몴占� �뵳�뗪쉘占쎈릭占쎈뮉 筌롫뗄苑뚳옙諭�
			Statement stmt = null;
			ResultSet rs = null;
			int rcnt = 0;	
	
			try {
				String sql = "select count(*) from t_" + wtype + "_saved where pm_id = '" + id + "'";
				stmt = conn.createStatement();
				rs = stmt.executeQuery(sql);
				rs.next();	
				rcnt = rs.getInt(1);

			} catch(Exception e) {
				System.out.println("SavedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getSaveCount() 筌롫뗄苑뚳옙諭� 占쎈퓠占쎌쑎");
				e.printStackTrace();
			} finally {
				close(rs);	
				close(stmt);
			}
			return rcnt;
		}
	
	
	
	public ArrayList<SavedCourseInfo> getCosList(String where, int cpage, int psize) {
	// 占쏙옙占쎌삢占쎈쭆 �굜遺용뮞 筌뤴뫖以됵옙�뱽 ArrayList<SavedCourseInfo>占쎌굨 占쎌뵥占쎈뮞占쎄쉘占쎈뮞嚥∽옙 �뵳�뗪쉘占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<SavedCourseInfo> cosList = new ArrayList<SavedCourseInfo>();
			SavedCourseInfo cosInfo = null;
 
			try {
				stmt = conn.createStatement();
				int snum = (cpage - 1) * psize; //limit 占쎈뻻占쎌삂 占쎌뵥占쎈쑔占쎈뮞 甕곕뜇�깈 
				String sql = "select a.*, b.ci_img, b.ci_name " 
						   + " from t_course_saved AS a, t_course_info AS b " + 
						     " where a.ci_id = b.ci_id " + where + " limit " + snum + ", " + psize; 
				System.out.println("getCosListsql :  " + sql);
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					cosInfo = new SavedCourseInfo();
					// ArrayList占쎌뵥 saveCosList占쎈퓠 占쏙옙占쎌삢占쎈릭疫뀐옙 占쎌맄占쎈퉸 SavedCourseInfo占쎌굨 占쎌뵥占쎈뮞占쎄쉘占쎈뮞 cosList�몴占� 占쎄문占쎄쉐
					cosInfo.setCs_idx(rs.getInt("cs_idx"));
					cosInfo.setCi_id(rs.getString("ci_id"));
					cosInfo.setCs_date(rs.getString("cs_date"));
					cosInfo.setPm_id(rs.getString("pm_id"));
					cosInfo.setCi_img(rs.getString("ci_img"));
					cosInfo.setCi_name(rs.getString("ci_name"));
					
					cosList.add(cosInfo);
				}
			} catch(Exception e) {
				System.out.println("SavedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getCosList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
				e.printStackTrace();
			} finally {
				close(rs);	
				close(stmt);
			}
			return cosList;
		}
	
	public ArrayList<SavedPlaceInfo> getPlsList(String where, int cpage, int psize) {
	// 占쏙옙占쎌삢占쎈쭆 占쎌삢占쎈꺖 筌뤴뫖以됵옙�뱽 ArrayList<SavedPlaceInfo>占쎌굨 占쎌뵥占쎈뮞占쎄쉘占쎈뮞嚥∽옙 �뵳�뗪쉘占쎈릭占쎈뮉 筌롫뗄�꺖占쎈굡
			Statement stmt = null;
			ResultSet rs = null;
			ArrayList<SavedPlaceInfo> plsList = new ArrayList<SavedPlaceInfo>();
			SavedPlaceInfo plsInfo = null;

			try {
				stmt = conn.createStatement();
				int snum = (cpage - 1) * psize; //limit 占쎈뻻占쎌삂 占쎌뵥占쎈쑔占쎈뮞 甕곕뜇�깈 
				String sql = "select a.*, b.pi_img1, b.pi_name " 
						   + " from t_place_saved AS a, t_place_info AS b " + 
						     " where a.pi_id = b.pi_id " + where + " limit " + snum + ", " + psize;  
				System.out.println("getPlaceListsql :  " + sql);
				rs = stmt.executeQuery(sql);
				while (rs.next()) {
					plsInfo = new SavedPlaceInfo();
					// ArrayList占쎌뵥 saveCosList占쎈퓠 占쏙옙占쎌삢占쎈릭疫뀐옙 占쎌맄占쎈퉸 SavedCourseInfo占쎌굨 占쎌뵥占쎈뮞占쎄쉘占쎈뮞 cosList�몴占� 占쎄문占쎄쉐
					plsInfo.setPs_idx(rs.getInt("ps_idx"));
					plsInfo.setPi_id(rs.getString("pi_id"));
					plsInfo.setPs_date(rs.getString("ps_date"));
					plsInfo.setPm_id(rs.getString("pm_id"));
					plsInfo.setPi_img(rs.getString("pi_img1"));
					plsInfo.setPi_name(rs.getString("pi_name"));

					plsList.add(plsInfo);
				}
			} catch(Exception e) {
				System.out.println("SavedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getPlsList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
				e.printStackTrace();
			} finally {
				close(rs);	
				close(stmt);
			}
			return plsList;
		}
		
	public int saveDelete(String wtype, String where) {
	// 占쏙옙占쎌삢占쎈쭆 占쎌삢占쎈꺖,�굜遺용뮞 占쎄텣占쎌젫占쎈뻻占쎄텕占쎈뮉 筌롫뗄苑뚳옙諭� 
		Statement stmt = null;
		int result = 0;
		System.out.println("wtype : " + wtype);
		System.out.println("where : " + where);
		
		
		try {
			String sql = "";
			if(wtype.equals("cosDel")) {  // 占쏙옙占쎌삢占쎈쭆 �굜遺용뮞 占쎄텣占쎌젫占쎈뻻 
				sql = "delete from t_course_saved " + where;
				
			}else {						 // 占쏙옙占쎌삢占쎈쭆 占쎌삢占쎈꺖 占쎄텣占쎌젫占쎈뻻 
				sql = "delete from t_place_saved " + where;
			}
			System.out.println("sql : " + sql);
			
			stmt = conn.createStatement();
			result = stmt.executeUpdate(sql);
			
		}catch(Exception e) {
			System.out.println("SaveDao占쎄깻占쎌삋占쎈뮞占쎌벥 saveDelete()筌롫뗄苑뚳옙諭� 占쎌궎�몴占�");
			e.printStackTrace();
		}finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int saveInsert(String wtype, String cnpid, String pmid) {
	// 占쎌삢占쎈꺖, �굜遺용뮞 占쏙옙占쎌삢占쎈뻻占쎄텕占쎈뮉 筌롫뗄苑뚳옙諭�
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;				// �뜎�눖�봺 野껉퀗�궢�몴占� 占쎈뼖占쎌뱽 癰귨옙占쎈땾
		int saved = 0;
		String saveTable = "";		// 占쎄텢占쎌뒠占쎈막 占쎈�믭옙�뵠�뇡遺우뱽 占쎈뼖占쎌뱽 癰귨옙占쎈땾 
		String cnp_id = "";			// 占쎄텢占쎌뒠占쎈막 占쎈툡占쎌뵠占쎈탵�몴占� 占쎈뼖占쎌뱽 癰귨옙占쎈땾
		
		if(wtype.equals("plsIn")) {	// 占쎌삢占쎈꺖 占쏙옙占쎌삢占쎌뵠筌롳옙, 
			System.out.println(wtype);
			saveTable = "t_place_saved";
			cnp_id = "pi_id";
		}else {
			saveTable = "t_course_saved";
			cnp_id = "ci_id";
		}
		
		try {
			String sql = "";
			stmt = conn.createStatement();
			sql = "select " + "count("+ cnp_id + ")" + " from " + saveTable + " where pm_id = '" + pmid + "' and " + cnp_id + " ='" + cnpid + "'"; 
			System.out.println(sql);
				
			rs = stmt.executeQuery(sql);
			rs.next();
			System.out.println("select(cnp_id : " + rs.getInt(1));
			if(rs.getInt(1) > 0) { 
				result = 0;
			}else {
				sql = "insert into " + saveTable + " (" + cnp_id + ", pm_id) " +
					  " values('" + cnpid + "', '" + pmid + "')";
				result = stmt.executeUpdate(sql);
				System.out.println("after insert : " + result);
			}
			
			if (result >= 1 && wtype.equals("plsIn")) {
				sql = " insert into t_own_member_stat (os_save, osi_id ) values ( 1 , '" + cnpid + "' )";
				System.out.println("t_course_saved sql :" + sql);
				saved = stmt.executeUpdate(sql);
			}else if (result >= 1 && wtype.equals("cosIn")) {
				sql = " insert into t_admin_stat_course (ac_save, ci_id ) values ( 1 , '" + cnpid + "' )";
				System.out.println("t_course_saved sql :" + sql);
				saved = stmt.executeUpdate(sql);
			}

			
			System.out.println("saved inert result : " + result);
		} catch(Exception e) {
			System.out.println("SaveDao占쎄깻占쎌삋占쎈뮞占쎌벥 saveInsert()筌롫뗄苑뚳옙諭� 占쎌궎�몴占�");
			e.printStackTrace();
		} finally {
			close(rs);
			close(stmt);
		}
		
		return result;
	}
}
