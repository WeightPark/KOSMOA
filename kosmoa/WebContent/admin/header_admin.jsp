<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.vo.*" %>
<%
request.setCharacterEncoding("utf-8");
AdminInfo adminInfo = (AdminInfo)session.getAttribute("adminInfo");
boolean isLogin = false;
if(adminInfo != null){
	isLogin = true;
}

%>
<style>
a:link { text-decoration:none; color:black; }
a:visited { text-decoration:none; color:black; }
a:hover { text-decoration:underline; color:red; }
</style>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>코스모아 관리자 페이지</title>

</head>
<body>
<header class="py-3 mb-4 bg-white border-bottom fixed-top mt-0">
<div class="container d-flex flex-wrap justify-content-center">
    <a href="main.adm" class="d-flex align-items-center mb-3 mb-lg-0 me-lg-auto text-dark text-decoration-none">
    <span class="fs-4 px-4 fw-bold"><strong>KOSMOA</strong></span>
    </a>
    <form class="col-12 col-lg-auto mb-3 mb-lg-0">
        <ul class="nav">
<% if(adminInfo != null){ %>
    <li class="nav-item"><a href="admin/admin_logout.jsp" class="nav-link link-dark px-2">Logout</a></li>
<% }else { %>
	<li class="nav-item"><a href="login.adm" class="nav-link link-dark px-2">Login</a></li>
    <li class="nav-item"><a href="adminJoinForm.jsp" class="nav-link link-dark px-2">Join</a></li>
<% } %>
    </form>
</div>
</header>
</body>
</html>