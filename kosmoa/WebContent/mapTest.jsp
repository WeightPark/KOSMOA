<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div id="map" style="width:800px;height:600px;"></div>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=54704751696b0161a5f26adff94f6691"></script>
	<script>
		var container = document.getElementById('map');
		var options = {
			center: new kakao.maps.LatLng(37.57305435868751,126.98085555587228),
			level: 5
		};

		var map = new kakao.maps.Map(container, options);
		
		// 마커를 표시할 위치와 title 객체 배열입니다 
		var positions = [
		    {
		        title: '블루쿠치나', 
		        latlng: new kakao.maps.LatLng(37.556784575010504, 126.90809239796648)
		    },
		    {
		        title: '소금집델리망원', 
		        latlng: new kakao.maps.LatLng(37.55692576943896, 126.90815205379073)
		    },
		    {
		        title: '호가양꼬치',
		        latlng: new kakao.maps.LatLng(37.57305435868751, 126.98085555587228)
		    }
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
