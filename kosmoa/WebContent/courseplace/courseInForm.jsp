<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../admin/header_admin.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장소 등록 폼</title>
<style>
#courseCou th, #courseCou td { border-bottom:1px solid black; }
.fontBlue { color:blue; font-weight:bold; }
.fontRed { color:red; font-weight:bold; }
#my-resv-pop { margin-bottom: 300px; }
.resv-wrap{ width:700px; height:690x; margin: 100px auto 100px auto; text-align: center;}
#btn-wrap { margin:20px auto 0 auto; text-align:center; width:350px;  }
#btn-wrap input { border:1px solid black; background:white; color:black; width:100px;}
</style>
</head> 
<body>
<form name="CourseIn" action="course_proc.cou" method="post">
<div id="my-resv-pop">
	<div class="resv-wrap">
		<table width="700" cellpadding="5" cellspacing="1" id="courseCou" style="border:1px solid black; text-align:center;">
			<tr>
			<th width="40%">코스 번호</th><td width="*%"><input type="text" name="pi_id" value="" /></td>
			</tr>
			<tr>
			<th >장소 이름</th><td width="*%"><input type="text" name="pi_name" value="" /></td>
			</tr>
			<tr>
			<th>장소 대분류</th><td><input type="text" name="pi_bigcata" value="" /></td>
			</tr>
			<tr>
			<th>장소 소분류</th><td><input type="text" name="pi_smallcata" value="" /></td>
			</tr>
			<tr>
			<th>게시 여부</th>
				<td>
					<label for="regitY">게시</label><input type="radio" name="pi_isview" value="y id="regitY" />
					<label for="regitY">미게시</label><input type="radio" name="pi_isview" value="n" id="regitN" checked="checked"/>
				</td>
			</tr>
			<tr>
			<th>위도값</th><td><input type="text" name="pi_la" value="" /></td>
			</tr>
			<tr>
			<th>경도값</th><td><input type="text" name="pi_lo" value="" /></td>
			</tr>
			<tr>
			<th>태그 아이디</th><td><input type="text" name="st_id" value="" /></td>
			</tr>
			<tr>
			<th>키워드 아이디</th><td><input type="text" name="sk_id" value="" /></td>
			</tr>
			<tr>
			<th>장소 태그 이름</th><td><input type="text" name="st_name" value="" /></td>
			</tr>
			<tr>
			<th>제공 서비스</th><td><input type="text" name="pi_service" value="" /></td>
			</tr>
			<tr>
			<th>장소 대표 이미지</th><td><input type="text" name="pi_img1" value="" /></td>
			</tr>
			<tr>
			<th>장소 이미지2(선택)</th><td><input type="text" name="pi_img2" value="" /></td>
			</tr>
			<tr>
			<th>장소 이미지3(선택)</th><td><input type="text" name="pi_img3" value="" /></td>
			</tr>
			<tr>
			<th>장소 이미지4(선택)</th><td><input type="text" name="pi_img4" value="" /></td>
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
		
		<div id="btn-wrap">
			<input type="submit" name="regit" value="등록" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<input type="reset" name="rewrite" value="다시 입력" />
		</div>
		</div>
	</div>
</form>
</body>
</html>
