<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%
String piid = request.getParameter("piid");
String rSuccess = request.getParameter("rSuccess");
if (rSuccess == null || rSuccess.equals(""))	rSuccess = "n";
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<style>
/* 상단 영역 */
#navi { margin-bottom:120px; }

#view { width:1200px; height:1000px; margin:0 auto; }

.vtop { display:inline-block; width:200px; height:50px; } 
#vleft { text-align:left; padding:10px; float:left;}	#vright { text-align:right; float:right; padding:10px;}

#like { text-align:left; float:left; padding:10px; margin-right:10px; }
#score { float:right; text-align:right; padding:10px; }
.titlebox { width:1100px; height:60px; padding:10px; }

/* 이미지 슬라이딩 */
#img { min-width:1200px; height:400px; clear:both; margin:0 auto; position:relative; overflow:hidden; }
.slideshow-slides { width:1200px; height:400px; position:absolute; }
.slideshow-slides .slide { 
		height:100%; width:100%; position:absolute; 
		overflow:hidden;
}
.slideshow-slides .slide img { left:50%; margin-left:-600px; position:absolute; }

.slideshow-nav a, .slideshow-indicator a{ 
	background:rgba(0, 0, 0, 0); overflow:hidden; 
}
.slideshow-nav a:before, .slideshow-indicator a:before {
	content:url("images/sprites.png"); display:inline-block;
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
	
	
#ctagdesc { text-align:Center; }

/* 카카오 맵 */
#map { width:1200px; height:500px; }

/* 장소 설명, 영업시간 */
#pla_desc { width:1200px; height:300px;  margin-top:20px; margin-bottom:20px; }
#pla_optime { width:1180px; height:180px; padding: 10px; text-align:center;  margin-top:20px; margin-bottom:20px;  }
.optime { width:1100px; height:auto; padding:6px; display:inline-block;  }
#optime_am { top : 10px; left:30%; }
#optime_pm {top : 120px; left:30%; }

/* 리뷰 영역 */
#review_wrap { width:1200px; height:840px; padding: 10px; border:1px solid black; }


#more { width:1100px; text-align:right; padding:10px; }
#creview { width:500px; height:220px; clear:both; }
.preview { width:1100px; height:200px; margin:0 auto; position:relative; }
.r_img { width:300px;; height:180px; display:inline-block; margin:0 10px; }


.preview_detail { width:300px; height:150px; display:inline-block; }
.pimg { float:left; width:300px; height:200px; margin-right:30px; }
.preview_title { width:600px; height:70px; display:inline-block; } 
.preview_detail { width:600px; height:100px; }

/* 하단 버튼 */
#c_view_btn { width:1200px; height:100px;  margin-top:20px;}
.c_btn { width:80px; height:60px; margin-left:210px;  }
</style>

<script src="js/jquery-3.6.0.js"></script>
<script src="js/jquery-ui-1.10.3.custom.min.js"></script>
<!-- 이미지 슬라이딩 jq -->
<script>
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
</script>
<script type="text/javascript">
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
		location.href = '../member/member_reserve_list.mem';
	}
}
</script>

<body <% if (rSuccess.equals("y")) { %>onload="movePage();" <% } %>>
<div id="navi">
</div>
<div id="view">
<div id="title">
<p class="titlebox"><span class="vtop" id="vleft">장소 이름</span> <span class="vtop" id="vright">하트</span></p>
<p class="titlebox"><span class="vtop" id="like">좋아요</span> <span class="vtop" id="like">영업시간</span> <span class="vtop" id="score">3.5</span></p>
</div>
<form name="frmPlace" method="post">
	<input type="hidden" name="rtype" value="p">
	<input type="hidden" name="piid" value="<%=piid %>"/>
</form>
<!-- title영역 종료 -->
<div id="img" class="slideshow"> 이미지 영역
	<div class="slideshow-slides">
		<a href="#" class="slide" id="slide-1"><img src="images/slide-1.jpg" width="1200" height="400" /></a>
		<a href="#" class="slide" id="slide-2"><img src="images/slide-2.jpg" width="1200" height="400" /></a>
		<a href="#" class="slide" id="slide-3"><img src="images/slide-3.jpg" width="1200" height="400" /></a>
		<a href="#" class="slide" id="slide-4"><img src="images/slide-4.jpg" width="1200" height="400" /></a>
	</div>
	<div class="slideshow-nav">
		<a href="#" class="prev" >Prev</a>
		<a href="#" class="next" >Next</a>
	</div>
	<div class="slideshow-indicator"></div>
</div>
<div id="ctagdesc">장소 간단 설명 영역
<p id="ctag">#태그1 #태그2 #태그3 #태그4</p>
<p id="cdesc">장소 간단 설명</p>
</div>


<%@ include file="../mapTest.jsp" %>


<div id="pla_desc">
	장소 설명이 들어갈 영역
</div>

<div id="pla_optime">
	<p id="optime_am" class="optime">오전영업시간</p>
	<p id="optime_pm" class="optime">오후영업시간</p>
</div>
<div id="review_wrap">
<div id="wrapinside">
	<div id="creview">
		<p id="more">더보기</p>
		<div class="pimg">
			<span class="r_img">장소 이미지 영역</span>
		</div>
		<div class="preview">
			<p>
				<span class="preview_title">후기 제목</span>
				<span class="preview_rate">평점</span>
			</p>
			<span class="preview_detail">후기 설명</span>
		</div>
	</div>
</div>
<div id="wrap">
	<div id="creview">
		<p id="more">더보기</p>
		<div class="pimg">
			<span class="r_img">장소 이미지 영역</span>
		</div>
		<div class="preview">
			<p>
				<span class="preview_title">후기 제목</span>
				<span class="preview_rate">평점</span>
			</p>
			<span class="preview_detail">후기 설명</span>
		</div>
	</div>
</div>
<div id="wrap">
	<div id="creview">
		<p id="more">더보기</p>
		<div class="pimg">
			<span class="r_img">장소 이미지 영역</span>
		</div>
		<div class="preview">
			<p>
				<span class="preview_title">후기 제목</span>
				<span class="preview_rate">평점</span>
			</p>
			<span class="preview_detail">후기 설명</span>
		</div>
	</div>
</div>
</div>


<p id="c_view_btn">
<input type="button" value="예약하기" class="c_btn" onclick="reserveSave('r');"/>
<input type="button" value="저장하기" class="c_btn" onclick="reserveSave('s');"/>
<input type="button" value="공유하기" class="c_btn" />
</p>
</div>
</body>
</html>