package review.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import review.act.*;
import act.*;
import course.act.CourseListAct;
import course.act.CourseViewtAct;
import vo.*; 


@WebServlet("*.riv")
public class ReviewCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReviewCtrl() {	super();  }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length()); 
    	System.out.println(command);
    	ActionForward forward = null;
    	Action action = null;

    	switch(command) {
    		case "/review_in_form.riv" :	// ¸®ºä ÀÛ¼º Ã¢ 
    			action = new ReviewInFormAct(); 
    			break;
    		case "/review_in_proc.riv" :	// ¸®ºä µî·Ï
    			action = new ReviewInProc();
    			break;
    		case "/review_list.riv" :	// ¸®ºä ¸ñ·Ï
    			action = new ReviewListAct(); 
    			break;	
    		case "/my_review_list.riv"	: // ¸®ºä ¸ñ·Ï
    			action = new MyReviewListAct();
    			break;
    		case "/member/my_review_list.riv"	: // ¸®ºä ¸ñ·Ï
    			action = new MyReviewListAct();
    			break;
    	}
    	try {
    		
			forward = action.execute(request, response);
			
		} catch(Exception e) {
			e.printStackTrace();
		}

		if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
	    		dispatcher.forward(request, response);
			}
		}
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
