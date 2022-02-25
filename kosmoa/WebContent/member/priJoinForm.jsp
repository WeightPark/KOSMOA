<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="/inc/header_nav.jsp" %>
<%
request.setCharacterEncoding("utf-8");
if (isLogin) {	// 로그인 확인 여부 
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
int lastDay = today.getActualMaximum(Calendar.DATE); // today의 말일 
// 처음 파일이 열릴 때 마지막일을 제대로 설정하려고 사용하는 변수 

String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com" };
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Insert title here</title>
<style>
#wrapperBox {
	width: 600px;
	height: 750px;
	margin: 0 auto;
}
table, th, td {
  border: 2px solid #afb2b5;
  border-collapse: collapse;
}
table {
	margin: 180px auto 0 auto;
}
table th {
	font-size: 0.9em;
	text-align: center;
}
table td {
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

#btn input {
	width: 200px;
	height: 40px;
	border: 1px solid black;
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
	font-size: 1em;
}
.fontBlue {
	color: blue;
	font-weight:bold;
	font-size: 1em;
}
</style>
<script src="/kosmoa/js/date_change.js" ></script>
<script src="/kosmoa/js/jquery-3.6.0.js" ></script>
<script>
// 이메일 도메인 선택시 e3에 값 넣어주는 함수 
function setDomain(domain){ 
	var e3 = document.frmJoin.e3;
	if(domain == "direct"){
		e3.value = "";
		e3.focus();
	}else {
		e3.value = domain;
	}
}

// 아이디 중복확인 함수
function chkDupId(uid){						// 하나의 페이지를 더 요청하는 방식을 jq로 구현 
	if (uid.length >= 4 ){ 					// 사용자가 입력한 id가 4자 이상일 경우 
		$.ajax({
			type : "POST", 					// 데이터 전송 방법
			url : "/kosmoa/dupId",			// 데이터를 받을 서버의 URL로 컨트롤러(서블릿)를 의미
			data : {"uid" : uid},			// 지정한 url로 보낼 데이터의 이름 및 값 
			success : function(chkRs){ 		// 데이터를 보내어 실행한 결과를 chkRs로 받아 옴, 쿼리 성공?
				var msg ="";				// 사용자에게 보여줄 메시지를 저장할 변수
			
				if (chkRs==0){				// uid와 동일한 회원 아이디가 없으면(사용할 수 있는 아이디 이면)
					msg="<p class='fontBlue'>사용하실 수 있는ID입니다 </p>";
					$("#idChk").val("y");	// y인 경우에만 회원가입을 시켜주면 됨 
				}else {						// uid와 동일한 회원 아이디가 있으면(사용 불가능한 아이디 이면)
					msg="<p class='fontRed'>이미 사용중인ID입니다.</p>";
					$("#idChk").val("n");
				}
				document.getElementById("idMsg").innerHTML = msg;
			}
		});
	} else {	
		document.getElementById("idMsg").innerHTML = "아이디는 4~20 자로 입력하세요";
		$("#idChk").val("n");
	}
}

// 작성한 비밀번호가 비밀번호 확인이랑 일치하는지 확인하는 함수 
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

