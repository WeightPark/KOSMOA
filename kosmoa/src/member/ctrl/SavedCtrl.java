package member.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import member.act.*;
import act.*;
import vo.*; 
import java.util.*;


@WebServlet("*.sav")
public class SavedCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public SavedCtrl() {
        super();
        
    }
    protected void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("UTF-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length()); 
    	
    	ActionForward forward = null;
    	Action action = null;
    	System.out.println("savedctrl command : " + command);
    	// ���� ���� ��Ʈ�ѷ�  .sav
    	switch(command) {	
    		case "/saved_list.sav" : 	// ���/�ڽ� ��� 
    			action = new SavedListAct();
    			break;
    		case "/saved_proc.sav" :		  	// ���/�ڽ�(����,����) 
    			action = new SavedProcAct();
    			break;
    	}
    	try {
    		
			forward = action.execute(request, response); // ó�� �� ���� �� �̵��� ��ο� ����� �޾ƿ�
		}catch(Exception e) {
			e.printStackTrace();
		}

    	if (forward != null) {
			if (forward.isRedirect()) {
				response.sendRedirect(forward.getPath());
			}else {
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
