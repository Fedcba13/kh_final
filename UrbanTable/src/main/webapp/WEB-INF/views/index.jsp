<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<fmt:requestEncoding value="utf-8" />
<jsp:include page="/WEB-INF/views/common/header.jsp" />
<link rel="stylesheet" href="${pageContext.request.contextPath }/resources/css/main.css">
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/main.js"></script>
<script>
   $(()=>{

	 var html = "";
	
	$.ajax({
		url: "${pageContext.request.contextPath}/banner/mainBannerList.do",
		dataType: "json",
		type: "POST",
		success: (data)=> {
			console.log(data);
			for(var i in data){
			html = "";
			html += "<div class='main_banner_con'>";
			html += "<a href='${pageContext.request.contextPath}/"+data[i].bannerURL + "' style='background-image:URL(${pageContext.request.contextPath}/resources/images/banner/"+data[i].bannerFileRenamed+");'class='aTag'>";
			html += "</a></div>";
			
			console.log(html);
			$(".main_banner").append(html); 
			}
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
});   
</script>
<style>
.main_banner_con a.aTag{
	background-size:cover; 
	background-position:center center;
	width: 100%; 
	height: 370px; 
	display:inline-block;
}
</style>
<section id="banner">
    <article>
        <div class="main_banner clearfix">
            <!--  <div class="main_banner_con"><a href="">banner1</a></div> -->
<!--              <div class="main_banner_con"><a href="">banner2</a></div> -->
        </div>
    </article>
</section>
<section id="sec1" class="main_sec">
    <article class="inner">
        <h3 class="main_tit txt_center">이 상품 어때요?</h3>
        <ul class="main_prd_list clearfix">
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="fw600">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                       <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="fw600">정가</p>
                    </div>
                </a>
            </li>
        </ul>
    </article>
</section>
<section id="sec2" class="main_sec sec_bg">
    <article class="inner">
        <h3 class="main_tit txt_center">Urban의 레시피</h3>
        <ul class="main_event_list main_receipe txt_center clearfix">
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <p>레시피명</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <p>레시피명</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <p>레시피명</p>
                    </div>
                </a>
            </li>
        </ul>
    </article>
</section>
<section id="sec3" class="main_sec">
    <article class="inner">
        <h3 class="main_tit txt_center">Urban의 추천</h3>
        <div class="recom_tab txt_center">
            <ul class="clearfix">
                <li data-target="recom1" class="ac_recom">채소</li>
                <li data-target="recom2">과일·견과·쌀</li>
                <li data-target="recom3">수산·해산·건어물</li>
                <li data-target="recom4">정육·계란</li>
                <li data-target="recom5">더있음</li>
            </ul>
        </div>
        <div class="recom_conts">
        	<div id="recom1">
        		<ul class="main_prd_list clearfix">
	                <li>
	                    <a href="" class="dp_block">
	                        <div class="prd_img_area">
	                            <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
	                            <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
	                        </div>
	                        <div class="prd_info_area">
	                            <h4>상품명</h4>
	                            <p class="prd_price fw600">할인가</p>
	                            <p class="prd_price2">정가</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	            <a href="" class="dp_block">채소 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>
        	</div>
            <div id="recom2">
        		<ul class="main_prd_list clearfix">
	                <li>
	                    <a href="" class="dp_block">
	                        <div class="prd_img_area">
	                            <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
	                            <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
	                        </div>
	                        <div class="prd_info_area">
	                            <h4>상품명</h4>
	                            <p class="prd_price fw600">할인가</p>
	                            <p class="prd_price2">정가</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	            <a href="" class="dp_block">과일·견과·쌀 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>
        	</div>
        	<div id="recom3">
        		<ul class="main_prd_list clearfix">
	                <li>
	                    <a href="" class="dp_block">
	                        <div class="prd_img_area">
	                            <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
	                            <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
	                        </div>
	                        <div class="prd_info_area">
	                            <h4>상품명</h4>
	                            <p class="prd_price fw600">할인가</p>
	                            <p class="prd_price2">정가</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	            <a href="" class="dp_block">수산·해산·건어물 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>
        	</div>
        	<div id="recom4">
        		<ul class="main_prd_list clearfix">
	                <li>
	                    <a href="" class="dp_block">
	                        <div class="prd_img_area">
	                            <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
	                            <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
	                        </div>
	                        <div class="prd_info_area">
	                            <h4>상품명</h4>
	                            <p class="prd_price fw600">할인가</p>
	                            <p class="prd_price2">정가</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	            <a href="" class="dp_block">정육·계란 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>
        	</div>
        	<div id="recom5">
        		<ul class="main_prd_list clearfix">
	                <li>
	                    <a href="" class="dp_block">
	                        <div class="prd_img_area">
	                            <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
	                            <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
	                        </div>
	                        <div class="prd_info_area">
	                            <h4>상품명</h4>
	                            <p class="prd_price fw600">할인가</p>
	                            <p class="prd_price2">정가</p>
	                        </div>
	                    </a>
	                </li>
	            </ul>
	            <a href="" class="dp_block">더있음 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>
        	</div>
        </div>
    </article>
</section>
<section id="sec4" class="main_sec">
    <article class="inner">
        <h3 class="main_tit txt_center">알뜰 상품</h3>
        <ul class="main_prd_list clearfix">
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="prd_img_area">
                        <p class="fw600 txt_center"><span>SALE</span><br>20%</p>
                        <img src="${pageContext.request.contextPath }/resources/images/example.PNG" alt="상품 사진">
                    </div>
                    <div class="prd_info_area">
                        <h4>상품명</h4>
                        <p class="prd_price fw600">할인가</p>
                        <p class="prd_price2">정가</p>
                    </div>
                </a>
            </li>
        </ul>
    </article>
</section>
<section id="sec5" class="main_sec sec_bg">
    <article class="inner">
        <h3 class="main_tit txt_center">이벤트 소식</h3>
        <ul class="main_event_list txt_center clearfix">
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <h4>이벤트명</h4>
                        <p>이벤트 내용 짧게 한줄로</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <h4>이벤트명</h4>
                        <p>이벤트 내용 짧게 한줄로</p>
                    </div>
                </a>
            </li>
            <li>
                <a href="" class="dp_block">
                    <div class="event_img_area">
                        <img src="${pageContext.request.contextPath }/resources/images/example2.PNG" alt="이벤트 사진">
                    </div>
                    <div class="event_info_area">
                        <h4>이벤트명</h4>
                        <p>이벤트 내용 짧게 한줄로</p>
                    </div>
                </a>
            </li>
        </ul>
    </article>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />