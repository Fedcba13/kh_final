<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/marketOwner.css">
<script>
	$(()=>{
		$(".marketResult > div").hide();
		$(".marketResult > div:first").show();
		$(".marketListTab li").on("click", function(){
			$(".marketListTab li").removeClass("ac_tab");
			$(this).addClass("ac_tab");
			var ac_tab = $(this).data("target");
			$(".marketResult > div").fadeOut("fast");
			$(".marketResult > div#"+ac_tab).fadeIn("fast");
		});
	});
	
	function showMarket(marketNo){
		alert(marketNo);
	}
</script>
<section id="marketListPage" class="sec_bg">
	<article class="subPage inner">
		<h3 class="sub_tit txt_center fw400">지점 · 오픈 예정 매장 · 휴점일 안내</h3>
		<div class="txt_center">
			<ul class="marketListTab dp_ib clearfix">
				<li data-target="marketListFlag1" class="ac_tab">지점 찾기</li>
				<li data-target="marketListFlag2">오픈 예정 매장 찾기</li>
				<li data-target="marketListHoliday">휴점일 알아보기</li>
			</ul>
		</div>
		<form action="" name="marketListSearchFrm" method="get" class="searchFrm">
    		<input type="text" class="dp_ib" placeholder="검색어를 입력하세요." style="width:415px; padding-right:40px;" />
    		<input type="submit" value="검색" class="dp_ib txt_center" />
    	</form>
	</article>
</section>
<section>
	<article class="subPage inner">
		<div class="marketSort_wrap">
			<ul class="marketSortByCity">
				<li rel="all" class="cur">전체</li>
				<li rel="seoul">서울</li>
				<li rel="incheon">인천</li>
				<li rel="gyeonggi">경기</li>
			</ul>
			<select name="marketSortByOption" id="marketSortByOption" class="dp_block">
				<option value="all">정렬 방식 선택</option>
				<option value="distance">거리순</option>
				<option value="alphabet">가나다순</option>
				<option value="alphabetdesc">가나다 역순</option>
			</select>
		</div>
		<div class="marketResult">
			<div id="marketListFlag1">
				<ul class="marketResultList clearfix">
				<c:forEach var="marketList" items="${marketList }" varStatus="vs">
					<c:if test="${marketList.flag eq 2 }">
						<li><a href="javascript:showMarket('${marketList.marketNo }');" class="dp_block">${marketList.marketName}</a></li>
					</c:if>
				</c:forEach>
				</ul>
			</div>
			<div id="marketListFlag2">
				<ul class="marketResultList clearfix">
				<c:forEach var="marketList" items="${marketList }" varStatus="vs">
					<c:if test="${marketList.flag eq 1 }">
						<li><a href="javascript:showMarket('${marketList.marketNo }');" class="dp_block">${marketList.marketName}</a></li>
					</c:if>
				</c:forEach>
				</ul>
			</div>
			<div id="marketListHoliday"></div>
		</div>
	</article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>