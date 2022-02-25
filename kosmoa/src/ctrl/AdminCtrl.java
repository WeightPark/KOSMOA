package ctrl;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.adm")
public class AdminCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public AdminCtrl() { super(); }

    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length());
    	String lnk = "";
    	System.out.println(command);
    	
    	switch(command) {
//		case "/main.adm" :
//			action = new 
//			lnk = "/admin/admin_index.jsp";
//			break;
		case "/main.adm" :	
			lnk = "/admin/admin_login.jsp";
			break;	
	}
    	
    	RequestDispatcher dispatcher = request.getRequestDispatcher(lnk);
		dispatcher.forward(request, response);
    }
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
