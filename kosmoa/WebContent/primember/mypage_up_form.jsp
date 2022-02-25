<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
Calendar today = Calendar.getInstance();
int year = today.get(Calendar.YEAR);		// 올해 연도
int month = today.get(Calendar.MONTH) + 1;	// 현재 월
int day = today.get(Calendar.DATE);			// 오늘 일 
int lastDay = today.getActualMaximum(Calendar.DATE);	// today의 말일 

String[] arrDomain = {"naver.com", "nate.com", "gmail.com", "daum.net", "yahoo.com"};
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="reset.css" />
<style>
#my-info-manage { 
		display:flex;
		margin-top : 120px;
		width:1200px; height:1600px;
} 
/* 네비 영역 */

#left-navi { 
		width:300px; height:1500px;
		border:1px solid black;
		border-radius : 40px 40px 40px 40px;
		margin-top: 60px; margin-right: 20px; margin-left: 100px;
}
li { margin:40px; }
.li-indent { text-indent: 1em; }

/* 수정 등록 폼  */
#joinBrd { margin-top:60px; margin-left:50px;  border-spacing: 3px 10px;   }
#joinBrd th, #joinBrd td { border-bottom:1px solid black; vertical-align: top; }
.fontBlue { color:blue; font-weight:bold; }
.fontRed { color:red; font-weight:bold; }


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
</script>
<title>Insert title here</title>
</head>
<body>
<div id="my-info-manage">
	<div id="left-navi">	<!-- 왼쪽 네비 영역 -->
	<ul>
		<li>정보 보기</li>
			<ul><li class="li-indent">- 내 정보 보기</li></ul>
		<li>예약 관리</li>
			<ul><li class="li-indent">- 예약 현황</li></ul>
		<li>후기 및 댓글 관리</li>
			<ul><li class="li-indent">- 내가 쓴 후기</li></ul>
			<ul><li class="li-indent">- 내가 쓴 댓글</li></ul>
		<li>저장된 코스 및 장소 관리</li>
		<li> 내 코스 관리 </li>
	</ul>
	</div>
<div id="jointable">
<form name="frmUpdate" method="post">	
<table width="600px" id="joinBrd" >
	<tr>
		<th>프로필 사진</th>
		<td> <input type="file" value="파일선택" />
			<p>jpg, png, jpeg, gif 형식의 최대 300*300 사이즈, 500KB 크기의 사진만 업로드</p>
		</td>
	</tr>
	<tr>
	<th width="20%">아이디</th>
	<td width ="*">
		아이디 
	</td>
	</tr>
	<tr ><th>비밀번호 변경</th><td><input type="password" name="mi_pw1" /></td></tr>
	<tr><th>비밀번호확인</th><td><input type="password" name="mi_pw2" /></td></tr>
	<tr><th>닉네임</th><td><input type="text" name="mi_name" /> <input type="button" name="DupId" value="중복체크" /></td></tr>
	<tr>
	<th>이름</th>
	<td>
		호우길동
	</td>
	</tr>
	<tr>
	<th>이메일</th>
	<td>
		<input type="text" name="e1" size="10" /> @
		<select name="e2" onchange="setDomain(this.value);">
			<option value="">도메인선택</option>
	<% for(int i=0; i<arrDomain.length; i++ ) { %>
			<option value="<%=arrDomain[i] %>" ><%=arrDomain[i] %></option>
	<% } %>
			<option value="direct">직접입력</option>
		</select>
		<input type="text" name="e3" size="10" />
	</td>
	</tr>
	<tr>
	<th>전화번호</th>
	<td>
		<select name="p1">
			<option value="010">010</option>
			<option value="011">011</option>
			<option value="016">016</option>
			<option value="019">019</option>
		</select> - 
		<input type="text" name="p2" size="4" maxlength="4" /> - 
		<input type="text" name="p3" size="4" maxlength="4" />
	</td>
	</tr>
</table>
<p style="width:700px; text-align:center;" >
	<input type="submit" value="수정하기" />
	<input type="reset" value="다시입력" />
</p>
</form>
</div>
</div>




</body>
</html>