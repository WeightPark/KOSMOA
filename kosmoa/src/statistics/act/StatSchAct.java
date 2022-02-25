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
		ArrayList<SchStatInfo> schStat = new ArrayList<SchStatInfo>();		// 통계 결과들을 담아갈 인스턴스 
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		// 태그인지 키워드인지를 구분함
		String kind = "t";
		if(!isEmpty(request.getParameter("kind")))	kind = request.getParameter("kind");
		System.out.println("kind : " + kind);
		
		String where = "";		// 날짜 조건을 담을 where
		if (kind.equals("t")) {	// 태그 조회일경우
			where = " where a.st_id = b.st_id and left(st_date,7) = '";
		}else {		// 키워드 조회일 경우
			where = " where a.sk_id = b.sk_id and left(sk_date,7) = '";
		}
		
		Calendar today = Calendar.getInstance();
		int cYear, cMonth;
		String year, month;
		
		String stime = "";
		if(!isEmpty(request.getParameter("stime")))	{	// '2021-11' 식으로 값이 있는 경우
			stime = request.getParameter("stime");
			year = stime.substring(0, stime.indexOf('-'));
			month = stime.substring(stime.indexOf('-')+1);
		}
		else {		// 값이 없는 경우
			cYear = today.get(Calendar.YEAR);			// 올해 연도
			year = cYear + "";							// 현재 연도와 월을 문자열로 만들어줌.
			cMonth = today.get(Calendar.MONTH) + 1;		// 현재 월
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
	
	private boolean isEmpty(String str) {		// 문자열에 어떤 값이든 들어 있는지 여부를 검사하는 메소드 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
