<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818ea16fdaa1dea0776c4671d1142fc0&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<title>매장찾기</title>
</head>
<body>
	<div id="map" style="width:800px;height:600px;"></div>
	<script>
		var markers = []; 
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(37, 127), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		var geocoder = new kakao.maps.services.Geocoder();
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch("경기도 안산시 단원구 원선1로 61", function(result, status) {
		    // 정상적으로 검색이 완료됐으면 
		     if (status === kakao.maps.services.Status.OK) {

		        var startLoc = new kakao.maps.LatLng(result[0].y, result[0].x);

		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var userAddress = new kakao.maps.Marker({
		            map: map,
		            position: startLoc
		        });
		        
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div style="width:150px;text-align:center;padding:6px 0;">현재주소</div>'
		        });
		        infowindow.open(map, userAddress);
		        
		        markers.push(userAddress.getPosition());
		    } 
			map.setCenter(startLoc);
		});		
		
		<c:forEach items="${marketList}" var="ml" varStatus="vs">			
			// 주소로 좌표를 검색합니다
			geocoder.addressSearch("${ml.marketAddress}", function(result, status) {
	
			    // 정상적으로 검색이 완료됐으면 
			     if (status === kakao.maps.services.Status.OK) {
	
			        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	
			        // 결과값으로 받은 위치를 마커로 표시합니다
			        var marker = new kakao.maps.Marker({
			            map: map,
			            position: coords,
			            clickable: true
			        });
			        markers.push(marker.getPosition());
			        kakao.maps.event.addListener(marker, 'click', clickEvent(map, marker));
			        function clickEvent(map, marker){
			        	var clickedAddress
			        	var callback = function(result, status){
			        		if (status === kakao.maps.services.Status.OK) {
			        	        clickedAddress = result[0].address.address_name;
			        	    }
			        	}
			        	geocoder.coord2Address(marker.getPosition().getLng(), marker.getPosition().getLat(), callback);
			        	console.log(clickedAddress);
			        	console.log(marker.getPosition);
			        	return function(){
			        		if(confirm(clickedAddress + " 여기로 하시겠습니까?")){
			        			opener.document.getElementById("market").value = clickedAddress;
			        			window.close();
			        		}
			        	}	
			        }
			    } 
			});    
		</c:forEach>
		console.log(markers);
		
		
	</script>

</body>
</html>