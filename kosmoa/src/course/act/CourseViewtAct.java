package course.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import vo.*;
import act.*;
import course.svc.*;
import course.vo.*;
import place.vo.PlacePageInfo;
import review.vo.CourseReviewInfo;

public class CourseViewtAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ArrayList<CourseInfo> courseInfo = new ArrayList<CourseInfo>();		// �ش� �ڽ���ȣ�� �ش��ϴ� ���ڵ���� ���� ArrayList<CourseInfo> �ν��Ͻ� 
		ArrayList<CourseReviewInfo> cReview = new ArrayList<CourseReviewInfo> ();		// �ش� �ڽ��� ���並 ���� ArrayList �ν��Ͻ� 
		
		request.setCharacterEncoding("utf-8");
		String cp = request.getParameter("cpage");
		int cpage = 0;
		if (cp != null && !cp.equals("")) {
			cpage = Integer.parseInt(request.getParameter("cpage"));
		}
		int result = 0;
		int saved = 0;	
		String ciid = request.getParameter("ciid");
		String pmid = request.getParameter("pmid");
		
		String keyword = request.getParameter("keyword");		if (keyword == null)		keyword = "";
		String tag = request.getParameter("tag");				if (tag == null)			tag = "";
		String key = request.getParameter("key");				if (key == null)			key = "";
		String area = request.getParameter("area");				if (area == null)			area = "";
		String sort = request.getParameter("sort");				if (sort == null)			sort="idd";
		
		HttpSession session = request.getSession();	
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		CourseViewSvc courseViewSvc = new CourseViewSvc();
		String type ="";
		if (request.getParameter("type") != null && !request.getParameter("type").equals(""))
			type = request.getParameter("type");
		if (type.equals("like")) {
			System.out.println("���׿� ����");
			result = courseViewSvc.doLike(ciid);
			out.println(result);
		}
		courseInfo = courseViewSvc.getCourseInfo(ciid);
		result = courseViewSvc.insertCourseStat(ciid);
		cReview = courseViewSvc.getCourseReviewList(ciid);
		
		if (pmid != null && !pmid.equals(""))	saved = courseViewSvc.isSaved(pmid, ciid);
		
		CoursePageInfo coursePageInfo = new CoursePageInfo();	
		coursePageInfo.setCpage(cpage);			
		coursePageInfo.setKeyword(keyword);		coursePageInfo.setTag(tag);				coursePageInfo.setKey(key);
		coursePageInfo.setSort(sort);			coursePageInfo.setArea(area);
		
		
		
		request.setAttribute("courseInfo", courseInfo);
		request.setAttribute("coursePageInfo", coursePageInfo);
		request.setAttribute("cReview", cReview);
		ActionForward forward = new ActionForward();
		forward.setPath("/courseplace/course_view.jsp");
		
		return forward;
	}

}
