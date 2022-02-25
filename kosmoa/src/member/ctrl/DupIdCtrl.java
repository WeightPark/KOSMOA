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
		// ���信 ���� ������ text�� html ������ utf-8 ���ڵ����� ������ �ڵ� 
		PrintWriter out = response.getWriter();
		// ������ ������ ��ü 
		
		try {
			DupIdSvc dupIdSvc = new DupIdSvc();
			int result = dupIdSvc.chkDupId(uid);
			out.println(result); // ��� ���� ȣ���ߴ� �ڹ� ��ũ��Ʈ �Լ��� ���Ͻ�Ŵ 
			out.close();
			
		}catch(Exception e) {	// ������ ���� �̸��� �����ϴµ� �����Ƽ� ��� ������ ������ Exception�� ����
			e.printStackTrace();
			out.println(1); // ������ ������ ���̸� ���̵� �ִٴ� �ǹ��� 1�� �ִ´�. 
		}
	}

}
