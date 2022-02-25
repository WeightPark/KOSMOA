package reserve.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;
import act.*;
import member.*;
import place.vo.PlaceInfo;
import reserve.vo.*;

public class ReservedDao {
	private static ReservedDao reservedDao;
	private Connection conn;
	
	private ReservedDao() {}
	
	public static ReservedDao getInstance() {
		if (reservedDao == null)	 reservedDao = new ReservedDao();
		return reservedDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<PlaceInfo> getPlaceList(String ciid) {
	// 占쎌굙占쎈튋占쎌넅筌롫똻�뱽 �겫�뜄�쑎占쎌궎占쎈뮉 筌롫뗄�꺖占쎈굡 
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		PlaceInfo place = null;
		
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_course_info a, t_course_place b, t_place_info c "
					+ "where a.ci_id = b.ci_id and b.pi_id = c.pi_id and a.ci_id = '" + ciid + "'"
					+ " and ci_isview = 'y' and c.pi_isop = 'a' order by b.cp_order";
			rs = stmt.executeQuery(sql);
			System.out.println("getplaceList sql : " + sql);
			while (rs.next()) { 
				place = new PlaceInfo();
				// ArrayList占쎌뵥 placeList占쎈퓠 占쏙옙占쎌삢占쎈릭疫뀐옙 占쎌맄占쎈퉸 PlaceInfo占쎌굨 占쎌뵥占쎈뮞占쎄쉘占쎈뮞 占쎄문占쎄쉐
				
				place.setCi_id(rs.getString("ci_id"));			place.setCi_name(rs.getString("ci_name"));
				place.setPi_name(rs.getString("pi_name"));		place.setCp_stime(rs.getString("cp_stime"));
				place.setCp_etime(rs.getString("cp_etime"));	place.setPi_person(rs.getInt("pi_person"));
				place.setPi_isr(rs.getString("pi_isr"));		place.setCp_order(rs.getInt("cp_order"));
				place.setPi_id(rs.getString("pi_id"));

				placeList.add(place);
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getPlaceList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return placeList;
	}
	
	public PlaceInfo getPlaceInfo(String piid) {
		Statement stmt = null;
		ResultSet rs = null;
		PlaceInfo placeInfo = new PlaceInfo();
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_place_info where pi_id = '" + piid + "'";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			System.out.println("rs : " + rs);
			rs.next();
			
			placeInfo.setPi_id(piid);		placeInfo.setPi_name(rs.getString("pi_name"));
			placeInfo.setPi_person(rs.getInt("pi_person"));
			placeInfo.setPi_time(rs.getString("pi_time"));
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getPlaceInfo() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return placeInfo;
	}
		
	public ArrayList<CourseReservedInfo> getCourseReserveList(String where) {
	// 占쎌돳占쎌뜚癰귨옙 占쎌굙占쎈튋 �뵳�딅뮞占쎈뱜�몴占� �겫�뜄�쑎占쎌궎占쎈뮉 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		ResultSet rs = null;
		ReservedListInfo rList = new ReservedListInfo();
		CourseReservedInfo course = null;
		ArrayList<CourseReservedInfo> courseList = new ArrayList<CourseReservedInfo>();
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_course_reserve where " + where;
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				course = new CourseReservedInfo();
				
				course.setCr_id(rs.getString("cr_id"));
				course.setCi_name(rs.getString("ci_name"));
				course.setCr_rdate(rs.getString("cr_rdate"));
				course.setCr_date(rs.getString("cr_date"));
				
				courseList.add(course);
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getCourseReserveList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);		close(stmt);
		}
		
		return courseList;
	}
	
