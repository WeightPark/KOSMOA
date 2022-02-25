<%@page import="review.vo.CourseReviewInfo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<%@page import="course.vo.*"%>
<%@page import="place.vo.*"%>
<%
request.setCharacterEncoding("utf-8");

ArrayList<CourseInfo> courseList = (ArrayList<CourseInfo>)request.getAttribute("courseList");
ArrayList<PlaceInfo> placeList = (ArrayList<PlaceInfo>)request.getAttribute("placeList");			
ArrayList<CourseReviewInfo> reviewList = (ArrayList<CourseReviewInfo>)request.getAttribute("reviewList");
ArrayList<String> tagList = (ArrayList<String>)request.getAttribute("tagList");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
<style>
a { color: black; }
a:link, a:visited, a:hover { text-decoration: none; }
 
img { display:block; vertical-align:bottom;}

.flex-start{
    display: flex; padding: 10px;
    margin:5px; background-color: white; justify-content: start;
}


.tag {
    width: 120px; height: 50px; margin: 5px; color: black; border-radius: 1em; padding: 10px; font-weight: bold;
    font-size: 20px; text-align: center; display: table-cell; vertical-align: middle; border: 1px solid black; 
}

.hot { display:inline-block; margin-left:50px; margin-top:50px; font-size: 30px; font-weight: bold; }
.hot:before {
    content: "• ";
    color: navy;
    text-weight:bold;
}

.courseWrapper { padding-top: 120px; width: 1200px; height:1900px; margin: 0 auto; }
.tagWrapper { margin: 20px; height: 80px; }
.flex-container{
    display: flex; padding: 10px; 
    margin:5px; background-color: white; justify-content: space-between;
    border-radius: 30px;
}
.course{
    width:520px; height: 350px; margin: 5px; color: white;
    font-size: 36px; text-align: center; border: 3px solid #4C4C4C;
    border-radius: 30px;
}


.cImg { width: 300px; height: 230px; color: black;  padding: 0; }
.cImg img { border:2px solid #4C4C4C; border-radius: 15px;  padding: 0; margin-right:0; }
.desc { width:220px; height: 230px; color: black; text-align: left;}
.cname { width:101%; font-size:0.5em; padding: 10px 5px;  border-bottom: 1px solid #4C4C4C;  margin: 0 0 12px -3px; }
.placeList { font-size: 16px; font-weight: bold; margin-bottom: 30px; color: #4C4C4C; text-align: center;}
.cplace { margin: 0; padding: 10px 0 0 60px; color:#4C4C4C; font-weight:bold; }

li::marker {
    color: #EDA900; /* or whatever color you prefer */
}

.reviewWrapper {  margin: 0 auto; width: 1200px; height:500px; }
.reviewBox { height: 340px; width: 90%; margin: 0 auto; }
.review { 
    border: 1px solid black; height: 300px; width: 250px; 
    text-align: center; color: black; font-size: 25px; border: 2px solid #4C4C4C; 
    border-radius: 15px; 
}
.img { 
	width: 245px; height: 210px; padding-top: 5px; background-color: white; margin: 0 auto; 
	padding: 0; border-radius: 15px; 
}

.placewWrapper { margin: 0 auto; width: 1200px; height: 680px; }
#place { margin: 5px; width: 250px; 
		 height: 250px; text-align: center; color: black; font-size: 36px;  
}
#place p {
    position: relative;
}
#place p img {
 	z-index: 1;
 	border:2px solid #4C4C4C; 
 	border-radius:15px;
}
#place p strong {
	font-size: 23px; text-align: center; background-color: black; background: rgba(0, 0, 0, 0.3);
    opacity: 0;  position: absolute; top: 0%; left: 0;  color: white; width: 250px; height: 250px;
    line-height:250px; border-radius:15px;
}

#footer { margin: 0 auto; width:100%; height: 200px; padding-top: 50px; }
</style>
<script src="js/jquery-3.6.0.js"></script>
<script type="text/javascript">
function doSearch(frm){
	frm.action = "course_list.cou";
}
$(document).ready(function() {
    var duration = 200; // 이미지에 효과를 적용할 시간(0.3초)
    var $place = $("#place p");   
    // 아이디가 'images'인 div 안에 존재하는 모든 p 요소를 $images에 저장

    // images의 첫 번째 이미지
    $place.on("mouseover", function() {
        $(this).find("strong, span").stop(true).animate({ opacity:1 }, duration);
        // 마우스 오버시 이벤트가 일어난 객체에 strong과 span 요소가 있으면 완전 불투명하게 보여준다.
    }).on("mouseout", function(){
        $(this).find("strong, span").stop(true).animate({ opacity:0 }, duration);
    });
});
</script>

