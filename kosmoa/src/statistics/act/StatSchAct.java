package statistics.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import act.Action;
import vo.ActionForward;
import statistics.vo.*;
import statistics.svc.*;

import java.io.PrintWriter;
import java.util.*;

public class StatSchAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<SchStatInfo> schStat = new ArrayList<SchStatInfo>();		// ��� ������� ��ư� �ν��Ͻ� 
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		// �±����� Ű���������� ������
		String kind = "t";
		if(!isEmpty(request.getParameter("kind")))	kind = request.getParameter("kind");
		System.out.println("kind : " + kind);
		
		String where = "";		// ��¥ ������ ���� where
		if (kind.equals("t")) {	// �±� ��ȸ�ϰ��
			where = " where a.st_id = b.st_id and left(st_date,7) = '";
		}else {		// Ű���� ��ȸ�� ���
			where = " where a.sk_id = b.sk_id and left(sk_date,7) = '";
		}
		
		Calendar today = Calendar.getInstance();
		int cYear, cMonth;
		String year, month;
		
		String stime = "";
		if(!isEmpty(request.getParameter("stime")))	{	// '2021-11' ������ ���� �ִ� ���
			stime = request.getParameter("stime");
			year = stime.substring(0, stime.indexOf('-'));
			month = stime.substring(stime.indexOf('-')+1);
		}
		else {		// ���� ���� ���
			cYear = today.get(Calendar.YEAR);			// ���� ����
			year = cYear + "";							// ���� ������ ���� ���ڿ��� �������.
			cMonth = today.get(Calendar.MONTH) + 1;		// ���� ��
			if (cMonth < 10)	month = "0" + cMonth + "";
			else				month = cMonth + "";
			
			stime = year + "-"+ month;
		}
		System.out.println("stime : " + stime);
		where += stime + "' ";
		System.out.println("where : " + where);
		
		StatSchSvc statSchSvc = new StatSchSvc();
		schStat = statSchSvc.getSchStat(where, kind);
		
		request.setAttribute("schStat", schStat);
		ActionForward forward = new ActionForward();  
		forward.setPath("/adminstat/stat_view.jsp?year="+year+"&month="+month+"&kind="+kind);
		
		return forward;
		
		
	}
	
	private boolean isEmpty(String str) {		// ���ڿ��� � ���̵� ��� �ִ��� ���θ� �˻��ϴ� �޼ҵ� 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
