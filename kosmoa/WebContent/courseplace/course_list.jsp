<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="course.vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<%
request.setCharacterEncoding("utf-8");
ArrayList<CourseInfo> courseList = (ArrayList<CourseInfo>)request.getAttribute("courseList");
CoursePageInfo pageInfo = (CoursePageInfo)request.getAttribute("coursePageInfo");

String args = "", schargs = "";	
// 검색관련 쿼리스트링 제작

if (pageInfo.getKeyword() != null && !pageInfo.getKeyword().equals("") ) {	
	schargs +="&keyword=" + pageInfo.getKeyword();
}

if (pageInfo.getTag() != null && !pageInfo.getTag().equals("")){
	schargs +="&brand=" + pageInfo.getTag();
}
if (pageInfo.getKey() != null && !pageInfo.getKey().equals("")){
	schargs +="&key=" + pageInfo.getKey();
}
if (pageInfo.getArea() != null && !pageInfo.getArea().equals("")){
	schargs +="&area=" + pageInfo.getArea();
}

if (pageInfo.getKind() != null && !pageInfo.getKind().equals("")){
	schargs +="&kind=" + pageInfo.getKind();
}

args = "?cpage=" + pageInfo.getCpage()+ schargs;
System.out.println("list args : " + args + ";");
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<style type="text/css">
.cou_title { font-size: 20px; text-decoration:none; color: black; } 
.lineUp { font-size:15px; }

.courseWrapper { margin: 120px auto 0; width: 1200px;  height: 1600px; }	  
.course-container{
	display: flex; border: 3px solid #4C4C4C; padding: 15px;
    width: 700px; height: 335px; margin: 5px; color: white;
    font-size: 36px; text-align: center; 
    border-radius: 20px;
}
.course-container img {
	border-radius: 20px;
}
.course-container.space-evenly{ justify-content: space-evenly; }

.footerWrapper { margin-top: 20px;  height: 300px; }
.innerCourse { width:306px; height:310px;   }	 

.page-container { /* page div */
	display:flex; padding:10px;  
    margin:5px; background-color: white;
}
.page-container.space-evenly{ justify-content: space-evenly; } 
.page{
	width:10px; height:10px; margin:5px; color:black;
	font-size:15px;	text-align:center;	background-color: white;
}

.tag-container { 
	display:flex; padding:10px;  
    margin:5px;
}
.tag-container.space-evenly{ justify-content: space-evenly; }
.tag{
	width:70px; height:10px; margin:3px; color:black;
	font-size:15px;	text-align:center; margin-bottom:10px;
	display: inline-block;
}
.flex-container{
    display: flex; padding: 10px;  
    margin:5px; background-color: white; 
}
.flex-container.space-evenly{ justify-content: space-evenly; }
.course{
    width: 700px; height: 330px; margin: 5px; 
    font-size: 36px; text-align: center; background-color: cornflowerblue;
}

.course-img { width:300px; height:160px;  }
.course-name { width:300px; height:80px; font-size: 0.8em; font-family: Georgia, "Malgun Gothic", serif; font-weight: bold; 
			   padding:20px 10px; margin:0;
}
.course-places { color:black; font-size : 0.7em; margin:10px; } /* �ڽ� ��� ������ */
.cour_desc { height: 100px;text-align:center; font-size : 0.4em; color:black; margin: 30px; }
.cour_desc2 {  text-align:center; font-size : 0.4em; color:black; margin-top:30px; }

.placeHeader {		 
	display:flex;
	width:1100px;
	margin: 0 auto;
	margin-top: 120px;
	height: 50px; 
	justify-content: space-between;
	align-items: center;
}

#plsArray {			 
	width:300px;
	text-align: center;
}

#plsFilter {		 
	width:100px;
	text-align: center; 
}

.placewWrapper {	 
	width: 1100px;
	margin: 0 auto;
	height: auto; 
}

.flex-container{		 
    display: flex; 
    padding: 10px; 
    margin:5px; 
    background-color: white; 
    flex-glow:0;
    flex-shrink:0;
    justify-content: space-evenly;
}

