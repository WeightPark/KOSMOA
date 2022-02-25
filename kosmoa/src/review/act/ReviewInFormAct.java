package review.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import review.svc.*;
import review.vo.*;
import member.vo.*;

public class ReviewInFormAct  implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		String chk = "";		// �ڽ����� ��������� ���� chk
		
		
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		
		if (memberInfo == null) {				// �α��� ������ ��� 
			out.println("<script> alert('�α��� �� ����ϙJ��'); location.href='login_form.jsp?url=review_in_form.riv'; </script>");
			out.close();
		}
		String pmid = memberInfo.getPm_id();
		
		String crid = request.getParameter("crid");
		
		if(crid == null || crid.equals("")) {	// ���� ��ȣ�� ������� ��� 
			out.println("<script> alert('�߸��� ����Դϴ�'); location.href='login_form.jsp'; </script>");
			out.close();
		}
		
		chk = crid.substring(0,1);		// �Ǿ� ���ڸ� �̾ƿ�
		
		ReviewInFormInfo rinfo = new ReviewInFormInfo();		// �����ۼ��� ������ �������� ��� �ν��Ͻ�
		ReviewInSvc reviewInSvc = new ReviewInSvc();
		
		if (chk.equals("p")) {		// ��� ������ ���
			rinfo = reviewInSvc.getInfo(chk, crid);
		}
		else if (chk.equals("c")) {	// �ڽ� ������ ���
			rinfo = reviewInSvc.getInfo(chk, crid);
		}
		
		request.setAttribute("rinfo", rinfo);
		ActionForward forward = new ActionForward();  
		forward.setPath("/review/review_form.jsp");
		
		return forward;
	}
}
