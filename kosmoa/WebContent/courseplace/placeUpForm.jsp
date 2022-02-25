<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="place.vo.*"%>
<%@ include file="../inc/header_nav.jsp" %>
<%
PlaceInfo place = (PlaceInfo)session.getAttribute("place");
// 장소 정보들을 추출하도록 PlaceInfo형 인스턴스로 세션내의 정보를 생성

String[] phones = place.getPi_phone().split("-");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#placePla th, #placePla td { border-bottom:1px solid black; }
.fontBlue { color:blue; font-weight:bold; }
.fontRed { color:red; font-weight:bold; }
#my-resv-pop { width:380px; height:700px; margin: 150px 0 0 800px; }
.resv-wrap{ width: width:350px; height:100x; margin: 0, auto; text-align: center;}
#btn-wrap { margin:20px 0 0 300px; text-align:left; width:350px; }
</style>
</head>
<body>
<h2>장보 정보 수정 폼</h2>
<form name="PlaceUpdate" action="place_Up.pla" method="post">
<input type="hidden" name="wtype" value="up" />
<div id="my-resv-pop">
	<div class="resv-wrap">
		<table width="700" cellpadding="5" cellspacing="0" id="placePla">
			<tr>
			<th width="20%">장소 번호</th><td width="*%"><%=place.getPi_id() %></td>
			<th width="20%">장소 이름</th><td width="*%"><%=place.getPi_name() %></td>
			</tr>
			<tr>
			<th>장소 대분류</th><td><%=place.getPi_bigcata() %></td>
			</tr>
			<tr>
			<th>장소 소분류</th><td><%=place.getPi_smallcata() %></td>
			</tr>
			<tr>
			<th>장소 태그</th><td><%=place.getSt_id() %></td>
			</tr>
			<tr>
			<th>장소 검색어</th><td><%=place.getSt_name() %></td>
			</tr>
			<tr>
			<th>대표 이미지</th><td><%=place.getPi_img1() %></td>
			</tr>
			<tr>
			<th>이미지2(선택)</th><td><%=place.getPi_img2() %></td>
			</tr>
			<tr>
			<th>이미지3(선택)</th><td><%=place.getPi_img3() %></td>
			</tr>
			<tr>
			<th>이미지4(선택)</th><td><%=place.getPi_img4() %></td>
			</tr>
			<tr>
			<th>장소 설명</th><td><%=place.getPi_desc() %></td>
			</tr>
			<tr>
			<th>장소 설명 이미지(선택)</th><td><%=place.getPi_descimg() %></td>
			</tr>
			<tr>
			<th>전화번호</th>
			<td colspan="3">
				<select name="p1">
					<option value="02" <% if (phones[0].equals("02")) { %>selected="selected"<% } %>>02</option>
					<option value="010" <% if (phones[0].equals("010")) { %>selected="selected"<% } %>>010</option>
					<option value="011" <% if (phones[0].equals("011")) { %>selected="selected"<% } %>>011</option>
					<option value="016" <% if (phones[0].equals("016")) { %>selected="selected"<% } %>>016</option>
					<option value="019" <% if (phones[0].equals("019")) { %>selected="selected"<% } %>>019</option>
				</select> -
				<input type="text" name="p2" size="4" maxlength="4" value="<%=phones[1] %>" /> -
				<input type="text" name="p3" size="4" maxlength="4" value="<%=phones[2] %>" />
			</td>
			</tr>
			<tr>
			<th>운영 시간</th><td><%=place.getPi_time() %></td>
			</tr>
			<tr>
			<th>제공 서비스</th><td><%=place.getPi_service() %></td>
			</tr>
			<tr>
			<th>수용 가능 인원 </th><td><%=place.getPi_person() %></td>
			</tr>
			<tr>
			<th>예약 가능 여부</th><td><%=place.getPi_isr() %></td>
			</tr>
			<tr>
			<th>메인 여부</th><td><%=place.getPi_ismain() %></td>
			</tr>
			<tr>
			<th>우편 번호</th><td><%=place.getPi_zip() %></td>
			</tr>
			<tr>
			<th>주소</th><td><%=place.getPi_addr1() %></td>
			</tr>
			<tr>
			<th>상세 주소</th><td><%=place.getPi_addr2() %></td>
			</tr>
			<tr>
			<th>지역</th><td><%=place.getPi_area() %></td>
			</tr>
			<tr>
			<th>해당 키워드 아이디</th><td><%=place.getSk_id() %></td>
			</tr>
			<tr>
			<th>등록한 관리자</th><td><%=place.getAi_idx() %></td>
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
