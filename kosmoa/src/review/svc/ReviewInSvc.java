package review.svc;

import static db.JdbcUtil.*;	
import java.util.*;
import java.sql.*;
import review.dao.*;
import review.vo.*;

public class ReviewInSvc {
	public ReviewInFormInfo getInfo(String chk, String crid) {
		ReviewInFormInfo rinfo = new ReviewInFormInfo();
		Connection conn = getConnection();
		ReviewDao reviewDao = ReviewDao.getInstance();	// �̱��� ������� �ν��Ͻ� ���� 
		reviewDao.setConnection(conn);
		
		if (chk.equals("p")) {
			rinfo = reviewDao.getPreserved(crid);
		}else {
			rinfo = reviewDao.getCreserved(crid);
		}
		
		close(conn);
		return rinfo;
	}

}
