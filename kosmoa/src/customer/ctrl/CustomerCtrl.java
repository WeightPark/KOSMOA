package customer.ctrl;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import customer.act.*;
import customer.vo.*;
import vo.*;
import act.*;

@WebServlet("*.cus")
public class CustomerCtrl extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public CustomerCtrl() {
        super();
    }

    public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	request.setCharacterEncoding("utf-8");
    	String requestUri = request.getRequestURI();
    	String contextPath = request.getContextPath();
    	String command = requestUri.substring(contextPath.length());
    	
    	ActionForward forward = null;
    	Action action = null;
    	
    	switch (command) {
    	// QnA 관련
		case "/qna_list.cus" :			// QnA 목록 화면 요청
			action = new QnaListAct();
			break;
		case "/qna_view.cus" :			// QnA 상세 화면 요청
			action = new QnaViewAct();
			break;
		case "/qna_in_form.cus" :		// QnA 질문 등록 화면 요청
			action = new QnaInAct();
			break;
		case "/qna_reply_form.cus" :	// QnA 답변 등록 화면 요청
			action = new QnaReplyAct();
			break;
			
		// 장소 문의(개인-기업) 관련
		case "/reply_in_form.cus" :		// 문의(개인-기업) 답변 등록 화면 요청
			action = new ReplyInAct();
			break;
		case "/reply_list.cus" :		// 문의(개인-기업) 목록 화면 요청
			action = new ReplyListAct();
			break;
		case "/reply_view.cus" :		// 문의(개인-기업) 상세 화면 요청
			action = new ReplyViewAct();
			break;
			
		// FAQ 관련
		case "/faq_list.cus" :			// FAQ 목록 화면 요청
			action = new FaqListAct();
			break;
		case "/faq_in.cus" :			// FAQ 등록 화면 요청
			action = new FaqInAct();
			break;
			
		// 공지사항 관련
		case "/notice_list.cus" :		// 공지 게시판 목록 화면 요청
			action = new NoticeListAct();
			break;
		case "/notice_view.cus" :		// 공지 게시판 상세 화면 요청
			action = new NoticeViewAct();
			break;
		case "/notice_in_form.cus" :	// 공지 게시판 등록 화면 요청
			action = new NoticeInAct();
			break;
		case "/notice_up_form.cus" :	// 공지 게시판 수정 화면 요청
			action = new NoticeUpAct();
			break;
			
		// 신고 관련
		case "/report_in.cus" :			// 신고 화면 요청
			action = new ReportInAct();
			break;	
		case "/report_list.cus" :		// 신고 목록 화면 요청
			action = new ReportListAct();
			break;
		case "/report_view.cus" :		// 신고 상세보기 화면 요청
			action = new ReportViewAct();
			break;
		}
    	
    	try {
    		forward = action.execute(request, response);
    		// 처리 및 실행 후 이동할 경로와 방법을 받아온다.
    	} catch (Exception e) {
			e.printStackTrace();
		}
    	
    	if (forward != null) {
    		if (forward.isRedirect()) {
    			response.sendRedirect(forward.getPath());
    		} else {
				RequestDispatcher dispatcher = request.getRequestDispatcher(forward.getPath());
				dispatcher.forward(request, response);
			}
    	}
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

}
