<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="place.vo.*" %>
<%@ page import="review.vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%
request.setCharacterEncoding("utf-8");
PlaceInfo placeInfo = (PlaceInfo)request.getAttribute("placeInfo");	// 장소 정보를 저장하는 인스턴스
if (placeInfo == null){
	// 보려는 장소가 없을 경우
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}	
PlacePageInfo pageInfo = (PlacePageInfo)request.getAttribute("placePageInfo");	// 돌아갈 검색 정보들을 저장하는 인스턴스

double lo = 0.0;
double la = 0.0;
if(placeInfo.getPi_la()!= null && !placeInfo.getPi_la().equals("") && placeInfo.getPi_lo()!= null && !placeInfo.getPi_lo().equals("")){
	la = Double.parseDouble(placeInfo.getPi_la());
	lo = Double.parseDouble(placeInfo.getPi_lo());
} // 위도와 경도가 있을때에만 la lo 값을 받아옴 


String ophour = "";
String breaktime = "";
// 영업시간과 브레이크 타임을 , 기준으로 나눈후에 길이가 2일때면 둘다 값을 넣어주고, 길이가 1일때에는 영업시간만 값을 넣어줌 
String[] hourArr = placeInfo.getPi_time().split(",");
if(hourArr != null && hourArr.length >=2){
	ophour = hourArr[0];
	breaktime = hourArr[1];
}

if(hourArr != null && hourArr.length ==1){
	ophour = hourArr[0];
}

System.out.println("area : " + pageInfo.getArea());
// 검색 정보들 담을 변수 args
String args = "" , schargs = "";
if (pageInfo.getKeyword() != null && !pageInfo.getKeyword().equals("") ) {	
	schargs +="&keyword=" + pageInfo.getKeyword();
}
if (pageInfo.getBcata() != null && !pageInfo.getBcata().equals("")){
	schargs +="&bcata=" + pageInfo.getBcata();
}
if (pageInfo.getScata() != null && !pageInfo.getScata().equals("")){
	schargs +="&scata=" + pageInfo.getScata();
}
if (pageInfo.getTag() != null && !pageInfo.getTag().equals("")){
	schargs +="&tag=" + pageInfo.getTag();
}
if (pageInfo.getKey() != null && !pageInfo.getKey().equals("")){
	schargs +="&key=" + pageInfo.getKey();
}
if (pageInfo.getArea() != null && !pageInfo.getArea().equals("")){
	schargs +="&area=" + pageInfo.getArea();
}
if (pageInfo.getSort() != null && !pageInfo.getSort().equals("")){
	schargs +="&sort=" + pageInfo.getSort();
}

args = "?cpage=" + pageInfo.getCpage() + schargs;
System.out.println("view args : " + args);

ArrayList<PlaceReviewInfo> pReview = (ArrayList<PlaceReviewInfo>)request.getAttribute("pReview");		// 리뷰를 담고있는 인스턴스 




String rSuccess = request.getParameter("rSuccess");
if (rSuccess == null || rSuccess.equals(""))	rSuccess = "n";
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
.slideshow-slides { width:1200px; height:1200px; position:absolute; }
#img { min-width:1200px; height:700px; clear:both; margin:0 auto 100px auto; position:relative; overflow:hidden; }

#navi { margin-bottom:120px; }

#view { width:1200px; height:1200px; margin:0 auto; padding-top: 120px; }

.vtop { display:inline-block; width:200px; height:50px; } 
#vleft { text-align:left; font-size: 2.5em; font-weight: bold; margin-left: -20px; }	
#vright { text-align:right; float:right; padding:10px;}

#addr { width: 300px; padding-left: 50px; }
#time { text-align:left; float:left; margin-right:10px; }
#score { float:right; text-align:right; font-size: 1.5em; margin: -15px -90px 0 0; }
.titlebox { width:1100px; height:80px; padding:10px; }
.titlebox2 { width:1100px; height:60px; padding:10px; }


.slideshow-slides .slide { 
		height:100%; width:100%; position:absolute; 
		overflow:hidden;
}
.slideshow-slides .slide img { left:50%; margin-left:-600px; position:absolute; }

