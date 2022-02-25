<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="place.vo.*" %>
<%@ page import="course.vo.*" %>
<%@ include file="/inc/header_nav.jsp" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("alert('잘못된 경로로 들어오셨습니다.');");
	out.println("history.back();");
	out.println("</script>");
	out.close();
}

request.setCharacterEncoding("utf-8");
ArrayList<SavedCourseInfo> cosList = (ArrayList<SavedCourseInfo>)request.getAttribute("cosList");
ArrayList<SavedPlaceInfo> plsList = (ArrayList<SavedPlaceInfo>)request.getAttribute("plsList");
PlacePageInfo plsPageInfo = (PlacePageInfo)request.getAttribute("plspageInfo");
CoursePageInfo cospageInfo = (CoursePageInfo)request.getAttribute("cospageInfo");
String wtype = (String)request.getAttribute("wtype"); 	// 페이지 이동할 때 코스인지 장소인지 구분하여 보여주기 위한 변수

System.out.println("plsPageInfo : " + plsPageInfo);
System.out.println("cospageInfo : " + cospageInfo);
String args;
if(wtype.equals("course")){
	args = "?cpage=" + cospageInfo.getCpage() + "&psize=" + cospageInfo.getPsize();
	
}else {
	args = "?cpage=" + plsPageInfo.getCpage() + "&psize=" + plsPageInfo.getPsize();
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>Insert title here</title>
</head>
<style>
.wrapper { padding-top: 150px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }
.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }
#my-saved-manage { 
	display:flex;
	margin-top : 120px;
	width:1200px; height:1600px;
} 
/* 네비 영역 */
#left-navi { 
	padding: 20px;
	width:270px; height:400px;
	border:1px solid black;
	border-radius : 30px;
	margin: 0 auto; 
}
#left-navi li { padding: 5px; }

.txtBold { font-weight: bold; }

.saved-box { 
    width: 800px; height: 700px;
    margin-top:30px; margin-left: 80px;
    margin: 0 auto;
}

/* 탭영역 */
.tab01, .tab02 { 
	display:inline-block; 
	width:150px; 
	height:50px; 
	border: 1px solid black;
	text-align: center;
	line-height: 50px;
}
.tab01 {
	background-color: #000; 
	color: #fff;
	cursor: pointer;
}
.tab02 {
	margin-left: -5px;
	border-left: none;
	cursor: pointer;
}

.tab03 { 
	display:inline-block; 
	width:194px; 
	height:50px; 
	text-align:right;
	font-size: 0.8em;
}

.tab03 input {
	width: 80px;
	height: 40px;
	border: 1px solid black;
	border-radius: 15px;
	background: white;
}

#del-btn:hover { font-weight:bold; }

/* 저장한 코스. 장소 영역 */
#boardBox { 
	width:800px;
	height:155px;
	position:relative;	
	margin:0px 8px 35px 50px;	
} 

#cosList { width:500px; }

.cosList { 
	display:flex;
	border: 2px solid black;
	margin-bottom: 20px;
	text-align: center;
	justify-content:space-between;
}

#empty {
	margin-top: 50px; text-align: center;
}
/* 처음에는 코스영역만 보여줌 */
#plsList{ width:500px; }

.plsList { 
	display:flex;
	border: 2px solid black;
	margin-bottom: 20px;
	text-align: center;
	justify-content:space-between;
}

/* 코스 영역 */	
.cospls_img { 
	width:150px; 
	height:150px; 
	margin:0;
	border-right: 2px solid black;
}
.cospls_name {
	width:300px; 
	height:150px; 
	line-height: 150px;
	margin:0;
	
}
.cospls_name a {
	font-size: 1.1em;	
}
.chkDel { 
	width:100px; 
	height:150px; 
	text-align:center; 
	padding-top: 57px;
	margin:0;
}
.chkDel input {
	width: 30px;
	height: 30px;
}

/* 페이징 영역 */
.more { 
	width:500px; 
	text-align:center; 
}
.more a { display:inline-block; }

</style>
<script src="/kosmoa/js/jquery-3.6.0.js"></script>
<script>
// 해당 탭을 보여주고 탭 배경과 글자색을 변경하는 메서드
var wtype = "";
function selTab(wtab) {
	var course = document.getElementById("cosList");
	var place  = document.getElementById("plsList");
	var cosTab = document.getElementById("cosTab");
	var plsTab = document.getElementById("plsTab");
	var cnpTab = document.getElementById("cnpTab");
	
	if(wtab == "course"){
		cnpTab.value = "cosDel";
		plsTab.style.background = "none";
		plsTab.style.color = "#000";
		
		cosTab.style.background = "#000";
		cosTab.style.color = "#fff";
	}else{
		cnpTab.value = "plsDel";
		plsTab.style.background = "#000";
		plsTab.style.color = "#fff";

		cosTab.style.background = "none";
		cosTab.style.color = "#000";
	}
}

