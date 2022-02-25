package review.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import review.svc.*;
import review.vo.*;
import member.vo.*;

public class ReviewInProc implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		// �α��� ���θ� ��������. memberInfo session �̿� 
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		System.out.println("start of act proc");
		
		
		ReviewInFormInfo rivInfo = new ReviewInFormInfo();
		
		String chk = "";		// �ڽ����� ��������� ���� chk
		

		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		
		if (memberInfo == null) {				// �α��� ������ ��� 
			out.println("<script> alert('�α��� �� ����ϙJ��'); location.href='login_form.jsp?url=review_in_proc.riv'; </script>");
			out.close();
		}
		
		String miid = memberInfo.getPm_id();
		
		String kind, rrid, riv_title, riv_img1, riv_content, crid;
		// �ڽ�, ��ҿ���, �ڽ� ��� ��ȣ, ����, �̹���, ����, ���� ��ȣ
		int idx = 0;	// �۹�ȣ
		int result = 0;
		int score = 0;
		score = Integer.parseInt(request.getParameter("riv_score"));
		// ������ radio�� ������ �ԷµǾ� ����.
		kind = request.getParameter("kind");
		rrid = request.getParameter("rrid");		// ��� �� �ڽ� ��ȣ
		riv_title = request.getParameter("riv_title").trim().replace("'", "''");
		riv_img1 = request.getParameter("riv_img1");
		riv_content = request.getParameter("riv_content").trim().replace("'", "''");
		crid = request.getParameter("crid");
		
		System.out.println("rrid" + rrid );
		System.out.println("crid" + crid );
		
		rivInfo.setMiid(miid); 	rivInfo.setContent(riv_content);  rivInfo.setIdnum(rrid);// �ڽ� Ȥ�� ��� ���� ��ȣ
		rivInfo.setImg1(riv_img1);  rivInfo.setKind(kind);  	rivInfo.setRiv_title(riv_title);
		rivInfo.setScroe(score);	rivInfo.setCrid(crid);
 		
		ReviewProcSvc reviewProcSvc = new ReviewProcSvc();
		if (kind.equals("p")) {		// ��ҿ� ���� �ı��� ���
			idx = reviewProcSvc.getMaxNum(kind, rivInfo);		// �ִ� �� ��ȣ ������, insert �ϰ� , ��� ���� ����
			
		}else {						// �ڽ��� ���� �ı��� ��� 
			idx = reviewProcSvc.getMaxNum(kind, rivInfo);		// �ִ� �� ��ȣ ������, insert �ϰ�, �ڽ� ���� ���� 
		}
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath("/kosmoa/review_list.riv?kind="+kind);
		
		return forward;
	
	}

}