.slideshow-nav a, .slideshow-indicator a{ 
	background:rgba(0, 0, 0, 0); overflow:hidden; 
}
.slideshow-nav a:before, .slideshow-indicator a:before {
	content:url("/kosmoa/courseplace/images/sprites.png"); display:inline-block;
	font-size:0; line-height:0;
}
.slideshow-nav a {
	position:absolute; top:50%; left:50%; width:72px; height:72px; margin-top:-36px;
}

.slideshow-nav a.prev { margin-left:-590px; }
.slideshow-nav a.prev:before { margin-top:-20px; }
.slideshow-nav a.next { margin-left:520px; }
.slideshow-nav a.next:before { margin:-20px 0 0 -80px; }
.slideshow-nav a.disabled { display:none; }

.slideshow-indicator {
		height:16px; left:0; bottom:10px; right:0; text-align:center; position:absolute;
}
.slideshow-indicator a { 
	display:inline-block; width:16px; height:16px; margin:0 3px; 
}
.slideshow-indicator a.active { cursor:default; } 
.slideshow-indicator a:before { margin-left:-110px; }
.slideshow-indicator a.active:before { margin-left:-130px; }
	
	
#ctagdesc { text-align:Center; margin: 50px 0; }

 
#map { width:1200px; height:500px; }

 
#pla_desc { width:1200px; height:300px;  margin-top:20px; margin-bottom:20px; }
#pla_optime { width:1180px; height:180px; padding: 10px; text-align:center;  margin-top:20px; margin-bottom:20px;  }
.optime { width:1100px; height:auto; padding:6px; display:inline-block;  }
#optime_am { top : 10px; left:30%; }
#optime_pm {top : 120px; left:30%; }

 
#review_wrap { margin: 50px auto; padding: 0 20px; }
#wrap { width: 800px; margin: 0 auto 20px auto;  border:1px solid black; height:200px;}


#more { width:1100px; text-align:right; padding:10px; }
#creview { width:500px; height:220px; clear:both; }
.preview { width:1100px; height:200px; margin:0 auto; position:relative; }
.r_img { width:200; height:200px; }


.preview_detail { width:300px; height:150px; display:inline-block; }
.pimg { float:left; width:300px; height:200px; margin-right:30px; }
.preview_title { width:600px; height:70px; display:inline-block; } 
.preview_detail { width:600px; height:100px; }

 
#c_view_btn { width:1200px; height:200px;  margin:100px auto; text-align: center; }
.c_btn { width:150px; height:60px; background-color: white; border: 2px solid; border-radius: 10px; margin: 0 25px;}
.c_btn:hover { font-weight:bold; }
#wrapP1 {
	display:flex; justify-content:space-between;
	margin-bottom:50px; padding-top:20px;
}
</style>

</head>


<script src="js/jquery-3.6.0.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<!-- 이미지 슬라이딩 jq -->


<script>

// 저장된 장소면 색있는 하트 아니면 색 없는 하트 
function isSaved(pmid, piid){		// 세션에 있는 pmid와 placeInfo에 있는 piid이용 
	$.ajax({
		type : "POST", 				
		url : "/kosmoa/place_view.pla",		
		data : {"pmid" : pmid, "piid" : piid },		
		success : function(chkRs){ 				
			if (chkRs==0)	$("#vright").css({ "background" : url() });		// count(*)의 값이 0 일 경우 저장이 되지 않은 경우
			else 			$("#vright").css({ "background" : url() });		// count(*)의 값이 1 일 경우 저장이 되어 있는 경우 
		}
	});
}

