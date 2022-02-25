<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
<style>
	body { width:1200px; height:2000px; } 
	#myinfo-wrapper { 
		display:flex;
		margin-top : 120px;
		width:1200px; height:1600px;

	} 
	/* 왼쪽 네비 영역   */
	#left-navi { 
		width:300px; height:1500px;
		border:1px solid black;
		border-radius : 40px 40px 40px 40px;
		margin-top: 60px; margin-right: 20px; margin-left: 100px;
	}
	li { margin:40px; }
	.li-indent { text-indent: 1em; }
	
	/* 내 개인정보 영역  */
	#my-info {
		margin-left: 100px; margin-top : 60px; padding: 30px; text-align:center;
	}

	.my-info-list { display:inline-block; width:170px; height:50px; text-align:left; float:left; }
	.my-info-view { display:inline-block; width: 300px; height:50px; text-align:center; float:left; }

	#my-info-wrapper { width:600px; height:700px; margin: 0 auto; }
	
	span { border:1px solid black; }
	#btn-wrapper { clear:both; width: 500px; height:100px; text-align:Center; padding:20px; }
	</style>
	
</head>
<body>
<div id="myinfo-wrapper">	<!-- 왼쪽 네비와 본문 영역을 담을 wrapper   -->
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

	<div id="my-info">	<!-- 본문 내역  -->
	<div id="my-info-wrapper">
		<p>
			<span class="my-info-list">ID</span> <span class="my-info-view">kosmoa</span>
		</p>
		<p>
			<span class="my-info-list">닉네임</span> <span class="my-info-view">kosmoa</span>
		</p>
		<p>
			<span class="my-info-list">이름</span> <span class="my-info-view">kosmoa</span>
		</p>
		<p>
			<span class="my-info-list">이메일</span> <span class="my-info-view">kosmoa</span>
		</p>
		<p>
			<span class="my-info-list">휴대폰</span> <span class="my-info-view">kosmoa</span>
		</p>
		<p>
			<span class="my-info-list">주소</span> <span class="my-info-view">kosmoa</span>
		</p>
		<div id="btn-wrapper">
			<button onclick = "location.href='mypage_up_form.jsp';">수정하기</button>
		</div>
	</div>
	
</div>

</div>
</body>
</html>