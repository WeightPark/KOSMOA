<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" type="text/css" href="reset.css" />
<title>Insert title here</title>
</head>

<style>

#my-review-manage { 
		display:flex;
		margin-top : 120px;
		width:1200px; height:1600px;

}
/* 좌측 네비 */ 
#left-navi { 
		 width:300px; height:1500px;
		border:1px solid black;
		border-radius : 40px 40px 40px 40px;
		margin-top: 60px; margin-right: 20px; margin-left: 100px;
}
li { margin:40px; }
.li-indent { text-indent: 1em; }

/*본문 내역*/ 
#my-info {
		margin-left: 100px; margin-top : 60px; padding: 30px; text-align:center;
}
th, td { padding:10px; }
</style>
<body>
<div id="my-review-manage">
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
		<table id="my-review-list" cellspacing=10px; width=600px;>
		<tr>
			<th width="10%">번호</th><th width="*">제목</th><th width="20%">분류</th><th width="20%">작성일</th><th width="20%">답변여부</th>
		</tr>
		<tr class="question">
			<td>1</td><td><a href="#">문의한 내역</a></td><td>혹한기 코스</td> <td>2021-11-11</td><td>y</td>
		</tr>	
		<tr class="answer">
			<td>2</td><td><a href="#">re: 답변</a></td><td>혹한기 코스</td> <td>2021-11-11</td><td>y</td>
		</tr>
		
		<tr class="question">
			<td>3</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="answer">
			<td>4</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="question">
			<td>5</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr  class="answer">
			<td>6</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="question">
			<td>7</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="answer">
			<td>8</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="question">
			<td>9</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		<tr class="answer">
			<td>10</td><td><a href="#"> </a></td><td>혹한기 코스</td> <td>2021-11-11</td><td> </td>
		</tr>
		</table>
		<table width="600" cellpadding="5" cellspacing="0">
		<tr>
			<td width="450" align="center">페이징 영역</td><td align="left"><input type="button" name="isdel" value="삭제하기" /></td>
		</tr>
		</table>
	</div>
</div>
</body>
</html>