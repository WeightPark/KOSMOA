package review.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import review.dao.*;
import review.vo.*;

public class ReviewProcSvc {
	public int getMaxNum(String kind, ReviewInFormInfo rivInfo) {
		int result = 0;
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		reviewDao.setConnection(conn);
		
		if (kind.equals("p"))	result = reviewDao.getPmaxNum(rivInfo);		// ����� ��� ��� �ı�� �� �ִ� �۹�ȣ��
		else					result = reviewDao.getCmaxNum(rivInfo);		// �ڽ��� ��� �ڽ� �ı�� �� �ִ� �� ��ȣ��
		
		if(result >= 1)	commit(conn);
		else			rollback(conn);
		
		close(conn);
		
		return result;
	}
}
