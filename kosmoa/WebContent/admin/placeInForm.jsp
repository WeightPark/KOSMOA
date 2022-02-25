<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="header_admin.jsp" %>
<%
if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하세요.');");
	out.println("location.href='../member/loginForm.jsp';");
	out.println("</script>");
	out.close();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장소 등록 폼</title>
<style>

/* 네비 영역 */
.wrapper { padding-top: 90px; }
.innerWrapper {
    display: flex; padding: 10px;
    background-color: white; justify-content: space-evenly;
    height: 725px; width: 1200px; margin:0 auto; 
}

tr { text-align: center; height: 40px;}

.innerWrapper a:link, .innerWrapper a:visited, .innerWrapper a { text-decoration: none; color: black; }
.innerWrapper a:hover { font-weight: bold; }

#left-navi { 
	padding: 20px;
	width:300px; height:500px;
	border:1px solid black;
	border-radius : 40px 40px 40px 40px;
	
	margin: 0 auto;
}
#left-navi ul { padding }
#left-navi li { padding: 5px; }

#placePla th, #placePla td { border-bottom:1px solid black; }
#placePla .file { margin-left: 150px; }
.fontBlue { color:blue; font-weight:bold; }
.fontRed { color:red; font-weight:bold; }
#btn-wrap { margin:20px 0 100px 220px; text-align:left; width:350px;}
.btn { margin: 0 auto; border: 1px solid black; margin-bottom: 50px; width: 100px; margin-left: 50px;}
</style>
<script>
var arrA = new Array();	// A 대분류의 소분류 목록을 저장할 배열
arrA[0] = new Option("", " 소분류 선택 ");			arrA[1] = new Option("aa", " aa ");
arrA[2] = new Option("ab", " ab");				arrA[3] = new Option("ac", " ac ");
arrA[4] = new Option("ad", " ad ");				arrA[5] = new Option("ae", " ae ");
arrA[6] = new Option("af", " af ");				arrA[7] = new Option("ag", " ag ");	
arrA[8] = new Option("ah", " ah ");	

var arrB = new Array();	// B 대분류의 소분류 목록을 저장할 배열
arrB[0] = new Option("", " 소분류 선택 ");			arrB[1] = new Option("ba", " ba ");
arrB[2] = new Option("bb", " bb ");				arrB[3] = new Option("bc", " bc ");
arrB[4] = new Option("bd", " bd ");				arrB[5] = new Option("be", " be ");
arrB[6] = new Option("bf", " bf ");				arrB[7] = new Option("bg", " bg ");

var arrC = new Array();	// C 대분류의 소분류 목록을 저장할 배열
arrC[0] = new Option("", " 소분류 선택 ");			arrC[1] = new Option("ca", " ca ");

function setCategory(x, target) {
	for (var i = target.options.length - 1 ; i > 0 ; i--) {
		target.options[i] = null;
	}
	if (x != "") {
		var arr = eval("arr" + x);
		for (var i = 0 ; i < arr.length ; i++) {
			target.options[i] = new Option(arr[i].value, arr[i].text);
		}
		target.options[0].selected = true;
	}
}

