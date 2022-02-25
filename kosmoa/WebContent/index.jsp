<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ include file="../inc/header_nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<title>Insert title here</title>
<style>
.courseWrapper { margin-top: 120px; border: 1px solid black; height: 1600px; }
.tagWrapper { margin: 20px; border: 1px solid blue; height: 80px; }
.flex-container{
    display: flex; padding: 10px; border: 1px solid black;
    margin:5px; background-color: white; 
}
.flex-container.space-evenly{ justify-content: space-evenly; }
.course{
    width: 700px; height: 330px; margin: 5px; color: white;
    font-size: 36px; text-align: center; background-color: cornflowerblue;
}


.reviewWrapper { margin-top: 20px; border: 1px solid black; height: 500px; }
.reviewBox { height: 450px; width: 90%; margin: auto; }
.review { border: 1px solid black; margin: 10px; height: 440px; width: 370px; text-align: center }

.placewWrapper { margin-top: 20px; border: 1px solid black; height: 800px; }
.place { border: 1px solid black; margin: 5px; width: 350px; height: 350px; text-align: center }

.footerWrapper { margin-top: 20px; border: 1px solid black; height: 300px; }
</style>
</head>
<body>

<div class="courseWrapper col-md-auto">
    <div class="tagWrapper">태그 영역</div>
    <div class="flex-container space-evenly">
        <div class="course">코스</div>
        <div class="course">코스</div>
    </div>
    <div class="flex-container space-evenly">
        <div class="course">코스</div>
        <div class="course">코스</div>
    </div>
    <div class="flex-container space-evenly">
        <div class="course">코스</div>
        <div class="course">코스</div>
    </div>
    <div class="flex-container space-evenly">
        <div class="course">코스</div>
        <div class="course">코스</div>
    </div>
</div>
<div class="reviewWrapper">
    <div class="flex-container space-evenly">
        <div class="review">리뷰</div>
        <div class="review">리뷰</div>
        <div class="review">리뷰</div>
        <div class="review">리뷰</div>
    </div>
</div>
<div class=placewWrapper>
    <div class="flex-container space-evenly">
        <div class="place">장소</div>
        <div class="place">장소</div>
        <div class="place">장소</div>
        <div class="place">장소</div>
    </div>
    <div class="flex-container space-evenly">
        <div class="place">장소</div>
        <div class="place">장소</div>
        <div class="place">장소</div>
        <div class="place">장소</div>
    </div>
</div>
<div class="footerWrapper">
    푸터 영역
</div>
</header>

</body>
</html>