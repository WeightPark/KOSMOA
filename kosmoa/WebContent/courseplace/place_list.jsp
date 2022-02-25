<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="place.vo.*" %>
<%@ page import="java.util.*" %>
<%@ include file="../inc/header_nav.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
request.setCharacterEncoding("utf-8");
ArrayList<PlaceInfo> placeList = (ArrayList<PlaceInfo>)request.getAttribute("placeList");
PlacePageInfo pageInfo = (PlacePageInfo)request.getAttribute("placePageInfo");

String args = "", schargs = "";	
// 검색관련 쿼리스트링 제작

if (pageInfo.getKeyword() != null && !pageInfo.getKeyword().equals("") ) {	
	schargs +="&keyword=" + pageInfo.getKeyword();
}
if (pageInfo.getBcata() != null && !pageInfo.getBcata().equals("")){
	schargs +="&bcata=" + pageInfo.getBcata();
}
if (pageInfo.getScata() != null && !pageInfo.getScata().equals("")){
	schargs +="&scata=" + pageInfo.getScata();
}
if (pageInfo.getTag() != null && !pageInfo.getTag().equals("")){
	schargs +="&brand=" + pageInfo.getTag();
}
if (pageInfo.getKey() != null && !pageInfo.getKey().equals("")){
	schargs +="&sprice=" + pageInfo.getKey();
}
if (pageInfo.getArea() != null && !pageInfo.getArea().equals("")){
	schargs +="&area=" + pageInfo.getArea();
}


args = "?cpage=" + pageInfo.getCpage() + schargs;
System.out.println(args + ";");
%>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">

<style type="text/css">

.placewWrapper {	
	width: 1100px;
	margin: 0 auto;
	height: auto; 
}

.cou_title { text-decoration:none; color: black; } 

.placeHeader {		/* 占쎌젟占쎌졊 獄쏉옙 占쎈툡占쎄숲 �겫占썽겫占� */
	display:flex;
	width:1100px;
	margin: 0 auto;
	margin-top: 130px;
	height: 50px; 
	justify-content: space-between;
	align-items: center;
}

#plsArray {			/* 占쎌젟占쎌졊 占쎄퐬占쎌젟 �겫占썽겫占� */
	width:300px;
	text-align: center;
}
#plsArray a {
	margin-right: 20px;
}

#plsFilter {		/* 占쎈툡占쎄숲 甕곌쑵�뱣 �겫占썽겫占� */
	width:100px;
	text-align: center; 
}

a { color: black; }
a:link, a:visited, a:hover { text-decoration: none; }

.flex-container{		/* 占쎌삢占쎈꺖 占쎈립 占쎈뻬占쎌뱽 揶쏅Ŋ�뼢占쎈뮉 div, flex 占쎄퐬占쎌젟 */
    display: flex; 
    padding: 10px; 
    margin:5px; 
    background-color: white; 
    flex-glow:0;
    flex-shrink:0;
    justify-content: space-evenly;
}

.place { 			/* 占쎈립 占쎌삢占쎈꺖�몴占� 癰귣똻肉т틠�눖�뮉 div */
	border: 1px solid black; 
	margin: 5px; 
	width: 350px; 
	height: 400px; 
	text-align: center;
}

.plsPhoto{			/* 占쎈립 占쎌삢占쎈꺖 占쎈툧占쎈퓠占쎄퐣 癰귣똻肉э쭪占쏙옙�뮉 占쎄텢筌욑옙 �겫占썽겫占� */
	border:1px solid black;
	width: 330px;
	height: 330px;
	margin:10px auto; 
}

.plsTitle{			/* 占쎈립 占쎌삢占쎈꺖 占쎈툧占쎈퓠占쎄퐣 癰귣똻肉э쭪占쏙옙�뮉 占쎌삢占쎈꺖 占쎌뵠�뵳占� �겫占썽겫占� */
	display:inline-block;
	width: 250px;
	height: 45px;
	margin: 5px 10px; font-size: 18px; font-weight: bold;
}

.plsAverage{		/* 占쎈립 占쎌삢占쎈꺖 占쎈툧占쎈퓠占쎄퐣 癰귣똻肉э쭪占쏙옙�뮉 占쎈즸占쎌젎 �겫占썽겫占� */
	display:inline-block;
	width: 60px;
	height: 45px;
}

