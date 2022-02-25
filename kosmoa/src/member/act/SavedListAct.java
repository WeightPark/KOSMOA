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

public class SavedListAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<SavedCourseInfo> cosList = new ArrayList<SavedCourseInfo>();
		ArrayList<SavedPlaceInfo> plsList = new ArrayList<SavedPlaceInfo>();
		String wtype = request.getParameter("wtype");
		System.out.println("wtype : " + wtype);
		
		System.out.println("getin mysaved list");
		if(wtype == null) {
			wtype = "course";
		}
		
		HttpSession session = request.getSession();	// �꽭�뀡 �깮�꽦
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		int cpage = 1, psize =3 , bsize = 3, spage, epage, rcnt, pcnt;
		if (request.getParameter("cpage") != null)	cpage = Integer.parseInt(request.getParameter("cpage"));
		if (request.getParameter("psize") != null)	psize = Integer.parseInt(request.getParameter("psize"));
		
		
		String pmid = memberInfo.getPm_id();
		// rcnt瑜� 援ы븯湲� �쐞�븳 where �젅 議곌굔 
		String where = " and a.pm_id = '" + pmid + "' ";
		// 肄붿뒪 紐⑸줉�쓣 媛��졇�삤湲� �쐞�븳 where�젅 議곌굔 
		SavedListSvc savedListSvc = new SavedListSvc();
		
		rcnt = savedListSvc.getSaveCount(pmid, wtype);	// 肄붿뒪 rcnt(珥� �긽�뭹媛쒖닔)瑜� 援ы븯�뒗 硫붿꽌�뱶 
		pcnt = rcnt / psize;
		if (rcnt % psize > 0)	pcnt++;				// �쟾泥� �럹�씠吏� 媛쒖닔
		spage = (cpage - 1) / bsize * bsize + 1;	// 釉붾줉�쓽 �떆�옉 �럹�씠吏� 踰덊샇
		epage = spage + bsize - 1;
		if (epage > pcnt)	epage = pcnt;			// 釉붾줉�쓽 醫낅즺 �럹�씠吏� 踰덊샇
	
		if(wtype.equals("course")) {
			CoursePageInfo cospageInfo = new CoursePageInfo();
			cospageInfo.setCpage(cpage);	cospageInfo.setPsize(psize);		cospageInfo.setBsize(bsize);
			cospageInfo.setSpage(spage);	cospageInfo.setEpage(epage);		cospageInfo.setRcnt(rcnt);
			cospageInfo.setPcnt(pcnt);
			request.setAttribute("cospageInfo", cospageInfo);
		}else {
			PlacePageInfo plspageInfo = new PlacePageInfo();
			plspageInfo.setCpage(cpage);	plspageInfo.setPsize(psize);		plspageInfo.setBsize(bsize);
			plspageInfo.setSpage(spage);	plspageInfo.setEpage(epage);		plspageInfo.setRcnt(rcnt);
			plspageInfo.setPcnt(pcnt);
			request.setAttribute("plspageInfo", plspageInfo);
		}
		
		cosList = savedListSvc.getCosList(where, cpage, psize);
		plsList = savedListSvc.getPlsList(where, cpage, psize);
		// �빐�떦 �븘�씠�뵒�뿉 �냽�븯�뒗 肄붿뒪, �옣�냼 �젙蹂대�� 媛��졇�삤�뒗 硫붿꽌�뱶 
		
		request.setAttribute("cosList", cosList);
		request.setAttribute("plsList", plsList);
		request.setAttribute("wtype", wtype);
		System.out.println("forwarding ");
		ActionForward forward = new ActionForward();
		forward.setPath("member/my_saved_course_place_list.jsp"); // �뵒�뒪�뙣移� 諛⑹떇�쑝濡� 蹂대깂
		
		return forward;
	}
}
