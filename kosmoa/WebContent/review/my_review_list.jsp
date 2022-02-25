<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="review.vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../inc/header_nav.jsp" %>

<%
request.setCharacterEncoding("utf-8");
PreviewPageInfo placeReview = (PreviewPageInfo)request.getAttribute("placeReview");
ArrayList<PlaceReviewInfo> myReview = (ArrayList<PlaceReviewInfo>)request.getAttribute("myReview");

String args = "";
args = "?cpage=" + placeReview.getCpage();
if (placeReview.getKind() != null && !placeReview.getKind().equals("")){
	args +="&kind=" + placeReview.getKind();
}

if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하세요.');");
	out.println("location.href='/kosmoa/member/loginForm.jsp?url=review/my_review_list.jsp?';");
	out.println("</script>");
	out.close();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<Style>
.wrapper { padding-top: 150px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}
#del-btn {
	width:150px;
	height:40px; 
	background:white; 
	border:2px solid orange;
	border-radius:15px;  
	font-size: 0.8em;
}
#del-btn:hover { font-weight:bold; }
#reviewTable { table-layout:fixed; text-align:center; }
#review-content { overflow:hidden; white-space:nowrap; text-overflow:ellipsis; }

#myinfo-wrapper { 
	display:flex;
	margin-top : 150px;
	width:1200px; height:800px;

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

.calendar-box { 
    width: 800px; height:500px;
    margin-top:30px; margin-left: 80px;
    margin: 0 auto;
}
.calendar-box table { margin: 0 auto; }

#tabA, #tabB { 
	display:inline-block;
	width:120px; 
	height:35px;
	line-height:35px;
	text-align:center;
	border:1px solid black;  
	border-radius:15px;
}

#tab { text-align:left; }
#line { border-bottom:3px solid black; }
#allSel { font-size: 0.8em; }
</Style>
<script src="/kosmoa/js/jquery-3.6.0.js"></script>
<script>
function chkAll(all){
	var arrChk = document.frmMyReview.chk;
	// 폼(frmCart) 안에 chk라는 이름의 컨트롤이 여러 개 있으므로 배열로 받아옴
	for (var i=1; i<arrChk.length; i++){
		arrChk[i].checked = all.checked;
	}
}

function getSelectedValues() {
	// chk 체크박스들에서 선택한 체크박스의 값들만 추출하여 문자열로 리턴하는 함수 (삭제와 구매에서 사용됨)
		var arrChk = document.frmMyReview.chk;
		// 문서내의 frmCart 폼 안에 있는 컨트롤들 중 chk라는 이름을 가진 컨트롤들을 배열로 받아옴 (단, chk라는 이름의 컨트롤이 하나 밖에 없으면 배열은 생성되지 않음)
		var idxs = "";	// chk 배열에 추출한 값들을 저장한 변수 
		for( var i=1; i<arrChk.length; i++){
		// 0번 인덱스가 아닌 1번부터 시작하는 이유는 chk라는 이름의 첫번째 컨트롤이 hidden이므로 
			if (arrChk[i].checked)	idxs += "," + arrChk[i].value;	
			// 체크된 체크박스의 value들만 추출하여 idxs에 누적 저장
		}
		return idxs.substring(1);
		// idxs 변수에 누적된 문자열의 맨 앞에 있는 구분자(쉼표)를 제거한 후 리턴시킴
	}

function callDel(idx){
	var isConfirm = false;
	if (idx == 0){	// 선택한 상품(들) 삭제시 (여러 삼품 선택시 여러 개의 oc_idx를 쉼표로 연결하여 문자열 생성, 상품을 하나도 선택하지 않았으면 경고메시지 출력 )
		idx = getSelectedValues();
		// 삭제하려고 선택한 상품들의 oc_idx 값을 받아옴 
		alert(idx);
		if (idx != ""){	// 삭제할 상품들의 인덱스가 있으면
			isConfirm = confirm("선택한 글을  삭제하시겠습니까?");		
		} else {		// 삭제할 상품들의 인덱스가 없으면(선택하지 않은 경우)
			alert("삭제할 글을 하나 이상 선택하세요.");
		}
	} else {		// 특정 상품 삭제시
		alert(idx);
		isConfirm = confirm("선택한 상품을 장바구니에서 삭제하시겠습니까?");
	}
	if(isConfirm){
		$.ajax({
			type : "POST", 				
			url : "/kosmoa/member/my_review_list.riv<%=args%>",		
			data : { "wtype" : "d", "idx" : idx },		
			success : function(chkRs){ 				
				if (chkRs==0)	alert("글 삭제 실패, \n 새로 고침 후 다시 시도해 주십시오");	
				else 			location.reload();		
			}
		});
	}
}


