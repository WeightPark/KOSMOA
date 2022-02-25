<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../inc/header_nav.jsp" %>
<%@ page import = "review.vo.*" %>
<%
request.setCharacterEncoding("utf-8");
ReviewInFormInfo rinfo = (ReviewInFormInfo)request.getAttribute("rinfo");	// 리뷰 등록 정보를 담을 인스턴스를 받아옴

String kind = rinfo.getKind();
String title = rinfo.getTitle();
String rrid = rinfo.getIdnum();			// 코스 /장소 번호 
String crid = rinfo.getCrid();			// 예약 번호 

System.out.println("crid : " + crid);
System.out.println("rrid : " + rrid);

if (!isLogin) {
	out.println("<script>");
	out.println("alert('로그인 후 사용하세요.');");
	out.println("location.href='/kosmoa/member/loginForm.jsp?url=review/review_form.jsp?';");
	out.println("</script>");
	out.close();
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style>
#rivWrapper { width:1000px; height:1000px; margin-top:120px; text-align:center;  }
#riv_form { width:800px; height:600px; margin: 0 auto;  }
.riv_btn { width:200px; height:60px; background:white; border:1px solid black; margin: 0 auto; }
.riv_btn:hover { font-weight:bold; }
#riv_submit { margin-right:100px;  }
#riv_reset { margin-right:-100px;  }
</style>
<script>
window.onload = function() {
	window.resizeTo(1000,1000);
};

function isImg(img){
	var arrImg =["jpg","gif","png","jpeg"];
	var ext = img.substring(img.lastIndexOf(".")+ 1);	
	for (var i=0; i<arrImg.length ;i++ ){
		if (ext == arrImg[i])	return true;
	}
	return false;
}
function chkVal(frm){
	var img1 = frm.riv_img1.value;
	var title = frm.riv_title.value;
	var contents = frm.riv_content.value;
	
	if (title == ""){
		alert("제목을 입력하세요");		return false;
	}
	
	if( contents = ""){
		alert("내용을 입력하세요");		return false;
	}
	
	
	if (img1 == ""){
		alert("img1을 입력하세요");	frm.riv_img1.focus();	return false;
	}else if(!isImg(img1)){	//이미지 파일 검사
		alert("이미지만 입력하세요");	frm.riv_img1.focus();	return false;		
	}
	
	return true;
}

function fnChkByte(obj, maxByte)
{
    var str = obj.value;
    var str_len = str.length;


    var rbyte = 0;
    var rlen = 0;
    var one_char = "";
    var str2 = "";


    for(var i=0; i<str_len; i++)
    {
        one_char = str.charAt(i);
        if(escape(one_char).length > 4) {
            rbyte += 2;                                         //한글2Byte
        }else{
            rbyte++;                                            //영문 등 나머지 1Byte
        }
        if(rbyte <= maxByte){
            rlen = i+1;                                          //return할 문자열 갯수
        }
     }
     if(rbyte > maxByte)
     {
        // alert("한글 "+(maxByte/2)+"자 / 영문 "+maxByte+"자를 초과 입력할 수 없습니다.");
        alert("메세지는 최대 " + maxByte + "byte를 초과할 수 없습니다.")
        str2 = str.substr(0,rlen);                                  //문자열 자르기
        obj.value = str2;
        fnChkByte(obj, maxByte);
     }
     else
     {
        document.getElementById('byteInfo').innerText = rbyte;
     }
}
</script>
</head>
<body>
<div id="rivWrapper">	<!--  리뷰 영역을 감싸는 WRAPPER -->
	<div id="riviewInForm">	<!-- 리뷰 영역 시작 -->
	<form name="reviewFrm" action="review_in_proc.riv" method="post" onsubmit ="return chkVal(this);">
		<input type="hidden" value="<%=kind %>" name="kind" />
		<input type="hidden" value="<%=rrid %>" name="rrid" />
		<input type="hidden" value="<%=crid %>" name="crid" />
 		<input type="hidden" value="" name="wtype" />
		<table id="riv_form">
		<tr><th width="20%"> 
				<% if(kind.equals("p")) { %>
					장소 명
				<%	
				} else {
				%>
					코스 명 
				<%	
				}
				%>			
		</th> <td><input type="text" value="<%=title %>" readonly="readonly" /></td> 
		<td>

		</td>
		</tr>
		<tr><th>후기제목</th><td><input type="text" value="" name="riv_title" /></td></tr>
		<tr><th>사진1</th><td><input type="file" value="" name="riv_img1" /></td></tr>
		<tr><th>평점</th><td> 
			<input type="radio" value="1" name="riv_score" id="riv_1"/> <label for="riv_1" >1</label>
			<input type="radio" value="2" name="riv_score" id="riv_2"/> <label for="riv_2" >2</label>
			<input type="radio" value="3" name="riv_score" id="riv_3"/> <label for="riv_3" >3</label>
			<input type="radio" value="4" name="riv_score" id="riv_4"/> <label for="riv_4" >4</label>
			<input type="radio" value="5" name="riv_score" id="riv_5" checked="checked"/> <label for="riv_5" >5</label>
			</td>
		</tr>
		<tr><th>입력</th><td><textarea value="" name="riv_content" cols="50" rows="5" onKeyUp="javascript:fnChkByte(this,'50')"/></textarea> <br / > <span id="byteInfo">0</span> 80bytes</td></tr>
		
		</table>
		<p id="riv_btn">
			<input type="submit" id="riv_submit" class="riv_btn" value="후기 등록"/>
		 </p>
	</form>
	</div>
</div>
</body>

</html>