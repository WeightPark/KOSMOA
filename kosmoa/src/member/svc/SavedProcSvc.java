package member.svc;

import static db.JdbcUtil.*;
import java.util.*;
import java.sql.*;
import member.dao.*;
import vo.*;

public class SavedProcSvc {
	public int saveProc(String wtype, String where, String cnpid, String pmid) {
		Connection conn = getConnection();
		SavedDao savedDao = SavedDao.getInstance();
		savedDao.setConnection(conn);
		int result = 0;
	
		if (wtype.equals("cosDel") || wtype.equals("plsDel")) {		// ���옣�맂 肄붿뒪�뿉�꽌 �듅�젙 �긽�뭹�쓣 �궘�젣 �븷 寃쎌슦
			result = savedDao.saveDelete(wtype, where);
			
		}else if (wtype.equals("plsIn") || wtype.equals("cosIn")) {	// �옣�냼 ���옣�떆 
			result = savedDao.saveInsert(wtype, cnpid, pmid);
		}

		if (result >= 1) {
			commit(conn);	// �벑濡�, �닔�젙, �궘�젣 �벑�쓽 �옉�뾽�씠 �씪�뼱�궃 �젅肄붾뱶媛� �븯�굹 �씠�긽�씠硫� 荑쇰━瑜� �쟻�슜�떆�궡
		}else {
			rollback(conn);	// �옉�뾽�씠 �씪�뼱�궃 �젅肄붾뱶媛� �뾾�쑝硫� 荑쇰━ �쟻�슜�쓣 痍⑥냼�븯怨�, 泥섏쓬�쑝濡� �릺�룎由�
		}
		close(conn);

		System.out.println("savedproc svc : " + result);
		return result;
	}

}
