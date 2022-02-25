<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="course.vo.*"%>
<%@ include file="../inc/header_nav.jsp" %>
<%
CourseInfo course = (CourseInfo)session.getAttribute("course");
// 현재 로그인한 회원의 정보들을 추출하도록 MemberInfo형 인스턴스로 세션내의 정보를 생성

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#courseCou th, #courseCou td { border-bottom:1px solid black; }
.fontBlue { color:blue; font-weight:bold; }
.fontRed { color:red; font-weight:bold; }
#my-resv-pop { width:380px; height:700px; margin: 150px 0 0 800px; }
.resv-wrap{ width: width:350px; height:100x; margin: 0, auto; text-align: center;}
#btn-wrap { margin:20px 0 0 300px; text-align:left; width:350px; }
</style>
</head>
<body>
<h2>코스 정보 수정 폼</h2>
<form name="CourseUpdate" action="course_proc.cou" method="post">
<input type="hidden" name="wtype" value="up" />
<div id="my-resv-pop">
	<div class="resv-wrap">
		<table width="700" cellpadding="5" cellspacing="0" id="courseCou">
			<tr>
			<th width="20%">코스 아이디</th><td width="30%"><%=course.getCi_id() %></td>
			<th width="20%">코스 이름</th><td width="30%"><%=course.getCi_name() %></td>
			</tr>
			<tr>
			<th>대표 이미지</th><td><%=course.getCi_img() %></td>
			</tr>
			<tr>
			<th>예상 소요 시간</th><td><%=course.getCi_time() %></td>
			</tr>
			<tr>
			<th>코스 설명</th><td><%=course.getCi_desc() %></td>
			</tr>
			<tr>
			<th>공개 여부</th><td><%=course.getCi_isview() %></td>
			</tr>
			<tr>
			<th>태그 아이디</th><td><%=course.getCi_st_id() %></td>
			</tr>
			<tr>
			<th>태그 이름</th><td><%=course.getCi_st_name() %></td>
			</tr>
			<tr>
			<th>키워드 아이디</th><td><%=course.getCi_sk_id() %></td>
			</tr>
			<tr>
			<th>키워드 이름</th><td><%=course.getCi_sk_name() %></td>
			</tr>
			<tr>
			<th>등록한 관리자</th><td><%=course.getAi_idx() %></td>
			</tr>
		</table>
		</div>
		<div id="btn-wrap">
			<input type="submit" value="정보 수정" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" value="다시 입력" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="button" value="메인 화면" onclick="location.href='../main.jsp';" />
		</div>
	</div>
</form>
<br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</body>
</html>
