package place.act;

import javax.servlet.http.*;
import java.util.*;
import java.io.*;
import act.Action;
import place.svc.*;
import place.vo.PlaceInfo;
import vo.*;

public class PlaceInProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		String pi_st_ids1 = request.getParameter("pi_st_ids1");
		String pi_st_ids2 = request.getParameter("pi_st_ids2");
		String pi_st_ids3 = request.getParameter("pi_st_ids3");
		String key1 = pi_st_ids1.substring(0, 5) + "," + pi_st_ids2.substring(0, 5) + "," + pi_st_ids3.substring(0, 5);
		String val1 = pi_st_ids1.substring(6) + "," + pi_st_ids2.substring(6) + "," + pi_st_ids3.substring(6);
		
		String pi_sk_ids1 = request.getParameter("pi_sk_ids1");
		String pi_sk_ids2 = request.getParameter("pi_sk_ids2");
		String pi_sk_ids3 = request.getParameter("pi_sk_ids3");
		String key2 = pi_sk_ids1.substring(0, 5) + "," + pi_sk_ids2.substring(0, 5) + "," + pi_sk_ids3.substring(0, 5);
		String val2 = pi_sk_ids1.substring(6) + "," + pi_sk_ids2.substring(6) + "," + pi_sk_ids3.substring(6);
		
		PlaceInfo place = new PlaceInfo();
		// ����ڰ� �Է��� ����� �������� ������ �ν��Ͻ� ����
		place.setPi_phone(request.getParameter("p1") + "-" + 
				request.getParameter("p2").trim() + "-" + request.getParameter("p3").trim());
		place.setPi_id(request.getParameter("pi_id"));
		place.setPi_name(request.getParameter("pi_name").trim());
		place.setPi_bigcata(request.getParameter("pi_bigcata"));
		place.setPi_smallcata(request.getParameter("pi_smallcata"));
		place.setPi_la(request.getParameter("pi_la"));
		place.setPi_lo(request.getParameter("pi_lo"));
		place.setSk_id(key1);
		place.setSk_name(val1);
		place.setSt_id(key2);
		place.setSt_name(val2);
		place.setPi_img1(request.getParameter("pi_img1"));
		place.setPi_img2(request.getParameter("pi_img2"));
		place.setPi_img3(request.getParameter("pi_img3"));
		place.setPi_img4(request.getParameter("pi_img4"));
		place.setPi_desc(request.getParameter("pi_desc").trim());
		place.setPi_descimg(request.getParameter("pi_descimg"));
		place.setPi_time(request.getParameter("pi_time").trim());
		place.setPi_service(request.getParameter("pi_service").trim());
		place.setPi_person(Integer.parseInt(request.getParameter("pi_person").trim()));
		place.setPi_isr(request.getParameter("pi_isr"));
		place.setPi_isop(request.getParameter("pi_isop"));
		place.setPi_isshow(request.getParameter("pi_isshow"));
		place.setPi_ismain(request.getParameter("pi_ismain"));
		place.setPi_zip(request.getParameter("pi_zip").trim());
		place.setPi_addr1(request.getParameter("pi_addr1"));
		place.setPi_addr2(request.getParameter("pi_addr2").trim());
		place.setPi_area(request.getParameter("pi_area"));
		place.setAi_idx(Integer.parseInt(request.getParameter("ai_idx")));
		// ����� �Խñ� �����͸� �޾ƿ� notice�ν��Ͻ��� ����(�Ű������� ����ϱ� ���ϱ� ����)
		

		PlaceInProcSvc placeInProcSvc = new PlaceInProcSvc();
		// DB�� ������ ����Ͻ� ������ ó���ϱ� ���� �ν��Ͻ� ����
		int result = placeInProcSvc.placeInsert(place);
		// ��� ���, ����, ������ ó���� �޼ҵ� ȣ��
			
		if (result == 0) 	// �� ��Ͽ� ���������� 
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('�� ��Ͽ� �����߽��ϴ�.\n�ٽ� �õ��� �ֽʽÿ�.');");
			out.println("history.back();");
			out.println("</script>");
		
		
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);	// dispatch�� �ƴ� sendRedirect ������� �̵��Ѵٴ� ����
		forward.setPath("/kosmoa/place_list.pla");
		
		return forward;
	}
}
