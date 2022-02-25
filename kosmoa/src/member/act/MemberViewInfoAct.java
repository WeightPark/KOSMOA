package member.act;

import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import member.svc.*;
import member.vo.*;
import place.vo.*;
import course.vo.*;
import vo.*;
import act.*;

public class MemberViewInfoAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();	// �꽭�뀡 �깮�꽦
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		if (memberInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용하세요');");
			out.println("location.href='login_form.jsp';");
			out.println("</script>");
		}
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/view_my_info.jsp");
		
		return forward;
	}

}
