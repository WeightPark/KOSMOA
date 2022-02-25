package member.dao;

import static db.JdbcUtil.*;
import java.sql.*;
import javax.sql.*;
import java.util.*;
import vo.*;
import member.vo.*;

public class DupIdDao {
	private static DupIdDao dupIdDao;
	private Connection conn;
	
	private DupIdDao() {}	// �ܺο��� �Ժη� �ν��Ͻ��� �������� ���ϰ� private�� �����ڸ� ���� 
	
	public static DupIdDao getInstance() {	// �̱��� ������� �ν��Ͻ� ���� ����
		if (dupIdDao == null)	 dupIdDao = new DupIdDao();	// ������ �ν��Ͻ��� �����ϸ� ���Ӱ� ������ �ʰ�, ���� ��쿡�� ���� �����ϰ� �� 
		return dupIdDao;
	}
	
	public void setConnection(Connection conn) {
		this.conn = conn;
	}
	
	public int chkDupId(String uid) { // ȸ�� ���Խ� ����ڰ� ����� ���̵��� �ߺ� ���θ� ������ �޼��� 
		Statement stmt = null;	// �ڵ带 db�� �ű�� �޾ƿ� ��ü 
		ResultSet rs = null;	// select�� �޾ƿ� �ڵ带 ������ ��ü 
		int result = 0; // �ߺ��� ���̵� ������ ������ ����(�ߺ��Ǿ����� : 1 , �ȵǾ����� : 0) 
			try {
				stmt = conn.createStatement();
				String sql = "select count(*) from t_pri_member_info where pm_id = '"+ uid +"'";
System.out.println("���̵� �ߺ�üũ sql : " + sql);
				rs = stmt.executeQuery(sql); // stmt ��ü�� ������ sql ������ �����ؼ� �޾ƿ� ���� rs�� �־��ش�. 
				rs.next();
				result = rs.getInt(1);
				
			} catch (Exception e) {
				System.out.println("DupIdDao Ŭ������ chkDupId() �޼ҵ� ����");
				e.printStackTrace();
			} finally {
				close(rs);
				close(stmt);
			}
			return result;
		}
}