$(document).ready(function () {
	$(".slideshow").each(function() {
		var $container = $(this),
			// .slideshow 객체를 $container에 저장
			 $slideGroup = $container.find(".slideshow-slides"),
			 // 슬라이드쇼에 사용될 이미지들을 감싸는 .slideshow-slides 객체
			 $slides = $slideGroup.find(".slide"),
			 // 슬라이드쇼에 사용될 이미지들을 의미하는 .slde 객체
			 $nav = $container.find(".slideshow-nav"),
			 // 다음 이전버튼을 의미하는 .slideshow-nav 객체
			 $indicator = $container.find(".slideshow-indicator"),
			 // 슬라이드 이미지의 바로가기 버튼들을 의미하는 객체
			 slideCount = $slides.length,
			 // slide이미지들의 개수로 
			 indicatorHTML= "",
			 // 바로가기 버튼들에 들어갈 html 소스를 저장할 변수
			 currentIndex= 0,
			 // 현재 보이는 슬라이드 이미지의 인덱스 번호
			 duration= 500,
			 // 애니메이션 소요 시간
			 easing = "easeInOutExpo",
			 // 애니메이션의 종류(동작되는 방식이나 형태를 의미) < 기본값써도됌
			 interval = 2500,
			 // 자동으로 슬라이드가 넘어갈 때 까지의 시간
			 timer;
			 // 타이머 객체로 아직 생성되지 않은 상태


		$slides.each(function(i) {
		// $slides 배열의 길이 만큼 루프를 돌면서 작업
			$(this).css({ left:100*i +"%"  });
			// 인덱스 번호를 이용하여 이미지를 롤링 시킴
			indicatorHTML += "<a href='#'>" + (i + 1) + "</a>";
			// 바로가기 버튼에 사용할 링크를 생성
		});
		$indicator.html(indicatorHTML);
		// 바로가기 버튼의 링크를 $indicator에 삽입

		function goToSlide(idx){
		// 받아온 idx를 인덱스로 하는 특정 슬라이드 이미지를 보여주는 함수
			$slideGroup.animate({ left:-100 * idx + "%"  }, duration, easing);
			// idx값을 이용하여 특정 슬라이드가 보이게 애니메이션 효과를 줌
			currentIndex = idx;
			// 현재 보이는 인덱스 값을 idx로 변환
			updateNav();
			// 현재 보이는 슬라이드에 따른 탐색 버튼의 변경을 위한 함수 호출
		}

		function updateNav(){
		// 현재 보이는 슬라이드 이미지에 따라 탐색과 표시를 업데이트하는 함수
			var $navPrev = $nav.find(".prev");
			var $navNext = $nav.find(".next");

			if (currentIndex==0)		$navPrev.addClass("disabled");
			// 현재 보이는 슬라이드가 첫번째 슬라이드 일 경우. disabled 클래스를 추가하여 이전 버튼이 안보이게 함
			else							$navPrev.removeClass("disabled");
			// 첫번째 슬라이드가 아니면 disabled를 삭제하여 이전 버튼이 보이게함

			if (currentIndex== slideCount-1)		$navNext.addClass("disabled");
			// 현재 보이는 슬라이드가 마지막 슬라이드 일 경우. disabled 클래스를 추가하여 다음 버튼이 안보이게 함
			else											$navNext.removeClass("disabled");
			// 첫번째 슬라이드가 아니면 disabled를 삭제하여 다음 버튼이 보이게함

			$indicator.find("a").removeClass("active").eq(currentIndex).addClass("active");
			// 바로가기 버튼들 모두 active클래스를 삭제한 후 중 현재 슬라이드 버튼은 다시 active클래스를 추가
		}

		function startTimer(){
		// 타이머를 시작하는 함수
			timer = setInterval(function() {
				var nextIndex = (currentIndex + 1) % slideCount;
				// 다음에 보여줄 슬라이드 인덱스 번호
				// 마지막 슬라이드인 경우 첫번째 슬라이드 번호(0)를 구함
				goToSlide(nextIndex);
				// 다음 슬라이드 번호를 가지고 goToSlide() 함수 호출
			}, interval);
			// interval의 시간만큼 대기하다가 작업
		}

		function stopTimer() {
		// 타이머를 중지시키는 함수 : 슬라이드 이미지에 마우스를 올리면 슬라이드 쇼가 멈춤
			clearInterval(timer);
			// timer에 저장된 Interval을 제거
		}

		$nav.on("click","a", function(evt) {
		// $nav영역의 이전 또는 다음 번호 클릭시 동작
			evt.preventDefault();
			// 발생한 이벤트의 원래 설정되어 있는 동작을 제거함
			// 여기서는 'a'태그의 원래 기능(링크기능)을 제거하는 역할

			if ($(this).hasClass("prev"))		goToSlide(currentIndex-1);
			// 이벤트를 일으킨 객체에 'prev'라는 클래스가 있으면(이전 슬라이드 버튼 클릭시) 이전 슬라이드로 이동
			else										goToSlide(currentIndex+1);
			// 이벤트를 일으킨 객체에 'prev'라는 클래스가 없으면(다음 슬라이드 버튼 클릭시) 다음 슬라이드로 이동
		});

		$indicator.on("click","a",function(evt){
		//indicator영역의 슬라이드 버튼을 클릭시 동작
			evt.preventDefault();
			// 발생한 이벤트의 원래 설정되어 있는 동작을 제거함
			// 여기서는 'a'태그의 원래 기능(링크기능)을 제거하는 역할
			
			if (!$(this).hasClass("active"))
			// 이벤트를 일으킨 객체에 active 클래스가 없으면(현재 보이는 슬라이드가 아니면)
				goToSlide($(this).index());
				// 이밴트를 일으킨 객체의 번호(인덱스 번호 슬라이드의 번호와 인디케이터에 있는 번호랑 개수 같음)를 가지고 goToSlide() 호출
		});
		
		$container.on({mouseenter : stopTimer, mouseleave:startTimer});
		// container영역에 마우스를 올리면 타이머를 멈추고(stopTimer) 내리면 타이머 시작(startTimer)

		goToSlide(currentIndex);
		// 페이지가 열리면 currentIndex에 해당하는 슬라이드 이미지를 보여줌

		startTimer();
		// 타이머를 시작시킴(정해진 시간에 따라 슬라이드를 움직임)
	});
});

