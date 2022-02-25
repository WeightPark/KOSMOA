<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.vo.*" %>
<%
request.setCharacterEncoding("utf-8");
PriMemberInfo memberInfo = (PriMemberInfo)session.getAttribute("memberInfo");
boolean isLogin = false;
if(memberInfo != null){
	isLogin = true;
}

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>어서오세요 KOSMOA입니다.</title>

</head>
<style>

</style>
<body>
<nav class="py-2 bg-light border-bottom fixed-top">
<div class="container d-flex flex-wrap">
    <ul class="nav me-auto">
	    <li class="nav-item"><a href="course_list.cou" class="nav-link link-dark px-4 active" aria-current="page">코스</a></li>
	    <li class="nav-item"><a href="place_list.pla" class="nav-link link-dark px-4">장소</a></li>
	    <li class="nav-item"><a href="review_list.riv" class="nav-link link-dark px-4">후기</a></li>
	    <li class="nav-item"><a href="#" class="nav-link link-dark px-4">고객센터</a></li>
    </ul>   
    <ul class="nav">
   <% if(memberInfo != null){ %>
    <li class="nav-item"><a href="/kosmoa/member_view_my_info.mem" class="nav-link link-dark px-2">My Page</a></li>
    <li class="nav-item"><a href="member/logout.jsp" class="nav-link link-dark px-2">Logout</a></li>
<% }else { %>
	<li class="nav-item"><a href="/kosmoa/loginForm.head" class="nav-link link-dark px-2">Login</a></li>
    <li class="nav-item"><a href="/kosmoa/joinForm.head" class="nav-link link-dark px-2">Join</a></li>
<% } %>
    </ul>
</div>
</nav>
<header class="py-3 mb-4 bg-white border-bottom fixed-top mt-5">
<div class="container d-flex flex-wrap justify-content-center">
    <a href="main" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
    <span class="fs-4 px-4 fw-bold" ><strong>KOSMOA</strong></span>
    </a>
    <form class="col-12 col-lg-auto mb-3 mb-lg-0" name ="frmKeyword" onsubmit = "doSearch(this);" >
    	<input type="text" id="keyword"  class="form-control" placeholder="Search..." aria-label="Search" name="keyword" value="" />
    </form>
</div>
</header>
</body>
</html>