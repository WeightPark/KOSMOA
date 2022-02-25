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

public class ReserveViewAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String crid = request.getParameter("crid");
		String ciname = request.getParameter("ciname");
		String rdate = request.getParameter("rdate");
		HttpSession session = request.getSession();	// �꽭�뀡 �깮�꽦
		ArrayList<PlaceReservedInfo> placeList = new ArrayList<PlaceReservedInfo>();
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		

		System.out.println("test1");
		System.out.println(crid + ", " + ciname + ", " + rdate);
		
		if (memberInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('濡쒓렇�씤 �썑 �씠�슜�븯�꽭�슂');");
			out.println("location.href='login_form.jsp';");
			out.println("</script>");
		}
		
		MemberReserveListSvc memberReserveListSvc = new MemberReserveListSvc();
		placeList = memberReserveListSvc.getPlaceList(crid);
		
		request.setAttribute("placeList", placeList);
		request.setAttribute("crid", crid);
		request.setAttribute("ciname", ciname);
		request.setAttribute("rdate", rdate);
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/member_reserved_view.jsp");
		
		return forward;
	}
}