.footerWrapper { 	/* 占쎈쳳占쎄숲占쎌겫占쎈열  */
	border:1px solid black;
	margin-top: 20px; 
	height: 300px; 
}

#wrapperBox{ 		/* 占쎌읈筌ｋ 占쏙옙 揶쏅Ŋ 뼢占쎈뮉 div */
	width: 520px;
	height: 750px;
	padding: 5px;	
	border: 1px solid black;
	position: relative;
	background: white;
}

.tabBox {			/* tap 甕곌쑵�뱣占쎌뱽 揶쏅Ŋ�뼢占쎈뮉 div */
	display: inline-block;
	width: 350px;
	position: absolute;
	z-index: 0;
}

#fPlus{				/* 筌띯뫁�맄占쎌벥 占쎈쐭癰귣떯由� 甕곌쑵�뱣 */
	display: inline-block;
	width: 100px;
	margin-left: 45px;
	text-align: right;
	font-size: 0.8em;
}
input[type="radio"] {	/* 占쎈툡占쎌뵠占쎈탵筌≪뼐由�, �뜮袁⑨옙甕곕뜇�깈 筌≪뼐由� radio 甕곌쑵�뱣 */
	display: none;
}

input[type="radio"] + label {		 
	display: inline-block; 
	width: 100px;
	height: 30px;
	text-align: center;
	line-height: 30px;
	color: #999;
	font-size: 13px;
	font-weight:bold;
	cursor: pointer;
	
}

input[type="radio"]:checked + label {	 
	color: #000;
	border-top: 1px solid #000;
	border-right: 1px solid #000;
	border-left: 1px solid #000;
}



table {				/* table */
	width: 500px;
	height: 600px;
	celspacing: 0;
	margin-top: 30px;
	border-collapse: collapse;
	border: 1px solid black;
	text-align: center;
	position: absolute;
	z-index: 2;
}

td {				/* table占쎌벥 td */
	padding: 5px;
}

