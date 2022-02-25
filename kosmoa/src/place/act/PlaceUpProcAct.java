package place.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import act.Action;
import place.svc.*;
import place.vo.*;
import place.vo.PlaceInfo;
import vo.*;

public class PlaceUpProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		PlaceInfo placeInfo = new PlaceInfo();
		
		HttpSession session = request.getSession();
		PlaceInfo pi = null;
		// 정보 수정이나 탈퇴시 사용할 세션 속성을 MemberInfo 형 인스턴스로 생성
	
		placeInfo.setPi_phone(request.getParameter("p1") + "-" + 
			request.getParameter("p2").trim() + "-" + request.getParameter("p3").trim());
		placeInfo.setPi_id(request.getParameter("pi_id"));
		placeInfo.setPi_name(request.getParameter("pi_name").trim());
		placeInfo.setPi_bigcata(request.getParameter("pi_bigcata"));
		placeInfo.setPi_smallcata(request.getParameter("pi_smallcata"));
		placeInfo.setSt_id(request.getParameter("st_id"));
		placeInfo.setSt_name(request.getParameter("st_name"));
		placeInfo.setPi_img1(request.getParameter("pi_img1"));
		placeInfo.setPi_img2(request.getParameter("pi_img2"));
		placeInfo.setPi_img3(request.getParameter("pi_img3"));
		placeInfo.setPi_img4(request.getParameter("pi_img4"));
		placeInfo.setPi_desc(request.getParameter("pi_desc").trim());
		placeInfo.setPi_descimg(request.getParameter("pi_descimg"));
		placeInfo.setPi_time(request.getParameter("pi_time").trim());
		placeInfo.setPi_service(request.getParameter("pi_service").trim());
		placeInfo.setPi_person(Integer.parseInt(request.getParameter("pi_person").trim()));
		placeInfo.setPi_isr(request.getParameter("pi_isr"));
		placeInfo.setPi_ismain(request.getParameter("pi_ismain"));
		placeInfo.setPi_zip(request.getParameter("pi_zip").trim());
		placeInfo.setPi_addr1(request.getParameter("pi_addr1"));
		placeInfo.setPi_addr2(request.getParameter("pi_addr2").trim());
		placeInfo.setPi_area(request.getParameter("pi_area"));
		placeInfo.setSk_id(request.getParameter("sk_id"));
		
		PlaceUpProcSvc placeUpProcSvc = new PlaceUpProcSvc();
		int result = placeUpProcSvc.placeUpdate(placeInfo);
		// 장소 정보 수정을 처리할 메소드 호출
		
		String lnk = "../place_list.jsp";
		if (result == 1) {	// 정상적으로 동작되었으면
			lnk = "placeUpform.jsp";
			pi.setPi_phone(placeInfo.getPi_phone());
			pi.setPi_name(placeInfo.getPi_name());
			pi.setPi_bigcata(placeInfo.getPi_bigcata());
			pi.setPi_smallcata(placeInfo.getPi_smallcata());
			pi.setPi_isview(placeInfo.getPi_isview());
			pi.setPi_la(placeInfo.getPi_la());
			pi.setPi_lo(placeInfo.getPi_lo());
			pi.setSt_id(placeInfo.getSt_id());
			pi.setSt_name(placeInfo.getSt_name());
			pi.setPi_img1(placeInfo.getPi_img1());
			pi.setPi_img2(placeInfo.getPi_img2());
			pi.setPi_img3(placeInfo.getPi_img3());
			pi.setPi_img4(placeInfo.getPi_img4());
			pi.setPi_desc(placeInfo.getPi_desc());
			pi.setPi_descimg(placeInfo.getPi_descimg());
			pi.setPi_time(placeInfo.getPi_time());
			pi.setPi_service(placeInfo.getPi_service());
			pi.setPi_person(placeInfo.getPi_person());
			pi.setPi_isr(placeInfo.getPi_isr());
			pi.setPi_isop(placeInfo.getPi_isop());
			pi.setPi_isshow(placeInfo.getPi_isshow());
			pi.setPi_ismain(placeInfo.getPi_ismain());
			pi.setPi_zip(placeInfo.getPi_zip());
			pi.setPi_addr1(placeInfo.getPi_addr1());
			pi.setPi_addr2(placeInfo.getPi_addr2());
			pi.setSk_id(placeInfo.getSk_id());
			pi.setPi_area(placeInfo.getPi_area());
			// 정보 수정 성공시 현재 세션에 들어있는 로그인 회원 정보도 변경시킴
		
		} else {	// 장소 정보 수정에 실패했으면 
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('장소 정보 수정에 실패했습니다.\n다시 시도해 주십시오.');");
			out.println("history.back();");
			out.println("</script>");
		}
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath(lnk);
		
		return forward;
	}
}