function showTab(chk){
	var pla = document.getElementById("pla_review");
	var cou = document.getElementById("cou_review");
	var frm = document.frmMyReview;
	
	var pls = document.getElementById("tabA");
	var cou = document.getElementById("tabB");
	if (chk == "a") {
		frm.kind.value = "p";
		location.href = "my_review_list.riv?kind=p"
	}else{
		frm.kind.value = "c";
		location.href = "my_review_list.riv?kind=c"
	}
}
function setColor(){
	var pls = document.getElementById("tabA");
	var cou = document.getElementById("tabB");
	var chk = '<%=placeReview.getKind() %>';
	
	if (chk == 'p'){
		cou.style.background = "none";
		cou.style.color = "#000";
		pls.style.background = "#000";
		pls.style.color = "#fff";
	} else {
		cou.style.background = "#000";
		cou.style.color = "#fff";
		pls.style.background = "none";
		pls.style.color = "#000";
	}
}
</script>
<body onload="setColor();">
<div class="wrapper">	<!-- 왼쪽 네비와 본문 영역을 담을 wrapper   -->
<div class="innerWrapper">
	<div id="left-navi">	
    <!-- 왼쪽 네비 영역 -->
	<ul>
		<li>정보 보기</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><a href="member_view_my_info.mem"><li class="li-indent">내 정보 보기</li></a></ul>
		<li>예약 관리</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><li class="li-indent txtBold">예약 현황</li></ul>
		<a href="saved_list.sav"><li class="menu">저장된 코스 및 장소 관리</li></a>
		<a href="my_review_list.riv"><li class="menu">내가 쓴후기</li></a>
		<a href=""><li class="menu">문의 내역</li></a>
	</ul>
	</div>
<div class="calendar-box">	

<table width="700" cellpadding="5" id="reviewTable" >
<form name="frmMyReview" action="member/my_review_list.riv" >
<input type="hidden" name="chk" value="" />
<input type="hidden" name="kind" value="" />

<tr height="70">
<td colspan="3" id="tab">
	<span class="tab" id="tabA" onclick="showTab('a');">장소후기</span>
	<span class="tab" id="tabB" onclick="showTab('b');">코스후기</span>
</td>
<td><input type="button" value="선택한 리뷰 삭제" onclick="callDel(0);" id="del-btn"  /></td>
</tr>

<tr id="line">
	<th width="25%">사진</th>
	<th width="15%">글제목</th>
	<th width="*">내용</th>
	<th width="15%" id="allSel">전체 선택 &nbsp;&nbsp;<input type="checkbox" name="all" onclick="chkAll(this);" /></th>
</tr>
<% if(myReview.size() > 0){
	for(int i=0; i<myReview.size(); i++ ){
		PlaceReviewInfo pri = myReview.get(i);
%>	
		<tr>
		<td><img src="/kosmoa/img/<%=pri.getPrl_img1() %>.jpg" width="50" height="50" align="absmiddle"  /></td>
		<td><%=pri.getPrl_title() %></td>
		<td id="review-content"><%=pri.getPrl_content() %></td>
		<td><input type="checkbox" name="chk"  value ="<%=pri.getPrl_idx() %>" /></td>
		</tr>
<%	}	
} else { 
	out.println("<td colspan='3'>작성한 리뷰가 없습니다</td>");
}
%>

</table>
</div>
</div>
</div>
</div>
</div>
</body>
</html>