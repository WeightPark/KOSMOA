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
.flex-start{
    display: flex; padding: 10px;
    margin:5px; background-color: white; justify-content: start;
}

.tag {
    width: 120px; height: 50px; margin: 5px; color: black; border-radius: 1em; padding: 10px; font-weight: bold;
    font-size: 20px; text-align: center; display: table-cell; vertical-align: middle; border: 1px solid black; 
}

.hot { margin-left: 50px; font-size: 20px; font-weight: bold;  }

.courseWrapper { padding-top: 100px; width: 1200px; height: 1720px; margin: 0 auto; }
.tagWrapper { margin: 20px; height: 80px; }
.flex-container{
    display: flex; padding: 10px; 
    margin:5px; background-color: white; justify-content: space-evenly;
}
.course{
    width: 530px; height: 330px; margin: 5px; color: white;
    font-size: 36px; text-align: center; border: 1px solid black;
}
.cname { font-size: 0.8em; }
.stick { margin: -10 0 10 0; }
.cImg { width: 320px; height: 300; color: black; border: 1px solid black; padding: 0; }
.desc { width: 350px; height: 300; color: black;}


.reviewWrapper {  margin: 0 auto; width: 1200px; height: 390px; }
.reviewBox { height: 340px; width: 90%; margin: 0 auto; }
.review { 
    border: 1px solid black; height: 300px; width: 250px; 
    text-align: center; color: black; font-size: 25px; border: 1px solid black; 
}
.img { 
	width: 245px; height: 210px; padding-top: 5px; background-color: white; margin: 2px auto; 
	border: 1px solid black; padding: 0;
}

.placewWrapper { margin: 0 auto; width: 1200px; height: 680px; }
.place { border: 1px solid black; margin: 5px; width: 250px; height: 250px; text-align: center; color: black; font-size: 36px;  }

.footerWrapper { margin: 0 auto; width:1200px; height: 500px; padding-top: 50px; }
</style>
s
<script type="text/javascript">

</script>
</head>
<body onload="loadMain();">
<div class="courseWrapper">
    <div class="tagWrapper flex-container">
	    <div class="tag"><a href="main.main">#전체</a></div>
<%
for (int i = 0 ; i < tagList.size() ; i++) {
%>
    	<div class="tag"><a href="main.main?tagName=<%=tagList.get(i) %>">#<%=tagList.get(i) %></a></div>
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
        <div class="course flex-container">
            <div class="cImg"><img alt="코스 이미지" src="../img/<%=ci.getCi_img() %>.png" width="280" height="300"></div>
            <div class="desc">
            	<p class="cname" style="margin-top: 25px;"><a href="../course/course_view.jsp?ciid=<%=ci.getCi_id() %>"><%=ci.getCi_name() %></a></p>
<%
	for (int j = 0 ; j < ci.getCourse_place_list().size() ; j++) {
		PlaceInfo pi = ci.getCourse_place_list().get(j);
		if (j != 0)	out.println("<p class=\"stick\" style=\"font-size: 5px;\">|</>");
%>
                <p class="cplace" style="font-size: 20px;">
                <% out.print((pi.getPi_name().length()) > 7 ? (pi.getPi_name().replace(pi.getPi_name().substring(7), "...")) : pi.getPi_name()); %>
                </p>
<%
	}
%>
            </div>
        </div>
<%
	if (i % 2 == 1 || courseList.size() == 1) {
		out.println("</div>");
	}
}
%>

<div class="reviewWrapper">
	<span class="hot">인기 리뷰</span>
    <div class="flex-container">
<% 
for(int i = 0 ; i < reviewList.size() ; i++) {
	CourseReviewInfo cri = reviewList.get(i);
%>
        <div class="review">
            <div class="img"><img alt="리뷰 이미지" src="../img/<%=cri.getCrl_img1() %>.png" width="243" height="208"></div>
            <%=(cri.getCrl_title().length() > 11 ? (cri.getCrl_title().replace(cri.getCrl_title().substring(8), "...")) : cri.getCrl_title()) %><br/>
            <P style="font-size: 22px;"><%=cri.getCrl_score() %> 점</P>
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
        <div class="place"><a href="../place/place_view.jsp?piid=<%=pi.getPi_id() %>"><img alt="<%=pi.getPi_name() %>" src="../img/<%=pi.getPi_img1() %>.png" width="250" height="250"></a></div>
<% 
	if (i == 3 || i == 8) {
		out.print("</div>");	
	}
} 
%>
</div>
<div class="footerWrapper">
    푸터 영역
</div>
</header>
</body>
</html>