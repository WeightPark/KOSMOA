package ctrl;

import java.io.*;
import java.util.ArrayList;

import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import course.vo.*;
import place.vo.*;
import review.vo.CourseReviewInfo;
import svc.MainSvc;

@WebServlet("/main")
public class MainCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public MainCtrl() { super(); }
    
    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length());
    	
    	System.out.println(command);
    	
    	ArrayList<CourseInfo> courseList = new ArrayList<CourseInfo>();
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		ArrayList<CourseReviewInfo> reviewList = new ArrayList<CourseReviewInfo>();
		ArrayList<String> tagList = new ArrayList<String>();
		String tagName = request.getParameter("tagName");
		if (tagName == null || tagName.equals(""))	tagName = "";
		String where = "";
		if (!tagName.equals("")) {
			where = " where ci_st_name like '%" + tagName + "%' ";
		}
	
		MainSvc mainSvc = new MainSvc();
		
		courseList = mainSvc.getCourseList(where);
		placeList = mainSvc.getPlaceList();
		reviewList = mainSvc.getReviewList();
		tagList = mainSvc.getTagList();
		
		request.setAttribute("courseList", courseList);
		request.setAttribute("placeList", placeList);
		request.setAttribute("reviewList", reviewList);
		request.setAttribute("tagList", tagList);
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher("/main.jsp");
		dispatcher.forward(request, response);
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