//페이지가 로드될때  변수 값이 course면 course를 보여주고 place면 place를 block으로 보여준다.
window.onload = function(){
	wtype = "<%=wtype%>";
	if( wtype == "course"){
		selTab("course");
	}else if( wtype == "place") {
		selTab("place");
	}
}

// tab 클릭시 해당 탭을 보여주고 탭 배경과 글자색을 변경하는 메서드
/* function tab(chk){
	if (chk == "c"){
		selTab("course");
	}else if(chk == "p") {
		selTab("place");
	}
	sessionStorage.setItem("wtype", wtype);
} */

		

function getSelectedValues() {
// chk 체크박스들에서 선택한 체크박스의 값들만 추출하여 문자열로 리턴하는 함수(삭제에서 사용됨)
		var arrChk = document.saveFrmDel.chk;
		// 문서내의 frmCart 폼안에 있는 컨트롤들 중 chk라는 이름을 가진 컨트롤들을 배열로 받아옴(단, chk라는 이름의 컨트롤이 하나 밖에 없으면 배열을 생성되지 않음)
		var idxs = "";	// chk배열에 추출한 값들을 저장할 변수
		for (var i = 1 ; i < arrChk.length ; i++) {
		// 0번 인덱스가 아닌 1번 부터 시작하는 이유는 chk라는 이름의 첫번째 컨트롤이 hidden이므로
			if (arrChk[i].checked)	idxs += "," + arrChk[i].value;
		}
		return idxs.substring(1);
}

//코스 장소 삭제 함수 	
function cnpDel(cnpidx, cnpTab) {	
	var isConfirm = false;
	if (cnpidx == 0) {
	// 선택한 상품(들) 삭제시(여러 상품 선택시 여러 개의 csidx를 쉼표로 연결하여 문자열 생성, 상품을 하나도 선택하지 않았으면 경고메시지 출력)
		cnpidx = getSelectedValues();
		// 삭제하려고 선택한 상품들의 csidx값을 받아옴
		if (cnpidx != "") {	
			isConfirm = confirm("선택한 코스를  삭제하시겠습니까?");
		} else {	
			alert("삭제할 코스를 하나 이상 선택하세요.");
		}
	} 
	if (isConfirm) {
		$.ajax({
			type : "POST", 
			url : "/kosmoa/saved_proc.sav<%=args%>",
 			data : { "wtype" : cnpTab, "cnpidx" : cnpidx },
			success :  function(request,status,error){
			    console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
				if (request.responseText == 0)	{
					alert("선택한 상품 삭제에 실패했습니다.\n새로 고침 후 다시 시도해 주십시오.");
				}else{
					alert("선택한 코스를 삭제했습니다.");
					location.reload();
				}
			},
		});
	}
}
</script>
<body>
<div class="wrapper">
<div class="innerWrapper">
	<div id="left-navi">	
    <!-- 왼쪽 네비 영역 -->
	<ul>
		<li>정보 보기</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><a href="member_view_my_info.mem"><li class="li-indent">내 정보 보기</li></a></ul>
		<li>예약 관리</li>
			<ul style="padding-bottom: 10px; list-style: none; margin-left: -20px;"><a href="member_reserve_list.mem"><li class="li-indent">예약 현황</li></a></ul>
		<li class="menu txtBold">저장된 코스 및 장소 관리</li>
		<a href="my_review_list.riv"><li class="menu">내가 쓴후기</li></a>
		<a href=""><li class="menu">문의 내역</li></a>
	</ul>
	</div>

	<div class="saved-box" id="boardBox">
	<form name="saveFrmDel" action="" method="post">
	<input type="hidden" name="chk" value="" /><!-- 코스나 장소 삭제시 배열을 생성하기 위해 생성한 임의의 값 (인덱스 0번)  -->
	<input type="hidden" name="cnpTab" id="cnpTab" value="cosDel" /> <!-- 코스/장소 삭제시 구분자로 사용할 태그  -->
	
		<!-- 하단 삭제 버튼 누를시 value가 변해야 함  ???????????????-->
		<input type="hidden" value="n" name="del" /> 	
		<span class="tab01" id="cosTab" onclick="location.href='saved_list.sav?wtype=course';">저장한 코스</span>
		<span class="tab02" id="plsTab" onclick="location.href='saved_list.sav?wtype=place';">저장한 장소</span> 
		<span class="tab03">
			<input type="button" id="del-btn" name="isDelbtn" value="삭제하기" onclick ="cnpDel(0, this.form.cnpTab.value); "/>
		
		</span>
		
		<!-- 저장된 코스를 불러오는 코드 -->   
		<div id="cosList">
<% 		if(wtype.equals("course")){
			if(cosList.size() > 0){
				for(int i = 0; i < cosList.size(); i++) { 
					SavedCourseInfo cosInfo = cosList.get(i);
					String lnk = args + "&ciid=" + cosInfo.getCi_id();
					if(cospageInfo.getPsize() == 3) {
%>
						<div class="cosList">
						<p class="cospls_img">
							<img src="/kosmoa/img/<%=cosInfo.getCi_img() %>.jpg" width="150px" height="150px" alt="코스이미지" />
						</p>
						<p class="cospls_name">
							<a href="/kosmoa/course_view.cou<%=lnk%>"><%=cosInfo.getCi_name()%></a>
						</p>
						<p class="chkDel">
							<input type="checkbox" name="chk" value="<%=cosInfo.getCs_idx() %>" />
						</p>
						</div>
<%
					}
				} 
			} else { 
%>
				<div id="empty">
					<strong>저장된 코스가 없습니다.</strong>
				</div>
				
<%			}  %>
			<p class="more">
<% 
			if(cosList.size() != 0){
				if(cospageInfo.getCpage() == 1){
					out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]");
				}else {
					out.print("<a href='saved_list.sav?cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");
					out.println("<a href='saved_list.sav?cpage=" + (cospageInfo.getCpage() -1) + "&wtype=course'>[&lt;]</a>");
				} // 첫 페이지와 이전 페이지 링크 
				
				// 페이지 번호 루프 
				for(int i = 1, j = cospageInfo.getSpage(); i <= cospageInfo.getBsize() && j <= cospageInfo.getEpage(); i++, j++){
				// i : 루프를 돌릴 횟수를 검사하는 용도의 변수, j : 페이지 번호 출력용 변수
					if(cospageInfo.getCpage() == j){
						out.print("&nbsp;&nbsp;<strong>" + j + "</strong>&nbsp;&nbsp;");			
					}else{
						out.print("&nbsp;&nbsp;<a href='saved_list.sav?cpage=" + j + "&wtype=course'>" + j + "</a>&nbsp;&nbsp;");
					}
				}
				
				if(cospageInfo.getCpage() == cospageInfo.getPcnt()){
					out.print("[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
				}else{
					out.print("<a href='saved_list.sav?cpage=" + (cospageInfo.getCpage() + 1) + "&wtype=course'>[&gt;]</a>&nbsp;&nbsp;");
					out.println("<a href='saved_list.sav?cpage=" + cospageInfo.getPcnt() + "&wtype=course'>[&gt;&gt;]</a>");
				}// 다음 페이지와 마지막 페이지 링크 
			}
%>
			</p>
			</div>
		
	<!-- 저장된 장소를 불러오는 코드 -->   
			<div id="plsList">
<%	 } else {
			if(plsList.size() > 0){
				for(int i = 0; i < plsList.size(); i++) { 
					SavedPlaceInfo plsInfo = plsList.get(i);
					String lnk = args + "&piid=" + plsInfo.getPi_id();
					if(plsPageInfo.getPsize() == 3) {
%>
						<div class="plsList">
						<p class="cospls_img">
							<img src="/kosmoa/img/<%=plsInfo.getPi_img() %>.jpg" width="150px" height="150px" alt="장소이미지" />
						</p>
						<p class="cospls_name">
							<a href="/kosmoa/place_view.pla<%=lnk%>"><%=plsInfo.getPi_name()%></a>
						</p>
						<p class="chkDel">
							<input type="checkbox" name="chk" value="<%=plsInfo.getPs_idx() %>" />
						</p>
						</div>
<%
					}
				} 
			} else { 
%>
				<div id="empty">
					<strong>저장된 장소가 없습니다.</strong>
				</div>
				
<%			} %>
			<p class="more">
<%
			if(plsList.size() != 0){
				if(plsPageInfo.getCpage() == 1){
					out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]");
				} else {
					out.print("<a href='saved_list.sav?cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");
					out.println("<a href='saved_list.sav?cpage=" + (plsPageInfo.getCpage() -1) + "&wtype=place'>[&lt;]</a>");
				} // 첫 페이지와 이전 페이지 링크 
				
				// 페이지 번호 루프 
				for(int i = 1, j = plsPageInfo.getSpage(); i <= plsPageInfo.getBsize() && j <= plsPageInfo.getEpage(); i++, j++){
				// i : 루프를 돌릴 횟수를 검사하는 용도의 변수, j : 페이지 번호 출력용 변수
					if(plsPageInfo.getCpage() == j){
						out.print("&nbsp;<strong>" + j + "</strong>&nbsp;");			
					} else {
						out.print("&nbsp;<a href='saved_list.sav?cpage=" + j + "&wtype=place'>" + j + "</a>&nbsp;");
					}
				}
				
				if(plsPageInfo.getCpage() == plsPageInfo.getPcnt()){
					out.print("[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
				} else {
					out.print("<a href='saved_list.sav?cpage=" + (plsPageInfo.getCpage() + 1) + "&wtype=place'>[&gt;]</a>&nbsp;&nbsp;");
					out.println("<a href='saved_list.sav?cpage=" + plsPageInfo.getPcnt() + "&wtype=place'>[&gt;&gt;]</a>");
				}// 다음 페이지와 마지막 페이지 링크 
			}
%>
			</p>
			</div>
<%	 } %>
	</div>
	</form>
</div>
</div>
</body>
</html>