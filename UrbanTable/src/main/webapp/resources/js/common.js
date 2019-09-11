$(document).ready(function(){
    $("#gnb > li a.gnb_menu1, #gnb_menu_wrap").hover(function(){
        $("#gnb_menu_wrap").addClass("gnb_open");
    }, function(){
        $("#gnb_menu_wrap").removeClass("gnb_open");
    });

    $(".gnb_menu > li").hover(function(){
        $(this).addClass("gnb_2depth_open");
    }, function(){
        $(this).removeClass("gnb_2depth_open");
    });

});