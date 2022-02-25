<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="reserve.vo.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%
request.setCharacterEncoding("utf-8");
//로그인 여부 확인
/*
if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하세요.');");
	out.println("location.href='loginForm.jsp?url=/member/member_reserve_list.mem';");
	out.println("</script>");
	out.close();
}
*/
// 예약 내역 
ReservedListInfo rlist = (ReservedListInfo)request.getAttribute("rList");
ArrayList<CourseReservedInfo> courseList = rlist.getCourseList();
ArrayList<PlaceReservedInfo> placeList = rlist.getPlaceList();

// 달력 관련
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
String prevYearLink = "location.href='member_reserve_list.mem?schYear=" + (prevYear - 1) + "&schMonth=" + schMonth + "';";
if (prevYear <= 1990) prevYearLink = "alert('이전 연도가 없습니다.');";
String prevMonthLink = "location.href='member_reserve_list.mem?schYear=" + prevYear + "&schMonth=" + prevMonth + "';";
if (prevYear < 1990 & prevMonth == 11) prevMonthLink = "alert('이전 연도가 없습니다.');";

String nextYearLink = "location.href='member_reserve_list.mem?schYear=" + (nextYear + 1) + "&schMonth=" + schMonth + "';";
if (nextYear >= curYear) nextYearLink = "alert('다음 연도가 없습니다.');";
String nextMonthLink = "location.href='member_reserve_list.mem?schYear=" + nextYear + "&schMonth=" + nextMonth + "';";
if (nextYear > curYear && nextMonth == 0) nextMonthLink = "alert('다음 연도가 없습니다.');";

String todayLink = "location.href='member_reserve_list.mem?schYear=" + curYear + "&schMonth=" + curMonth + "';";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약 현황</title>
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

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }

#left-navi { 
	padding: 20px;
	width:270px; height:400px;
	border:1px solid black;
	border-radius : 30px;
	margin: 0 auto; 
	}
#left-navi li { padding: 5px; }
  
  
.calendar-box { 
    width: 800px; height: 700px;
    border: 5px solid #000;
    margin-top:30px; margin-left: 80px;
    margin: 0 auto;
}

