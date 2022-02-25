<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header_nav.jsp" %>
<%@ page import="review.vo.*" %>
<%@ page import="java.util.*" %>

<%
request.setCharacterEncoding("utf-8");
PreviewPageInfo placeReview = (PreviewPageInfo)request.getAttribute("placeReview");

ArrayList<PlaceReviewInfo> pReview = (ArrayList<PlaceReviewInfo>)request.getAttribute("pReview");
ArrayList<CourseReviewInfo> cReview = (ArrayList<CourseReviewInfo>)request.getAttribute("cReview");
out.println(cReview.size());
String args = "";
// 장소 검색관련 쿼리스트링 제작
args = "?cpage=" + placeReview.getCpage();

if (placeReview.getKeyword() != null && !placeReview.getKeyword().equals("") ) {	
	args +="&keyword=" + placeReview.getKeyword();
}
if (placeReview.getKind() != null && !placeReview.getKind().equals("")){
	args +="&kind=" + placeReview.getKind();
}
System.out.println("args : " + args);
String kind = placeReview.getKind();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#riv { margin-top:120px;  }
#wrapper {  width:1100px; height:1000px; margin: 0 auto;}
#rivList_wrapper { width:1000px; height:800px; text-align:Center;  }
#review_regit { text-align:right; width:1000x;  }
#wrap {  margin-top:10px; margin-bottom:10px; border:1px solid orange;  height:180px;  }
.pimg { float:left; width:200px; height:180px; margin-right:5px; }
.r_img { width:250px; height:180px; display:inline-block; margin:0; }
.r_img img { width:250px; height:180px; margin:0;}
#creview { width:500px; height:180px; clear:both; }

.preview { width:1100px; height:180px; margin:0 auto; position:relative; }
.preview_title { width:500px; height:70px; display:inline-block; text-align:left; margin-left:-100px; } 
.preview_detail { width:300px; text-overflow: ellipsis;   overflow : hidden; display:inline-block; float:left; 
    -webkit-line-clamp: 2; /* 라인수 */
    -webkit-box-orient: vertical;
    word-wrap:break-word; 
    line-height: 1.2em;
    height: 3.6em; 
    text-align:left;
    margin-left:140px; 
    }
.tab { width:80px; height:30px; display:inline-block; text-align:center; }
#tab { text-align:right; }

.paging { margin-top:40px;  }

#preview_like { width:40px; height:40px;  background:url("courseplace/images/like.png");  }

a { color: black; }
a:link, a:visited, a:hover { text-decoration: none; }
</style>
<script src="js/jquery-3.6.0.js"></script>
<script>
function showTab(chk){
	var pla = document.getElementById("pla_review");
	var cou = document.getElementById("cou_review");
	var frm = document.listFrm;
	if (chk == "a") {
		frm.kind.value = "p";
		location.href = "review_list.riv?kind=p"
	}else{
		frm.kind.value = "c";
		location.href = "review_list.riv?kind=c"
	}
}

function setColor(){
	var a = document.getElementById("tabA");
	var b = document.getElementById("tabB");
	var frm = document.listFrm;
	frm.kind.value = "<%=placeReview.getKind() %>"
	if (frm.kind.value =='p'){
		a.style.color="red";
	}else{
		b.style.color="red";
	}
}

function callLike(num){
	var isConfirm = true;
	var idx = num;
	if(isConfirm){
		$.ajax({
			type : "POST", 				
			url : "/kosmoa/review_list.riv<%=args%>",		
			data : { "type" : "like", "rvid" : idx , "kind" : "<%=kind %>" },		
			success : function(chkRs){ 				
				if (chkRs==0)	alert("좋아요 실패");	
				else 			location.reload();		
			}
		});
	}
}
</script>
</head>
<body onload="setColor();">
<div id="riv">
<div id="wrapper" >
<div id="rivList_wrapper" >
	<p id="tab"> <span class="tab" id="tabA" onclick="showTab('a');">장소후기</span>
		 <span class="tab" id="tabB" onclick="showTab('b');">코스 후기</span> 
	</p>
	
	<p id="review_sch">
		<form name="listFrm" action="review_list.riv" method="get">
		<input type="hidden" name="kind" value="<%=kind %>" />	
		<span>제목 검색 </span><input type="text" name="keyword" value="" />
		</form>
	</p>

