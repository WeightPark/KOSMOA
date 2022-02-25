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

String month="";
year = Integer.parseInt(request.getParameter("year"));

month = request.getParameter("month");
String kind = request.getParameter("kind");

ArrayList<ViewStatInfo> revStat = (ArrayList<ViewStatInfo>)request.getAttribute("revStat");
System.out.println("revStat size : " + revStat.size());
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#tab {
width:75%;
text-align:right;
}
.tab { display:inline-block; width:50px; height:20px; border:1px solid orange; text-align:Center; }
.selection { width:75%; text-align:right;  }
#container { margin: 0 auto; }

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
    width: 800px; height: 600px;
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
	if (frm.kind.value =='c'){
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
		frm.kind.value = "c";
		callProc(); 
	}else{
		frm.kind.value = "p";
		callProc();		
	}
} 
var color = Chart.helpers.color;
var barChartData = {
		labels: 
		[
		<% for (int i=0; i<revStat.size(); i++){ 
			ViewStatInfo vi = revStat.get(i);
			if(i == revStat.size()-1)	out.print(" '" +vi.getCi_name() +"' ");
			else						out.print("' " + vi.getCi_name() + "' " + ",");
		}
		%>
		],
		datasets: [{
			label: '예약수',
			backgroundColor: color(window.chartColors.red).alpha(0.5).rgbString(),
			borderColor: window.chartColors.red,
			borderWidth: 1,
			data: 
			[
			<% for(int i=0; i<revStat.size(); i++){
				ViewStatInfo vi = revStat.get(i);
				if (i == revStat.size()-1)	out.print(vi.getSum_reserve());
				else						out.print(vi.getSum_reserve() +", ");
			}	
			%>	
			]
		}, {
			label: '검색수',
			backgroundColor: color(window.chartColors.blue).alpha(0.5).rgbString(),
			borderColor: window.chartColors.blue,
			borderWidth: 1,
			data: 
			[
			<%for(int i=0; i<revStat.size(); i++){
				ViewStatInfo vi = revStat.get(i);
				if (i == revStat.size()-1)	out.print(vi.getSum_sch());
				else						out.print(vi.getSum_sch() +", ");
			}
			%>
			]
		}, {
			label: '저장수',
			backgroundColor: color(window.chartColors.green).alpha(0.5).rgbString(),
			borderColor: window.chartColors.blue,
			borderWidth: 1,
			data: 
			[
			<%
			for(int i=0; i<revStat.size(); i++){
				ViewStatInfo vi = revStat.get(i);
				if (i == revStat.size()-1)	out.print(vi.getSum_save());
				else						out.print(vi.getSum_save() +", ");
			}
			%>
			]
		}

		]
	};

window.onload = function() {
	setColor();
	var ctx = document.getElementById('canvas').getContext('2d');
	window.myBar = new Chart(ctx, {
		type: 'bar',
		data: barChartData,
		options: {
			responsive: true,
			legend:{ position:'top' }, 
			title:{ display:true, text:'월별 매출 및 순이익(세로 막대 차트)' }
		}
	});
};
</script>

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
			<p id="tab" style="margin-left: -280px;"><span class="tab" id="tabA" onclick="showTab('a');" >코스</span>
	 		<span class="tab" id="tabB" onclick="showTab('b');">장소</span> </p>
			<form name="frmStat" action="stat_reserve_view.sta" method="post">
			<input type="hidden" name="kind" value="" />
			<input type="hidden" name="stime" value="" />
			<p class="selection" style="margin-left: 180px;">
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
			</form>
			<div id="container" style="width: 100%; height: 60%;">
				<canvas id="canvas"></canvas>
			</div>
        </div>  
    </div>
</div>
</body>
</html>