package member.act;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import act.Action;
import vo.ActionForward;

public class MemberProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
	         request.setCharacterEncoding("utf-8");
		
	         ActionForward test = new ActionForward();
       return test;
    }
}