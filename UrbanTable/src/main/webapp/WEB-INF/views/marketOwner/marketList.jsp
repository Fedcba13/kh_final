<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<section id="marketListPage" class="sec_bg">
	<article class="subPage inner">
		<h3 class="sub_tit txt_center fw400">지점 · 오픈 예정 매장 · 휴점일 안내</h3>
		<div class="txt_center">
			<ul class="marketListTab dp_ib clearfix">
				<li onclick="selectList(2, null, null);" class="ac_tab" rel="2">지점 찾기</li>
				<li onclick="selectList(1, null, null);" rel="1">오픈 예정 매장 찾기</li>
				<li onclick="selectHoliday(2, null, null);" rel="3">휴점일 알아보기</li>
			</ul>
		</div>
		<div class="searchFrm">
    		<input type="text" name="marketAddress" class="dp_ib" placeholder="검색어를 입력하세요." style="width:415px; padding-right:40px;" />
    		<input type="submit" value="검색" class="dp_ib txt_center" />
    	</div>
	</article>
</section>
<section>
	<article class="subPage inner">
		<div class="marketSort_wrap">
			<ul class="marketSortByCity">
				<li class="cur">전체</li>
				<li>서울</li>
				<li>인천</li>
				<li>경기</li>
			</ul>
		</div>
		<div class="marketResult sec_bg">
			
		</div>
		<p class="info red">*매장명을 클릭하면 매장에 대한 정보를 볼 수 있습니다.</p>
		<div class="marketInfo">
			<h4 class="point"></h4>
			<p></p>
			<ul class="txt_center clearfix">
				<li>
					<p id="marketTime">
						<img src="${pageContext.request.contextPath }/resources/images/clock.png" alt="" class="dp_ib" />
						<span class="dp_block">쇼핑시간</span>
						<span class="mInfo"></span>
					</p>
				</li>
				<li>
					<p id="marketHoliday">
						<img src="${pageContext.request.contextPath }/resources/images/calendar.png" height="55" alt="" class="dp_ib" style="margin-top:3px" />
						<span class="dp_block" style="padding:26px 0 5px;">휴점일</span>
						<span class="mInfo red"></span>
					</p>
				</li>
				<li>
					<p id="marketTel">
						<img src="${pageContext.request.contextPath }/resources/images/call.png" height="55" alt="" class="dp_ib" style="margin-top:3px" />
						<span class="dp_block" style="padding:26px 0 5px;">고객센터</span>
						<span class="mInfo"></span>
					</p>
				</li>
				<li>
					<p id="marketEvent">
						<img src="${pageContext.request.contextPath }/resources/images/discount.png" alt="" class="dp_ib" />
						<span class="dp_block">이벤트</span>
						<span class="mInfo"></span>
					</p>
				</li>
			</ul>
			<h5 class="fw400">오시는 길</h5>
			<div class="txt_right"><a href="" id="searchMap" class="btn txt_center" target="_blank">길찾기</a></div>
			<div id="marketInfo_map"></div>
		</div>
	</article>
