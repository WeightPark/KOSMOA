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
		ArrayList<PlaceReviewInfo> pReview = new ArrayList<PlaceReviewInfo> ();		// 해당 장소에 관한 리뷰를 가져올 어레이리스트 
		int cpage = Integer.parseInt(request.getParameter("cpage"));
		// int	psize = Integer.parseInt(request.getParameter("psize"));
		int result = 0;
		int saved = 0;
		String piid = request.getParameter("piid");			// 장소 번호
		String pmid = request.getParameter("pmid");			// 개인회원 번호 
		
		String keyword = request.getParameter("keyword");		if (keyword == null)	keyword = "";
		String bcata = request.getParameter("bcata");			if (bcata == null)	bcata = "";
		String scata = request.getParameter("scata");			if (scata == null)	scata = "";
		String tag = request.getParameter("tag");				if (tag == null)	tag = "";
		String key = request.getParameter("key");				if (key == null)	key = "";
		String area = request.getParameter("area");				if (area == null)	area = "";
		String sort = request.getParameter("sort");				if (sort == null)	sort="idd";	 
	
		PlaceViewSvc placeViewSvc = new PlaceViewSvc();
		PlaceInfo placeInfo = placeViewSvc.getplaInfo(piid);		// 장소 번호에 해당하는 글을 인스턴스에 담은 후에 , 디스패치 방식으로 request에 담아서 보냄
		result = placeViewSvc.insertPlaceStat(piid);				// 글 상세보기시, 해당 글의 조회수를 기록하는 table에  insert하는 
		if (pmid != null && !pmid.equals("")) saved = placeViewSvc.isSaved(pmid, piid);		// 세션에서 회원아이디를 받아올 수 있을경우에만 저장한 장소 여부 함수를 호출함
		pReview = placeViewSvc.getPlaceReviewList(piid);
		
		
		HttpSession session = request.getSession();		// 세션 생성 out객체 이용하기 위함 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(saved);
			
		PlacePageInfo placePageInfo = new PlacePageInfo();	// 페이징에 필요한 정보들을 저장할 인스턴스 
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
