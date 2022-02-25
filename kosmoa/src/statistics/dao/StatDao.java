package statistics.dao;

import static db.JdbcUtil.*;
import javax.sql.*;

import place.dao.PlaceDao;
import place.vo.PlaceInfo;

import java.sql.*;
import java.util.*;
import statistics.vo.*;


public class StatDao {
	private static StatDao statDao;
	private Connection conn;
	
	private StatDao() {}
	
	public static StatDao getInstance() {
		if (statDao == null)	statDao =  new StatDao();
		return statDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public ArrayList<SchStatInfo> getTagStat(String where){
		ArrayList<SchStatInfo> tagInfo = new ArrayList<SchStatInfo>();
		Statement stmt = null;		 
		ResultSet rs = null;	
		SchStatInfo sch =  null;
		int cnt = 0;
		try {
			String sql = "select a.st_id, count(*), b.st_name from t_sch_tag a , t_tag_info b " +
						where + " group by a.st_id order by count(*) desc  limit 0, 6 ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				sch = new SchStatInfo();
				sch.setSt_count(rs.getInt("count(*)"));
				cnt += rs.getInt("count(*)");	// �α������ 5���� ������ ��� ������
				sch.setSt_id(rs.getString("a.st_id"));
				sch.setSt_name(rs.getString("b.st_name"));
				
				tagInfo.add(sch);
			}
			SchStatInfo sch2 =  new SchStatInfo();
			sql = "select count(*)  from t_sch_tag a , t_tag_info b " + where;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			rs.next();	sch2.setCount_of_all(rs.getInt(1) - cnt);	// �� �������� �α� 5�� �� �� ������ ��Ÿ�� ������ ����
			tagInfo.add(sch2);
		}catch (Exception e) {
			System.out.println("StatDao Ŭ������ getTagStat() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return tagInfo;
		
	}
	
	public ArrayList<SchStatInfo> getKeyStat(String where){
		ArrayList<SchStatInfo> keyInfo = new ArrayList<SchStatInfo>();
		Statement stmt = null;		 
		ResultSet rs = null;	
		SchStatInfo sch = null;
		int cnt = 0;
		try {
			String sql = "select a.sk_id, count(*), b.sk_name from t_sch_keyword a, t_key_info b " +
						where + " group by a.sk_id order by count(*) desc limit 0, 6 ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				sch = new SchStatInfo();
				sch.setSt_count(rs.getInt("count(*)"));
				cnt += rs.getInt("count(*)");	
				sch.setSt_id(rs.getString("a.sk_id"));
				sch.setSt_name(rs.getString("b.sk_name"));
				
				keyInfo.add(sch);
			}
			SchStatInfo sch2 =  new SchStatInfo();
			sql = "select count(*)  from t_sch_keyword a, t_key_info b " + where;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			rs.next();	sch2.setCount_of_all(rs.getInt(1) - cnt);
			keyInfo.add(sch2);
			
		}catch (Exception e) {
			System.out.println("StatDao Ŭ������ getTagStat() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return keyInfo;
	}
	
	public ArrayList<ViewStatInfo>  getCouStat(String where){		// �ڽ� �˻� ����� ���
		ArrayList<ViewStatInfo>  revStat = new ArrayList<ViewStatInfo>();
		Statement stmt = null;		 
		ResultSet rs = null;	
		ViewStatInfo rev = null;
		int cnt = 0;
		try {
			String sql = " select a.ci_id, b.ci_name,  sum(ac_course_sch), sum(ac_course_reserv), sum(ac_save)  from t_admin_stat_course a, t_course_info b " +
						where + " group by a.ci_id order by sum(ac_course_sch) desc limit 0, 5 ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				rev = new ViewStatInfo();
				rev.setCi_id(rs.getString("a.ci_id"));
				rev.setCi_name(rs.getString("b.ci_name"));
				rev.setSum_sch(rs.getInt(3));
				rev.setSum_reserve(rs.getInt(4));
				rev.setSum_save(rs.getInt(5));
				
				revStat.add(rev);
			}
			/*
			SchStatInfo sch2 =  new SchStatInfo();
			sql = "select count(*)  from t_sch_keyword a, t_key_info b " + where;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			rs.next();	sch2.setCount_of_all(rs.getInt(1) - cnt);
			revStat.add(sch2);
			*/
		}catch (Exception e) {
			System.out.println("StatDao Ŭ������ getCouStat() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return revStat;
	}
	
	
	public ArrayList<ViewStatInfo>  getPlaStat(String where){		// ��� �˻� ���� ��� 
		ArrayList<ViewStatInfo>  revStat = new ArrayList<ViewStatInfo>();
		Statement stmt = null;		 
		ResultSet rs = null;	
		ViewStatInfo rev = null;
		int cnt = 0;
		try {
			String sql = " select  a.osi_id, b.pi_name, sum(os_view), sum(os_reserv), sum(os_save) from t_own_member_stat a, t_place_info b " +
						where + " group by b.pi_id order by sum(os_view) desc limit 0, 5 ";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			while(rs.next()) {
				rev = new ViewStatInfo();
				rev.setCi_id(rs.getString("a.osi_id"));
				rev.setCi_name(rs.getString("b.pi_name"));
				rev.setSum_sch(rs.getInt(3));
				rev.setSum_reserve(rs.getInt(4));
				rev.setSum_save(rs.getInt(5));
				
				revStat.add(rev);
			}
			/*
			SchStatInfo sch2 =  new SchStatInfo();
			sql = "select count(*)  from t_sch_keyword a, t_key_info b " + where;
			System.out.println(sql);
			rs = stmt.executeQuery(sql);
			rs.next();	sch2.setCount_of_all(rs.getInt(1) - cnt);
			revStat.add(sch2);
			*/
		}catch (Exception e) {
			System.out.println("StatDao Ŭ������ getPlaStat() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		
		return revStat;
	}
	
	public ArrayList<ViewStatInfo> getMainStat () {		// ���ο��� ������ �˻����� ����� �׷��� 
		ArrayList<ViewStatInfo> mainstat = new ArrayList<ViewStatInfo>();			// �˻� ���� �ڷ���� ���� �ν��Ͻ� 
		ViewStatInfo vsi = null;
		Statement stmt = null;		 
		ResultSet rs = null;	
		try {
			String sql = "select  sum(ac_course_sch), sum(ac_course_reserv), sum(ac_save), left(a.ac_date,7) from t_admin_stat_course a, t_course_info b " +
							"where a.ci_id = b.ci_id group by left(a.ac_date,7) order by sum(ac_course_sch);";
			System.out.println(sql);
			stmt = conn.createStatement();
			rs = stmt.executeQuery(sql);
			if (rs.next()) {
				do {
					vsi = new ViewStatInfo();
					vsi.setSum_sch(rs.getInt(1));
					vsi.setSum_reserve(rs.getInt(2));
					mainstat.add(vsi);
				}while(rs.next());
			}
			
			
		}catch (Exception e) {
			System.out.println("StatDao Ŭ������ getMainStat() �޼ҵ� ����");
			e.printStackTrace();
		}finally {
			close(rs);	close(stmt);
		}
		return mainstat;
	}

}
