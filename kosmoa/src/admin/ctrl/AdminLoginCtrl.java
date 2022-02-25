package admin.ctrl;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.svc.*;
import admin.vo.*;

@WebServlet("/alogin")
public class AdminLoginCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public AdminLoginCtrl() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid").trim().toLowerCase();
		String pwd = request.getParameter("pwd").trim(); //
		AdminInfo adminInfo = null;
		
		System.out.println("test");
		
		String url = request.getParameter("url").replace("$", "&");
		if (url.equals(""))	url = "main.adm"; 
		
		AdminLoginSvc adminLoginSvc = new AdminLoginSvc();
		adminInfo = adminLoginSvc.getAdminInfo(uid, pwd); 
		
		HttpSession session = request.getSession(); 
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		
		if(adminInfo != null) {
			session.setAttribute("adminInfo", adminInfo);
			response.sendRedirect("stat_main_view.sta");
		}else {
			out.println("<script>");
			out.println("alert('로그인에 실패하였습니다.');");
			out.println("history.back();");
			out.println("</script>");
		}
	}
}