	public ArrayList<PlaceReservedInfo> getPlaceReserveList(String where) {
		Statement stmt = null;
		ResultSet rs = null;
		ReservedListInfo rList = new ReservedListInfo();
		PlaceReservedInfo place = null;
		ArrayList<PlaceReservedInfo> placeList = new ArrayList<PlaceReservedInfo>();

		try {
			stmt = conn.createStatement();
			String sql = "select * from t_place_reserve where " + where +  " and pr_id like 'pr%'";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				place = new PlaceReservedInfo();
				
				place.setPr_id(rs.getString("pr_id"));
				place.setPi_name(rs.getString("pi_name"));
				place.setPr_rdate(rs.getString("pr_rdate"));
				place.setPr_date(rs.getString("pr_date"));
				
				placeList.add(place);
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getPlaceReserveList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);		close(stmt);
		}
		
		return placeList;
	}
	
	public ArrayList<PlaceReservedInfo> getReservePlaceList(String crid) {
		Statement stmt = null;
		ResultSet rs = null;
		String rid = crid.substring(7);
		ArrayList<PlaceReservedInfo> reserveList = new ArrayList<PlaceReservedInfo>();
		PlaceReservedInfo place = null;
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_place_reserve where  pr_id like '%" + rid + "'";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			while (rs.next()) {
				place = new PlaceReservedInfo();
				
				place.setPi_name(rs.getString("pi_name"));
				place.setPr_rdate(rs.getString("pr_rdate"));
				place.setPr_person(rs.getInt("pr_person"));
				
				reserveList.add(place);
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getReserveList() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return reserveList;
	}
	
	public PlaceReservedInfo getReservePlaceInfo (String prid) {
		Statement stmt = null;
		ResultSet rs = null;
		String rid = prid.substring(7);
		PlaceReservedInfo reserveInfo = new PlaceReservedInfo();
		
		try {
			stmt = conn.createStatement();
			String sql = "select * from t_place_reserve where pr_id like 'pr%' and pr_id like '%" + rid + "'";
			System.out.println(sql);
			
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				reserveInfo.setPr_id(prid);
				reserveInfo.setPi_name(rs.getString("pi_name"));
				reserveInfo.setPr_rdate(rs.getString("pr_rdate"));
				reserveInfo.setPr_person(rs.getInt("pr_person"));
				reserveInfo.setPr_date(rs.getString("pr_date"));
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 getReservePlaceInfo() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs);	close(stmt);
		}
		
		return reserveInfo;
	}
	
	public int reserveSet(String rtype, String ciid, String ciname, String uid, String[] pi_name, String[] prrdate, String[] rperson) {
		Statement stmt = null;
		ResultSet rs = null;
		int result = 0;
		int saved = 0; // 통계들어갔나 확인용입니다
		
		try {
			stmt = conn.createStatement();
			
			String sql = "select * from t_course_place where ci_id = '" + ciid + "'";
			rs = stmt.executeQuery(sql);
			
			if (rs.next()) {
				do {
					result += reservePlace(rtype, rs.getString("pi_id"), uid, pi_name[result], prrdate[result], rperson[result]);

					System.out.println("result : " + result);
				} while(rs.next());
				
				
				System.out.println(prrdate.length);
				System.out.println(result);
				if (result == prrdate.length) {	// 占쎌삢占쎈꺖 占쎌굙占쎈튋占쎈퓠 筌뤴뫀紐� 占쎄쉐�⑤벏六쏙옙�몵筌롳옙 �굜遺용뮞占쎌굙占쎈튋(占쎈뼄占쎈솭占쎈뻻 占쎌삢占쎈꺖 占쎌굙占쎈튋 筌뤴뫀紐� 占쎄텣占쎌젫)
					sql = "insert into t_course_reserve (cr_id, ci_id, ci_name, pm_id, cr_rdate, cr_person) "
							+ "values ('c" + ciid + prrdate[0].substring(5, 10) + uid.substring(0, 3) + "', '" 
							+ ciid + "', '"+ ciname + "', '" + uid + "', '" + prrdate[0].substring(0, 10) + "', " + Integer.parseInt(rperson[0]) + ")";
					
					result = stmt.executeUpdate(sql) + 1;
				} else {
				// 占쎌굙占쎈튋 �뿆�뫁�꺖(占쎄텣占쎌젫)筌롫뗄�꺖占쎈굡 占쎌깈�빊占�
				}
			}
			
			if (result >= 1) {	// 예약이 된 상태라면
				sql = " insert into t_admin_stat_course (ci_id, ac_course_reserv) values ('" + ciid + "' ,  1)";
System.out.println("코스 예약 통계 : " + sql);
				saved = stmt.executeUpdate(sql);
			}
			
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 reserveSet() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(rs); 	close(stmt);
		}
		
		return result;
	}
	
	public int reservePlace(String rtype, String pi_id, String uid, String pi_name, String rdate, String rperson) {
	// 占쎌삢占쎈꺖 占쎌굙占쎈튋 筌롫뗄�꺖占쎈굡
		Statement stmt = null;
		int result = 0;	
		int saved = 0; // 통계들어갔나 확인용입니다
		
		try {
			stmt = conn.createStatement();
			if (rdate.equals("0")) {	// 占쎈퉸占쎈뼣 占쎌삢占쎈꺖揶쏉옙 占쎌굙占쎈튋 疫꿸퀡�뮟占쎌뱽 筌욑옙占쎌뜚占쎈릭筌욑옙 占쎈륫占쎈뮉 �⑤끃�뵠占쎌뵬筌롳옙
				result = 1;				// DB占쎈퓠 癰귣�沅∽옙�뮉 揶쏉옙 占쎈씨占쎌뵠 result占쎌벥 揶쏅�れ뱽 1嚥∽옙 占쎄퐨占쎈섧
			} else {
				String sql = ""; 
				
				if (rtype.equals("c")) {
				sql = "insert into t_place_reserve (pr_id, pi_id, pi_name, pm_id, pr_rdate, pr_person) "
						+ "values ('c" + pi_id + rdate.substring(5, 10) + uid.substring(0, 3) + "', '" 
						+ pi_id + "', '" + pi_name + "', '" + uid + "', '" + rdate + "', " + Integer.parseInt(rperson) + ")";
				} else {
					sql = "insert into t_place_reserve (pr_id, pi_id, pi_name, pm_id, pr_rdate, pr_person) "
							+ "values ('p" + pi_id + rdate.substring(5, 10) + uid.substring(0, 3) + "', '" 
							+ pi_id + "', '" + pi_name + "', '" + uid + "', '" + rdate + "', " + Integer.parseInt(rperson) + ")";	
				}
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
				if (result >= 1) {
					sql = " insert into t_own_member_stat (os_reserv, osi_id) values (1 ,'" + pi_id + "' )";
System.out.println("장소 저장 통계 sql : " + sql);
					saved = stmt.executeUpdate(sql);
				}
			}
		} catch(Exception e) {
			System.out.println("ReservedDao 占쎄깻占쎌삋占쎈뮞占쎌벥 reservePlace() 筌롫뗄�꺖占쎈굡 占쎌궎�몴占�");
			e.printStackTrace();	
		} finally {
			close(stmt);
		}
		
		return result;
	}
	
	public int reservedCancel(String rtype, String rid) {
	// 예약 취소 메소드
			Statement stmt = null;
			int result = 0;		
			String sql = ""; 
			
			try {
				stmt = conn.createStatement();
				if (rtype.equals("c")) {	
					sql = "delete from t_course_reserve where cr_id = '" + rid + "'";		
				} else {
					sql = "delete from t_place_reserve where pr_id = '" + rid + "'";		
				}
				System.out.println(sql);
				result = stmt.executeUpdate(sql);
			} catch(Exception e) {
				System.out.println("ReservedDao 클래스의 reservedCancel() 메소드 오류.");
				e.printStackTrace();	
			} finally {
				close(stmt);
			}
			
			return result;
		}
}
