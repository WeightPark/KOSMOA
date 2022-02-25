package reserve.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import reserve.svc.*;
import reserve.vo.*;
import act.*;
import vo.*;

public class ReservedCancelProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String rtype = request.getParameter("rtype");
		String rid = request.getParameter("rid");
		
		ReservedCancelProcSvc reservedCancelProcSvc = new ReservedCancelProcSvc();
		int result = reservedCancelProcSvc.reservedCancel(rtype, rid);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		if (result == 0) {
			out.println("<script>");
			out.println("alert('예약취소 작업시 문제가 발생했습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
		out.close();
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("");
		
		return forward;
	}
}
