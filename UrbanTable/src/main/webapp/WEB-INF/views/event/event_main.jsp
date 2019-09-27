<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
img.eventImg{
	width:950px;
	height:200px;
}
</style>

<script>


</script>
<section class="sec_bg"> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">이벤트</h3>
	    <div class="event_list_wrapper">
	    	<ul id="event-list" style="position: relative; ">  		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10&couponEndDate=newDate()+s7'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=10'>
	    				<img src="${pageContext.request.contextPath }/resources/images/banner/20190926_154703374_893.jpg" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    	</ul>
	    	
	    </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>