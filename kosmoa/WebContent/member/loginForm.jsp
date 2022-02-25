<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="member.vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%

request.setCharacterEncoding("utf-8");
String url = request.getParameter("url");
System.out.println("login url : " + url);
if (url == null)	url = "";
// 로그인 후 이동할 페이지 주소로 없는 경우 빈 문자열로 지정
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>KOSMOA 로그인</title>
<style>

#loginBox {		/* 로그인 폼안에 요소들을 감싸는 div */  
	border: 1px solid black;		
	width: 450px;
	height: 280px;
	padding-top: 30px;
	text-align: center;
	margin: 200px auto 0 auto;
}


.textBox {		/* id, pw의 text 박스  */ 
	width: 300px;
	height: 40px;
	margin-top: 10px;
}

input[type="checkbox"] { 	/* 아이디 저장 체크박스 */
	margin-bottom: 6px;
	vertical-align: middle;
}

#snjBox {		/* 아이디 저장, 회원가입 요소를 감싸는 div */ 
	display: flex;
	width:305px;
	margin: 10px auto 0 auto;
	heigth: 50px;
	justify-content: space-between;
}

#saveBox {		/* 아이디 저장 요소들을 감싸는 div */ 
	width: 100px;
	display: inline;
	text-align: left;
	font-size: 0.7em;
}

#joinBox {		/* 회원가입, 아이디찾기, 비밀번호 찾기 감싸는 div */ 
	display: inline;
	width: 200px;
	padding-top: 2px;
	font-size: 0.7em;
	text-align: right;
}

#joinBox a { 
	font-size: 1.1em;
	line-height: 13px; 
	text-decoration: none;
}

#loginBtn{		/* 로그인 버튼을 감싸는 div */ 
	width: 305px;
	height: 50px;
	margin: 40px auto 0 auto;	
}

input[type="submit"] {	/* 로그인 버튼 */ 
	width: 305px;
	height: 45px;
}

</style>
</head>
<body>
<!-- 전체를 감싸는 div -->
<div id="wrapperBox"> 
	<!-- 로그인 폼안에 요소들을 감싸는 div -->
	<div id="loginBox" >
	<form name="frmLogin" action="/kosmoa/login" method="post">
	<input type="hidden" name="url" value="<%=url %>" />
		<!-- 아이디 박스 -->
		<div>	
			<input type="text" class="textBox" name="uid" placeholder="아이디" value="test1"/>
		</div>
		<!-- 비밀번호 박스 -->
		<div>	
			<input type="password" class="textBox" name="pwd" placeholder="비밀번호" value="1234"/>
		</div>
		<!-- 아이디저장, 회원가입을 감싸는 div -->
		<div id="snjBox">	
			<div id="saveBox">
				<input type="checkbox" id="radioBnt" name="saveId" value="saveId"/>
				<label for="radioBnt">아이디저장</label> 
			</div>	
			<div id="joinBox">
				<a href="./priJoinForm.jsp">회원가입</a>
			</div>
		</div>
		<!-- 로그인 버튼을 감싸는 div -->
		<div id="loginBtn">
			<input type="submit" value="로그인" />
		</div>
	</form>
	</div>
</div>
</body>
</html>