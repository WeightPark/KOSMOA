package customer.act;

import javax.servlet.http.*;
import java.util.*;	
import java.io.*;
import customer.svc.*;
import customer.vo.*;
import vo.*;
import act.*;

public class ReplyProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		
		return forward;
	}
}