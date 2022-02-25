package member.act;

import java.io.PrintWriter;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import act.*;
import vo.*;
import member.svc.MemberReserveListSvc;
import member.vo.*;
import reserve.vo.*;


public class MemberReserveListAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ReservedListInfo rList = new ReservedListInfo();
		HttpSession session = request.getSession();	// �꽭�뀡 �깮�꽦
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		if (memberInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('濡쒓렇�씤 �썑 �씠�슜�븯�꽭�슂');");
			out.println("location.href='loginForm.jsp?url=member/member_reserve_list.mem';");
			out.println("</script>");
		}
		
		String where = " pm_id = '" + memberInfo.getPm_id() + "' ";
		
		MemberReserveListSvc memberReserveListSvc = new MemberReserveListSvc();
		rList = memberReserveListSvc.getReserveList(where);
		
		request.setAttribute("rList", rList);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_reserved_list.jsp");
		
		return forward;
	}
}
