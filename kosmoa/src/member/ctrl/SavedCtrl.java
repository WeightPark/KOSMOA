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
    	// 저장 관련 컨트롤러  .sav
    	switch(command) {	
    		case "/saved_list.sav" : 	// 장소/코스 목록 
    			action = new SavedListAct();
    			break;
    		case "/saved_proc.sav" :		  	// 장소/코스(저장,삭제) 
    			action = new SavedProcAct();
    			break;
    	}
    	try {
    		
			forward = action.execute(request, response); // 처리 및 실행 후 이동할 경로와 방법을 받아옴
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
