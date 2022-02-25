package member.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import act.*;
import member.act.*;
import reserve.act.*;
import reserve.act.ReservedInFormAct;
import reserve.act.ReservedProcAct;
import reserve.act.ReservedUpFormAct;
import vo.*;

@WebServlet("*.mem")
public class MemberCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public MemberCtrl() {
        super();
       
    }

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
    	case "/member_view_my_info.mem" :
    		action = new MemberViewInfoAct();
    		break;
    	case "/mypage_up_form.mem" :
    		action = new MemberUpFormcAct();
    		break;
    	case "/member_up_proc.mem" :
    		action = new MemberUpProcAct();
    		break;
    	case "/member_in_proc.mem" :
    		action = new MemberInProcAct();
    		break;
    	case "/member_reserve_list.mem" :	// 占쎌굙占쎈튋占쎌겱占쎌넺 占쎌뒄筌ｏ옙
    		action = new MemberReserveListAct();
    		break;
    	case "/member_reserved_view.mem" :	// �굜遺용뮞占쎌굙占쎈튋 占쎄맒占쎄쉭癰귣떯由� 占쎌뒄筌ｏ옙
    		action = new ReserveViewAct();
    		break;
    	case "/member_reserved_Place_view.mem" : 
    		action = new ReservePlaceViewAct();
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
