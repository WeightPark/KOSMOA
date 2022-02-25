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


public class StatRevAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<ViewStatInfo> revStat = new ArrayList<ViewStatInfo>();
		
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String kind = "c";		// 기본은 코스 통계보기임
		if(!isEmpty(request.getParameter("kind")))	kind = request.getParameter("kind");
		System.out.println("kind : " + kind);
		
		String where = "";		// 날짜 조건을 담을 where
		if (kind.equals("c")) {	// 코스 통계 조회일경우
			where = " where a.ci_id = b.ci_id and left(ac_date,7) = '";
		}else {		// 장소 통계 조회일 경우
			where = " where a.osi_id = b.pi_id and left(os_date,7) = '";
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
		
		StatRevSvc statRevSvc = new StatRevSvc();
		revStat = statRevSvc.getRevStat(where, kind);
		
		request.setAttribute("revStat", revStat);		
		ActionForward forward = new ActionForward();  
		forward.setPath("/adminstat/stat_reserve_view.jsp?year="+year+"&month="+month+"&kind="+kind);
		
		return forward;
	}
	
	private boolean isEmpty(String str) {		// 문자열에 어떤 값이든 들어 있는지 여부를 검사하는 메소드 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
