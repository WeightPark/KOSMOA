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

public class MemberUpFormcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();	// 占쎄쉭占쎈�� 占쎄문占쎄쉐
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		if (memberInfo == null) {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('로그인 후 이용 가능합니다.');");
			out.println("location.href='login_form.jsp';");
			out.println("</script>");
		}
		
		ActionForward forward = new ActionForward();
		forward.setPath("/member/mypage_up_form.jsp");
		
		return forward;
	}

}
