package course.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import course.act.*;
import act.*;
import vo.*; 

@WebServlet("*.cou")
public class CourseCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CourseCtrl() {
        super();
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length()); 
    	System.out.println(command);
    	
    	ActionForward forward = null;
    	Action action = null;

    	switch(command) {
    		case "/course_list.cou" :
    			action = new CourseListAct();
    			break;
    		case "/course_view.cou" :	
    			action = new CourseViewtAct();
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
