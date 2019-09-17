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
    
    //로그인 버튼 클릭시
    $(".login-btn").click(()=>{
		modal.css("display", "block");
	});
    
    //비밀번호에서 엔터 누를시 login 버튼 클릭
    $(".container [name=password]").keyup((e)=>{
    	if(e.key == 'Enter'){
    		$(".login-modal .login").trigger("click");    		
    	}
    });
    
    //modal창이 열려 있을 경우, 바탕 클릭시 모달 닫기
	$(window).click(function(e){
		if (e.target == modal[0]) {
			modal.css("display", "none");
	    }
	});
	
	//로그인 ajax
	$(".login-modal .login").click(()=>{
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
				}else if(data.msg == '비밀번호가 틀립니다'){
					$("input[type=password][name=password]").val("");
					$("input[type=password][name=password]").focus();
				}else{//아이디가 없을 경우
					$("input[type=password][name=password]").val("");
					$("input[type=text][name=memberId]").val("");
					$("input[type=text][name=memberId]").focus();
				}
			},
			error: (xhr, txtStatus, err)=>{
				console.log("ajax처리실패!", xhr, txtStatus, err);
			}
		});
	});

});