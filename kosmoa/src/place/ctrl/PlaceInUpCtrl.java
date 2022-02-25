package place.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import place.vo.*;
import place.act.*;
import act.*;
import act.Action;
import vo.*; 

@WebServlet("*.piu")
public class PlaceInUpCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public PlaceInUpCtrl() {
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
		case "/courseplace/place_In.piu" :	// ��� ��� ó�� ��û ��
			action = new PlaceInProcAct();
			break;
		case "/courseplace/place_Up.piu" :	// ��� ���� ���� ��� �� ��û
			action = new PlaceUpProcAct();
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
