<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="reserve.vo.*" %>
<%
request.setCharacterEncoding("utf-8");

//예약 내역
PlaceReservedInfo place = (PlaceReservedInfo)request.getAttribute("place");
String rdate = request.getParameter("rdate");
Calendar tday = Calendar.getInstance();
String today = tday.get(Calendar.YEAR) + "-" + (tday.get(Calendar.MONDAY) + 1) + "-" + (tday.get(Calendar.DATE) < 10 ? "0" + tday.get(Calendar.DATE) : tday.get(Calendar.DATE));  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
</head>

<style>
#my-resv-pop { width:380px; height:400px; margin:0 auto; }
.my-info-view { display:inline-block; width: 300px; height:80px; text-align:center; }
.resv-wrap{ width: width:350px; height:100x; margin: 0, auto; text-align: center;}
#resv-place { float:left; }
#btn-wrap { margin: 20px auto; text-align:left; width:350px; }
.btn { margin-left: 20px; width:80px; }
.rBrd { margin: 0, auto; }
</style>

<script src="/kosmoa/js/jquery-3.6.0.js"></script>
<script>
function doMove(){
	var frm = document.getElementById("frmView");
	frm.submit();	
}

function cancelReserve() {
	var rid = document.frmView.crid.value;
	var rdate = new Date(document.frmView.rdate.value);
	var today = new Date(document.frmView.today.value);
	var isDel = false;
	
	if (rdate > today) {
		isDel = confirm("정말 예약을 취소하시겠습니까?");
		if (isDel) {
			$.ajax({
				type : "POST", 
				url : "/kosmoa/reserved_cancel_proc.res", 
				data : {"rtype" : "p", "rid" : rid}, 
				success : function(chkRs) {
					if (chkRs == 0)	{
						alert("예약 취소에 실패했습니다.\n새로 고침 후 다시 시도해 주십시오.");
					} else {
						alert("예약 취소에 성공했습니다.");
						opener.parent.location.reload();
						window.close();
					}
				}
			});
		}
	} else {
		alert("예약 취소 가능 시간이 지났습니다.");
	}
}
</script>

<body>
<form action="review_in_form.riv" name="frmView" method="post" id="frmView" >
<div id="my-resv-pop">
	<div class="resv-wrap">
		<table width="380" class="rBrd">
		<input type="hidden" name="crid" value="<%=place.getPr_id() %>"/>
		<input type="hidden" name="rdate" value="<%=rdate %>">
		<input type="hidden" name="today" value="<%=today %>">
		<tr height="70px"><th colspan="3" align="center" style="font-size: 1.5em;">예약 상세 보기</th></tr>
			<tr height="50px">
			<th>예약 번호</th>
			<td colspan="2" align="center"><%=place.getPr_id() %></td>
			</tr>
			<tr height="50px">
			<th>장소명</th>
			<td colspan="2" align="center"><%=place.getPi_name() %></td>
			</tr>
			<tr height="50px">
			<th>예약 일시</th>
			<td colspan="2" align="center"><%=rdate %></td>
			</tr>
			<tr height="50px">
			<th>시간</th>
			<td colspan="2" align="center"><%=(place.getPr_rdate()).substring(10, 16) %></td>
			</tr>
			<tr height="50px">
			<th>인원</th>
			<td colspan="2" align="center"><%=place.getPr_person() %> 명</td>
			</tr>	
			<tr></tr>
		</table>
	</div>
	<div id="btn-wrap">
		<input type="button" class="btn" name = "resvChk" value="확인" onclick="window.close()"/>
		<input type="button" class="btn" name="wReview" value="예약 취소" onclick="cancelReserve()"/>
		<input type="button" class="btn" name="wReview" value="후기 남기기" onclick="doMove();" />
	</div>
</div>
</form>
</body>
</html>