package reserve.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import reserve.svc.*;
import reserve.vo.*;
import vo.*;
import act.*;
import member.*;
import place.vo.PlaceInfo;

public class ReservedProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String ci_id = request.getParameter("ci_id");
		String uid = request.getParameter("uid");
		String rtype = request.getParameter("rtype");
		String rdate = request.getParameter("rdate");
		String args = request.getParameter("args");
		System.out.println(rdate);
		String ci_name = "", pi_id = "";
		if (rtype.equals("c"))	ci_name = request.getParameter("ci_name");
		else					pi_id = request.getParameter("pi_id");
		String[] pi_name = request.getParameterValues("piname");
		String[] rtime = request.getParameterValues("rtime");
		String[] rperson = request.getParameterValues("rperson");
		
		
		String pr_rdate[] = new String[rtime.length];
		
		for (int i = 0 ; i < pr_rdate.length ; i++) {
			if (rtime[i] != null && !rtime[i].equals("") && rperson[i] != null && !rperson[i].equals("")) {
				pr_rdate[i] = rdate + " " + (rtime[i].length() == 4 ? rtime[i] + "0" : rtime[i]);
			} else {	
				pr_rdate[i] = "0";
			}
			System.out.println("order : " + i + " : "  + pr_rdate[i]);
		}
		
		int result = 0;
	
		String id = "";
		
		ReservedProcSvc reservedProcSvc = new ReservedProcSvc();
		
		if (rtype.equals("c"))	{
			id = ci_id;
			result = reservedProcSvc.reserveSet(rtype, id, ci_name, uid, pi_name, pr_rdate, rperson);
		} else {
			id = pi_id;
			result = reservedProcSvc.reserveSet(rtype, id, "", uid, pi_name, pr_rdate, rperson);
		}
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if (result < rtime.length) {
			out.println("<script>");
			out.println("alert('占쎌굙占쎈튋 占쎌삂占쎈씜占쎈뻻 �눧紐꾩젫揶쏉옙 獄쏆뮇源�占쎈뻥占쎈뮸占쎈빍占쎈뼄.');");
			out.println("history.back();");
			out.println("</script>");
		}
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		
		if (result == 1) {
			forward.setPath("/kosmoa/place_view.pla" + args + "&rSuccess=y&piid=" + pi_id);
		} else if (result > 1) {
			forward.setPath("/kosmoa/course_view.cou" + args + "&rSuccess=y&ciid="+ci_id);
		}
		return forward;
	}
}