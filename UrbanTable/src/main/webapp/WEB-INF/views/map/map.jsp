<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818ea16fdaa1dea0776c4671d1142fc0&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<title>매장찾기</title>
</head>
<body>
	<div id="map" style="width:800px;height:600px;"></div>
	<script>
		var markers = [];
		var distances = [];
		var container = document.getElementById('map'); //지도를 담을 영역의 DOM 레퍼런스
		var options = { //지도를 생성할 때 필요한 기본 옵션
			center: new kakao.maps.LatLng(37, 127), //지도의 중심좌표.
			level: 3 //지도의 레벨(확대, 축소 정도)
		};
		var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴
		
		var geocoder = new kakao.maps.services.Geocoder();
		
		//사용자 위치 마커 생성
		var createUserOverlay = (result) =>{
			var startLoc = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var userAddress = new kakao.maps.Marker({
	            map: map,
	            position: startLoc
	        });
	        
	        var infowindow = new kakao.maps.InfoWindow({
	            content: '<div style="width:150px;text-align:center;padding:6px 0;">현재위치</div>'
	        });
	        infowindow.open(map, userAddress);		        
	        
	        //사용자 좌표값을 배열의 0번지에 저장
	        markers[0] = startLoc;
	        //console.log(JSON.parse(JSON.stringify(markers)));
	        map.setCenter(startLoc);
		}
		
		//매장위치 마커 생성
		var createMarketOverlay = (result)=>{
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            clickable: true
	        });
	        //각 매장의 좌표를 배열에 저장
	        markers.push(coords);
	        //console.log(JSON.parse(JSON.stringify(marker.getPosition())));
	        //console.log(marker.getPosition());
	        getDistance(coords, marker);
	        
	        kakao.maps.event.addListener(marker, 'click', clickEvent(map, marker));
	        function clickEvent(map, marker){
	        	var clickedAddress
	        	var callback = function(result, status){
	        		if (status === kakao.maps.services.Status.OK) {
	        	        clickedAddress = result[0].address.address_name;
	        	    }
	        	}
	        	geocoder.coord2Address(marker.getPosition().getLng(), marker.getPosition().getLat(), callback);			        	
	        	return function(){
	        		if(confirm(clickedAddress + " 여기로 하시겠습니까?")){
	        			opener.document.getElementById("market").value = clickedAddress;
	        			window.close();
	        		}
	        	}	
	        }	        
		}
		
		// 사용자 기본주소로 좌표를 검색합니다
		function userAddressSearch(address){
		    return new Promise((resolve, reject)=>{
		    	geocoder.addressSearch(address, function(result, status) {		    		
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
						resolve(result);				        
				    } else {
				    	reject(result);
				    }
				});
		    });			
		};
		
		function marketAddressSearch(address){
		    return new Promise((resolve, reject)=>{
		    	geocoder.addressSearch(address, function(result, status) {		    		
				    // 정상적으로 검색이 완료됐으면 
				     if (status === kakao.maps.services.Status.OK) {
						resolve(result);				        
				    } else {
				    	reject(result);
				    }
				});
		    });			
		};
		(async ()=>{			
			try{
				var result = await userAddressSearch("경기도 안산시 단원구 원선1로 61");
				createUserOverlay(result);				
			} catch(e){
				console.log(e);
			}
			<c:forEach items="${marketList}" var="ml" varStatus="vs">			
				try{
					var result = await marketAddressSearch("${ml.marketAddress}");
					createMarketOverlay(result);					
				} catch(e){
					console.log(e);
				}
			</c:forEach>	
			//console.log(JSON.parse(JSON.stringify(markers)));
			console.log(JSON.parse(JSON.stringify(distances)))
		})();		
		
		//console.log(JSON.parse(JSON.stringify(markers)));
		//var temp = $.extend(true, {}, markers);
		//console.log(markers);		
		//console.log(JSON.parse(JSON.stringify(temp)));
		//console.log(markers[0]);
		//console.log(markers.length);		
		
		function getDistance(coords, marker){
			var polyline = new kakao.maps.Polyline({
			    map: map,
			    path: [
			        markers[0],
			        coords
			    ],
			    strokeWeight: 3,
			    strokeColor: '#FF00FF',
			    strokeOpacity: 0.3
			});
			polyline.setMap(map);
			distances.push(Math.round(polyline.getLength()));
			distanceInfo(coords, Math.round(polyline.getLength()), marker);
		}
		
		function distanceInfo(coords, distance, marker){
			var contents = '<div class ="label"><span class="left"></span><span class="center">';
			if(distance <= 1000){
				contents += distance + "m";
			} else {
				contents += Math.round(distance/100)/10 + "Km";				
			}			
			contents += '</span><span class="right"></span></div>';
			
			var distanceInfo = new kakao.maps.InfoWindow({
			    position: coords,
			    content: contents 
			});
			// 커스텀 오버레이를 지도에 표시합니다
			distanceInfo.open(map, marker);
		}
		
	</script>	

</body>
</html>