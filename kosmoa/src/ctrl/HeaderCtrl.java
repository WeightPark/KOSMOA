package ctrl;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import course.vo.*;
import place.vo.*;
import review.vo.CourseReviewInfo;
import svc.MainSvc;

@WebServlet("*.head")
public class HeaderCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public HeaderCtrl() { super(); }

    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length());
    	String lnk = "";
    	System.out.println(command);
    	
    	switch(command) {
		case "/loginForm.head" :
			lnk = "/member/loginForm.jsp";
			break;
		case "/joinForm.head" :	
			lnk = "/member/priJoinForm.jsp";
			break;	
	}
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher(lnk);
		dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
}