<% if(placeReview.getKind().equals("p") ){ %>
	<div id="pla_review">
<%	for(int i=0; i<pReview.size(); i++ ) {
		PlaceReviewInfo prinfo = pReview.get(i);
		int seq = placeReview.getRcnt() - ((placeReview.getCpage() - 1)*placeReview.getPsize());
%>		
	<div id="wrap">
		<div id="creview">
			<div class="pimg">
				<span class="r_img"><img src="/kosmoa/img/<%=prinfo.getPrl_img1() %>.jpg"></span>
			</div>
			<div class="preview">
				<p>
					<span class="preview_title">제목 : <%=prinfo.getPrl_title() %></span>
					<span class="preview_rate" >평점 : <%=prinfo.getPrl_score() %></span>
				</p>
				<p>
				<span class="preview_detail"><%=prinfo.getPrl_content() %></span>
				</p>
			</div>
		</div>
	</div>	
		
		
<%	seq --; } %>
<% } else { %>
	<div id="cou_review">
<%	for(int i=0; i< cReview.size(); i++ ) {
		CourseReviewInfo crinfo = cReview.get(i);
%>
	<div id="wrap">
		<div id="creview">
			<div class="pimg">
				<span class="r_img"><img src="/kosmoa/img/<%=crinfo.getCrl_img1() %>.jpg" width="200" height="180"></span>
			</div>
			<div class="preview">
				<p>
					<span class="preview_title">제목 : <%= crinfo.getCrl_title() %></span>
					<span class="preview_rate"> 평점 : <%= crinfo.getCrl_score() %></span>
					<span calss="preview_like" onclick = "callLike(<%=crinfo.getCrl_idx() %>);">좋아요 : <%=crinfo.getCrl_good() %></span>
				</p>
				<p>
				<span class="preview_detail"><%=crinfo.getCrl_content() %></span>
				</p>
			</div>
		</div>
	</div>

<% 	}
}
%>
</div>
</div>

</div>

<%
if(pReview.size()>0 && placeReview.getKind().equals("p")){
	out.println("<p class='paging' id='place_page' style='width=800px;' align='center'>");
	args = "?keyword=" + placeReview.getKeyword() + "&kind=" + placeReview.getKind()+"&piid=" +placeReview.getPiid();
	
	if (placeReview.getCpage() == 1){
		out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
	} else {
		out.print("<a href='review_list.riv" + args + "&cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");	// 처음페이지로 이동
		out.println("<a href='review_list.riv" + args + "&cpage=" + (placeReview.getCpage() -1 ) +"'>[&lt;]</a>&nbsp;&nbsp;");	// 이전 페이지로 이동 
	} // 첫 페이지와 이전 페이지 링크
	
	for (int i=0, j = placeReview.getSpage(); i<= placeReview.getBsize() && j<= placeReview.getEpage(); i++, j++ ){
		if(placeReview.getCpage() == j){
			out.print("&nbsp;<strong>" + j + "</strong>&nbsp;");
		}else{
			out.print("&nbsp;<a href='review_list.riv" + args + "&cpage=" + j + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (placeReview.getCpage() == placeReview.getPcnt()){
		out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
	}else {
		out.print("&nbsp;&nbsp; <a href='review_list.riv" + args + "&cpage=" + (placeReview.getCpage()+1) + "'>[&gt;]</a>");
		out.println("&nbsp;&nbsp;<a href='review_list.riv" + args + "&cpage="+ (placeReview.getPcnt()) + "'>[&gt;&gt;]</a>");
	}
	out.println("</p>");
} else if (cReview.size()> 0 && placeReview.getKind().equals("c")){ 
	out.println("<p class='paging' id='place_page' style='width=800px;' align='center'>");
	args = "?keyword=" + placeReview.getKeyword() + "&kind=" + placeReview.getKind() + "&ciid=" +placeReview.getCiid();
	
	if (placeReview.getCpage() == 1){
		out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
	}else {
		out.print("<a href='review_list.riv" + args + "&cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");	// 처음페이지로 이동
		out.println("<a href='review_list.riv" + args + "&cpage=" + (placeReview.getCpage() -1 ) +"'>[&lt;]</a>&nbsp;&nbsp;");	// 이전 페이지로 이동 
	}// 첫 페이지와 이전 페이지 링크
	
	for (int i=0, j = placeReview.getSpage(); i<= placeReview.getBsize() && j<= placeReview.getEpage(); i++, j++ ){
		if(placeReview.getCpage() == j){
			out.print("&nbsp;<strong>" + j + "</strong>&nbsp;");
		}else{
			out.print("&nbsp;<a href='review_list.riv" + args + "&cpage=" + j + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (placeReview.getCpage() == placeReview.getPcnt()){
		out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
	}else {
		out.print("&nbsp;&nbsp; <a href='review_list.riv" + args + "&cpage=" + (placeReview.getCpage()+1) + "'>[&gt;]</a>");
		out.println("&nbsp;&nbsp;<a href='review_list.riv" + args + "&cpage="+ (placeReview.getPcnt()) + "'>[&gt;&gt;]</a>");
	}
	out.println("</p>");
	
}

%>
</div>
</div>
</body>
</html>