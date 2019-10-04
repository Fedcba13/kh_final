$(document).ready(function(){
	
	setTimeout(function() {
		$('.main_banner').slick({
	        autoplay:true,
	        infinite: true,
	        speed: 700,
	        autoplaySpeed: 3000,
	        slidesToShow: 1,
	        arrows:false
	    });
	}, 200);

});