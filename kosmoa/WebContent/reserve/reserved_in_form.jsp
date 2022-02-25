<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="place.vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%
request.setCharacterEncoding("utf-8");
//예약 옵션을 위한 스크립트
ArrayList<PlaceInfo> placeList = (ArrayList<PlaceInfo>)request.getAttribute("placeList");
PlaceInfo place = placeList.get(0);
String rtype = request.getParameter("rtype");
String args = request.getParameter("args");
System.out.println("args : " + args); 

// 로그인 여부 확인
if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하세요.');");
	out.println("location.href='/kosmoa/member/loginForm.jsp?url=/kosmoa/course_view.cou" + ((args + "&ciid=" + place.getCi_id()).replace("&", "$")) + "';");
	out.println("</script>");
	out.close();
}


// 달력을 위한 스크립트
String tmpYear = request.getParameter("schYear");
String tmpMonth = request.getParameter("schMonth");
String chkPerson = request.getParameter("chkPerson");
if (chkPerson == null) chkPerson = "0";

int curYear, curMonth, curDay;		// 오늘 날짜의 연도와 월을 저장할 변수
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
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>코스 예약</title>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<style>
.wrapper { padding-top: 150px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}
.calendar-box { 
    width: 600px; height: 700px; 
    border: 1px solid black; text-align: center;
}

.calendar-box h2 { margin-top: 50px; }

.calendar-box p { font-size: 1.2em; }

.reserve-tool {
    width: 600px; height: 700px;
    border: 1px solid black; text-align: center;
}
.reserve-tool h2 { margin-top: 50px; }
.reserveBrd { margin: 0 auto; }
.button-box { margin-top: 50px; }
.btn { width: 100px; height: 40px; background-color: #efefef; border: 1px solid black; }

#calenarBox { width: 700; text-align: center; margin-top: 50px; }

.txtRed { color: red; font-weight: bold; }
.txtBlue { color: blue; font-weight: bold; }

.calendar th { height: 30px; background: #585858; color: white; }
.calendar table, .calendar th, .calendar td { border: 1px solid black; }
.calendar { border-collapse: collapse; }
.calendar td { height: 80px; cursor: pointer; }

#txtToday { background-color: #efefef; }
.selT { width: 140px; }
.selP { width: 80px; }
</style>

<script src="/kosmoa/js/jquery-3.6.0.js"></script>

<script>
function setRdate(rdate) {
	if (rdate < <%=curDay %>) {
		alert("지나간 날에는 예약할 수 없습니다.");
	} else {
		var rday = "<%=curYear %>-<%=curMonth + 1%>-" + rdate;
		document.getElementById("date").innerHTML = "예약 일시 : <%=curYear %>년 <%=curMonth + 1%> 월 " + rdate + "일"; 
		document.getElementById("date").style.color = "blue";
		document.frmCourseReserve.rdate.value = rday;
	}
}
</script>

</head>

<body>
<div class="wrapper">
<div class="innerWrapper">
<div class="calendar-box">
	    <h2>예약</h2>
	    <p><%= curYear %> 년 <%=curMonth + 1%> 월</p>
	<br/>
   <table width="560" class="calendar" align="center">
   <tr height="30">
   <th width="80">일</th><th width="80">월</th><th width="80">화</th><th width="80">수</th>
   <th width="80">목</th><th width="80">금</th><th width="80">토</th>
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
            
            out.println("<td valign='top' " + txtClass + txtID + " onclick='setRdate(" + i + ");'>" + i + "</td>");
            
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
<div class="reserve-tool">
    <h2 style="margin-bottom: 30px;"><%=place.getCi_name() %></h2>
    <form name="frmCourseReserve" method="post" action="reserved_proc.res">
    <!-- request를 위한 hidden 객체 -->
    <input type="hidden" name="rtype" value="<%=rtype %>">
    <input type="hidden" name="rdate" value=""/>
    <input type="hidden" name="uid" value="<%=memberInfo.getPm_id() %>">
    <input type="hidden" name="ci_id" value="<%=place.getCi_id() %>"/>
    <input type="hidden" name="ci_name" value="<%=place.getCi_name() %>"/>
    <input type="hidden" name="args" value="<%=args %>" />
    
    <span id="date">예약 일시 : </span>
    <p></p><p></p>
    <table class="reserveBrd" width="500px">
        <tr height="50px">
            <th width="45%">장소 이름</th>
            <th width="28%">예약 시간</th>
            <th width="27%">인원</th>
        </tr>
<% 
if (placeList.size() > 0) {
	for (int i = 0 ; i < placeList.size() ; i++) {
		PlaceInfo pi = placeList.get(i);
		if (pi.getPi_isr().equals("y")) {
		
%>
     <tr height="80px">
         <td style="font-weight: bold;" align="left">
         	<input type="hidden" value="<%=pi.getCp_order() %>"/>
         	<input type="hidden" name="piid" value="<%=pi.getPi_id() %>"/>
         	<input type="hidden" name="piname" value="<%=pi.getPi_name() %>">
         	<%=pi.getPi_name() %>
         </td>
         <td class="tdTime">
             <select name="rtime" id="" class="selT">
             	<option value="">시간을 선택하세요</option>
<%
			String[] arrStime = pi.getCp_stime().split(":");
			String[] arrEtime = pi.getCp_etime().split(":");
			Calendar sTime = Calendar.getInstance();
			Calendar eTime = Calendar.getInstance();
			sTime.set(curYear, curMonth, curDay, Integer.parseInt(arrStime[0]), Integer.parseInt(arrStime[1]), 0);
			eTime.set(curYear, curMonth, curDay, Integer.parseInt(arrEtime[0]), Integer.parseInt(arrEtime[1]), 0);
			
			for (int j = 0 ; sTime.compareTo(eTime) < 1  ; j++) {
				String t = (sTime.get(Calendar.HOUR_OF_DAY) < 10) ? "0" + sTime.get(Calendar.HOUR_OF_DAY) : sTime.get(Calendar.HOUR_OF_DAY) + "";
				String m = (sTime.get(Calendar.MINUTE) == 0) ? "0" + sTime.get(Calendar.MINUTE) : sTime.get(Calendar.MINUTE) + "";
%>
                <option value="<%=t + ":" + m %>">
                <%=t + "시 " + m + "분"%></option>
<%
			sTime.add(Calendar.MINUTE, 30);
		}
%>
            </select>
        </td>
        <td class="tdPerson">
            <select name="rperson" class="selP" onchange="chkPerson(this);">
                <option value="">인원</option>
<%
		for (int k = 1 ; k <= pi.getPi_person() ; k++) {
%>
				<option value="<%=k %>"><%=k %> 명</option>
<%
		}
%>
            </select>
        </td>
    </tr>
<%
		} else {
%>
	<tr height="80px">
         <td style="font-weight: bold;" align="left">
	         <input type="hidden" value="<%=pi.getCp_order() %>"/>
	         <%=pi.getPi_name() %>
	         <input type="hidden" name="rtime" value=""/>
	         <input type="hidden" name="rperson" value=""/>
         </td>
         <td colspan="2" style="color: red;">예약이 지원되지 않는 장소입니다.</td>
	</tr>
	<tr height="10px"><td colspan="2"></td></tr>
	         
<%		
		}
	}	
} 
%>
    </table>
    <div class="button-box">
        <input type="submit" class="btn" style="border: 1px solid black;" value="예약"/>&nbsp;&nbsp;&nbsp;&nbsp;
        <input type="button" class="btn" style="border: 1px solid black;" value="취소"/>
    </div>
    </form>
</div>
</div>
</div>
</body>
</html>