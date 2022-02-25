<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import="reserve.vo.*" %>
<%
request.setCharacterEncoding("utf-8");

//예약 내역 
String crid = request.getParameter("crid");
String ciname = request.getParameter("ciname");
String rdate = request.getParameter("rdate");
Calendar tday = Calendar.getInstance();
String today = tday.get(Calendar.YEAR) + "-" + (tday.get(Calendar.MONDAY) + 1) + "-" + (tday.get(Calendar.DATE) < 10 ? "0" + tday.get(Calendar.DATE) : tday.get(Calendar.DATE));  
ArrayList<PlaceReservedInfo> placeList = (ArrayList<PlaceReservedInfo>)request.getAttribute("placeList");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="reset.css" />
</head>

<style>
#my-resv-pop { width:380px; height:500px; margin:0 auto; }
.my-info-view { display:inline-block; width: 300px; height:80px; text-align:center; }
.resv-wrap{ width: width:350px; height:100x; margin: 0, auto; text-align: center;}
#resv-place { float:left; }
#btn-wrap { margin: 20px auto; text-align:left; width:350px; }
.btn { margin-left: 25px; width:80px; }
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
				data : {"rtype" : "c", "rid" : rid}, 
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
<div id="my-resv-pop">
	<form name="frmView" action="review_in_form.riv" method="post" id="frmView">
	<div class="resv-wrap">
		<input type="hidden" name="crid" value="<%=crid %>">
		<input type="hidden" name="rdate" value="<%=rdate %>">
		<input type="hidden" name="today" value="<%=today %>">
		<table width="380" class="rBrd">
		<tr height="70px"><th colspan="3" align="center" style="font-size: 1.5em;">예약 상세 보기</th></tr>
			<tr height="50px">
			<th>예약 번호</th>
			<td colspan="2" align="center"><%=crid %></td>
			</tr>
			<tr height="50px">
			<th>코스명</th>
			<td colspan="2" align="center"><%=ciname %></td>
			</tr>
			<tr height="50px">
			<th>예약 일시</th>
			<td colspan="2" align="center"><%=rdate %></td>
			</tr>
			<tr height="50px">
			<th colspan="3" class="rBrd">예약한 장소</th>
			</tr>
<%
			
for (int i = 0 ; i < placeList.size() ; i++) {
	PlaceReservedInfo pri = placeList.get(i);
%>
			<tr height="50px">
			<td width="40%">장소 : <%=pri.getPi_name() %> </td>
			<td width="30%">시간 : <%=(pri.getPr_rdate()).substring(10, 16) %>  </td>
			<td width="*">인원 : <%=pri.getPr_person() %> 명</td>
			</tr>	
			<tr></tr>
<%
}
%>
		</table>
	</div>
	<div id="btn-wrap">
		<input type="button" class="btn" name = "resvChk" value="확인" onclick="window.close();"/>
		<input type="button" class="btn" name="wReview" value="예약 취소" onclick="cancelReserve()"/>
		<input type="button" class="btn" name="wReview" value="후기 남기기" onclick="doMove();"/>
	</div>
	</form>
</div>
</body>
</html>