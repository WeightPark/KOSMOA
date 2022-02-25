<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="course.vo.*" %>
<%@ page import="java.util.*" %>
<%@ page import="review.vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
request.setCharacterEncoding("utf-8");
ArrayList<CourseInfo> courseInfo = (ArrayList<CourseInfo>)request.getAttribute("courseInfo");		// 코스 정보
CoursePageInfo pageInfo = (CoursePageInfo)request.getAttribute("coursePageInfo");					// 페이징 정보
ArrayList<CourseReviewInfo> cReview = (ArrayList<CourseReviewInfo>)request.getAttribute("cReview");	// 코스 리뷰 정보 
if (courseInfo == null){
	// 보려는 장소가 없을 경우
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어왔습니다');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}

String args = "" , schargs = "";
if (pageInfo.getKeyword() != null && !pageInfo.getKeyword().equals("") ) {	
	schargs +="&keyword=" + pageInfo.getKeyword();
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

CourseInfo ci = courseInfo.get(0);

String ciid = ci.getCi_id();
String rSuccess = request.getParameter("rSuccess");
if (rSuccess == null || rSuccess.equals(""))	rSuccess = "n";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style>
#navi { margin-bottom:140px; }

#view { width:1000px; height:1000px; margin:0 auto; }

.vtop { display:inline-block; width:200px; height:70px;} 
#vleft {  padding:10px; float:left;}	#vright { width:400px; padding:10px;}
#like { text-align:left; float:left; padding:10px; margin-right:10px;  }
#score { float:right; text-align:right; padding:10px;  }
.titlebox { width:1200px; height:80px; font-size: 2.5em; font-weight: bold; }
.titlebox span { width: 50%; }


#img { min-width:1000px; height:600px; clear:both; margin:0 auto; position:relative; overflow:hidden; } 
.slideshow-slides { width:1000px; height:600px; position:absolute; }
.slideshow-slides .slide { 
		height:100%; width:1000px; position:absolute; 
		overflow:hidden;
}
.slideshow-slides .slide img { left:50%; margin-left:-500px; position:absolute; }

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
	

#ctagdesc { text-align:Center; margin-top:20px; margin: 100px; }

#map { width:1000px; height:500px; }

.c_img { width:200px; height:170px; display:inline-block; float: left; }
.cp_desc { display:inline-block; width : 500px; height:200px; } 



#wrap {  margin-top:10px; margin-bottom:10px; }
#more { width:1100px; text-align:right; }
#creview { width:500px; height:280px; clear:both; }
.preview { width:1100px; height:200px; margin:0 auto; position:relative; border:1px solid black; text-align:center;}
.r_img { width:300px; height:180px; display:inline-block; margin:0 10px; }


.preview_detail { width:300px; height:150px; display:inline-block; }
.pimg { float:left; width:300px; height:200px; margin-right:30px; }
.preview_title { width:600px; height:100px; display:inline-block; } 
.preview_detail { width:600px; height:100px; }



#c_view_btn { width:1000px; height:200px;  margin:100px auto; text-align: center; }
.c_btn { width:150px; height:60px; background-color: white; border: 2px solid; border-radius: 10px; margin: 0 25px;}

.c_btn:hover { font-weight:bold; }

a { text-decoration:none; } 


#imgdesc { width:1000px; padding:10px; margin: 0 auto; }
.imgdesc { width:800px; height:185px; margin:0 100px 10px 100px;   padding:5px; display: inline-block; border: 1px solid black;  }

a { color: black; }
a:link, a:visited, a:hover { text-decoration: none; }

#review_wrap { margin: 50px auto; }
#wrap { 
	display:flex; width:800px; height:202px; margin: 10px 100px 30px 110px; border:1px solid black;
	justify-content: space-between;			
}
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

//코스 저장 
function courseSave() {	
	<% if(!isLogin) {%>
		location.href = "/kosmoa/member/loginForm.jsp?url=/kosmoa/course_view.cou?<%=request.getQueryString().replace("&", "$")%>";
	<% }else { %>
		var cnpid = document.getElementById("cnp_id0").value;
		var isConfirm = false;
		$.ajax({
			type : "POST", 
			url : "saved_proc.sav<%=args%>", 
			dataType : "text",
			data : { "wtype" : "cosIn" , "cnp_id" : cnpid }, 
			success : function(chkRs) {
				console.log(chkRs)
				if (chkRs == 0)	{
					console.dir(chkRs);
					alert("이미 등록된 코스입니다.");
				} else {
					console.dir(chkRs)
					isConfirm = confirm("저장되었습니다.\n저장된 코스 보기를 보시겠습니까?");
					if(isConfirm){
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
			 duration= 800,
			 // 애니메이션 소요 시간
			 easing = "easeInOutExpo",
			 // 애니메이션의 종류(동작되는 방식이나 형태를 의미) < 기본값써도됌
			 interval = 4000,
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

function gotoView(piid){		// 코스의 장소 이름 클릭시 새창으로 띄워줄 함수
	var link = 'place_view.pla?piid='+piid+'&cpage=1&psize=8';
	window.open(link);
}

function doSearch(frm){
	frm.action = "course_list.cou";
}

function reserveSave(chk) {
	// 예약이나 저장 페이지로 이동시키는 함수, 비로그인시 로그인 폼으로 이동 
	var lnk = "";
	if (chk == 'r') lnk = "reserved_in_form.res";		// 장바구니에 담기일 경우 이동할 경로 
	else 			lnk = "order_form.ord";				// 바로 구매일 경우 이동할 경로
		
	var frm = document.frmCourse;
	frm.action = lnk;
	frm.submit();
}

function movePage() {
	isConfirm = confirm("예약에 성공했습니다.\n예약 내역 페이지로 이동하시겠습니까?");
	if (isConfirm) {
		location.href = 'member_reserve_list.mem';
	}
}


function callLike(){
	var isConfirm = true;
	var idx = "<%=ci.getCi_id() %>";
	if(isConfirm){
		$.ajax({
			type : "POST", 				
			url : "/kosmoa/course_view.cou<%=args%>",		
			data : { "type" : "like", "ciid" : idx },		
			success : function(chkRs){ 				
				if (chkRs==0)	alert("좋아요 실패");	
				else 			location.reload();		
			}
		});
	}
}

</script>

<body  <% if (rSuccess.equals("y")) { %>onload="movePage();" <% } %>>

<div id="navi">
</div>
<div id="view">
<div id="title">
<p class="titlebox"><span class="vtop" id="vleft"><%=ci.getCi_name() %></span> 
<span class="vtop" id="vright" onclick="callLike();" style="text-align: right;"><img src="courseplace/images/like.png" width="30px" height="40px" style=""/></span>
</p>
<p class="likebox"><span class="vtop" id="like">좋아요 <%=ci.getCi_like() %></span> <span class="vtop" id="like">소요 시간 &nbsp;&nbsp;<%=ci.getCi_time() %>시간</span> 
<span class="vtop" id="score">평점 <%=ci.getCi_score() %></span></p>
</div>
<form name="frmCourse" method="post">
	<input type="hidden" name="args" value="<%=args %>">
	<input type="hidden" name="rtype" value="c">
	<input type="hidden" name="ciid" value="<%=ciid %>"/>
	
</form>
<!-- 이미지 슬라이딩 영역 -->
<div id="img" class="slideshow">
	<div class="slideshow-slides">
<% 
for (int i = 0 ; i < courseInfo.size() ; i++) {
	CourseInfo cInfo = courseInfo.get(i);
%>
		<a href="#" class="slide" id="slide-<%=i %>"><img src="/kosmoa/img/<%=cInfo.getPi_img1() %>.jpg" width="1000" height="1000" style="margin-top: -250px;" /></a>
<%
}
%>
	</div>
	<div class="slideshow-nav">
		<a href="#" class="prev" >Prev</a>
		<a href="#" class="next" >Next</a>
	</div>
	<div class="slideshow-indicator"></div>
</div>
<div id="ctagdesc">
</div>

<div id="map">
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0107e1dd1bb18105b6abc57007a471a"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(<%=ci.getPi_la() %>, <%= ci.getPi_lo() %>), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
 

var positions = [
	<%for (int i=0; i < courseInfo.size(); i++ ) { 
		CourseInfo cou = courseInfo.get(i);
		if ( i == courseInfo.size()-1){
	%>
		 	{
		        content: '<div><%=cou.getPi_name()%></div>',
		        latlng: new kakao.maps.LatLng(<%=cou.getPi_la() %>, <%= cou.getPi_lo() %>)
		    }
	
	<%	} else { %>
		  	{
		        content:  '<div><%=cou.getPi_name()%></div>',
		        latlng: new kakao.maps.LatLng(<%=cou.getPi_la() %>, <%= cou.getPi_lo() %>)
		    },
	<% } %>
	
		 
	<% } %>   
];

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });
    
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}

function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}
</script>
</div>

<div id="ctagdesc">
<p id="ctag" style="font-size: 1.5em;"># <%=ci.getCi_st_name().replace(',', '#') %></p>
<p id="cdesc" style="font-size: 1.5em;"><%=ci.getCi_desc() %></p>
</div>
<!-- 이미지 및 간단 설명 영역 -->
<div id="imgdesc">
<% for(int i=0; i < courseInfo.size(); i++ ) { 
	CourseInfo cidesc = courseInfo.get(i);
%>
	<p class="imgdesc">
		<span class="c_img"><a href="place_view.pla?cpage=1&piid=<%=cidesc.getPi_id() %>"><img src="/kosmoa/img/<%=cidesc.getPi_img1() %>.jpg" width="170px" height="170px" /></a></span>

		<br/><br/><span id="desc"><a href="#" style="font-size: 1.3em; font-weight: bold;"><%=cidesc.getPi_name() %></a></span><br/><br/>
		<span style="margin-top: 100px; font-size: 1.2em;"><%=cidesc.getPi_desc() %></span>

		<input type="hidden" id="cnp_id<%=i %>" value="<%=cidesc.getCi_id() %>" />
	</p>
<% } %>	
</div>
<div id="review_wrap">
<%
if (cReview.size()>0){

	for (int i=0; i< cReview.size(); i++){
		CourseReviewInfo cri = cReview.get(i);
%>
	
			<div id="wrap">
				<div style="display:inline-block; width:200px; height:200px; ">
					<img src = "/kosmoa/img/<%=cri.getCrl_img1() %>.jpg" width="200" height="200" />			
				</div>
				<div  style="display:inline-block; width:500px; height:200px;">
					<p id="wrapP1">
						<span >제목 : <%=cri.getCrl_title() %></span>
						<span style="padding-right:20px;"> 평점 <%=cri.getCrl_score() %></span>
					</p>
					<p ><%=cri.getCrl_content() %></p>
				</div>
			</div>
	
<!-- 
		<div id="wrap">
			<div id="creview">
				<div class="pimg" style="display:inline-block;">
					<img src = "" />
				</div>
				<div class="preview" style="display:inline-block;">
					<p>
						<span class="preview_title"></span>
						<span class="preview_rate"></span>
					</p>
					<p class="preview_detail"></p>
				</div>
			</div>
		</div>
 -->
<%
	}
} else {
	out.println("<div id='wrap'>후기가 없습니다</div>");
}
%>
</div>

<p id="c_view_btn">
<input type="button" value="돌아가기" class="c_btn" onclick="location.href='course_list.cou<%=args %>';" />
<input type="button" value="예약하기" class="c_btn" onclick="reserveSave('r');" />
<input type="button" value="저장하기" class="c_btn"  onclick="courseSave();" />
</p>
</div>
</body>
</html>