</head>
<body>
<div class="courseWrapper">
    <div class="tagWrapper flex-container">
	    <div class="tag"><a href="main">#전체</a></div>
<%
for (int i = 0 ; i < tagList.size() ; i++) {
%>
    	<div class="tag"><a href="main?tagName=<%=tagList.get(i) %>">#<%=tagList.get(i) %></a></div>
<%
}
%>
    </div>
    <span class="hot">인기 코스</span>
<%
for (int i = 0 ; i < courseList.size() ; i++) {
	CourseInfo ci = courseList.get(i);
	if (i % 2 == 0) {
		out.println("<div class=\"flex-container\">");
	}
%>
		
      	
        <div class="course">
	        <p class="cname">
	      		<a href="course_view.cou?cpage=1&ciid=<%=ci.getCi_id() %>"><%=ci.getCi_name() %></a>
	      	</p>
	      	<div class="flex-container"> 
            <div class="cImg">
            	<a href="course_view.cou?cpage=1&ciid=<%=ci.getCi_id() %>">
            		<img alt="코스 이미지" src="img/<%=ci.getCi_img() %>.jpg" width="250" height="250">
            	</a>
            </div>
            <div class="desc">
            	<p class="placeList">------- Line-Up -------</p>
				<ul class="cplace">
<%
	for (int j = 0 ; j < ci.getCourse_place_list().size() ; j++) {
		PlaceInfo pi = ci.getCourse_place_list().get(j);
		if (j != 0)	out.println("<p class=\"stick\" style=\"font-size: 5px; margin: 10px 0;\">&nbsp;</p>");
%>
                <li style="font-size: 15px;">
                <% out.print((pi.getPi_name().length()) > 10 ? (pi.getPi_name().replace(pi.getPi_name().substring(7), "...")) : pi.getPi_name()); %>
                </li>
<%
	}
%>	
				</ul>
			</div>
            </div>
        </div>
<%
	if (i % 2 == 1 || courseList.size() == 1) {
		out.println("</div>");
	}
}
%>
</div>

<div class="reviewWrapper">
	<span class="hot">인기 리뷰</span>
    <div class="flex-container">
<% 
for(int i = 0 ; i < reviewList.size() ; i++) {
	CourseReviewInfo cri = reviewList.get(i);
%>
        <div class="review">
            <div class="img">
            	<a href="course_view.cou?cpage=1&ciid=<%=cri.getCi_id()%>">
            		<img alt="리뷰 이미지" src="/kosmoa/img/<%=cri.getCrl_img1() %>.jpg" width="245" height="208" style="border-radius:15px;">
            	</a>
           </div>
            <p style="font-size:17px;margin-top:5px;"><%=(cri.getCrl_title().length() > 11 ? (cri.getCrl_title().replace(cri.getCrl_title().substring(8), "...")) : cri.getCrl_title()) %></p>
            <P style="font-size: 15px;"><%=cri.getCrl_score() %>점</P>
        </div>
<% 
} 
%>
    </div>
</div>
<div class=placewWrapper>
<span class="hot">인기 장소</span>
<% 
for (int i = 0 ; i < placeList.size() ; i++) {
	PlaceInfo pi = placeList.get(i);
	if (i == 0 || i == 4) {
		out.print("<div class=\"flex-container placeBox\">");	
	}
%>
       <div id="place">
       	 <a href="place_view.pla?cpage=1&piid=<%=pi.getPi_id() %>">
       		<p>
       			<img alt="<%=pi.getPi_name() %>" src="./img/<%=pi.getPi_img1().trim() %>.jpg" width="250" height="250">
       
       			<strong><%=pi.getPi_name() %></strong>
       		</p>
		 </a>
       </div>
<% 
	if (i == 3 || i == 8) {
		out.print("</div>");	
	}
} 
%>
</div>
<div id="footer">
</div>
</header>
</body>
</html>