// 자바로 데이터를 보내기전에 입력된 데이터 유효성 검사 
function isJoin() {
	var isuid 	= document.getElementById("idChk");
	var uid 	= document.getElementById("uid");
	var chpwd 	= document.getElementById("chpwd");
	var pwd 	= document.getElementById("pwd");
	var name 	= document.getElementById("name");
	var nikname = document.getElementById("nikname");
	var p2 		= document.getElementById("p2");
	var p3 		= document.getElementById("p3");
	var email 	= document.getElementById("email");
	var domain 	= document.getElementById("domain");
	
	var idReg = /^[A-Za-z0-9]{4,20}$/;
	var pwReg = /^[A-Za-z0-9]{6,16}$/;
	var koReg = /^[ㄱ-ㅎ가-힣]{1,6}$/;
	var enReg = /^[a-zA-z]{1,12}$/;
	
	if (!idReg.test(uid.value)) { 	// 아이디 유효성검사 
		alert("아이디는 4 ~ 20자 이하의 영문과 숫자만 가능합니다.");
		return false;
	}
	
	if (isuid.value == "n" ) {	 	// 아이디 유효성검사 
		alert("중복된 아이디 입니다.");
		return false;
	}

	if (!pwReg.test(pwd.value)) {   // 비밀번호 유효성검사 
		alert("비밀번호는 6 ~ 16자 이하의 영문과 숫자만 가능합니다.");
		return false;
	}
	
	if (pwd.value != chpwd.value) { // 비밀번호 유효성검사 
		alert("비밀번호가 일치하지 않습니다.");
		return false;
	}
	
	if(name.value == ""){			// 이름 유효성 검사
		alert("이름을 입력하세요.");
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
</head>
<body>
<!-- 로그인 폼 작성 영역 -->
<div id="wrapperBox">
<form name="frmJoin" action="member_in_proc.mem" method="post">
<input type="hidden" name="idChk" value="n" id="idChk" />

	<table width="550" height="600" cellpadding="5" id="joinBrd">
	<tr >
		<th width="25%"><strong>*</strong> ID</th>
		<td width="*">
			<input type="text" id="uid" name="pm_id" maxlength="20" onkeyup="chkDupId(this.value)"/>
			<p id="idMsg" style="font-size:80%;">아이디는 4~20자 이내 영문과 숫자만 입력하세요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 비밀번호</th>
		<td>
			<input type="password" name="pm_pwd" id="pwd" maxlength="16" value="wjsdndud123"/>
			<p>6문자 이상 16문자 이하의 영문과 숫자 조합으로 기입해 주십시요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 비밀번호 확인</th>
		<td>
			<input type="password" id="chpwd" name="pm_ispwd" onkeyup="chkPw(this.value)"/>
			<p id="pwMsg">비밀번호를 한번 더 입력해주세요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 이름</th>
		<td>
			<input type="text" name="pm_name" id="name" value="전우영"/>
		</td>
	</tr>
	<tr>
		<th>&nbsp;&nbsp;닉네임</th>
		<td>
			<input type="text" name="pm_nikname" id="nikname" maxlength="20" value="코딩머신"/>
			<p>공백 및 특수문자를 제외한 한글 6자 이내 또는 영문 12자 이내로 작성해 주십시요.</p>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 전화번호</th>
		<td>
			<select name="p1">
				<option value="010" selected="selected">010</option>
				<option value="011">011</option>
				<option value="016">016</option>
				<option value="019">019</option>
			</select> -
			<input type="text" name="p2" id="p2" size="4" maxlength="4" value="1234"/> - 
			<input type="text" name="p3" id="p3" size="4" maxlength="4" value="4567"/>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 이메일</th>
		<td>
			<input type="text" id="email" name="e1" size="10" value="jeonwooyoung"/> @ 
			<select name="e2"  onchange="setDomain(this.value);">
				<option value="" >도메인 선택 </option>
			<% for (int i = 0; i < arrDomain.length; i++){ %>
				<option value="<%=arrDomain[i] %>"><%=arrDomain[i] %></option>
			<% } %>
				<option value="direct">직접 입력 </option>
			</select>
			<input type="text" name="e3" id="domain" size="10"/>
		</td>
	</tr>
	<tr>
		<th><strong>*</strong> 광고 수신</th>
		<td>
			<input type="radio" name="pm_isad" value="y" id="adY" checked="checked"/>
			<label for="adY">수신</label>
			<input type="radio" name="pm_isad" value="n" id="adN" />
			<label for="adN">미수신</label>
		</td>
	</tr>
	</table>
<div id="btn">
	<input type="button" value="회원가입" onclick="isJoin();"/>
</div>
</form>
</div>
</body>

</html>