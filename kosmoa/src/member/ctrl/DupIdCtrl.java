package member.ctrl;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import svc.*;
import member.svc.*;

@WebServlet("/dupId")
public class DupIdCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public DupIdCtrl() {
        super();
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String uid = request.getParameter("uid");
		response.setContentType("text/html; charset=utf-8");
		// 응답에 대한 내용을 text나 html 형식의 utf-8 인코딩으로 보내는 코드 
		PrintWriter out = response.getWriter();
		// 응답을 보내는 객체 
		
		try {
			DupIdSvc dupIdSvc = new DupIdSvc();
			int result = dupIdSvc.chkDupId(uid);
			out.println(result); // 결과 값을 호출했던 자바 스크립트 함수로 리턴시킴 
			out.close();
			
		}catch(Exception e) {	// 원래는 예외 이름이 들어가야하는데 귀찮아서 모든 예외의 조상인 Exception을 넣음
			e.printStackTrace();
			out.println(1); // 오류시 리턴할 값이며 아이디가 있다는 의미의 1을 넣는다. 
		}
	}

}
