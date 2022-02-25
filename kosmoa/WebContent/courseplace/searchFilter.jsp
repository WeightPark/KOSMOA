<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="../js/jquery-3.6.0.js"></script>
<style>
#wrapperBox{ 		/* 전체를 감싸는 div */
	width: 520px;
	height: 750px;
	padding: 5px;	
	border: 1px solid black;
	position: relative;
}
.tabBox {			/* tap 버튼을 감싸는 div */
	display: inline-block;
	width: 350px;
	position: absolute;
	z-index: 0;
}

#fPlus{				/* 맨위의 더보기 버튼 */
	display: inline-block;
	width: 100px;
	margin-left: 45px;
	text-align: right;
	font-size: 0.8em;
}
input[type="radio"] {	/* 아이디찾기, 비밀번호 찾기 radio 버튼 */
	display: none;
}

input[type="radio"] + label {		/* 아이디찾기, 비밀번호 찾기 label 글자 */
	display: inline-block; 
	width: 100px;
	height: 30px;
	text-align: center;
	line-height: 30px;
	background: #fff;
	color: #999;
	font-size: 13px;
	cursor: pointer;
	
}

input[type="radio"]:checked + label {	/* 아이디찾기, 비밀번호 찾기 중 선택된  label */
	background: #8be7f4;
	color: #000;
	border-bottom: 1px solid #8be7f4;
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

td {				/* table의 td */
	padding: 5px;
}

.cata{				/*  분류 td */
	border-top:1px solid black;
	border-bottom:1px solid black;
	padding-left: 10px;
	text-align: left;
	
}
.plus {				/* 분류 td 중 더보기 버튼 */
	border-top:1px solid black;
	border-bottom:1px solid black;
	text-align: right;
	padding-right: 10px;
	font-size: 0.8em;
}
#buttonBox {		/* 맨 밑에 button을 감싸는 div */
	width: 500px;
	margin-top: 20px;
	text-align: center;
	position: absolute;
	bottom:30px;
}
.button {			/* 취소, 적용 button */
	width: 100px;
	height: 50px;
	margin: 0 15px;
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
	background: #8be7f4;
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

.chked { background:blue; }

</style>
</head>
<script>
function setVal(sch){
	var frm = document.getElementById("frmSch");
	if( sch.startsWith('a') || sch.startsWith('b') || sch.startsWith('c') ){
		if( frm.Scata.value.indexOf(sch) > 0 ){
			frm.Scata.value = frm.Scata.value.replace(','+sch , '');
		}else {
			frm.Scata.value += "," + sch;	
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
		if ( frm.Parea.value.indexOf(sch) > 0 ){
			frm.Parea.value = frm.Parea.value.replace(','+sch , '');
		}else {
			frm.Parea.value += ","+sch;
		}
	
	}
}

function setKey(frm){
	var val = document.getElementById("keyword").value;
	frm.keyword.value = val;
}

$(document).ready(function () {
	$("#fPlus").click(function () {
		$("#wrapperBox").slideDown(2000, function () {
			
		});
	});
});
</script>
<body>
<div id="wrapperBox"> <!-- 전체를 감싸는 div -->
	<form name="frmSchFilter" action="place_list.pla" id="frmSch" onsubmit = "setKey(this);">
		<div class="tabBox">
			<input type="radio" name="bcata" id="restaurant"  value="a" checked="checked" />
			<label for="restaurant">식당</label>
			<input type="radio" name="bcata" id="place" value="b" />
			<label for="place">플레이스</label>

		</div>
		<p id="fPlus"><a href="#">더보기</a></p>
		<table> 	<!-- tap영역 밑에 부터 버튼 전까지 talbe 영역  -->
		<input type="hidden" value="" name="keyword" />
		<input type="hidden" value="" name ="scata" />
		<input type="hidden" value="" name ="tag" />
		<input type="hidden" value="" name ="key" />
		<input type="hidden" value="" name ="area" />
			<tr height="15%">
				<td>
					<span onclick = "setVal('aa');" class="unchk" >한식</span> 
				</td>
				<td>
					<span onclick = "setVal('ab');" class="unchk">양식</span> 
				</td>
				<td>
					<span onclick = "setVal('ac');" class="unchk">중식</span> 
				</td>
				<td>
					<span onclick = "setVal('ad');" class="unchk">분식</span> 
				</td>
			</tr>
			<tr height="15%">
				<td>
					<span onclick = "setVal('ae');" class="unchk">카페</span> 
				</td>
				<td>
					<span onclick = "setVal( 'af');" class="unchk">디저트</span> 
				</td>
				<td>
					<span onclick = "setVal(  'ag');" class="unchk">비건음식</span> 
				</td>
				<td>
					<span onclick = "setVal(  'ah');" class="unchk">펍/주점</span> 
				</td>
			</tr>
			<tr height="5%">
				<td class="cata" colspan="3">태그</td>
				<td class="plus">
					<a href="#">더보기</a>
				</td>
			</tr>
			<tr height="15%">
				<td>
					<span onclick = "setVal ( 'tag01');" class="unchk">#한식</span> 
				</td>
				<td>
					<span onclick = "setVal(  'tag02');" class="unchk">#양식</span> 
				</td>
				<td>
					<span onclick = "setVal( 'tag03');" class="unchk">#중식</span> 
				</td>
				<td>
					<span onclick = "setVal( 'tag04');" class="unchk">#분식</span> 
				</td>
			</tr>
			<tr height="15%">
				<td>
					<span onclick = "setVal(  'tag05');" class="unchk">#아늑한 </span> 
				</td>
				<td>
					<span onclick = "setVal(  'tag06');" class="unchk">#맛집 </span> 
				</td>
				<td>
					<span onclick = "setVal(  'tag07');" class="unchk">#친구랑 </span> 
				</td>
				<td>
					<span onclick = "setVal(  'tag08');" class="unchk">#데이트 </span> 
				</td>
			</tr>
			<tr height="5%">
				<td class="cata" colspan="3">서비스</td>
				<td class="plus">
					<a href="#">더보기</a>
				</td>
			</tr>
			<tr height="15%">
				<td>
					<span onclick = "setVal( 'key01');" class="unchk">주차 가능 </span> 
				</td>
				<td>
					<span onclick = "setVal('key02');" class="unchk">반려동물과 출입가능 </span> 
				</td>
				<td>
					<span onclick = "setVal('key03');" class="unchk">테이크 아웃 가능 </span> 
				</td>
				<td>
					<span onclick = "setVal('key04');" class="unchk">sns 태그시 할인 </span> 
				</td>
			</tr>
			<tr sheight="15%">
				<td>
					<span onclick = "setVal('key05');" class="unchk">단체석 </span> 
				</td>
				<td>
					<span onclick = "setVal('key06');" class="unchk">입장료 무료 </span> 
				</td>
				<td>
					<span onclick = "setVal('key07');" class="unchk">혼밥가능 </span> 
				</td>
				<td>
					<span onclick = "setVal('key08');" class="unchk">적립가능 </span> 
				</td>
			</tr>
			<tr height="5%">
				<td class="cata" colspan="3">서비스</td>
				<td class="plus">
					<a href="#">더보기</a>
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" name="area" id="area1" value="강남구" onclick = "setVal(this.value);" />
					<label for="area1">강남구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area2" value="강동구" onclick = "setVal(this.value);" />
					<label for="area2">강동구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area3" value="마포구" onclick = "setVal(this.value);" />
					<label for="area3">마포구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area4" value="강서구" onclick = "setVal(this.value);" />
					<label for="area4">강서구</label> 
				</td>
			</tr>
			<tr>
				<td> 
					<input type="checkbox" name="area" id="area5" value="관악구" onclick = "setVal(this.value);" />
					<label for="area5">관악구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area6" value="광진구" onclick = "setVal(this.value);" />
					<label for="area6">광진구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area7" value="구로구" onclick = "setVal(this.value);" />
					<label for="area7">구로구</label> 
				</td>
				<td>
					<input type="checkbox" name="area" id="area8" value="금천구" onclick = "setVal(this.value);" />
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
</body>
</html>

	 