$(document).ready(function(){
    $('.main_banner').slick({
        autoplay:true,
        infinite: true,
        speed: 700,
        autoplaySpeed: 3000,
        slidesToShow: 1,
        arrows:false
    });
    
    $(".recom_conts > div").hide();
    $(".recom_conts > div:first").show();
    $('.recom_tab li').click(function(){
    	$(".recom_tab li").removeClass("ac_recom");
    	$(this).addClass("ac_recom");
    	var tab = $(this).data("target");
    	$(".recom_conts > div").fadeOut("fast");
    	$(".recom_conts > div#"+tab).fadeIn("fast");
    });
});