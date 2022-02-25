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
		ReviewDao reviewDao = ReviewDao.getInstance();	// 싱글톤 방식으로 인스턴스 생성 
		reviewDao.setConnection(conn);
		
		if (kind.equals("p"))	result = reviewDao.getPmaxNum(rivInfo);		// 장소일 경우 장소 후기글 중 최댓 글번호값
		else					result = reviewDao.getCmaxNum(rivInfo);		// 코스일 경우 코스 후기글 중 최댓 글 번호값
		
		if(result >= 1)	commit(conn);
		else			rollback(conn);
		
		close(conn);
		
		return result;
	}
}
