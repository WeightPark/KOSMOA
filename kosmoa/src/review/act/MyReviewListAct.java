package review.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import review.svc.*;
import review.vo.*;
import member.vo.*;

public class MyReviewListAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		int result = 0;		// ajax ������ �޾ư� ��

		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		
		if (memberInfo == null) {				// �α��� ������ ��� 
			out.println("<script> alert('�α��� �� ����ϙJ��'); location.href='login_form.jsp?url=my_review_list.riv'; </script>");
			out.close();
		}
		String pmid = memberInfo.getPm_id();

		PreviewPageInfo placeReview = new PreviewPageInfo();
		
		int cpage = 1, psize = 3, bsize = 10, spage, epage, rcnt, pcnt;
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		
		ArrayList<PlaceReviewInfo> myReview = new ArrayList<PlaceReviewInfo> ();		// �ڽ� ���� �Ѵ� ���� ����
		String kind = "p";		// �⺻���� �����
		String wtype = "v";
		String idx = "0";		// ������ �۹�ȣ�� �⺻���� ���ڿ� 0, �⺻���̸� �Ⱦ���
		String idxs = request.getParameter("idx");

		if(!isEmpty(request.getParameter("kind")))  kind = request.getParameter("kind");	// �ڽ����� ������� �޾ƿ�
		if(!isEmpty(request.getParameter("wtype")))  wtype = request.getParameter("wtype");	// �����ϰ�� d
		System.out.println("idxs : " + idxs + ", wtype : " + wtype + ", kind : " + kind);
		String where = " where pm_id = '" + pmid +"' ";
		
		if(wtype.equals("d")) {
			String[] arrIdx = idxs.split(",");
			String tmpStr = "";
			for (int i=0; i< arrIdx.length; i++) {
				if(kind.equals("p")) {			// ��� ���� �� ���
					tmpStr += " or prl_idx = " + arrIdx[i];
				}else {							// �ڽ� ���� �� ���
					tmpStr += " or crl_idx = " + arrIdx[i];
				}
				
			}
			where += " and (" + tmpStr.substring(4) + ") ";
		}
		System.out.println(" del where : " + where);
		
		MyReviewListSvc myReviewListSvc = new MyReviewListSvc();
		if (wtype.equals("d"))	{
			result = myReviewListSvc.delReview(kind, where);
			out.println(result);
		}
		// �����϶��� ������ �����Ŵ
		
		
		rcnt = myReviewListSvc.getRcnt(kind, where);
		myReview = myReviewListSvc.getMyReviewListAct(kind, pmid, cpage, psize);		
		// ȸ�����̵�� �ڽ�, ��������� �����ϴ� kind�� ���ؼ� �ۼ��� ������� ����� ������ 
		
		
		pcnt = rcnt / psize;
		if (rcnt % psize > 0 )	pcnt++;		// ��ü ������ ����
		spage = (cpage-1) / bsize * bsize + 1;	// ����� ���� ������ ��ȣ
		epage = spage + bsize - 1;
		if (epage > pcnt)	epage = pcnt;		// ����� ���� ������ ��ȣ
		
		placeReview.setCpage(cpage); 	placeReview.setBsize(bsize); 	placeReview.setEpage(epage);
		placeReview.setKind(kind); 		placeReview.setPcnt(pcnt); 		placeReview.setPsize(psize);  		
		placeReview.setRcnt(rcnt);		placeReview.setSpage(spage);
		
		request.setAttribute("placeReview", placeReview);	// �ı� ����¡ ���� 
		request.setAttribute("myReview", myReview);		// �ش��ϴ� �ı� �� ����Ʈ
		ActionForward forward = new ActionForward();  
		forward.setPath("/review/my_review_list.jsp");
		
		return forward;
	}
	
	private boolean isEmpty(String str) {		// ���ڿ��� � ���̵� ��� �ִ��� ���θ� �˻��ϴ� �޼ҵ� 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
