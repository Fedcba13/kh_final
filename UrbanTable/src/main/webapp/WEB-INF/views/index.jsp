<%@page import="com.kh.urbantable.food.model.service.FoodServiceImpl"%>
<%@page import="com.kh.urbantable.food.model.vo.FoodDivision"%>
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
	// 배너
	$.ajax({
		url: "${pageContext.request.contextPath}/banner/mainBannerList.do",
		dataType: "json",
		type: "POST",
		success: (data)=> {
			var html = "";
			for(var i in data){
				html = "";
				html += "<div class='main_banner_con'>";
				html += "<a href='${pageContext.request.contextPath}/"+data[i].bannerURL + "' style='background-image:URL(${pageContext.request.contextPath}/resources/images/banner/"+data[i].bannerFileRenamed+");'class='aTag'>";
				html += "</a></div>";
				$(".main_banner").append(html); 
			}

			bannerSlide();
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
	//이상품 어때요? foodList
	$.ajax({
		 url: "${pageContext.request.contextPath}/food/selectFoodInMain1.do", 
		 dataType: "json",
		type: "POST",
		success: (data)=> {
			var html = ' ';
			for(var i in data){
				html += '<li><a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo='+data[i].foodNo+'&marketNo=mar00012" class="dp_block"><div class="prd_img_area">';
				if(data[i].eventPercent != 0){
					html +=  '<p class="fw600 txt_center"><span>SALE</span><br>'+data[i].eventPercent+'%</p>';
				}
				if(data[i].foodImg != null){
					html += '<img src="'+data[i].foodImg+'" alt="상품 사진">';
				}else if(data[i].foodOriginalFileName != null){
					html += ' <img src="${pageContext.request.contextPath}/resources/upload/food/'+data[i].foodRenamedFileName+'" alt="상품 사진">';
				}
				html += '</div>';
				html += '<div class="prd_info_area"><h4>'+data[i].foodName+'</h4>';
				if(data[i].eventPercent != 0){
					var afterEventPrice = Math.floor(data[i].foodMemberPrice-data[i].foodMemberPrice*(data[i].eventPercent/100));
					
					html += ' <p class="prd_price fw600">'+afterEventPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</p>';
					html += '<p class="prd_price2">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원 </p>';
				}else{
					html += ' <p class="prd_price fw600">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+' 원</p>';
				}
				
				html += '</div> </a> </li> ';
			} 
				$("#foodListMain1").html(html); 
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
	 //Urban의 추천
	$.ajax({
		 url: "${pageContext.request.contextPath}/food/selectFoodInMain2.do", 
		 dataType: "json",
		type: "POST",
		success: (data)=> {
			var html = '<ul class="main_prd_list clearfix">';
			for(var i in data){
				
				html += '<li> <a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo='+data[i].foodNo+'&marketNo=mar00012" class="dp_block">';
				html += '<div class="prd_img_area">';
				if(data[i].eventPercent != 0){
					html += '<p class="fw600 txt_center"><span>SALE</span><br>'+data[i].eventPercent+'%</p>';
				}
				if(data[i].foodImg != null){
					html += '<img src="'+data[i].foodImg+'" alt="상품 사진">';
				}else if(data[i].foodOriginalFileName != null){
					html += ' <img src="${pageContext.request.contextPath}/resources/upload/food/'+data[i].foodRenamedFileName+'" alt="상품 사진">';
				}
				html += ' </div><div class="prd_info_area"> <h4>'+data[i].foodName+'</h4> ';
				if(data[i].eventPercent != 0){
					var afterEventPrice = Math.floor(data[i].foodMemberPrice-data[i].foodMemberPrice*(data[i].eventPercent/100));
					
					html += ' <p class="prd_price fw600">'+afterEventPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</p>';
					html += '<p class="prd_price2">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원 </p>';
				}else{
					html += ' <p class="prd_price fw600">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+' 원</p>';
				}
				
				html += '</div></a> </li> ';
				
			} 
				html += '</ul><a href="${pageContext.request.contextPath}/food/selectBestFoodList.do" class="dp_block">베스트 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>';
				$("#recom1").html(html); 
		},
		error: (xhr, txtStatus, err)=> {
			console.log("ajax 처리실패!", xhr, txtStatus, err);
		}
	});
	 
	 
    $(".recom_conts > div").hide();
    $(".recom_conts > div:first").show();
    
	 $('.recom_tab li').click(function(){
		 $(".recom_tab li").removeClass("ac_recom");
	    	$(this).addClass("ac_recom");
	    	var tab = $(this).data("target");
	    	$(".recom_conts > div").fadeOut("fast");
	    	$(".recom_conts > div#"+tab).fadeIn("fast");
	    	
	    	var foodDivisionNo = $(this).children().val()
	    	var foodDivisionName = $(this).children().attr('name');
	    	
	    	var param = {
	    		foodDivisionNo : foodDivisionNo
	    	}
	    	
	 //Urban의 추천 다른 카테고리
	$.ajax({
    	url: "${pageContext.request.contextPath}/food/selectFoodInMain3.do",
    	type: "get",
		data: param,
		dataType:"json",
   		success: (data)=> {
   			var html = '<ul class="main_prd_list clearfix">';
   			for(var i in data){
   				
   				html += '<li> <a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo='+data[i].foodNo+'&marketNo=mar00012" class="dp_block">';
   				html += '<div class="prd_img_area">';
   				if(data[i].eventPercent != 0){
   					html += '<p class="fw600 txt_center"><span>SALE</span><br>'+data[i].eventPercent+'%</p>';
   				}
   				if(data[i].foodImg != null){
   					html += '<img src="'+data[i].foodImg+'" alt="상품 사진">';
   				}else if(data[i].foodOriginalFileName != null){
   					html += ' <img src="${pageContext.request.contextPath}/resources/upload/food/'+data[i].foodRenamedFileName+'" alt="상품 사진">';
   				}
   				html += ' </div><div class="prd_info_area"> <h4>'+data[i].foodName+'</h4> ';
   				if(data[i].eventPercent != 0){
   					var afterEventPrice = Math.floor(data[i].foodMemberPrice-data[i].foodMemberPrice*(data[i].eventPercent/100));
					
					html += ' <p class="prd_price fw600">'+afterEventPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</p>';
					html += '<p class="prd_price2">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원 </p>';
   				}else{
   					html += ' <p class="prd_price fw600">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+' 원</p>';
   				}
   				
   				html += '</div></a> </li> ';
   				
   			} 
   				html += '</ul><a href="${pageContext.request.contextPath}/food/selectBestFoodList.do?foodDivisionName='+foodDivisionName+'" class="dp_block">'+foodDivisionName+' 베스트 전체보기 <img src="${pageContext.request.contextPath }/resources/images/more.png" alt="" /></a>';
   				var recomId = $('[name="'+foodDivisionNo+'"]').attr('id');
   				$("#"+recomId).html(html); 
   		},
   		error: (xhr, txtStatus, err)=> {
   			console.log("ajax 처리실패!", xhr, txtStatus, err);
   		}
   	});
	   });
	 
	//알뜰상품 foodList
		$.ajax({
			 url: "${pageContext.request.contextPath}/food/selectFoodInMain4.do", 
			 dataType: "json",
			type: "POST",
			success: (data)=> {
				var html = ' ';
				for(var i in data){
					if(data[i].eventPercent != 0){
					html += '<li><a href="${pageContext.request.contextPath}/food/goFoodView.do?foodNo='+data[i].foodNo+'&marketNo=mar00012" class="dp_block"><div class="prd_img_area">';
					if(data[i].eventPercent != 0){
						html +=  '<p class="fw600 txt_center"><span>SALE</span><br>'+data[i].eventPercent+'%</p>';
					}
					if(data[i].foodImg != null){
						html += '<img src="'+data[i].foodImg+'" alt="상품 사진">';
					}else if(data[i].foodOriginalFileName != null){
						html += ' <img src="${pageContext.request.contextPath}/resources/upload/food/'+data[i].foodRenamedFileName+'" alt="상품 사진">';
					}
					html += '</div>';
					html += '<div class="prd_info_area"><h4>'+data[i].foodName+'</h4>';
					if(data[i].eventPercent != 0){
						var afterEventPrice = Math.floor(data[i].foodMemberPrice-data[i].foodMemberPrice*(data[i].eventPercent/100));
						
						html += ' <p class="prd_price fw600">'+afterEventPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원</p>';
						html += '<p class="prd_price2">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+'원 </p>';
					}else{
						html += ' <p class="prd_price fw600">'+data[i].foodMemberPrice.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")+' 원</p>';
					}
					
					html += '</div> </a> </li> ';
				} 
					$("#foodListMain4").html(html); 
				}
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	
	// 이벤트 List
		$.ajax({
			 url: "${pageContext.request.contextPath}/event/mainEventList.do", 
			 dataType: "json",
			type: "POST",
			success: (data)=> {
				
				console.log(data);
					html = '';
				for(var i in data){
					html += '<li><a href="" class="dp_block">'
					html += '<div class="event_img_area"><img src="${pageContext.request.contextPath }/resources/images/event/'+data[i].eventFile +'" alt="이벤트 사진" >';
					html += '</div>';
					html += '<div class="event_info_area">';
					html += '<h4>'+data[i].eventTitle + '</h4>';
					html += '<p>'+data[i].eventContent + '</p>';
					html += '</div></a></li>'
				}
				
				$('.event_div').html(html);
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	
	// recipe
		$.ajax({
			 url: "${pageContext.request.contextPath}/recipe/selectRecipeList", 
			 dataType: "json",
			 type: "POST",
			 success: (data)=> {
					html = '';
				for(var i=0; i<3; i++){
					html += '<li><a href="${pageContext.request.contextPath}/recipe/recipeView.do?recipeNo=' + data[i].recipeNo + '&memberId=${memberLoggedIn.memberId}" class="dp_block">'
					html += '<div class="event_img_area" value="' + i + '">';
					html += '</div>';
					html += '<div class="event_info_area">';
					html += '<p>' + data[i].recipeTitle + '</p>';
					html += '</div></a></li>'
				}
				
				$('.main_receipe').html(html);
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});
	
	// recipeImage
		$.ajax({
			 url: "${pageContext.request.contextPath}/recipe/selectImageList", 
			 dataType: "json",
			 type: "POST",
			 success: (data)=> {
					html = '';
				for(var i=0; i<3; i++){
					html = '<img src="${pageContext.request.contextPath}/resources/upload/recipe/' + data[i] + '" alt="이벤트 사진">'
					$('.event_img_area[value="' + i + '"]').html(html);
				}
			},
			error: (xhr, txtStatus, err)=> {
				console.log("ajax 처리실패!", xhr, txtStatus, err);
			}
		});

	
}); 
   
function bannerSlide(){
	$('.main_banner').slick({
        autoplay:true,
        infinite: true,
        speed: 700,
        autoplaySpeed: 3000,
        slidesToShow: 1,
        arrows:false
    });
}
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
        <ul class="main_prd_list clearfix" id="foodListMain1">
        
        </ul>
    </article>
</section>
<section id="sec2" class="main_sec sec_bg">
    <article class="inner">
        <h3 class="main_tit txt_center">Urban의 레시피</h3>
        <ul class="main_event_list main_receipe txt_center clearfix">
            
        </ul>
    </article>
</section>
<section id="sec3" class="main_sec">
    <article class="inner">
        <h3 class="main_tit txt_center">Urban의 추천</h3>
        <div class="recom_tab txt_center">
            <ul class="clearfix">
            <%
            	int i = 1;
            	for (FoodDivision foodDivision : new FoodServiceImpl().foodDivisionList ){
           %>
                <li data-target="recom<%=i%>"><%=foodDivision.getFoodDivisionName() %>
                <input type="hidden" name="<%=foodDivision.getFoodDivisionName() %>" value="<%=foodDivision.getFoodDivisionNo()%>"/>
                </li>
           <%
            		i++;
            	}
            %>
            </ul>
        </div>
        <div class="recom_conts" id="foodListMain2">
			<%
				int k = 1;
				for (FoodDivision foodDivision : new FoodServiceImpl().foodDivisionList) {
			%>
				<div id="recom<%=k%>" name="<%=foodDivision.getFoodDivisionNo()%>"></div>
			<%
				k++;
				}
			%>
        </div>
    </article>
</section>
<section id="sec4" class="main_sec">
    <article class="inner">
        <h3 class="main_tit txt_center">알뜰 상품</h3>
        <ul class="main_prd_list clearfix" id="foodListMain4">
           
        </ul>
    </article>
</section>
<section id="sec5" class="main_sec sec_bg">
    <article class="inner">
        <h3 class="main_tit txt_center">이벤트 소식</h3>
        <ul class="main_event_list txt_center clearfix event_div">
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