.place { 			 
	margin: 5px; 
	width: 350px; 
	height: 400px; 
	text-align: center;
}

.plsPhoto{			 
	width: 330px;
	height: 330px;
	margin:10px auto; 
}

.plsTitle{			 
	display:inline-block;
	width: 250px;
	height: 45px;
	margin:0 10px;
}

.plsAverage{		 
	display:inline-block;
	width: 60px;
	height: 45px;
}

.footerWrapper { 	 
	margin-top: 20px; 
	height: 300px; 
}

#wrapperBox{ 		 
	width: 520px;
	height: 750px;
	padding: 5px;	
	position: relative;
	border: 4px solid black;
	background:white;
	-webkit-user-select:none; 
	-moz-user-select:none; 
	-ms-user-select:none; 
	user-select:none

}
.tabBox {			 
	display: inline-block;
	width: 350px;
	position: absolute;
	z-index: 0;
}

#fPlus{				 
	display: inline-block;
	width: 100px;
	margin-left: 45px;
	text-align: right;
	font-size: 0.8em;
}
input[type="radio"] {	 
	display: none;
}

input[type="radio"] + label {		 
	display: inline-block; 
	width: 100px;
	height: 30px;
	text-align:center;
	line-height: 30px;
	background: #fff;
	color: #999;
	font-size: 13px;
	cursor: pointer;
	
}

input[type="radio"]:checked + label {	 
	background: #8be7f4;
	color: #000;
	border-top: 1px solid #000;
	border-right: 1px solid #000;
	border-left: 1px solid #000;
}


table {				/* table */
	width: 500px;
	height: 600px;
	celspacing: 0;
	margin-top: -8px;
	border-collapse: collapse;
	border: 1px solid black;
	text-align: center;
	position: absolute;
	z-index: 2;
}

td {				 
	padding: 5px;
}

.cata{				 
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding-left: 10px;
	text-align: left;
	
}
.plus {				 
	border-top:1px solid black;
	border-bottom:1px solid black;
	text-align: right;
	padding-right: 10px;
	font-size: 0.8em;
}
#buttonBox {		 
	width: 500px;
	margin-top: 20px;
	text-align: center;
	position: absolute;
	bottom:30px;
	
}
.button {			 
	width: 100px;
	height: 50px;
	margin: 0 15px;
	background: white;
	border: 1px solid orange;
}

.button:hover { font-weight:bold; }


input[type="checkbox"] {
	display:none;
}

input[type="checkbox"] + label {
	display: inline-block;
	text-align:center;
	height: 50px;
	line-height:50px;
	width: 100%;
}

input[type="checkbox"]:checked + label {
	font-weight:bold;
}

#areaTitle {
	height: 35px;
	text-align: left;
	line-height: 35px;
	position:absolute;
	bottom:30px;
}


.areaList {
	display: flex;
	justify-content: space-between;
	border-bottom: 1px solid black;
	border-right: 1px solid black;
}

.firstArea {
	border-top: 1px solid black;
}

.areaList p {
	width: 20%;
	heith: 100%;
	margin: 0;
	text-align: center;
	line-height: 50px;
	border-left: 1px solid black;
}
#slideUp{
	position: absolute;
	 left:30%;
	z-index : 9999;
}

.footerWrapper { margin-top: 20px; border: 1px solid black; height: 300px; }

#clwrapper { margin-top:150px;  }

#slideUp{
	position: absolute;
	top:0; left:30%;
	z-index : 9999;
	height:0; overflow:hidden;
}




a { color: black; }
a:link, a:visited, a:hover { text-decoration: none; }
</style>
</head>

<script src="/kosmoa/js/jquery-3.6.0.js"></script>
<script>

function setVal(sch){
	var frm = document.getElementById("frmSch");
	if (sch.startsWith('t')){
		if( frm.tag.value.indexOf(sch) > 0 ){
			frm.tag.value = frm.tag.value.replace(','+sch , '');
		}else {
			frm.tag.value +=","+ sch;
		}		
	} else if (sch.startsWith('k')) {
		if ( frm.key.value.indexOf(sch) > 0 ){
			frm.key.value = frm.key.value.replace(','+sch , '');
		}else {
			frm.key.value += ","+sch;
		}
		
	} else {
		if ( frm.area.value.indexOf(sch) > 0 ){
			frm.area.value = frm.area.value.replace(','+sch , '');
		}else {
			frm.area.value += ","+sch;
		}
	
	}
}


$(document).ready(function () {	 
	$("#filter").click(function () {
		var open = $("#slideUp").height();
		var el = $("#slideUp"),
			curHeight = el.height(),
			autoHeight = el.css('height', 'auto').height();
		if (open === 0){
			el.height(curHeight).animate({height: autoHeight}, 0);
		} else {
			el.animate({height : 0}, 0);
		}
	}); 
});
</script>

<script>
function setKey(frm){
	var val = document.getElementById("keyword").value;
	frm.keyword.value = val;
}

function doSearch(frm){
	frm.action = "course_list.cou";
}


</script>


<body>
<div id="navi">

</div>

<div id="slideUp">
	<div id="wrapperBox"> <!-- 전체를 감싸는 div -->
		<form name="frmSchFilter" action="course_list.cou" id="frmSch" onsubmit= "setKey(this);">
			<p id="fPlus">&nbsp;</p>
			<table id="cou-filter"> 	<!-- tap영역 밑에 부터 버튼 전까지 talbe 영역  -->
			<input type="hidden" value="" name ="keyword" />
			<input type="hidden" value="" name ="tag" />
			<input type="hidden" value="" name ="key" />
			<input type="hidden" value="" name ="area" />
				<tr height="5%">
					<td class="cata" colspan="3">태그</td>
					<td class="plus">
 
					</td>
				</tr>
				<tr height="15%">
					<td>
						<input type="checkbox"  id="tag1" value="tag01" onclick = "setVal(this.value);" />
						<label for="tag1">#데이트</label> 						
					</td>
					<td>
						<input type="checkbox"  id="tag2" value="tag02" onclick = "setVal(this.value);" />
						<label for="tag2">#차분</label> 
						
					</td>
					<td>
						<input type="checkbox"  id="tag3" value="tag03" onclick = "setVal(this.value);" />
						<label for="tag3">#무드</label> 
					</td>
					<td>
						<input type="checkbox"  id="tag4" value="tag04" onclick = "setVal(this.value);" />
						<label for="tag4">#맛집</label> 
					</td>
				</tr>
				<tr height="15%">
					<td>
						<input type="checkbox"  id="tag5" value="tag05" onclick = "setVal(this.value);" />
						<label for="tag5">#핫한</label> 
					</td>
					<td>
						<input type="checkbox"  id="tag6" value="tag06" onclick = "setVal(this.value);" />
						<label for="tag6">#아늑한</label> 
					</td>
					<td>
						<input type="checkbox"  id="tag7" value="tag07" onclick = "setVal(this.value);" />
						<label for="tag7">#친구와</label> 
					</td>
					<td>
						<input type="checkbox"  id="tag8" value="tag08" onclick = "setVal(this.value);" />
						<label for="tag8">#빈티지</label> 
					</td>
				</tr>
				<tr height="5%">
					<td class="cata" colspan="3">분류</td>
					<td class="plus">
 
					</td>
				</tr>
				<tr height="15%">
					<td>
						<input type="checkbox"  id="key1" value="key01" onclick = "setVal(this.value);" />
						<label for="key1">주차 가능</label> 
					</td>
					<td>
						<input type="checkbox"  id="key2" value="key02" onclick = "setVal(this.value);" />
						<label for="key2">반려동물</label>  
					</td>
					<td>
						<input type="checkbox"  id="key3" value="key03" onclick = "setVal(this.value);" />
						<label for="key3">카페</label> 
					</td>
					<td>
						<input type="checkbox"  id="key4" value="key04" onclick = "setVal(this.value);" />
						<label for="key4">한식</label>  
					</td>
				</tr>
				<tr sheight="15%">
					<td>
						<input type="checkbox"  id="key5" value="key05" onclick = "setVal(this.value);" />
						<label for="key5">양식</label>  
					</td>
					<td>
						<input type="checkbox"  id="key6" value="key06" onclick = "setVal(this.value);" />
						<label for="key6">중식</label>
					</td>
					<td>
						<input type="checkbox"  id="key7" value="key07" onclick = "setVal(this.value);" />
						<label for="key7">일식</label>
					</td>
					<td>
						<input type="checkbox"  id="key8" value="key08" onclick = "setVal(this.value);" />
						<label for="key8">기타</label>
					</td>
				</tr>
				<tr height="5%">
					<td class="cata" colspan="3">지역별</td>
					<td class="plus">
 
					</td>
				</tr>
				<tr>
					<td>
						<input type="checkbox"  id="area1" value="강남구" onclick = "setVal(this.value);" />
						<label for="area1">강남구</label> 
					</td>
					<td>
						<input type="checkbox"  id="area2" value="마포구" onclick = "setVal(this.value);" />
						<label for="area2">마포구</label> 
					</td>
					<td>
						<input type="checkbox"  id="area3" value="송파구" onclick = "setVal(this.value);" />
						<label for="area3">송파구</label> 
					</td>
					<td>
						<input type="checkbox" id="area4" value="용산구" onclick = "setVal(this.value);" />
						<label for="area4">용산구</label> 
					</td>
				</tr>
				<tr>
					<td> 
						<input type="checkbox" id="area5" value="종로구" onclick = "setVal(this.value);" />
						<label for="area5">종로구</label> 
					</td>
					<td>
						<input type="checkbox"  id="area6" value="중구" onclick = "setVal(this.value);" />
						<label for="area6">중구</label> 
					</td>
					<td>
						<input type="checkbox"  id="area7" value="구로구" onclick = "setVal(this.value);" />
						<label for="area7">구로구</label> 
					</td>
					<td>
						<input type="checkbox" id="area8" value="금천구" onclick = "setVal(this.value);" />
						<label for="area8">금천구</label> 
					</td>
				</tr>	
			</table>			
			<div id="buttonBox">	<!-- 버튼 영역 -->
				<input type="button" class="button" value="취소"/>
				<input type="submit" class="button" value="적용"/>
			</div>
		</form>
	</div>
</div>
<div>
<div class="courseWrapper col-md-auto">				  
    <div class="tag-container space-evenly">		  
    	<div class="tag"><a href="course_list.cou<%=args %>&sort=scored" class='lineUp'>평점순</a></div>
    	<div class="tag"><a href="course_list.cou<%=args %>&sort=liked" class='lineUp'>좋아요순</a></div>
    	<div class="tag"><a href="course_list.cou<%=args %>&sort=namea" class='lineUp'>이름순</a></div>
    	<div class="tag"><span id="filter">필터</span></div>
    </div>
 <%
 String cid = "";		// 같은 코스 id를 가졌다면 같은 코스임을 의미한다는 것을 담을 변수 
 String lnk ="";			// 페이징정보를 담은 상세보기 화면  
boolean isend = false;
int k = 0;
 if(courseList.size() > 0) {
 	for(int i=0; i< courseList.size(); i++){
 		CourseInfo ci = courseList.get(i);
 		lnk = "<a href='course_view.cou" + args + "&ciid="+ ci.getCi_id() + "&sort="+pageInfo.getSort()+ "&psize="+pageInfo.getPsize() +"' class='cou_title' >";
 		if(i == 0){
 			cid = ci.getCi_id();		// 처음 들어온 경우
 			k++;
 %>
 		 <div class="flex-container space-evenly">	
 		 	<div class="course-container space-evenly">		 
				<div class="innerCourse">
					<p class="course-img"><%=lnk%><img alt="" src="/kosmoa/img/<%=ci.getCi_img() %>.jpg" width="300" height="300"></a></p>
				</div>
				<div class="innerCourse">
					<p class="course-name" ><%=lnk%><%=ci.getCi_name() %></a></p>
					<p class="cour_desc"><%=ci.getCi_desc() %></p>
					<p class="cour_desc2">#<%=ci.getCi_st_name().replace(", ", "  #")%><p>
				</div>

 <%		}else if(i > 0 && !cid.equals(ci.getCi_id())){		// 새로운 코스가 나온 경우	1. 2개를 다 채운경우, 2. 2개를 다 채우지 못한 경우
	 		cid = ci.getCi_id();
	 		if(k%2==0){		// 새로운 코스이면서 2개를 찍은 경우
%>	 			
				</div>	<!-- course-container space-evenly -->
				</div>	<!--  flex-container space-evenly -->  
		<div class="flex-container space-evenly">	
 		 	<div class="course-container space-evenly">		 
				<div class="innerCourse">
					<p class="course-img"><%=lnk%><img alt="" src="/kosmoa/img/<%=ci.getCi_img() %>.jpg" width="300" height="300">
					</a></p>
				</div>
				<div class="innerCourse">
					<p class="course-name" ><%=lnk%><%=ci.getCi_name() %></a></p>
					<p class="cour_desc"><%=ci.getCi_desc() %></p>
					<p class="cour_desc2">#<%=ci.getCi_st_name().replace(", ", "  #")%><p>
				</div>

<%	 		} else { %>
				</div>	<!-- course-container space-evenly -->
				<div class="course-container space-evenly">		 
				<div class="innerCourse">
					<p class="course-img"><%=lnk%><img alt="" src="/kosmoa/img/<%=ci.getCi_img() %>.jpg" width="300" height="300"></a></p>
				</div>
				<div class="innerCourse">
					<p class="course-name" ><%=lnk%><%=ci.getCi_name() %></a></p>
					<p class="cour_desc"><%=ci.getCi_desc() %></p>
					<p class="cour_desc2">#<%=ci.getCi_st_name().replace(", ", "  #")%><p>
				</div>
<%				
			}
	 		k++;
 		}
 		

 		if(i == courseList.size()-1 && k%2 ==1){		// 한줄에 코스가 한개일 경우
%> 			
			</div>	<!-- course-container space-evenly -->
			<div class="course-container space-evenly">
			<div class="innerCourse"> </div>
			<div class="innerCourse"> </div>
			</div>	<!-- course-container space-evenly -->
			</div>	<!--  flex-container space-evenly -->
<%		
		}else if ( i == courseList.size()-1 && k%2 == 0){ 	// 한줄에 코스가 2개일경우 
%>	 
			</div>	<!-- course-container space-evenly -->
			</div>	<!--  flex-container space-evenly -->
<% 		}
	}
  } 
