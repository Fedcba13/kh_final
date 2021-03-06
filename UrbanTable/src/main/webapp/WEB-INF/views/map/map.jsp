<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/default.css">
<script type="text/javascript" src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=818ea16fdaa1dea0776c4671d1142fc0&libraries=services,clusterer,drawing"></script>
<meta charset="UTF-8">
<title>매장찾기</title>
<style>
.modal .cancelbtn {width: auto;padding: 0px 18px;float: left;}
.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:center;background-color:white;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
</style>
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
		var createMarketOverlay = (result, marketName)=>{
			var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
			
	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            position: coords,
	            clickable: true
	        });
	        //각 매장의 좌표를 배열에 저장
	        markers.push(coords);
	        var distance = getDistance(coords, marker, marketName);
	        
	        kakao.maps.event.addListener(marker, 'click', clickEvent(map, marker));
	        function clickEvent(map, marker){
	        	var clickedAddress
	        	var callback = function(result, status){
	        		if (status === kakao.maps.services.Status.OK) {
	        	        clickedAddress = result[0].road_address.address_name +  " (" + marketName + ")";
	        	    }
	        	}
	        	geocoder.coord2Address(marker.getPosition().getLng(), marker.getPosition().getLat(), callback);			        	
	        	return function(){
	        		if(confirm(marketName + " 여기로 하시겠습니까?")){
	        			deliverySelect(distance, clickedAddress);	        			
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
				console.log(opener.location.pathname);
				var curLocation;
				<c:if test="${empty userAddress}">curLocation = "${memberLoggedIn.memberAddress}"</c:if>
				<c:if test="${!empty userAddress}">curLocation = "${userAddress}"</c:if>
				var result = await userAddressSearch(curLocation);
				createUserOverlay(result);				
			} catch(e){
				console.log(e);
			}
			<c:forEach items="${marketList}" var="ml" varStatus="vs">			
				try{
					var result = await marketAddressSearch("${ml.marketAddress}");
					createMarketOverlay(result, "${ml.marketName}");					
				} catch(e){
					console.log(e);
				}
			</c:forEach>
			map.setCenter(markers[0]);
		})();
		
		function getDistance(coords, marker, marketName){
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
			var distance = Math.round(polyline.getLength());
			polyline.setMap(map);
			distances.push(distance);
			distanceInfo(coords, Math.round(distance), marker, marketName);
			return distance;
		}
		
		function distanceInfo(coords, distance, marker, marketName){
			var contents = '<div class ="customoverlay"><span class="center">' + marketName + "(";
			if(distance <= 1000){
				contents += distance + "m";
			} else {
				contents += (Math.round(distance/100))/10 + "Km";				
			}			
			contents += ')</span></span></div>';
				
			var distanceInfo = new kakao.maps.CustomOverlay({
				map: map,
			    position: coords,
			    content: contents,
			    yAnchor: -0.5
			});
			// 커스텀 오버레이를 지도에 표시합니다
			//distanceInfo.open(map, marker);
		}
		
		function deliverySelect(distance, clickedAddress){
			$("#selectDelWay").css("display", "block");
			if(distance >= 5000){
				$("option[value='d']").prop("disabled", true);
			}
			$("#submitMarket").on("click", ()=>{
				if(opener.location.pathname == "/urbantable/cart/cartList.do"){
					opener.$("#market").val(clickedAddress);
					var deliveryWay = $("#deliveryWay option:selected").val();
					//console.log(deliveryWay);
					//console.log(opener.$("#dawn").val());
					if(deliveryWay == "d"){
						opener.$("#dawn").prop("checked", true);
						opener.deliveryCost(deliveryWay);
					} else if(deliveryWay == "n") {
						opener.$("#nomal").prop("checked", true);
						opener.deliveryCost(deliveryWay);
					} else {
						opener.$("#regular").prop("checked", true);
						opener.deliveryCost(deliveryWay);
					}
					var length = opener.length;
					console.log(length);
					for(var i = 1; i <= length; i++){
						opener.$("#item" + i).remove();
					}
					opener.getMarketNo();
					opener.getList();
					opener.totalPrice();
					opener.discountCost();
					opener.finalPrice();
					opener.totalPayment();                    
					window.close();
				} else if(opener.location.pathname == "/urbantable/pay/order.do"){
					opener.$("#marketAddressField").val(clickedAddress);
					var deliveryWay = $("#deliveryWay option:selected").val();
					if(deliveryWay == "d"){
						opener.$("#deliveryType").val("샛별배송 (5000원+)");
						opener.$("#deliverType").val("d")
						opener.$("#totalPaymentCost").val(parseInt(opener.$("#totalPrice").val()) + 5000 + " 원")
					} else if(deliveryWay == "n") {
						opener.$("#deliveryType").val("일반배송 (2500원+)");
						opener.$("#deliverType").val("n")
						opener.$("#totalPaymentCost").val(parseInt(opener.$("#totalPrice").val()) + 2500 + " 원")
					} else {
						opener.$("#deliveryType").val("정기배송 (30000원+)");
						opener.$("#deliverType").val("r")
						opener.$("#totalPaymentCost").val(parseInt(opener.$("#totalPrice").val()) + 30000 + " 원")
					}
					window.close();
				}
			});
		}		
		
		function closeModal(){
			$("#selectDelWay").css("display", "none");
		}
		
	</script>
	<div class="modal txt_center" id="selectDelWay">
		<form class="modal-content animate">
			<div class="container txt_center">
				<span>배송방식을 선택하세요(5km이상 샛별배송 불가)</span>
				<select class="select" name="ways" id="deliveryWay">
					<option value="d">샛별배송</option>
					<option value="n" selected>일반배송</option>
					<option value="r">정기배송</option>
				</select>
			</div>
			<div class="container txt_center" style="background-color:#f4f4f0;">
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" onclick="closeModal();">취소</button>
				<button type="button" class="btn btn2 cancelbtn" style="float:right; margin-right: 10px;" id="submitMarket">매장선택</button>
		    </div>
		</form>
	</div>
	

</body>
</html>