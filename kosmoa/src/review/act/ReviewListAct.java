package review.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import review.svc.*;
import review.vo.*;

public class ReviewListAct  implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<PlaceReviewInfo> pReview = new ArrayList<PlaceReviewInfo> ();
		ArrayList<CourseReviewInfo> cReview = new ArrayList<CourseReviewInfo> ();
		PreviewPageInfo placeReview = new PreviewPageInfo();
		
		int cpage = 1, psize = 3, bsize = 10, spage, epage, rcnt, pcnt;
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		String keyword ="", kind ="", piid ="", ciid ="";
		String pWhere = "", cWhere="";	// �˻� ������ ���� where��, ���� ��ҿ� �ڽ��� where���� 
		kind = "p"; 

		if(!isEmpty(request.getParameter("keyword")))  keyword = request.getParameter("keyword");	// �˻� Ű���带 �޾ƿ�
		else		keyword = "";
		if(!isEmpty(request.getParameter("kind")))  kind = request.getParameter("kind");	// �ڽ����� ������� �޾ƿ�
		if(!isEmpty(request.getParameter("piid")))  kind = request.getParameter("piid");	// ��� ���̵�
		else 		piid = "";
		if(!isEmpty(request.getParameter("ciid")))  kind = request.getParameter("ciid");	// �ڽ� ���̵�
		else		ciid = "";
		
		pWhere = " where prl_isview = 'y' ";
		cWhere = " where crl_isview = 'y' ";
		
		
		HttpSession session = request.getSession();		// ���� ���� out��ü �̿��ϱ� ���� 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		
		
		String type="";
		if (request.getParameter("type") != null && !request.getParameter("type").equals(""))
			type = request.getParameter("type");
		int result = 0;		// ���� ���θ� ������
		int rvid = 0;		//  �ش� �ı��� �� ��ȣ
		if (request.getParameter("rvid") != null && !request.getParameter("rvid").equals(""))
			rvid = Integer.parseInt(request.getParameter("rvid"));
		ReviewListSvc reviewListSvc = new ReviewListSvc();
		if (type.equals("like")) {
			System.out.println("�ı� ajax");
			result = reviewListSvc.doLike(rvid, kind);
			out.println(result);
			out.close();
		}
			
		
		if (kind.equals("p")) {		// ��� ���亸�� �ΰ��
			if (!isEmpty(piid)) 	pWhere += " and pi_id = '" + piid + "' ";
			//  ��� �󼼺��⿡�� �Ѿ�� ���
			if (!isEmpty(keyword)) pWhere += " and prl_title like '%" + keyword + "%' or prl_content like '%" + keyword + "%' ";
			// �˻�� ������ ���
			rcnt = reviewListSvc.getPreviewCnt(pWhere);		// ��� ���� ���� ��ü ����
			pReview = reviewListSvc.getPlaceReviewList(pWhere, cpage, psize);	// ��� ���� ���� �޾ƿ�
			pcnt = rcnt / psize;
			if (rcnt % psize > 0 )	pcnt++;		// ��ü ������ ����
			spage = (cpage-1) / bsize * bsize + 1;	// ����� ���� ������ ��ȣ
			epage = spage + bsize - 1;
			if (epage > pcnt)	epage = pcnt;		// ����� ���� ������ ��ȣ
			
			placeReview.setCpage(cpage); 	placeReview.setBsize(bsize); 	placeReview.setEpage(epage);
			placeReview.setKeyword(keyword); placeReview.setKind(kind); 	placeReview.setPiid(piid);
			placeReview.setPcnt(pcnt); 	placeReview.setPsize(psize);  		placeReview.setRcnt(rcnt);
			placeReview.setSpage(spage);
			
			request.setAttribute("pReview", pReview);
			request.setAttribute("cReview", cReview);
			
		}else {	// �ڽ� ���亸�� �� ���
			if (!isEmpty(ciid)) 	cWhere += " and ci_id = '" + ciid + "' ";
			//  ��� �󼼺��⿡�� �Ѿ�� ���
			if (!isEmpty(keyword)) cWhere += " and crl_title like '%" + keyword + "%' or crl_content like '%" + keyword + "%' ";
			// �˻�� ������ ���
			rcnt =  reviewListSvc.getCreviewCnt(cWhere);	// �ڽ� ���� ���� ��ü ���� 
			cReview = reviewListSvc.getCourseReviewList(cWhere, cpage, psize);	// �ڽ� ���� �� �޾ƿ�
			pcnt = rcnt / psize;
			if (rcnt % psize > 0 )	pcnt++;		// ��ü ������ ����
			spage = (cpage-1) / bsize * bsize + 1;	// ����� ���� ������ ��ȣ
			epage = spage + bsize - 1;
			if (epage > pcnt)	epage = pcnt;		// ����� ���� ������ ��ȣ
			
			placeReview.setCpage(cpage); 	placeReview.setBsize(bsize); 	placeReview.setEpage(epage);
			placeReview.setKeyword(keyword); placeReview.setKind(kind); 	placeReview.setCiid(ciid);
			placeReview.setPcnt(pcnt); 	placeReview.setPsize(psize);  		placeReview.setRcnt(rcnt);
			placeReview.setSpage(spage);
			
			request.setAttribute("cReview", cReview);
			request.setAttribute("pReview", pReview);
			
		}	
		
		request.setAttribute("placeReview", placeReview);
		
		
		ActionForward forward = new ActionForward();  
		forward.setPath("/review/review_list.jsp");
		
		return forward;
	}
	
	private boolean isEmpty(String str) {		// ���ڿ��� � ���̵� ��� �ִ��� ���θ� �˻��ϴ� �޼ҵ� 
		boolean empty = true;
		if (str != null && !str.equals(""))	empty = false;
		return empty;
	}

}
