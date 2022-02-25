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

public class StatMainAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		StatMainSvc statMainSvc = new StatMainSvc();
		ArrayList<ViewStatInfo> mainstat = statMainSvc.getMainStat();		
		
		request.setAttribute("mainstat", mainstat);
		ActionForward forward = new ActionForward();  
		forward.setPath("/admin/admin_index.jsp");
		
		return forward;
	}

}
