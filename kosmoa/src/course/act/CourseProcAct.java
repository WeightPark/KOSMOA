package course.act;

import javax.servlet.http.*;
import act.Action;
import java.util.*;			
import java.io.*;
import course.svc.*;
import course.vo.*;
import vo.ActionForward;
import place.vo.PlaceInfo;

public class CourseProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		ArrayList<PlaceInfo> placeInfo = new ArrayList<PlaceInfo>();
		String wtype = request.getParameter("wtype");	// 코스 등록(in), 수정(up) 여부를 구분짓는 값
		
		String ci_st_ids1 = request.getParameter("ci_st_ids1");
		String ci_st_ids2 = request.getParameter("ci_st_ids2");
		String ci_st_ids3 = request.getParameter("ci_st_ids3");
		String key1 = ci_st_ids1.substring(0, 5) + "," + ci_st_ids2.substring(0, 5) + "," + ci_st_ids3.substring(0, 5);
		String val1 = ci_st_ids1.substring(6) + "," + ci_st_ids2.substring(6) + "," + ci_st_ids3.substring(6);
		
		String ci_sk_ids1 = request.getParameter("ci_sk_ids1");
		String ci_sk_ids2 = request.getParameter("ci_sk_ids2");
		String ci_sk_ids3 = request.getParameter("ci_sk_ids3");
		String key2 = ci_sk_ids1.substring(0, 5) + "," + ci_sk_ids2.substring(0, 5) + "," + ci_sk_ids3.substring(0, 5);
		String val2 = ci_sk_ids1.substring(6) + "," + ci_sk_ids2.substring(6) + "," + ci_sk_ids3.substring(6);
		
		String pi_id = request.getParameter("pi_id");
		String pi_name = request.getParameter("pi_name");
		
		CourseInfo course = new CourseInfo();		// 등록 및 수정할 장소의 데이터들을 저장할 인스턴스
		PlaceInfo place = new PlaceInfo();
		
		HttpSession session = request.getSession();
		CourseInfo ci = null;
		PlaceInfo pi = null;
	
				
		if (wtype.equals("in") || wtype.equals("up")) { 
			// 현재 처리하려는 작업이 코스 등록이나 수정일 경우(사용자가 입력한 데이터들을 받아와서 courseInfo 인스턴스에 저장)
			course.setCi_name(request.getParameter("ci_name"));
			course.setCi_id(request.getParameter("ci_id").trim().toLowerCase());
			course.setCi_img(request.getParameter("ci_img"));
			course.setCi_time(Integer.parseInt(request.getParameter("ci_time")));
			course.setCi_desc(request.getParameter("ci_desc"));
			course.setCi_isview(request.getParameter("ci_isview"));
			course.setCi_st_id(key1);
			course.setCi_st_name(val1);
			course.setCi_sk_id(key2);
			course.setCi_sk_name(val2);
			place.setPi_id(pi_id);
			place.setPi_name(pi_name);
			course.setAi_idx(Integer.parseInt(request.getParameter("ai_idx")));
			
		} 

		CourseProcSvc courseProcSvc = new CourseProcSvc();
		int result = courseProcSvc.courseProc(wtype, course);
		// 코스 등록, 수정, 삭제를 처리할 메소드 호출
		
		System.out.println(result);
		String lnk = "kosmoa/courseplace/course_list.jsp";
		if (result == 1) {	// 정상적으로 동작 되었으면 이라는 조건
			if(wtype.equals("in"))			lnk = "../course_list.jsp";
			else if(wtype.equals("up")) {			
				lnk = "courseUpForm.jsp";
				ci.setCi_name(course.getCi_name());
				ci.setCi_id(course.getCi_id());
				ci.setCi_img(course.getCi_img());
				ci.setCi_time(course.getCi_time());
				ci.setCi_desc(course.getCi_desc());
				ci.setCi_isview(course.getCi_isview());
				ci.setCi_st_id(course.getCi_st_id());
				ci.setCi_st_name(course.getCi_st_name());
				ci.setCi_sk_id(course.getCi_sk_id());
				ci.setCi_sk_name(course.getCi_sk_name());
				pi.setPi_name(place.getPi_name());
				pi.setPi_id(place.getPi_id());
				ci.setAi_idx(course.getAi_idx());
				
				// 정보 수정 성공 시 현재 세션에 들어있는 로그인 코스 정보도 변경시킴
			}	
		} else {
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>");
			out.println("alert('등록 및 수정에 실패했습니다. 다시 시도해 보십시오');");
			out.println("history.back();");
			out.println("</script>");
			out.close();
		}
		
		// 작업 후 이동할 위치와 방법에 대해 지정하는 ActionForward 인스턴스 생성
		request.setAttribute("placeInfo", place);
		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		forward.setPath(lnk);
		
		return forward;
	}

}
