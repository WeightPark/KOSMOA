<%@ page language="java" contentType="text/html; charset=UTF-8"  pageEncoding="UTF-8"%>
<%@ page import="course.vo.*" %>
<%@ page import= "java.util.*" %>

<%


%>


<div id="map" style="width:1200px;height:600px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d0107e1dd1bb18105b6abc57007a471a"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div  
    mapOption = { 
        center: new kakao.maps.LatLng(<%=ci.getPi_la() %>, <%=ci.getPi_lo()%> ), // 지도의 중심좌표
        level: 2 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
var positions = [
// 마커를 표시할 위치와 title 객체 배열입니다
<% for(int i=0; i<courseInfo.size(); i++) {
	CourseInfo ciMap = courseInfo.get(i);
	if (i == courseInfo.size() -1 ){
%>
		{
		    title: '<%=ciMap.getPi_name() %>', 
		    latlng: new kakao.maps.LatLng(<%=ciMap.getPi_la() %>, <%=ciMap.getPi_lo() %> )
		}
<%		
	}else {
%>
		{
	    	title: '<%=ciMap.getPi_name() %>', 
	    	latlng: new kakao.maps.LatLng(<%=ciMap.getPi_la() %>, <%=ciMap.getPi_lo() %> )
		},
<%
	}
} 
%>
];

// 마커 이미지의 이미지 주소입니다
var imageSrc = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
    
for (var i = 0; i < positions.length; i ++) {
    
    // 마커 이미지의 이미지 크기 입니다
    var imageSize = new kakao.maps.Size(24, 35); 
    
    // 마커 이미지를 생성합니다    
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize); 
    
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng, // 마커를 표시할 위치
        title : positions[i].title, // 마커의 타이틀, 마커에 마우스를 올리면 타이틀이 표시됩니다
        image : markerImage // 마커 이미지 
    });
}
</script>
