package reserve.ctrl;

import java.io.*;

import javax.servlet.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import reserve.vo.*;
import reserve.act.*;
import vo.*;
import act.*;

@WebServlet("*.res")
public class ReservedCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ReservedCtrl() { super(); }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();		 
    	String contextPath = request.getContextPath();		 
    	String command = requestUri.substring(contextPath.length());
    	System.out.println("requestUri : " + requestUri);	 
    	System.out.println("contextPath : " + contextPath); 
    	System.out.println("command : " + command); 
    	
    	ActionForward forward = null;
    	Action action = null;

    	switch (command) {
    	case "/reserved_in_form.res" :	 
    		action = new ReservedInFormAct();
    		break;
    	case "/reserved_up_form.res" : 
    		action = new ReservedUpFormAct();
    		break;
    	case "/reserved_proc.res" :		
    		action = new ReservedProcAct();
    		break;	
    	case "/reserved_cancel_proc.res" :		
    		action = new ReservedCancelProcAct();
    		break;
    	}
    	try {
    		forward = action.execute(request, response);
    	}catch (Exception e) {
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