.cata{				/*  �겫袁⑥첒 td */
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding-left: 10px;
	text-align: left;
	
}
.plus {				/* �겫袁⑥첒 td 餓ο옙 占쎈쐭癰귣떯由� 甕곌쑵�뱣 */
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


input[type="checkbox"] {
	display:none;
}

input[type="checkbox"] + label {
	display: inline-block;
	width: 100%;
	height: 100%;
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
	top:0; left:30%;
	z-index : 9999;
	height:0; overflow:hidden;
}

#pla-entertain { display:block;  }
</style>

<script src="/kosmoa/js/jquery-3.6.0.js"></script>
<script>


// 필터에 대한 스크립트
function setVal(sch){
	var frm = document.getElementById("frmSch");
	if( sch.startsWith('a') || sch.startsWith('b') || sch.startsWith('c') ){
		if( frm.scata.value.indexOf(sch) > 0 ){
			frm.scata.value = frm.Scata.value.replace(','+sch , '');
		}else {
			frm.scata.value += "," + sch;	
		}
		
	}else if (sch.startsWith('t')){
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
		
	}else {
		if ( frm.area.value.indexOf(sch) > 0 ){
			frm.area.value = frm.area.value.replace(','+sch , '');
		}else {
			frm.area.value += ","+sch;
		}
	
	}
}

function setKey(frm){
	var val = document.getElementById("keyword").value;
	alert(val);
	frm.keyword.value = val;
}

$(document).ready(function () {
	 
	$("#filter").click(function () {
		var open = $("#slideUp").height();
		var el = $("#slideUp"),
			curHeight = el.height(),
			autoHeight = el.css('height', 'auto').height();
		if (open === 0){
			el.height(curHeight).animate({height: autoHeight}, 500);
		}else {
			el.animate({height : 0}, 500);
		}
	}); 
});
	

function tabMenu(tab){
	var placeTab = document.getElementById("pla-restaurant");
	var enterTab = document.getElementById("pla-entertain");
	
	if (tab == 'a'){
		placeTab.style.display="table";
		enterTab.style.display="none";
	}else{
		placeTab.style.display="none";
		enterTab.style.display="table";
	}
}

function doSearch(frm){
	frm.action = "place_list.pla";
}
</script>
</head>

<body>
<div id="navi">
 
</div>

<!-- 정렬 및 필터 부분 -->
<div class="placeHeader">
	<div id="plsArray">
		<a href="place_list.pla<%=args %>&sort=scored" class="cou_title" > 평점순</a> 
		<a href="place_list.pla<%=args %>&sort=idd" class="cou_title"  > 최신순</a> 
	</div>
	<div id="plsFilter">
		<span id="filter"> 필터 </span>
	</div>
</div>

<!-- onclick="showFilter(); -->
<!-- 필터. 숨길것임 -->
<div id="slideUp">
	<div id="wrapperBox"> <!-- 전체를 감싸는 div -->
		<form name="frmSchFilter" action="place_list.pla" id="frmSch" onsubmit = "setKey(this);">
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



<!-- 필터 종료 -->

<!-- 장소 보여지는 부분 -->
<div class="placewWrapper">
    
      <% for(int i=0; i<placeList.size(); i++){
    	  PlaceInfo pi = placeList.get(i);
    	  String lnk = "<a href='place_view.pla" + args + "&piid="+ pi.getPi_id() + "&sort="+pageInfo.getSort()+ "&psize="+pageInfo.getPsize() +"' class='cou_title'>";
     	  if (i%3 == 0){
      %>		  
     	  	<div class="flex-container space-evenly">	<!-- 장소 1번 행  -->
     <%   }
    	  
       %> 
      
        <div class="place">
        	<div class="plsPhoto"><%=lnk %><img src="/kosmoa/img/<%=pi.getPi_img1()%>.jpg" width="100%" height="100%"  /></div>
        	<div class="plsTitle"><%=pi.getPi_name() %> </a></div>
        	<div class="plsAverage"><%=pi.getPi_score() %></div>
        </div>
      <% if(i == placeList.size()-1 && i % 3 != 2){
   			for(int j=0; j<2-(i%3); j++){
   		%>
   			<div class="place"></div>	
   <%			
   			} 	    
   %>
 		
 	</div>
      <% }else if(i % 3 == 2){ %>
      	</div>
      <%
      	 }
      	
      	
      } 
      %>
</div>
<%
if(placeList.size()>0){
	out.println("<p class='paging' style='width=800px;' align='center'>");
	args = "?sort=" + pageInfo.getSort()+"&psize="+pageInfo.getPsize() + schargs;
	
	if (pageInfo.getCpage() == 1){
		out.println("[&lt;&lt;]&nbsp;&nbsp;[&lt;]&nbsp;&nbsp;");
	}else {
		out.print("<a href='place_list.pla" + args + "&cpage=1'>[&lt;&lt;]</a>&nbsp;&nbsp;");	// 처음페이지로 이동
		out.println("<a href='place_list.pla" + args + "&cpage=" + (pageInfo.getCpage() -1 ) +"'>[&lt;]</a>&nbsp;&nbsp;");	// 이전 페이지로 이동 
	}// 첫 페이지와 이전 페이지 링크
	
	for (int i=0, j = pageInfo.getSpage(); i<= pageInfo.getBsize() && j<= pageInfo.getEpage(); i++, j++ ){
		if(pageInfo.getCpage() == j){
			out.print("&nbsp;<strong>" + j + "</strong>&nbsp;");
		}else{
			out.print("&nbsp;<a href='place_list.pla" + args + "&cpage=" + j + "'>" + j + "</a>&nbsp;");
		}
	}
	
	if (pageInfo.getCpage() == pageInfo.getPcnt()){
		out.println("&nbsp;&nbsp;[&gt;]&nbsp;&nbsp;[&gt;&gt;]");
	}else {
		out.print("&nbsp;&nbsp; <a href='place_list.pla" + args + "&cpage=" + (pageInfo.getCpage()+1) + "'>[&gt;]</a>");
		out.println("&nbsp;&nbsp;<a href='place_list.pla" + args + "&cpage="+ (pageInfo.getPcnt()) + "'>[&gt;&gt;]</a>");
	}
	out.println("</p>");
}
%>

<!-- 푸터 영역 -->

</body>
</html>