%>
 <%
if(courseList.size()>0){
	out.println("<p class='paging' style='width=800px;' align='center'>");
	args = "?sort=" + pageInfo.getSort()+"&psize="+pageInfo.getPsize() + schargs;
	
	if (pageInfo.getCpage() == 1){
		out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
	}else {
		out.print("<a href='course_list.cou" + args + "&cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");	// 처음페이지로 이동
		out.println("<a href='course_list.cou" + args + "&cpage=" + (pageInfo.getCpage() -1 ) +"'>[&lt;]</a>&nbsp;&nbsp;");	// 이전 페이지로 이동 
	}// 첫 페이지와 이전 페이지 링크
	
	for (int i=0, j = pageInfo.getSpage(); i<= pageInfo.getBsize() && j<= pageInfo.getEpage(); i++, j++ ){
		if(pageInfo.getCpage() == j){
			out.print("&nbsp;<strong>" + j + "</strong>&nbsp;");
		}else{
			out.print("&nbsp;<a href='course_list.cou" + args + "&cpage=" + j + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (pageInfo.getCpage() == pageInfo.getPcnt()){
		out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
	}else {
		out.print("&nbsp;&nbsp; <a href='course_list.cou" + args + "&cpage=" + (pageInfo.getCpage()+1) + "'>[&gt;]</a>");
		out.println("&nbsp;&nbsp;<a href='course_list.cou" + args + "&cpage="+ (pageInfo.getPcnt()) + "'>[&gt;&gt;]</a>");
	}
	out.println("</p>");
}
%>
</div>
</header>
</body>
</html>