function doSearch(frm){
	frm.action = "place_list.pla";
}


function reserveSave(chk) {
	// 예약이나 저장 페이지로 이동시키는 함수, 비로그인시 로그인 폼으로 이동 
	var lnk = "";
	if (chk == 'r') lnk = "reserved_in_form.res";		// 장바구니에 담기일 경우 이동할 경로 
	else 			lnk = "order_form.ord";				// 바로 구매일 경우 이동할 경로
		
	var frm = document.frmPlace;
	frm.action = lnk;
	frm.submit();
}

function movePage() {
	isConfirm = confirm("예약에 성공했습니다.\n예약 내역 페이지로 이동하시겠습니까?");
	if (isConfirm) {
		location.href = 'member_reserve_list.mem';
	}
}


function placeSave() {	
	<% if (!isLogin) {%>
		location.href = "/kosmoa/member/loginForm.jsp?url=/kosmoa/place_view.pla?<%=request.getQueryString().replace("&", "$")%>";
	<% } else { %>
		var cnpid = document.frmPlace.cnp_id;
		cnpid = cnpid.value;
		var isConfirm = false;
		$.ajax({
			type : "POST", 
			url : "saved_proc.sav<%=args%>", 
			data : { "wtype" : "plsIn" , "cnp_id" : cnpid }, 
			success : function(chkRs) {
				console.log(chkRs);
				if (chkRs == 0)	{
					alert("이미 등록된 장소입니다.");
				} else {
					isConfirm = confirm("저장되었습니다.\n저장된 장소 보기를 보시겠습니까?");
					if (isConfirm) {
						location.href="saved_list.sav";
					}
				}
			},
			error : function(chkRs) {
				console.log(chkRs);
			}
		});
	<% } %>	
	}
</script>

