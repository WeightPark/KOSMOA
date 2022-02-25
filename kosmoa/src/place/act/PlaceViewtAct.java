package place.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import place.svc.*;
import place.vo.*;
import review.vo.PlaceReviewInfo;
import vo.*;
import act.*;

public class PlaceViewtAct  implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<PlaceReviewInfo> pReview = new ArrayList<PlaceReviewInfo> ();		// �ش� ��ҿ� ���� ���並 ������ ��̸���Ʈ 
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		// int	psize = Integer.parseInt(request.getParameter("psize"));
		int result = 0;
		int saved = 0;
		String piid = request.getParameter("piid");			// ��� ��ȣ
		String pmid = request.getParameter("pmid");			// ����ȸ�� ��ȣ 
		
		String keyword = request.getParameter("keyword");		if (keyword == null)	keyword = "";
		String bcata = request.getParameter("bcata");			if (bcata == null)	bcata = "";
		String scata = request.getParameter("scata");			if (scata == null)	scata = "";
		String tag = request.getParameter("tag");				if (tag == null)	tag = "";
		String key = request.getParameter("key");				if (key == null)	key = "";
		String area = request.getParameter("area");				if (area == null)	area = "";
		String sort = request.getParameter("sort");				if (sort == null)	sort="idd";	 
	
		PlaceViewSvc placeViewSvc = new PlaceViewSvc();
		PlaceInfo placeInfo = placeViewSvc.getplaInfo(piid);		// ��� ��ȣ�� �ش��ϴ� ���� �ν��Ͻ��� ���� �Ŀ� , ����ġ ������� request�� ��Ƽ� ����
		result = placeViewSvc.insertPlaceStat(piid);				// �� �󼼺����, �ش� ���� ��ȸ���� ����ϴ� table��  insert�ϴ� 
		if (pmid != null && !pmid.equals("")) saved = placeViewSvc.isSaved(pmid, piid);		// ���ǿ��� ȸ�����̵� �޾ƿ� �� ������쿡�� ������ ��� ���� �Լ��� ȣ����
		pReview = placeViewSvc.getPlaceReviewList(piid);
		
		
		HttpSession session = request.getSession();		// ���� ���� out��ü �̿��ϱ� ���� 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(saved);
			
		PlacePageInfo placePageInfo = new PlacePageInfo();	// ����¡�� �ʿ��� �������� ������ �ν��Ͻ� 
		placePageInfo.setCpage(cpage);			// placePageInfo.setPsize(psize);			
		placePageInfo.setKeyword(keyword);		placePageInfo.setBcata(bcata);
		placePageInfo.setScata(scata);			placePageInfo.setTag(tag);				placePageInfo.setKey(key);
		placePageInfo.setSort(sort);			placePageInfo.setArea(area);
		
		request.setAttribute("placeInfo", placeInfo);
		request.setAttribute("placePageInfo", placePageInfo);
		request.setAttribute("pReview", pReview);
		ActionForward forward = new ActionForward();
		forward.setPath("/courseplace/place_view.jsp");
		
		return forward;
	}
}
