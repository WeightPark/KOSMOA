<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="header_admin.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
.txtRed { color: red; }

.wrapper { padding-top: 90px; }

.loginBox { 
    width: 800px; height: 650px;
    margin-top:60px; margin-left: 80px;
    margin: 0 auto;
}

.reserve-tool {
    width: 800px; height: 780px;
    border: 1px solid black; text-align: center;
}
.button-box { margin-top: 50px; }
.btn { width: 100px; height: 40px; }

#searchBox { width: 700; text-align: center; margin-top: 50px; }
#searchBox input,  #searchBox select { margin-left: 10px;  }

#txtToday { background-color: #efefef; }

#loginBox {		/* 로그인 폼안에 요소들을 감싸는 div */  
	border: 1px solid black;		
	width: 450px;
	height: 380px;
	padding-top: 50px;
	text-align: center;
	margin: 120px auto 0 auto;
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

<div class="wrapper">
        <div class="loginBox">
            <div id="loginBox" >
            <h2>관리자 로그인</h2>
			<form name="frmLogin" action="/kosmoa/alogin" method="post">
			<input type="hidden" name="url" value="" />
				<!-- 아이디 박스 -->
				<div>	
					<input type="text" class="textBox" name="uid" placeholder="아이디" value="a01"/>
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
    </div>
</div>
</body>
</html>