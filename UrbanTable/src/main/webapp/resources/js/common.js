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
    
    //로그인 모달
    
    var modal = $(".login-modal");
    
    //로그인 버튼 크릭시
    $(".login-btn").click(()=>{
		modal.css("display", "block");
	});
    
    //modal창이 열려 있을 경우, 바탕 클릭시 모달 닫기
	$(window).click(function(e){
		if (e.target == modal[0]) {
			modal.css("display", "none");
	    }
	});
	
	//로그인 ajax
	$(".login-modal .login").click(()=>{
		console.log("로그인 클릭");
		var param = {
				memberId : $("input[type=text][name=memberId]").val(),
				password : $("input[type=password][name=password]").val()
		}
		
		$.ajax({
			url: "member/memberLogin.do",
			data: param,
			type: "POST",
			success: (data)=>{
				alert(data.msg);
				if(data.msg == '로그인 성공'){
					location.reload();
				}
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	});

});