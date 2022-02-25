package statistics.ctrl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import act.Action;
import statistics.act.*;
import vo.ActionForward;

@WebServlet("*.sta")
public class StatCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public StatCtrl() { super();  }
    
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length()); 
    	System.out.println(command);
    	ActionForward forward = null;
    	Action action = null;

    	switch(command) {
    		case "/stat_sch_view.sta" :	
    			action = new StatSchAct(); 
    			break;
    		case "/stat_reserve_view.sta" :	
    			action = new StatRevAct();
    			break;
    		case "/stat_main_view.sta":	
    			action = new StatMainAct();
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
