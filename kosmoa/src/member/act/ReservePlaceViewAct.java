package member.act;

import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import act.Action;
import member.vo.*;
import member.svc.*;
import reserve.vo.PlaceReservedInfo;
import vo.ActionForward;

public class ReservePlaceViewAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String prid = request.getParameter("prid");
		String rdate = request.getParameter("rdate");
		HttpSession session = request.getSession();	// �꽭�뀡 �깮�꽦
		PlaceReservedInfo place = new PlaceReservedInfo();
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		if (memberInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('濡쒓렇�씤 �썑 �씠�슜�븯�꽭�슂');");
			out.println("location.href='login_form.jsp';");
			out.println("</script>");
		}
		
		MemberReserveListSvc memberReserveListSvc = new MemberReserveListSvc();
		place = memberReserveListSvc.getPlaceInfo(prid);
		
		request.setAttribute("place", place);
		request.setAttribute("rdate", rdate);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_reserved_place_view.jsp");
		
		return forward;
	}
}
