package member.act;

import javax.servlet.http.*;
import java.io.*;
import java.util.*;
import member.svc.*;
import vo.*;
import member.vo.*;
import act.*;

public class SavedProcAct implements Action {
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
		
		String wtype = request.getParameter("wtype");		// ���옣, �궘�젣 �뿬遺�瑜� 援щ텇吏볥뒗 媛�
		String cnpidxs = request.getParameter("cnpidx");	// �옣�냼, 肄붿뒪 �씪�젴踰덊샇�뱾濡� 援щ텇�옄 "," 濡� ���옣�릺�뼱�엳�떎 肄붿뒪 �궘�젣�떆 �궗�슜.  
		String cnpid = request.getParameter("cnp_id");		// �옣�냼, 肄붿뒪 ���옣�떆 �궗�슜�븷 �옣�냼,肄붿뒪 �븘�씠�뵒  
		System.out.println("cnp_id : " + cnpid);
		String pmid = memberInfo.getPm_id();				// where�젅�뿉 �궗�슜�븷 �궗�슜�옄 �븘�씠�뵒 
		
		String where = "";	// where �젅�쓣 ���옣�븷 蹂��닔 
		String tmpStr = "";	// 異붽� where�젅�쓣 ���옣�븷 蹂��닔 
		
		
		if(wtype.equals("cosDel")) {	
			where = " where pm_id = '" + pmid + "' and ";	// 肄붿뒪 ���옣 where�젅 
			String[] arrIdx = cnpidxs.split(",");			// �꽑�깮�맂 肄붿뒪  cnpidxs瑜� "," 援щ텇�옄濡� �옒�씪 arrIdx�뿉 ���옣  
			
			for(int i = 0; i < arrIdx.length; i++) {
				tmpStr += " or cs_idx = " + arrIdx[i];
			}
			where += " (" + tmpStr.substring(4) + ") ";
			
		}else if(wtype.equals("plsDel")) {
			where = " where pm_id = '" + pmid + "' and ";	// �옣�냼 ���옣 where�젅 
			String[] arrIdx = cnpidxs.split(",");			// �꽑�깮�맂 �옣�냼 cnpidxs瑜� "," 援щ텇�옄濡� �옒�씪 arrIdx�뿉 ���옣  
			
			for(int i = 0; i < arrIdx.length; i++) {
				tmpStr += " or ps_idx = " + arrIdx[i];
			}
			where += " (" + tmpStr.substring(4) + ") ";
		}
		
		String url = "";
		if(wtype.equals("plsDel") || wtype.equals("cosDel")) {
			url = "saved_list.sav";
		}else if(wtype.equals("plsIn")) {
			url = "place_view.pla";
		}else if(wtype.equals("cosIn")) {
			url = "course_view.cou";
		}
		
		SavedProcSvc savedProcSvc = new SavedProcSvc();
		int result = savedProcSvc.saveProc(wtype, where, cnpid, pmid);
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		out.println(result);
		out.close();
		
		String isChk = "&";
		isChk += wtype.substring(0, 1).equals("c") ? "ci" : "pi";
		
		String args = "?cpage=" + request.getParameter("cpage") + "&psize=" + request.getParameter("psize") + isChk +"id="+cnpid;
		String keyword	= request.getParameter("keyword");	if (!isEmptyStr(keyword))	args += "&keyword=" + keyword;
		String bcata	= request.getParameter("bcata");	if (!isEmptyStr(bcata))		args += "&bcata=" + bcata;
		String scata	= request.getParameter("scata");	if (!isEmptyStr(scata))		args += "&scata=" + scata;
		String brand	= request.getParameter("brand");	if (!isEmptyStr(brand))		args += "&brand=" + brand;
		String sprice	= request.getParameter("sprice");	if (!isEmptyStr(sprice))	args += "&sprice=" + sprice;
		String eprice	= request.getParameter("eprice");	if (!isEmptyStr(eprice))	args += "&eprice=" + eprice;
		String sort		= request.getParameter("sort");		if (!isEmptyStr(sort))		args += "&sort=" + sort;
		

		ActionForward forward = new ActionForward();
		forward.setRedirect(true);
		System.out.println("saved proc act url : /kosmoa/" + url + args);
		forward.setPath(url+ args);
		//forward.setPath("my_saved_course_place_list.jsp" + args);
		
		return forward;
		}
	
	private boolean isEmptyStr(String str) {
		boolean isEmpty = false;
		if (str == null || str.equals(""))	isEmpty = true;
		return isEmpty;
	}
}