.calendar th { height: 30px; background: #585858; color: white; }
.calendar table, .calendar th, .calendar td { border: 1px solid black; }
.calendar { border-collapse: collapse; margin: 0 auto; }
.calendar th { height: 30px; background: #585858; color: white; }
.calendar td { height: 80px; }

.reserve-tool {
    width: 800px; height: 780px;
    border: 1px solid black; text-align: center;
}
.button-box { margin-top: 50px; }
.btn { width: 100px; height: 40px; }

#searchBox { width: 700; text-align: center; margin-top: 50px; }
#searchBox h2 { padding-bottom: 20px; font-size: 1.2em; font-weight: bold; }
#searchBox input,  #searchBox select { margin-left: 10px; }

.txtBold { font-weight: bold; }
.txtRed { color: red !important; font-weight: bold; }
.txtBlue { color: blue; font-weight: bold; }

#txtToday { background-color: #FAF4C0; }
.text{ 
	font-size: 0.7em; 
	width:80px;
	height:25px;
	background: white;
	color:black;
	border:1px solid black;
}
.text:hover { font-weight: bold; }

.resC { font-weight: bold; color: black; background: pink; font-size: 14px; }
.resP { font-weight: bold; color: black; background: aqua; font-size: 14px; }

</style>

</head>
<body>

<div class="wrapper">
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
        <!-- 예약 현황을 보여주는 달력 영역 -->
            <div id="searchBox" style="">
                <h2>예약 현황</h2>
                <form name="frmCalendar" action="">
                <input type="button" class="text" value="작년" onclick="<%=prevYearLink%>" />
                <input type="button" class="text" value="이전 달" onclick="<%=prevMonthLink%>" />
                <select name="schYear" onchange="this.form.submit()">
                <% for (int i = curYear - 2 ; i <= (curYear + 2) ; i++) { %>
                    <option value="<%=i %>" <% if (i == schYear) { %>selected="selected"<% } %>><%=i %></option>
                <% } %>
                </select> 년
                <select name="schMonth" onchange="this.form.submit()">
                <% for (int i = 0 ; i <= 11 ; i++) { %>
                    <option value="<%=i %>" <% if (i == schMonth) { %>selected="selected"<% } %>><%=i + 1 %></option>
                <% } %>
                </select> 월
                <input type="button" class="text" value="오늘" onclick="<%=todayLink%>"/>
                <input type="button" class="text" value="다음 달" onclick="<%=nextMonthLink%>" />
                <input type="button" class="text" value="내년" onclick="<%=nextYearLink%>"/>
                </form>
            </div>
            <br/>
            <table width="700" class="calendar" align="center">
            <tr height="30" align="center">
            <th width="100">일</th><th width="100">월</th><th width="100">화</th><th width="100">수</th>
            <th width="100">목</th><th width="100">금</th><th width="100">토</th>
            </tr>
            <%
            if (weekDay != 1) {	
                out.println("<tr>");
                for (int i = 1 ; i < weekDay ; i++)    out.print("<td></td>");
            }
            
            String txtClass = "", txtID = "", txtRes = "";
            for (int i = 1, n = weekDay ; i <= endDay ; i++, n++) {
             	String tday = schYear + "-" + (schMonth < 9 ? "0" + (schMonth + 1) : (schMonth + 1)) + "-" + (i < 10 ? "0" + i : i);
                txtClass = "";	
                txtID = "";	
                txtRes = "";
                
               for (int k = 1 ; k <= courseList.size() ; k++) {
            	   CourseReservedInfo cri = courseList.get(k - 1);
            	   if (cri.getCr_rdate().substring(0, 10).equals(tday)) {
            		   txtRes = "<a href='member_reserved_view.mem?crid=" + cri.getCr_id() + "&ciname="
            		   + cri.getCi_name() + "&rdate=" + cri.getCr_rdate().substring(0, 10) +"' class='resC' " +
            		   "onclick=\"window.open(this.href, '_blank', 'width=600, height=700, left=700, top=200' ); return false;\">&nbsp;" 
            		   + (cri.getCi_name().length() > 7 ? cri.getCi_name().replace( cri.getCi_name().substring(5), "...") : cri.getCi_name()) + "&nbsp;<a>";
            		// 달력에 표시된 날짜 중에 예약된 날짜가 있다면 해당 코스 이름을 출력, 클릭시 팝업창으로 상세보기 
            	   } 
               }
               
               for (int k = 1 ; k <= placeList.size() ; k++) {
            	   PlaceReservedInfo pri = placeList.get(k - 1);
            	   if (pri.getPr_rdate().substring(0, 10).equals(tday)) {
            		   txtRes = "<a href='member_reserved_Place_view.mem?prid=" + pri.getPr_id() + "&piname="
                    	+ pri.getPi_name() + "&rdate=" + pri.getPr_rdate().substring(0, 10) +"' class='resP' " +
                    	"onclick=\"window.open(this.href, '_blank', 'width=500, height=450, left=700, top=200'); return false;\">&nbsp;" 
                    	+ (pri.getPi_name().length() > 7 ? pri.getPi_name().replace(pri.getPi_name().substring(5), "...") : pri.getPi_name()) + "&nbsp;<a>";
            	   }
               }
                
                if (n % 7 == 1) {
                    out.println("<tr>");
                    txtClass = " class='txtRed'";
                }	
                if (n % 7 == 0)	txtClass = " class='txtBlue'"; 
                
                if (schYear == curYear && schMonth == curMonth && i == curDay) 
                    txtID = " id='txtToday'";
               
                
                out.println("<td  valign='top'" + txtClass + txtID + ">" + i +  "<br/>&nbsp;&nbsp;" + txtRes + "</td>");
                
                
                if (n % 7 == 0) {	
                    out.println("</tr>");
                } else if (i == endDay) {	
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