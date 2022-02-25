<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ include file="../inc/header_nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
.wrapper { padding-top: 150px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }

/* 왼쪽 네비 영역   */
#left-navi { 
padding: 20px;
width:270px; height:400px;
border:1px solid black;
border-radius : 30px;
margin: 0 auto; 
}
#left-navi li { padding: 5px; }
	
/* 내 개인정보 영역  */
#wrapperBox {
	width: 800px; height: 700px;
    margin-top:30px; margin-left: 80px;
    margin: 0 auto;
}

table {
	margin: 0 auto 0 auto;
	border: 2px solid #afb2b5;
	border-collapse: collapse;
}
table th {
 	border: 2px solid #afb2b5;
	font-size: 0.9em;
	text-align: center;
}
table td {
	border: 2px solid #afb2b5;
	padding-left: 10px;
}

p {
	font-size: 0.6em;
	margin: 5px 0 0 0;
	padding: 0;
}

#btn {
	width: 550px;
	margin: 10px auto 0 auto;
	text-align: center;
}

input[type="submit"] {
	margin-top: 15px;
	background: #8be7f4;
	color: #292929;
	border: 1px solid #afb2b5;
	width: 200px;
	height: 50px;
}

select {
	height: 28px;
}
#btn input {
	width: 200px;
	height: 40px;
	border: 1px solid black;
}
.txtBold { font-weight: bold; }
</style>
	
</head>
<body>
<div class="wrapper">	<!-- 왼쪽 네비와 본문 영역을 담을 wrapper   -->
	<div class="innerWrapper">
	<div id="left-navi">	<!-- 왼쪽 네비 영역 -->
	<ul>
		<li>정보 보기</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><li class="li-indent txtBold">내 정보 보기</li></ul>
		<li>예약 관리</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><a href="member_reserve_list.mem"><li class="li-indent">예약 현황</li></a></ul>
		<a href="saved_list.sav"><li class="menu">저장된 코스 및 장소 관리</li></a>
		<a href="my_review_list.riv"><li class="menu">내가 쓴후기</li></a>
		<a href=""><li class="menu">문의 내역</li></a>
	</ul>
	</div>
	<div id="wrapperBox">
		<table width="550" height="600" cellpadding="5" id="joinBrd">
		<tr >
			<th width="25%"><strong>ID</strong></th>
			<td width="*">
				<%=memberInfo.getPm_id() %>
			</td>
		</tr>
		<tr>
			<th><strong>이름</strong></th>
			<td>
				<%=memberInfo.getPm_name() %>
			</td>
		</tr>
		<tr>
			<th>&nbsp;&nbsp;<strong>닉네임</strong></th>
			<td>
				<%=memberInfo.getPm_nikname() %>
			</td>
		</tr>
		<tr>
			<th><strong> 전화번호 </strong></th>
			<td>
				<%=memberInfo.getPm_phone() %>
			</td>
		</tr>
		<tr>
			<th><strong> 이메일 </strong></th>
			<td>
				<%=memberInfo.getPm_mail() %>
			</td>
		</tr>
		<tr>
			<th> 광고 수신 여부</th>
			<td>
			<% if(memberInfo.getPm_isad().equals("y")){ %>
			 광고 수신 
			<% }else{ %>
			광고 미수신 
			<% } %>
			</td>
		</tr>
		</table>
<div id="btn">
	<input type="button" value="수정하기" onclick="location.href='/kosmoa/mypage_up_form.mem';"/>
</div>
</div>
</div>
</div>
</body>
</html>