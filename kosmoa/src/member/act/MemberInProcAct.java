package member.act;

import java.io.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import act.*;
import vo.*;
import member.vo.*;
import member.svc.*;

public class MemberInProcAct  implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		PriMemberInfo priMemberInfo = new PriMemberInfo(); 	// 媛쒖씤 �쉶�썝�쓽 �뜲�씠�꽣�뱾�쓣 ���옣�븷 �씤�뒪�꽩�뒪
		
		priMemberInfo.setPm_id(request.getParameter("pm_id").trim().toLowerCase());
		priMemberInfo.setPm_pwd(request.getParameter("pm_pwd").trim());
		priMemberInfo.setPm_name(request.getParameter("pm_name").trim());
		priMemberInfo.setPm_nikname(request.getParameter("pm_nikname").trim());
		priMemberInfo.setPm_mail(request.getParameter("e1").trim() + "@" + request.getParameter("e3").trim());
		priMemberInfo.setPm_phone(request.getParameter("p1") + "-" + request.getParameter("p2").trim() + "-" + request.getParameter("p3").trim());
		priMemberInfo.setPm_isad(request.getParameter("pm_isad"));
		priMemberInfo.setPm_isact("y");
		priMemberInfo.setAi_idx(0);
			
		MemberInProcSvc memberInProcSvc = new MemberInProcSvc(); 
		int result = memberInProcSvc.memberInsert(priMemberInfo);
		// 媛쒖씤�씤吏� 湲곗뾽�씤吏� 援щ텇�븯�뒗 mtype怨� �궗�슜�옄媛� �엯�젰�븳 媛쒖씤�젙蹂�, 湲곗뾽�젙蹂대�� 媛��졇媛꾨떎.    
		
		
		String lnk = "main";
		
		if (result == 1) { //�젙�긽�쟻�쑝濡� �룞�옉�릺�뿀�쑝硫�
			lnk="loginForm.head";
		}else { 
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�옉�뾽�뿉 �떎�뙣�뻽�뒿�땲�떎. �떎�떆 �떆�룄�빐 蹂댁떗�떆�삤.');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		ActionForward forward = new ActionForward(); 
		forward.setRedirect(true); // url�씠 蹂댁씠硫� �븞�릺湲� �븣臾몄뿉 Redirect 諛⑹떇�쑝濡� 蹂대궡�빞�븳�떎. 
		forward.setPath(lnk);	 
		return forward;
	}
}