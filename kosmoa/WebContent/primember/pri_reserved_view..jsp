<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
</head>
<style>
	#my-resv-pop { width:600px; height:700px; margin:0 auto; }

	.my-info-list { display:inline-block; width:170px; height:80px; text-align:center; }
	.my-info-view { display:inline-block; width: 300px; height:80px; text-align:center; }
	.block { width:300px; height:20px; display:inline-block;  }
	 .resv-wrap{ width: width:310px; height:100x; }
	 #resv-place { float:left; }
	 #btn-wrap { text-align:left; width:600px; }
	 #btn2 { margin-left:120px; margin-right:40px; width:80px; }
</style>
<body>
<div id="my-resv-pop">
	<p class="resv-wrap">
		<span class="my-info-list">결제번호</span> <span class="my-info-view">12345</span>
	</p>
	<p class="resv-wrap">
		<span class="my-info-list">코스명/장소명</span> <span class="my-info-view">가을 춥다</span>
	</p>
	<p class="resv-wrap">
		<span class="my-info-list">예약일시</span> <span class="my-info-view">2021-11-01</span>
	</p>
	<p class="resv-wrap">
		<span class="my-info-list" id="resv-place"> 예약한 장소</span> 
		<span class="my-info-view"> 
			<span class="block">장소 : 시간</span>
			<span class="block">장소 : 시간</span>
			<span class="block">장소 : 시간</span>
		</span>
	</p>
	<p id="btn-wrap">
		<input type="button" id="btn2" name = "resvChk" value="확인" />
		<input type="button"  name="wReview" value="후기 남기기" />
	</p>
</div>
</body>
</html>