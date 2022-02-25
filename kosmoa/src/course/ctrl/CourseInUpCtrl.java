package course.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import course.vo.*;
import course.act.*;
import act.*;
import act.Action;
import vo.*; 

@WebServlet("*.ciu")
public class CourseInUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public CourseInUpCtrl() {
        super();
    }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length()); 
    	System.out.println(requestUri);
    	System.out.println(contextPath);
    	System.out.println(command);
    	
    	ActionForward forward = null;
    	Action action = null;

    
    	switch(command) {	
		case "/course_proc.ciu" :	
			action = new CourseProcAct();
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
