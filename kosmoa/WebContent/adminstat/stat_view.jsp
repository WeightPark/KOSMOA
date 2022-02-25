<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.util.*" %>
<%@ page import = "statistics.vo.*" %>
<%@ include file="../admin/header_admin.jsp" %>
<%

int year, cYear, cMonth;
Calendar sdate = Calendar.getInstance();	// 시작일
cYear = sdate.get(Calendar.YEAR);			// 올해 연도
cMonth = sdate.get(Calendar.MONTH) + 1;		// 현재 월
request.setCharacterEncoding("utf-8");

String month;

out.println(request.getParameter("year"));
year = Integer.parseInt(request.getParameter("year"));
out.println(request.getParameter("month"));
month = request.getParameter("month");
String kind = request.getParameter("kind");

ArrayList<SchStatInfo> schStat = (ArrayList<SchStatInfo>)request.getAttribute("schStat");

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
canvas {
-moz-user-select: none;
-webkit-user-select: none;
-ms-user-select: none;
}
#tab {
text-align:center;
padding:30px; 
}
.tab { display:inline-block; width:50px; height:20px; border:1px solid orange; }
.selection { text-align:center; }

#tab {
width:75%;
text-align:right;
}
.tab { display:inline-block; width:50px; height:20px; border:1px solid orange; text-align:Center; }
.selection { width:75%; text-align:right;  }
#container { margin: 0 auto; }

.txtRed { color: red; }

.wrapper { padding-top: 66px; }
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
    width: 800px; height: 600px;
    border: 1px solid black;
    margin-top:0px; margin-left: 80px;
    margin: 0 auto; padding-top: 0px;
}

.reserve-tool {
    width: 800px; height: 780px;
    border: 1px solid black; text-align: center;
}
.button-box { margin-top: 50px; }
.btn { width: 100px; height: 40px; }

#searchBox { width: 700; text-align: center; margin-top: 50px; }
#searchBox input,  #searchBox select { margin-left: 10px;  }

.tab { width: 150px; height: 30px; }
</style>
<script src="js/Chart.min.js"></script>
<script src="js/utils.js"></script>
<script>
function setColor(){
	var a = document.getElementById("tabA");
	var b = document.getElementById("tabB");
	var frm = document.frmStat;
	frm.kind.value = "<%=kind%>"
	if (frm.kind.value =='t'){
		a.style.color='red';
	}else{
		b.style.color='red';
	}
}

function callProc(){
	var frm = document.frmStat;
	var y = frm.y.value;		var m = frm.m.value;		
	frm.stime.value = y +"-" + m;
	frm.submit();
}

function showTab(chk){
	var frm = document.frmStat;
	if (chk == "a") {
		frm.kind.value = "t";
		callProc();
 
	}else{
		frm.kind.value = "k";
		callProc();
 		
	}
}


var config = {
	type: 'doughnut',
	data: {
		datasets: [{
			data:[ <%
				for(int i=0; i< schStat.size(); i++) {
					SchStatInfo si = schStat.get(i);
					if(i == schStat.size()-1){
						out.print(si.getCount_of_all());
					}else {
						out.print((si.getSt_count() * 200) +", ");
						}
					}
					%>], 
				backgroundColor: [
					window.chartColors.red, 
					window.chartColors.orange, 
					window.chartColors.yellow, 
					window.chartColors.green, 
					window.chartColors.blue,
					window.chartColors.aqua,
					window.chartColors.gray
				],
				label: '점유율'
			}],
			labels: [ <%
				for(int i=0; i< schStat.size(); i++) {
					SchStatInfo si = schStat.get(i);
					if(i == schStat.size()-1){
						out.print("'기 타'");
					}else {
						out.print("'"+si.getSt_name()+"' , ");
						}
					}
					%>],
		},
		options: {
			responsive: true, legend: { position: 'top', }, 
			title: { display: true, text: '점유율' },
			animation: { animateScale: true, animateRotate: true }
		}
	};

window.onload = function() {
	var ctx = document.getElementById('chart-area').getContext('2d');
	window.myDoughnut = new Chart(ctx, config);
	setColor();
};

</script>
</head>
<body>
<div class="wrapper">
<div class="innerWrapper">
    <div id="left-navi"><!-- 왼쪽 네비 영역 -->
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
		<p id="tab" style="margin-left: -250px;"> <span class="tab" id="tabA" onclick="showTab('a');">태그</span>
		<span class="tab" id="tabB" onclick="showTab('b');">키워드</span> </p>
	<form name="frmStat" action="stat_sch_view.sta" method="post">
	<input type="hidden" name="kind" value="" />
	<input type="hidden" name="stime" value="" />
	<p class="selection" style="margin-left: 150px;">
	<select name="y" onchange = "callProc();" >
	<% for (int i = 2020 ; i <= cYear; i++) { %>
			<option value="<%=i %>" <% if (i == year) { %>selected="selected"<% } %>><%=i  %></option>
	<% } %>
		</select> 년  
		<select name="m" onchange = "callProc();" >
	<% for (int i = 1 ; i <= 12 ; i++) {
			String n = 	(i < 10? "0" + i : "" + i );
	%>
			<option value="<%=n %>" <% if (n.equals(month)) { %>selected="selected"<% } %> ><%=n %></option>
	<% } %>
		</select> 월
	</p>
	<%if (schStat.size()>1) { %>
		<div id="canvas-holder" style="width:100%">
		<canvas id="chart-area"></canvas>
		</div>
	<% } else { %>
		<div id="stat-empty">
		통계가 없습니다
		</div>
	<% } %>
	</form>
      </div>   
</div>
</div>
</body>
</html>