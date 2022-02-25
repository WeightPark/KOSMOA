package member.ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.svc.*;
import member.vo.*;

@WebServlet("/login")
public class LoginCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginCtrl() {
        super();
    }
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length());
    	
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim(); //
		PriMemberInfo priMemberInfo = null;
		
		System.out.println(command);
		
		String url = request.getParameter("url").replace("$", "&");
		System.out.println("ctrl url : " + url);
		if (url.equals(""))	url = "main"; 
		
		LoginSvc loginSvc = new LoginSvc();
		priMemberInfo = loginSvc.getMemberInfo(uid, pwd); 
		
		HttpSession session = request.getSession(); 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(priMemberInfo != null) {
			session.setAttribute("memberInfo", priMemberInfo);
			response.sendRedirect(url);
		}else {
			out.println("<script>");
			out.println("alert('아이디와 비밀번호를 확인해주세요.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
