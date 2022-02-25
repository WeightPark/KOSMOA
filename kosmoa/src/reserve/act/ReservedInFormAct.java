package reserve.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import reserve.svc.*;
import reserve.vo.*;
import vo.*;
import act.*;
import member.*;
import place.vo.PlaceInfo;

public class ReservedInFormAct implements Action {

	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String rtype = request.getParameter("rtype");	
		String ciid = request.getParameter("ciid");		
		String args = request.getParameter("args");
		if (ciid == null || ciid.equals(""))	ciid = "";
		String piid = request.getParameter("piid");		
		if (piid == null || piid.equals(""))	piid = "";
		System.out.println("Act : " + piid);
		ArrayList<PlaceInfo> placeList = new ArrayList<PlaceInfo>();
		PlaceInfo placeInfo = new PlaceInfo(); 
		System.out.println("ciid : " + ciid);
		ReservedInFormSvc reservedInFormSvc = new ReservedInFormSvc();
		
		if (rtype.equals("c")) {
			placeList = reservedInFormSvc.getPlaceList(ciid);
			request.setAttribute("placeList", placeList);
			request.setAttribute("rtype", rtype);
			request.setAttribute("args", args);
			ActionForward forward = new ActionForward();
			forward.setPath("reserve/reserved_in_form.jsp");
			
			return forward;
		} else {
			placeInfo = reservedInFormSvc.getPlaceInfo(piid);
			request.setAttribute("placeInfo", placeInfo);	
			request.setAttribute("rtype", rtype);
			request.setAttribute("args", args);
			
			ActionForward forward = new ActionForward();
			forward.setPath("reserve/reserved_place_form.jsp");
			
			return forward;
		}
	}
}