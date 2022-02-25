<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
request.setCharacterEncoding("utf-8");
String tmpYear = request.getParameter("schYear");
String tmpMonth = request.getParameter("schMonth");

int curYear, curMonth, curDay;				// 오늘 날짜의 연도와 월을 저장할 변수
Calendar today = Calendar.getInstance();	// 오늘 날짜를 저장할 인스턴스
curYear = today.get(Calendar.YEAR);			// 현재 연도
curMonth = today.get(Calendar.MONTH);		// 현재 월(0~11 사이의 값)
curDay = today.get(Calendar.DATE);

int schYear = curYear, schMonth = curMonth;	// 달력 출력용 연도와 월을 저장할 변수
if (tmpYear != null && tmpMonth != null) {	// 달력 출력용 연도와 월을 받아 왔을 경우
	schYear = Integer.parseInt(tmpYear);	// 선택한 연도
	schMonth = Integer.parseInt(tmpMonth);	// 선택한 월
}

Calendar sdate = Calendar.getInstance();	// 달력 시작일을 저장할 인스턴스
Calendar edate = Calendar.getInstance();	// 달력 종료일을 저장할 인스턴스
sdate.set(schYear, schMonth, 1);			// sdate에 달력 시작일 지정
edate.set(schYear, schMonth + 1, 1);		// 다음달 1일 지정
edate.add(Calendar.DATE, -1);				// 다음달 1일에서 하루를 뺀 날짜로 종료일 지정

int weekDay = sdate.get(Calendar.DAY_OF_WEEK);	// 1일의 요일번호이자 1일의 시작 위치
int endDay = edate.get(Calendar.DATE);			// 말일로 루프의 종료점으로 사용

int nextYear = schYear, nextMonth = schMonth + 1;
int prevYear = schYear, prevMonth = schMonth - 1;
if (nextMonth == 12) {
	nextMonth = 0;	nextYear++;
} 
if (prevMonth == -1) {
	prevMonth = 11;	prevYear--;
}
// 파일 이름 변경시 pri_reseved_list 를 변경할 파일명으로 바꿔야 함
String prevYearLink = "location.href='pri_reserved_list.jsp?schYear=" + (prevYear - 1) + "&schMonth=" + schMonth + "';";
if (prevYear <= 1990) prevYearLink = "alert('이전 연도가 없습니다.');";
String prevMonthLink = "location.href='pri_reserved_list.jsp?schYear=" + prevYear + "&schMonth=" + prevMonth + "';";
if (prevYear < 1990 & prevMonth == 11) prevMonthLink = "alert('이전 연도가 없습니다.');";

String nextYearLink = "location.href='pri_reserved_list.jsp?schYear=" + (nextYear + 1) + "&schMonth=" + schMonth + "';";
if (nextYear >= curYear) nextYearLink = "alert('다음 연도가 없습니다.');";
String nextMonthLink = "location.href='pri_reserved_list.jsp?schYear=" + nextYear + "&schMonth=" + nextMonth + "';";
if (nextYear > curYear && nextMonth == 0) nextMonthLink = "alert('다음 연도가 없습니다.');";

String todayLink = "location.href='pri_reserved_list.jsp?schYear=" + curYear + "&schMonth=" + curMonth + "';";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>코스 예약</title>
    <style>
    .innerWrapper {
        display: flex; padding: 10px; border: 1px solid black;
        margin:5px; background-color: white; justify-content: space-evenly;
        height: 1800px;
    }
    .calendar-box { 
        width: 800px; height: 780px;
        border: 1px solid black;
        margin-top:250px;
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
	
	#left-navi { 
		 width:300px; height:1500px;
		border:1px solid black;
		border-radius : 40px 40px 40px 40px;
		margin-top: 60px; margin-right: 20px; margin-left: 100px;
	}

    </style>
</head>
<body>
<div class="wrapper">
    <div class="innerWrapper">
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
        <div class="calendar-box">
            <div id="searchBox">
                <h2>예약</h2>
                <form name="frmCalendar" action=""><!-- action과 method는 기본값으로 현재 파일과 get을 사용함 -->
                <input type="button" value="작년" onclick="<%=prevYearLink%>" />
                <input type="button" value="이전 달" onclick="<%=prevMonthLink%>" />
                <select name="schYear" onchange="this.form.submit()">
                <% for (int i = 1990 ; i <= curYear ; i++) { %>
                    <option value="<%=i %>" <% if (i == schYear) { %>selected="selected"<% } %>><%=i %></option>
                <% } %>
                </select> 년
                <select name="schMonth" onchange="this.form.submit()">
                <% for (int i = 0 ; i <= 11 ; i++) { %>
                    <option value="<%=i %>" <% if (i == schMonth) { %>selected="selected"<% } %>><%=i + 1 %></option>
                <% } %>
                </select> 월
                <input type="button" value="오늘" onclick="<%=todayLink%>"/>
                <input type="button" value="다음 달" onclick="<%=nextMonthLink%>" />
                <input type="button" value="내년" onclick="<%=nextYearLink%>"/>
                </form>
            </div>
            <br/>
            <table width="700" class="calendar" align="center">
            <tr height="30">
            <th width="100" class="txtRed">일</th><th width="100">월</th><th width="100">화</th><th width="100">수</th>
            <th width="100">목</th><th width="100">금</th><th width="100" class="txtBlue">토</th>
            </tr>
            <%
            if (weekDay != 1) {	// 1일이 일요일이 아닐 경우(1일의 시작 위치가 처음이 아니면)
                out.println("<tr>");
                for (int i = 1 ; i < weekDay ; i++)    out.print("<td></td>");
                // 1일의 요일 만큼 빈 칸으로 채워 1일의 위치에서 출력되도록 함
            }
            
            String txtClass = "", txtID = "";
            for (int i = 1, n = weekDay ; i <= endDay ; i++, n++) {
            // i : 날짜의 일(day)를 표현하기 위한 변수 / n : 일주일이 지날 때 마다 다음 줄로 내리기 위한 변수
                txtClass = "";	// 요일별 색상 스타일을 적용하기 위한 html클래스용 변수	
                txtID = "";		// 오늘 날짜의 배경색 스타일을 적용시키기 위한 html아이디용 변수
                
                if (n % 7 == 1) {	// 요일 번호가 1일 때 (일요일인 경우)
                    out.println("<tr>");
                    txtClass = " class='txtRed'";
                }	
                if (n % 7 == 0)	txtClass = " class='txtBlue'"; // 요일 번호가 0일 때(토요일인 경우)
                
                if (schYear == curYear && schMonth == curMonth && i == curDay) // 오늘 날짜
                    txtID = " id='txtToday'";
                
                out.println("<td" + txtClass + txtID + ">" + "<a href='#'>"+i+"</a>" + "</td>");
                
                
                if (n % 7 == 0) {				// 요일 번호가 7(토요일)이면 줄 tr태그를 닫아주어 줄을 바꿈
                    out.println("</tr>");
                } else if (i == endDay) {		// 해달 월(month)이 끝나면 남은 칸을 빈 td태그로 채워주고 tr태그를 닫음
                    for (int j = n % 7 ; j < 7 ; j++) 	out.println("<td></td>");
                    out.println("</tr>");
                }
            }
            %>
            </table>
        </div>
        
    </div>
</div>
</body>
</html>