</section>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fad2db7104eed0a4e507665e420c86cf&libraries=services"></script>
<script>
	$(()=>{
		selectList(2, null, null);
		
		$(".marketListTab li").click(function(){
			$(".marketListTab li").removeClass("ac_tab");
			$(this).addClass("ac_tab");
		});
		
		$(".searchFrm input[name=marketAddress").keyup(function(){
			if(event.keyCode == '13'){
				searchFrmSubmit();
			}
		});
		
		$(".searchFrm input[type=submit]").click(function(){
			searchFrmSubmit();
		});
		
		$(".marketSortByCity li").click(function(){
			$(".marketSortByCity li").removeClass("cur");
			$(this).addClass("cur");
			var marketAddress = $(this).text();
			if(marketAddress=="전체"){
				marketAddress = null;
			}
			var flag = $(".marketListTab li.ac_tab").attr("rel");
			searchMarket(flag, marketAddress);
		});
	});
	
	function searchFrmSubmit(){
		var marketAddress = $("div.searchFrm input[name=marketAddress]").val();
		var flag = $(".marketListTab li.ac_tab").attr("rel");
		if(flag==3){
			selectHoliday(2, null, marketAddress);
		} else {
			searchMarket(flag, marketAddress);
		}
	}
	
	function selectList(flag, marketNo, marketAddress){
		$(".searchFrm input[name=marketAddress]").val("");
		$(".marketSortByCity li").removeClass("cur");
		$(".marketSortByCity li:first-child").addClass("cur");
		var param = {
			flag : flag,
			marketNo : marketNo,
			marketAddress : marketAddress
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/selectMarketList.do",
			data: param,
			type: "get",
			dataType:"json",
			success: function(data){
				var marketList = data.marketList;
				var eventList = data.eventList;
				var html = "<ul class='marketResultList clearfix'>";
				if(marketList.length>0){
					for(var i in marketList){
						html += "<li><a href='javascript:showMarket(\""+marketList[i].flag+"\", \""+marketList[i].marketNo+"\", null);' class='dp_ib'>";
						html += marketList[i].marketName+"</a>";
						html += "<span class='marketInfoDetail'>";
						if(marketList[i].flag==2){
							html += "영업중";
						} else if(marketList[i].flag==1){
							html += "오픈 예정";
						}
						html += "</span>";
						for(var j in eventList){if(eventList[j].marketNo == null) {
								html += "<span class='marketInfoDetail marketEvent'>전체 이벤트</span>";
							} else if(eventList[j].marketNo == marketList[i].marketNo){
								html += "<span class='marketInfoDetail marketEvent2'>지점 이벤트</span>";
							} 
						}
						html += "</li>";
					}
				} else {
					html += "<li class='noResult txt_center'>조회 결과가 없습니다.</li>";
				}
				html += "</ul>";
				$(".marketResult").html(html);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	}
	
	function showMarket(flag, marketNo, marketAddress){
		if($(".marketInfo").css("display") == "none"){
			$(".marketInfo").show();
		}
		$("#marketEvent .mInfo").html("");
		
		var param = {
			flag : flag,
			marketNo : marketNo,
			marketAddress : marketAddress
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/selectMarketList.do",
			data: param,
			type: "get",
			dataType:"json",
			success: function(data){
				var marketList = data.marketList;
				var status = "";
				for(var i in marketList){
					$(".marketInfo h4").html(marketList[i].marketName);
					$("#marketTime .mInfo").html(marketList[i].marketTime);
					var holiday = marketList[i].marketHoliday;
					if(holiday!=null){
						holiday = holiday.replace(/[0-9]{4}./gi, "");
					} else {
						holiday = "없음";
					}
					$("#marketHoliday .mInfo").html(holiday);
					$("#marketTel .mInfo").html(marketList[i].marketTelephone);
					for(var j in data.eventList){
						if(j==0){
							$("#marketEvent .mInfo").append(data.eventList[j].eventTitle+"<br>");
						} else {
							$("#marketEvent .mInfo").append(data.eventList[j].eventTitle);
						}
					}
					
					if(marketList[i].flag==2){
						status += "<span class='dp_ib marketInfoDetail'>영업중</span>";
						if(data.eventList.length>0){
							status += "<span class='dp_ib marketInfoDetail marketEvent'>이벤트</span>";
						}
					} else if(marketList[i].flag==1){
						status += "<span class='dp_ib marketInfoDetail'>오픈 예정</span>";
					}
					$(".marketInfo h4+p").html(status);
					makeMap(marketList[i].marketAddress, marketList[i].marketName);
				}
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	}
	
	function selectHoliday(flag, marketNo, marketAddress){
		$(".searchFrm input[name=marketAddress]").val("");
		$(".marketSortByCity li").removeClass("cur");
		$(".marketSortByCity li:first-child").addClass("cur");
		var param = {
			flag : flag,
			marketNo : marketNo,
			marketAddress :  marketAddress
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath}/market/selectMarketList.do",
			data: param,
			type: "get",
			dataType:"json",
			success: function(data){
				var marketList = data.marketList;
				var html = "<table class='w100 txt_center'><tr><th>지점명</th><th>휴점일</th><th>전화번호</th></tr>";
				for(var i in marketList){
					var holiday = marketList[i].marketHoliday;
					if(holiday!=null){
						holiday = holiday.replace(/[0-9]{4}./gi, "");
					} else {
						holiday = "없음";
					}
					html += "<tr>";
					html += "<td><a href='javascript:showMarket(\""+marketList[i].flag+"\", \""+marketList[i].marketNo+"\", null);' class='dp_ib'>"+marketList[i].marketName+"</a></td>";
					html += "<td>"+holiday+"</td>";
					html += "<td>"+marketList[i].marketTelephone+"</td>";
					html += "</tr>";
				}
				html += "</table>";
				$(".marketResult").html(html);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	}
	
	function searchMarket(flag, marketAddress){
		var param = {
			flag: flag,
			marketAddress: marketAddress
		}
		
		$.ajax({
			url: "${pageContext.request.contextPath }/market/searchMarket.do",
			type: "get",
			data: param,
			dataType:"json",
			success: function(data){
				var marketList = data.marketList;
				var eventList = data.eventList;
				var html = "<ul class='marketResultList clearfix'>";
				if(marketList.length>0) {
					for(var i in marketList){
						html += "<li><a href='javascript:showMarket(\""+marketList[i].flag+"\", \""+marketList[i].marketNo+"\", null);' class='dp_ib'>";
						html += marketList[i].marketName+"</a>";
						html += "<span class='marketInfoDetail'>";
						if(marketList[i].flag==2){
							html += "영업중";
						} else if(marketList[i].flag==1){
							html += "오픈 예정";
						}
						html += "</span>";
						for(var j in eventList){
							if(eventList[j].marketNo == null) {
								html += "<span class='marketInfoDetail marketEvent'>전체 이벤트</span>";
							} else if(eventList[j].marketNo == marketList[i].marketNo){
								html += "<span class='marketInfoDetail marketEvent2'>지점 이벤트</span>";
							} 
						}
						html += "</li>";
					}
				} else {
					html += "<li class='noResult txt_center'>조회 결과가 없습니다.</li>";
				}
				html += "</ul>";
				$(".marketResult").html(html);
			},
			error: function(xhr, txtStatus, err){
				console.log("ajax 처리 실패", xhr, txtStatus, err);
			}
		});
	}
	
	function makeMap(marketAddress, marketName){
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		var container = document.getElementById('marketInfo_map');
		var options = {
			//center: new kakao.maps.LatLng(coords.Ga, coords.Ha),
			level: 3
		};
		//var map = new kakao.maps.Map(container, options);
		
		geocoder.addressSearch(marketAddress, function(result, status) {
			if (status === kakao.maps.services.Status.OK) {
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
				options.center = new kakao.maps.LatLng(coords.Ga, coords.Ha);
				var map = new kakao.maps.Map(container, options);
				// 결과값으로 받은 위치를 마커로 표시합니다
				var marker = new kakao.maps.Marker({
				    map: map,
				    position: coords
				});
				
				// 인포윈도우로 장소에 대한 설명을 표시합니다
				var infowindow = new kakao.maps.InfoWindow({
				    content: '<div style="width:150px;text-align:center;padding:6px 0;">'+marketName+'</div>'
				});
				infowindow.open(map, marker);
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
				map.setCenter(coords);
				
				$("#searchMap").attr("href", "https://map.kakao.com/link/to/UrbanTable "+marketName+","+coords.Ha+","+coords.Ga);
			}
		});
	}
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>