package place.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import place.vo.*;
import place.act.*;
import vo.*;
import act.*;

@WebServlet("*.pla")
public class PlaceCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public PlaceCtrl() {
        super();
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String requestUri = request.getRequestURI();		 
    	String contextPath = request.getContextPath();		 
    	String command = requestUri.substring(contextPath.length());	
    	System.out.println(requestUri);
    	System.out.println(contextPath);
    	System.out.println(command);
    	
    	ActionForward forward = null;
    	Action action = null;


    	switch(command) {	
    		case "/place_list.pla" : 	
    			action = new PlaceListAct();
    			break;
    		case "/place_view.pla" :	 
    			action = new PlaceViewtAct();
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