<body  <% if (rSuccess.equals("y")) { %>onload="movePage();" <% } %>>
<div id="view">
<div id="title">
<p class="titlebox"><span class="vtop" id="vleft"><%=placeInfo.getPi_name() %></span></p>
<p class="titlebox2">
<span class="vtop" id="addr"><%=placeInfo.getPi_addr1() %>, <%=placeInfo.getPi_addr2() %></span> 
<span class="vtop" id="time"><strong>영업 시간</strong> :  <%=ophour %></span> 
<span class="vtop" id="score">평점 <%=placeInfo.getPi_score() %></span></p>
</div>
<form name="frmPlace" method="post">
	<input type="hidden" name="cnp_id" value="<%=placeInfo.getPi_id() %>" />
	<input type="hidden" name="args" value="<%=args %>">
	<input type="hidden" name="rtype" value="p">
	<input type="hidden" name="piid" value="<%=placeInfo.getPi_id() %>"/>
</form>
<!-- title영역 종료 -->
<div id="img" class="slideshow">
	<div class="slideshow-slides">
		<a href="#" class="slide" id="slide-1"><img src="/kosmoa/img/<%=placeInfo.getPi_img1()%>.jpg" width="1200" height="1200"  style="margin-top: -350px"/></a>
		<a href="#" class="slide" id="slide-2"><img src="/kosmoa/img/<%=placeInfo.getPi_img2()%>.jpg" width="1200" height="1200"  style="margin-top: -350px"/></a>
		<a href="#" class="slide" id="slide-3"><img src="/kosmoa/img/<%=placeInfo.getPi_img3()%>.jpg" width="1200" height="1200"  style="margin-top: -350px"/></a>
		<a href="#" class="slide" id="slide-4"><img src="/kosmoa/img/<%=placeInfo.getPi_img4()%>.jpg" width="1200" height="1200"  style="margin-top: -350px"/></a>
	</div>
	<div class="slideshow-nav">
		<a href="#" class="prev" >Prev</a>
		<a href="#" class="next" >Next</a>
	</div>
	<div class="slideshow-indicator"></div>
</div>


<%@ include file="mapTest.jsp" %>


<div id="ctagdesc">
	<p id="ctag"><%="# "+ placeInfo.getSt_name().replaceAll(",", " #") %></p>
	<p id="cdesc"><%=placeInfo.getPi_desc() %></p>
</div>

<div id="review_wrap">
<% 
if(pReview.size()>0) { 
	for(int i=0; i<pReview.size(); i++){
		PlaceReviewInfo pri = pReview.get(i);		// 해당 장소에 관한 후기들 최신순으로 3개 받아온 후 보여줌
%>
	<!-- <div id="wrap">
		<div id="creview">
			<div class="pimg">
				<span class="r_img"><img src="/kosmoa/img/<%=pri.getPrl_img1() %>.jpg" width="150" height="150" /></span>
			</div>
			<div class="preview">
				<p>
					<span class="preview_title"><%=pri.getPrl_title() %></span>
					<span class="preview_rate"><%=pri.getPrl_score() %></span>
				</p>
				<span class="preview_detail"><%=pri.getPrl_content() %></span>
			</div>
		</div>
	</div>
-->
	<div id="wrap" style="position:relative;">
				<div style="position:absolute; display:inline-block; width:200px; height:200px; margin: 0 30px 0 0;">
					<img src = "/kosmoa/img/<%=pri.getPrl_img1() %>.jpg" class="r_img" width="200" height="200" />			
				</div>
				<div  style="display:inline-block; width:500px; height:200px; margin-left:230px;">
					<p id="wrapP1">
						<span >제목 : <%=pri.getPrl_title() %></span>
						<span style="padding-right:20px;"> 평점 <%=pri.getPrl_score() %></span>
					</p>
					<p ><%=pri.getPrl_content() %></p>
				</div>
			</div>		
<% 	
	}
}else {
	out.println("<div id='wrap'>해당 후기글이 없습니다. </div>");	
}
%>
</div>
<div id="c_view_btn">
<input type="button" value="목록으로" class="c_btn" onclick="location.href='place_list.pla<%=args %>';"  />
<input type="button" value="예약하기" class="c_btn" onclick="reserveSave('r');" />
<input type="button" value="저장하기" class="c_btn" onclick="placeSave();" />
</div>
</div>
</body>
</html>