</script>
</head>
<body>
<div class="wrapper">
<div class="innerWrapper">
    <div id="left-navi">	<!-- 왼쪽 네비 영역 -->
	<ul>
		<li>코스 관리</li>
			<a href=""><ul><li class="li-indent">코스 등록</li></ul></a>
			<a href=""><ul><li class="li-indent">코스 삭제</li></ul></a>
			<a href=""><li>예약 관리</li></a>
		<li>통계 관리</li>
			<a href=""><ul><li class="li-indent">방문 통계</li></ul></a>
			<a href="stat_reserve_view.sta"><ul><li class="li-indent">예약 통계</li></ul></a>
			<a href="stat_sch_view.sta"><ul><li class="li-indent">검색 통계</li></ul></a>
			<a href=""><ul><li class="li-indent">이용 통계</li></ul></a>
	</ul>
	</div>
	<form name="PlaceIn" action="place_In.piu" method="post">
	<div id="my-resv-pop">
		<div class="resv-wrap">
			<table width="820" border="1" cellpadding="5" cellspacing="1" id="placePla" >
				<tr align="center">
				<th width="40%">장소 번호</th><td width="*%"><input type="text" name="pi_id" value="" /></td>
				</tr>
				<tr>
				<th>장소 이름</th><td width="*"><input type="text" name="pi_name" value="" /></td>
				</tr>
				<tr align="center">
				<th>장소 분류</th>
					<td width="*">
						<select name="pi_bigcata" onchange="setCategory(this.value, this.form.smallcata);">
							<option value=""> 대분류 선택 </option>
							<option value="A"> a </option>
							<option value="B"> b </option>
							<option value="C"> c </option>
						</select>
						<select name="smallcata">
							<option value=""> 소분류 선택 </option>
						</select>
					</td>
				</tr>
				<tr align="center">
				<th>게시 여부</th>
					<td>
						<label for="regitY">게시</label><input type="radio" name="pi_isview" value="y" id="regitY" />
						<label for="regitY">미게시</label><input type="radio" name="pi_isview" value="n" id="regitN" checked="checked"/>
					</td>
				</tr>
				<tr align="center">
				<th>위도 값</th><td><input type="text" name="pi_la" value="" /></td>
				</tr>
				<tr align="center">
				<th>경도 값</th><td><input type="text" name="pi_lo" value="" /></td>
				</tr>
				<tr align="center">
				<th>키워드 아이디 / 이름</th>
					<td width="*">
						<select name="pi_st_ids1">
							<option value=""> 키워드 선택 </option>
							<option value="key01/디저트"> KEY01 / 디저트  </option>					<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="key02/분식"> KEY02 / 분식 </option>						<!-- key02 -> pi_st_id,  분식 -> pi_st_name -->
							<option value="key03/카페"> KEY03 / 카페 </option>
							<option value="key04/쇼핑몰"> KEY04 / 쇼핑몰 </option>
							<option value="key05/햄버거"> KEY05 / 햄버거 </option>
							<option value="key06/양식"> KEY06 / 양식 </option>
							<option value="key07/일식"> KEY07 / 일식 </option>
							<option value="key08/중식"> KEY08 / 중식  </option>
							<option value="key09/미술관"> KEY09 / 미술관 </option>
							<option value="key13/치킨"> KEY13 / 치킨 </option>
							<option value="key14/반려동물"> KEY14 / 반려동물 </option>
							<option value="key15/주차가능"> KEY15 / 주차가능 </option>
							<option value="key16/한식"> KEY16 / 한식 </option>
							<option value="key17/기타"> KEY17 / 기타 </option>
							<option value="key18/술집"> KEY18 / 술집 </option>
							<option value="key19/영화관"> KEY19 / 영화관 </option>
						</select>
						<select name="pi_st_ids2">
							<option value=""> 키워드 선택 </option>
							<option value="key01/디저트"> KEY01 / 디저트  </option>				<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="key02/분식"> KEY02 / 분식 </option>					<!-- key02 -> pi_st_id,  분식 -> pi_st_name -->
							<option value="key03/카페"> KEY03 / 카페 </option>
							<option value="key04/쇼핑몰"> KEY04 / 쇼핑몰 </option>
							<option value="key05/햄버거"> KEY05 / 햄버거 </option>
							<option value="key06/양식"> KEY06 / 양식 </option>
							<option value="key07/일식"> KEY07 / 일식 </option>
							<option value="key08/중식"> KEY08 / 중식  </option>
							<option value="key09/미술관"> KEY09 / 미술관 </option>
							<option value="key13/치킨"> KEY13 / 치킨 </option>
							<option value="key14/반려동물"> KEY14 / 반려동물 </option>
							<option value="key15/주차가능"> KEY15 / 주차가능 </option>
							<option value="key16/한식"> KEY16 / 한식 </option>
							<option value="key17/기타"> KEY17 / 기타 </option>
							<option value="key18/술집"> KEY18 / 술집 </option>
							<option value="key19/영화관"> KEY19 / 영화관 </option>
						</select>
						<select name="pi_st_ids3">
							<option value=""> 키워드 선택 </option>
							<option value="key01/디저트"> KEY01 / 디저트  </option>				<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="key02/분식"> KEY02 / 분식 </option>					<!-- key02 -> pi_st_id,  분식 -> pi_st_name -->
							<option value="key03/카페"> KEY03 / 카페 </option>
							<option value="key04/쇼핑몰"> KEY04 / 쇼핑몰 </option>
							<option value="key05/햄버거"> KEY05 / 햄버거 </option>
							<option value="key06/양식"> KEY06 / 양식 </option>
							<option value="key07/일식"> KEY07 / 일식 </option>
							<option value="key08/중식"> KEY08 / 중식  </option>
							<option value="key09/미술관"> KEY09 / 미술관 </option>
							<option value="key13/치킨"> KEY13 / 치킨 </option>
							<option value="key14/반려동물"> KEY14 / 반려동물 </option>
							<option value="key15/주차가능"> KEY15 / 주차가능 </option>
							<option value="key16/한식"> KEY16 / 한식 </option>
							<option value="key17/기타"> KEY17 / 기타 </option>
							<option value="key18/술집"> KEY18 / 술집 </option>
							<option value="key19/영화관"> KEY19 / 영화관 </option>
						</select>
					</td>
				</tr>
				<tr align="center">
				<th>태그 아이디 / 이름</th>
					<td width="*">
						<select name="pi_sk_ids1">
							<option value=""> 키워드 선택 </option>
							<option value="tag01/데이트"> TAG01 / 데이트  </option>					<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="tag02/차분"> TAG02 / 차분  </option>
							<option value="tag03/무드"> TAG03 / 무드  </option>
							<option value="tag04/맛집"> TAG04 / 맛집  </option>
							<option value="tag05/핫한"> TAG05 / 핫한  </option>
							<option value="tag06/쇼핑"> TAG06 / 쇼핑  </option>
							<option value="tag07/다양한"> TAG07 / 다양한  </option>
							<option value="tag08/귀여움"> TAG08 / 귀여움 </option>
							<option value="tag09/아늑한"> TAG09 / 아늑한  </option>
							<option value="tag10/따뜻한"> TAG10 / 따뜻한  </option>
							<option value="tag11/미슐랭"> TAG11 / 미슐랭  </option>
							<option value="tag12/사진맛집"> TAG12 / 사진맛집  </option>
							<option value="tag13/빈티지"> TAG13 / 빈티지 </option>
							<option value="tag14/최자로드"> TAG14 / 최자로드  </option>
							<option value="tag15/신선함"> TAG15 / 신선함  </option>
							<option value="tag16/중국풍"> TAG16 / 중국풍  </option>
							<option value="tag17/tv프로그램출연"> TAG17 / tv프로그램출연  </option>
							<option value="tag18/상견례"> TAG18 / 상견례  </option>
							<option value="tag19/신남"> TAG19 / 신남  </option>
							<option value="tag20/친구와"> TAG20 / 친구와  </option>
							<option value="tag21/치맥"> TAG21 / 치맥  </option>
							<option value="tag22/고즈넉한"> TAG22 / 고즈넉한  </option>
						</select>
						<select name="pi_sk_ids2">
							<option value=""> 키워드 선택 </option>
							<option value="tag01/데이트"> TAG01 / 데이트  </option>					<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="tag02/차분"> TAG02 / 차분  </option>
							<option value="tag03/무드"> TAG03 / 무드  </option>
							<option value="tag04/맛집"> TAG04 / 맛집  </option>
							<option value="tag05/핫한"> TAG05 / 핫한  </option>
							<option value="tag06/쇼핑"> TAG06 / 쇼핑  </option>
							<option value="tag07/다양한"> TAG07 / 다양한  </option>
							<option value="tag08/귀여움"> TAG08 / 귀여움 </option>
							<option value="tag09/아늑한"> TAG09 / 아늑한  </option>
							<option value="tag10/따뜻한"> TAG10 / 따뜻한  </option>
							<option value="tag11/미슐랭"> TAG11 / 미슐랭  </option>
							<option value="tag12/사진맛집"> TAG12 / 사진맛집  </option>
							<option value="tag13/빈티지"> TAG13 / 빈티지 </option>
							<option value="tag14/최자로드"> TAG14 / 최자로드  </option>
							<option value="tag15/신선함"> TAG15 / 신선함  </option>
							<option value="tag16/중국풍"> TAG16 / 중국풍  </option>
							<option value="tag17/tv프로그램출연"> TAG17 / tv프로그램출연  </option>
							<option value="tag18/상견례"> TAG18 / 상견례  </option>
							<option value="tag19/신남"> TAG19 / 신남  </option>
							<option value="tag20/친구와"> TAG20 / 친구와  </option>
							<option value="tag21/치맥"> TAG21 / 치맥  </option>
							<option value="tag22/고즈넉한"> TAG22 / 고즈넉한  </option>
						</select>
						<select name="pi_sk_ids3">
							<option value=""> 키워드 선택 </option>
							<option value="tag01/데이트"> TAG01 / 데이트  </option>					<!-- key01 -> pi_st_id,  디저트 -> pi_st_name -->
							<option value="tag02/차분"> TAG02 / 차분  </option>
							<option value="tag03/무드"> TAG03 / 무드  </option>
							<option value="tag04/맛집"> TAG04 / 맛집  </option>
							<option value="tag05/핫한"> TAG05 / 핫한  </option>
							<option value="tag06/쇼핑"> TAG06 / 쇼핑  </option>
							<option value="tag07/다양한"> TAG07 / 다양한  </option>
							<option value="tag08/귀여움"> TAG08 / 귀여움 </option>
							<option value="tag09/아늑한"> TAG09 / 아늑한  </option>
							<option value="tag10/따뜻한"> TAG10 / 따뜻한  </option>
							<option value="tag11/미슐랭"> TAG11 / 미슐랭  </option>
							<option value="tag12/사진맛집"> TAG12 / 사진맛집  </option>
							<option value="tag13/빈티지"> TAG13 / 빈티지 </option>
							<option value="tag14/최자로드"> TAG14 / 최자로드  </option>
							<option value="tag15/신선함"> TAG15 / 신선함  </option>
							<option value="tag16/중국풍"> TAG16 / 중국풍  </option>
							<option value="tag17/tv프로그램출연"> TAG17 / tv프로그램출연  </option>
							<option value="tag18/상견례"> TAG18 / 상견례  </option>
							<option value="tag19/신남"> TAG19 / 신남  </option>
							<option value="tag20/친구와"> TAG20 / 친구와  </option>
							<option value="tag21/치맥"> TAG21 / 치맥  </option>
							<option value="tag22/고즈넉한"> TAG22 / 고즈넉한  </option>
						</select>
					</td>
				</tr>
				<tr align="center">
				<th>제공 서비스</th><td><input type="text" name="pi_service" value="" /></td>
				</tr>
	
				<tr align="center">
				<th>장소 대표 이미지</th><td><input class="file" type="file" name="pi_img1" value="" /><br /></td>
				</tr>
				<tr>
				<th>장소 이미지2(선택)</th><td><input class="file" type="file" name="pi_img2" value="" /></td>
				</tr>
				<tr>
				<th>장소 이미지3(선택)</th><td><input class="file" type="file" name="pi_img3" value="" /></td>
				</tr>
				<tr>
				<th>장소 이미지4(선택)</th><td><input class="file" type="file" name="pi_img4" value="" /></td>
				</tr>
				<tr>
				<th>장소 상세 설명</th><td><input type="text" name="pi_desc" value="" /></td>
				</tr>
				<tr>
				<th>장소 설명 이미지(선택)</th><td><input type="text" name="pi_descimg" value="" /></td>
				</tr>
				<tr>
				<th>전화번호</th>
				<td>
					<select name="p1">
						<option value="02">02</option>
						<option value="010">010</option>
						<option value="011">011</option>
						<option value="016">016</option>
						<option value="019">019</option>
					</select> -
					<input type="text" name="p2" size="4" maxlength="4" /> -
					<input type="text" name="p3" size="4" maxlength="4" />
				</td>
				</tr>
				<tr>
				<th>운영 시간(브레이크 타임 포함)</th><td><input type="text" name="pi_time" value="" /></td>
				</tr>
				<tr>
				<th>수용 가능 인원 </th><td><input type="text" name="pi_person" value="30" /></td>
				</tr>
				<tr>
				<th>예약 가능 여부</th>
					<td>
						<label for="isrY">가능</label><input type="radio" name="pi_isr" value="y" id="isrY" />
						<label for="isrN">불가능</label><input type="radio" name="pi_isr" value="n" id="isrN" checked="checked"/>
					</td>
				</tr>
				<tr>
				<th>영업 여부(영업, 휴업, 폐업)</th>
					<td><label for="isopP">영업중</label><input type="radio" name="pi_isop" value="a" id="isopP" checked="checked" />
						<label for="isopC">휴업중</label><input type="radio" name="pi_isop" value="b" id="isopC" />
						<label for="isopS">폐업</label><input type="radio" name="pi_isop" value="c" id="isopS" />
					</td>
				</tr>
				<tr>
				<th>우편 번호</th><td><input type="text" name="pi_zip" value="" /></td>
				</tr>
				<tr>
				<th>주소</th><td><input type="text" name="pi_addr1" value="" /></td>
				</tr>
				<tr>
				<th>상세 주소</th><td><input type="text" name="pi_addr2" value="" /></td>
				</tr>
				<tr>
				<th>승인 상태</th>
					<td>
						<label for="isshowY">승인</label><input type="radio" name="pi_isshow" value="y" id="isshowY" />
						<label for="isshowN">미승인</label><input type="radio" name="pi_isshow" value="n" id="isshowN" checked="checked" />
					</td>
				</tr>
				<tr>
				<th>지역</th><td><input type="text" name="pi_area" value="" /></td>
				</tr>
				<tr>
				<th>등록한 관리자</th><td><input type="text" name="ai_idx" value="0" /></td>
				</tr>
			</table>
			</div>
			<div id="btn-wrap">
			<input class="btn" type="submit" value="등록" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input class="btn" type="reset" value="다시 입력" />
			</div>
		</div>
	</form>
</div>
</div>
</body>
</html>
