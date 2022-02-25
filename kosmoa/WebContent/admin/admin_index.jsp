<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="header_admin.jsp" %>
<%@ page import="statistics.vo.*" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("location.href='/kosmoa/login.adm';");
	out.println("</script>");
	out.close();
}

request.setCharacterEncoding("utf-8");
ArrayList<ViewStatInfo> mainstat = (ArrayList<ViewStatInfo>)request.getAttribute("mainstat");   // 통계 정보를 담고있는 ArrayList<ViewStatInfo> 받아옴
int a,b,c,d;      // 각각 11월 검색 저장, 12월 검색 저장을 담을 변수임
a = mainstat.get(0).getSum_sch();
b = mainstat.get(0).getSum_reserve();
c = mainstat.get(1).getSum_sch();
d = mainstat.get(1).getSum_reserve();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 메인</title>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
<style>
.txtRed { color: red; }

.wrapper { padding-top: 90px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }

#left-navi { 
padding: 20px;
width:300px; height:500px;
border:1px solid black;
border-radius : 40px 40px 40px 40px;

margin: 0 auto;
}
#left-navi ul { padding }
#left-navi li { padding: 5px; }
   
.calendar-box { 
    width: 800px; height: 500px;
    border: 1px solid black;
    margin-top:60px; margin-left: 80px;
    margin: 0 auto; padding-top: 30px;
}

.reserve-tool {
    width: 800px; height: 780px;
    border: 1px solid black; text-align: center;
}
.button-box { margin-top: 50px; }
.btn { width: 100px; height: 40px; }

#searchBox { width: 700; text-align: center; margin-top: 50px; }
#searchBox input,  #searchBox select { margin-left: 10px;  }
.calendar, .calendar th, .calendar td { border: 1px black solid; }
.calendar { border-collapse: collapse; margin-top: 30px; }
.calendar td { height: 70px; }
.txtRed { color: red; font-weight: bold; }
.txtBlue { color: blue; font-weight: bold; }
#txtToday { background-color: #efefef; }
</style>
</head>
<body>

<div class="wrapper">
    <div class="innerWrapper">
    <div id="left-navi">	<!-- 왼쪽 네비 영역 -->
	<ul>
		<li>장소 관리</li>
			<a href="courseplace/placeInForm.jsp"><ul><li class="li-indent">장소 등록</li></ul></a>
		<li>코스 관리</li>
			<a href="courseplace/courseInForm.jsp"><ul><li class="li-indent">코스 등록</li></ul></a>
		<li>통계 관리</li>
			<a href="stat_reserve_view.sta"><ul><li class="li-indent">예약 통계</li></ul></a>
			<a href="stat_sch_view.sta"><ul><li class="li-indent">검색 통계</li></ul></a>
	</ul>
	</div>
        <div class="calendar-box">
			<div id="container" style="width: 100%;">
				<canvas id="box"></canvas>
			</div>
        </div>  
        
<script>
var color = Chart.helpers.color;
var horizontalBarChartData = {
   labels: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
   datasets: [{
      label: '검색수',
      backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
      borderColor: window.chartColors.red,
      borderWidth: 1,
      data: [6000, 9200, 8005, 7005, 9059, 8030, 10080, 8200, 9180, 7500, <%=a %>, <%=c %> ]
   }, {
      label: '예약수',
      backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
      borderColor: window.chartColors.blue,
      data: [5150, 6120, 7714, 5320, 6822, 5240, 8921, 5100, 8350, 6400,(<%=b %>*2), <%= d %> ]
   }]
};

window.onload = function() {
   var ctx = document.getElementById('box').getContext('2d');
   window.myHorizontalBar = new Chart(ctx, {
      type: 'horizontalBar',
      data: horizontalBarChartData,
      options: {
         elements: { rectangle: { borderWidth: 2 } }, 
         responsive: true, 
         legend: { position: 'right' }, 
         title: { display: true, text: '월별 검색수 및 예약수' }
      }
   });
};
</script>
    </div>
</div>
</body>
</html>