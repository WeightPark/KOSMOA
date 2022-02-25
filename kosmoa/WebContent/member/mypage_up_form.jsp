<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@include file="/inc/header_nav.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
if (!isLogin) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}

Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);		// 올해 연도
int month = today.get(Calendar.MONTH) + 1;	// 현재 월
int day = today.get(Calendar.DATE);			// 오늘 일 
int lastDay = today.getActualMaximum(Calendar.DATE);	// today의 말일 

String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"};
String[] arrPhone = memberInfo.getPm_phone().split("-");
String[] arrEmail = memberInfo.getPm_mail().split("@");

%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<style> 
.wrapper { padding-top: 150px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }

/* 네비 영역 */

#left-navi { 
padding: 20px;
width:270px; height:400px;
border:1px solid black;
border-radius : 30px;
margin:0 auto;
}
#left-navi li { padding: 5px; }

/* 수정 등록 폼  */
#wrapperBox {
	width: 800px;
	height: 700px;
	margin: 0 auto;
}

table {
	margin: 0 auto;
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

table strong {
	color: red;
}

select {
	height: 28px;
}
.fontRed {
	color: red;
	font-weight:bold;
}
.fontBlue {
	color: blue;
	font-weight:bold;
}
#btn input {
	width: 200px;
	height: 40px;
	border: 1px solid black;
}
.txtBold { font-weight: bold; }
</style>
<script src="js/date_change.js"></script>
<script src="js/jquery-3.6.0.js"></script>
<script>
function setDomain(domain){
	var e3 = document.frmJoin.e3;
	if(domain=="direct"){
		e3.value =""; e3.focus();
	}else{
		e3.value = domain;
	}
}

function chkPw(chkpwd){
	var pwd = document.frmJoin.pwd.value;
	var msg = "";
	if (pwd == chkpwd){
		msg = "<p class='fontBlue'>비밀번호가 일치합니다.</p>";
	}else if(chkpwd.length > 0 && pwd.value != chkpwd) {
		msg = "<p class='fontRed'>비밀번호가 일치하지 않습니다.</p>";
	}else {
		msg = "<p>비밀번호를 한번 더 입력해주세요.</p>";
	}
	
	document.getElementById("pwMsg").innerHTML = msg;
}

function isUp() {
	var chpwd 	= document.getElementById("chpwd");
	var pwd 	= document.getElementById("pwd");
	var nikname = document.getElementById("nikname");
	var p2 		= document.getElementById("p2");
	var p3 		= document.getElementById("p3");
	var email 	= document.getElementById("email");
	var domain 	= document.getElementById("domain");
	
	var pwReg = /^[A-Za-z0-9]{6,16}$/;
	var koReg = /^[ㄱ-ㅎ가-힣]{1,6}$/;
	var enReg = /^[a-zA-z]{1,12}$/;
	

	if (!pwReg.test(pwd.value)) {   // 비밀번호 유효성검사 
		alert("비밀번호는 6 ~ 16자 이하의 영문과 숫자만 가능합니다.");
		return false;
	}
	
	if (pwd.value != chpwd.value) { // 비밀번호 유효성검사 
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if(!(koReg.test(nikname.value) || enReg.test(nikname.value))){ // 닉네임 한글 유효성 검사
		alert("닉네임은 한글이나 영문으로만 작성가능합니다.\n한글은 6자이내, 영문은 12자이내로 가능합니다.");
		return false;
	}

	if(name.value == ""){		// 닉네임 빈문자 유효성 검사
		alert("닉네임을 입력하세요.");
		return false;
	}
	
	if(p2.value == "" || p3.value == ""){ 	// 전화번호 유효성 검사 
		alert("전화번호를 입력해주세요.");
		return false;
	}
	
	if(email.value == "" || domain.value == ""){ 	// 이메일 유효성 검사 
		alert("이메일을 확인해주세요.");
		return false;
	}
	
	document.frmJoin.submit();
}
</script>
<title>Insert title here</title>
</head>
<body>
<div class="wrapper">
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
<!-- 수정 등록 영역 -->
<div id="wrapperBox">
<form name="frmJoin" action="member_up_proc.mem" method="post">
<input type="hidden" name="mtype" value="pri" />
<input type="hidden" name="pm_id" value="<%=memberInfo.getPm_id() %>" />
<input type="hidden" name="idChk" value="n" id="idChk" />

	<table width="550" height="600" cellpadding="5" id="joinBrd">
	<tr >
		<th width="25%"><strong>*</strong> ID</th>
		<td width="*">
			<%=memberInfo.getPm_id() %>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 비밀번호</th>
		<td>
			<input type="password" name="pm_pwd" id="pwd" maxlength="16" value="<%=memberInfo.getPm_pwd() %>"/>
			<p>6문자 이상 16문자 이하의 영문과 숫자 조합으로 기입해 주십시요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 비밀번호 확인</th>
		<td>
			<input type="password" id="chpwd" name="pm_ispwd" value="<%=memberInfo.getPm_pwd() %>" onkeyup="chkPw(this.value)"/>
			<p id="pwMsg">비밀번호를 한번 더 입력해주세요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 이름</th>
		<td>
			<%=memberInfo.getPm_name() %>
		</td>
	</tr>
	<tr>
		<th>&nbsp;&nbsp;닉네임</th>
		<td>
			<input type="text" name="pm_nikname" id="nikname" maxlength="20" value="<%=memberInfo.getPm_nikname() %>"/>
			<p>공백 및 특수문자를 제외한 한글 6자 이내 또는 영문 12자 이내로 작성해 주십시요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 전화번호</th>
		<td>
			<select name="p1">
				<option value="010" <%if(arrPhone[0] == "010") { %> selected="selected"<% } %>>010</option>
				<option value="011" <%if(arrPhone[0] == "011") { %> selected="selected"<% } %>>011</option>
				<option value="016" <%if(arrPhone[0] == "016") { %> selected="selected"<% } %>>016</option>
				<option value="019" <%if(arrPhone[0] == "019") { %> selected="selected"<% } %>>019</option>
			</select> -
			<input type="text" name="p2" id="p2" value="<%=arrPhone[1] %>" size="4" maxlength="4" /> - 
			<input type="text" name="p3" id="p3" value="<%=arrPhone[2] %>" size="4" maxlength="4" />
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 이메일</th>
		<td>
			<input type="text" id="email" name="e1" size="10" value="<%=arrEmail[0] %>"/> @ 
			<select name="e2"  onchange="setDomain(this.value);">
				<option value="" >도메인 선택 </option>
			<% for (int i = 0; i < arrDomain.length; i++){ %>
				<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<% } %>
				<option value="direct">직접 입력 </option>
			</select>
			<input type="text" name="e3" id="domain" size="10" value="<%=arrEmail[1] %>"/>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 광고 수신</th>
		<td>
			<input type="radio" name="pm_isad" value="y" id="adY" 
			<%if(memberInfo.getPm_isad().equals("y")){ %>checked="checked"<% } %>/>
			<label for="adY">수신</label>
			<input type="radio" name="pm_isad" value="n" id="adN" 
			<%if(memberInfo.getPm_isad().equals("n")){ %>checked="checked"<% } %>/>
			<label for="adN">미수신</label>
		</td>
	</tr>
	</table>
<div id="btn">
	<input type="button" value="수정하기" onclick="isUp();"/>
</div>
</form>
</div>
</div>
</div>
</body>
</html>