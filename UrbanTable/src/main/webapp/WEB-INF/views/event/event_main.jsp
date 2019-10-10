<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<style>
img.eventImg{
	width:100%;
}
a{
	display:block;
}
li.event_item{
	margin: 20px 0;
}

</style>

<script>


</script>
<section> <!--배경색이 있는 경우만 sec_bg 넣으면 됩니다.-->
	<article class="subPage inner">
	    <h3 class="sub_tit">이벤트</h3>
	    <div class="event_list_wrapper">
	    	<ul id="event-list" style="position: relative; ">  		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/food/selectFoodByCat.do?searchNo=UPPER125&searchKeyword=불고기용ㆍ양념육'>
	    				<img src="${pageContext.request.contextPath }/resources/images/event/20191007_785641246_215.PNG" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/food/selectFoodBySearchKeyword.do?searchKeyword=감&marketNo=mar00006'>
	    				<img src="${pageContext.request.contextPath }/resources/images/event/20191007_785658746_215.PNG" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/event/insertCoupon.do?couponDiscount=30&couponMinPrice=50000'>
	    				<img src="${pageContext.request.contextPath }/resources/images/event/20191007_132148147_231.png" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='${pageContext.request.contextPath}/food/selectFoodByCat.do?searchNo=UPPER138&searchKeyword=연어'>
	    				<img src="${pageContext.request.contextPath }/resources/images/event/20191007_154448147_231.PNG" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    		<li class="event_item" style="">
	    			<a href='#'>
	    				<img src="${pageContext.request.contextPath }/resources/images/event/20191007_195148147_231.PNG" alt="" class="eventImg"/>
	    			</a>
	    		</li>	    		
	    	</ul>
	    	
	    </div>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>