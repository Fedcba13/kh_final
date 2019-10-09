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
    
    $("#util_wrap > ul > li.cs_center").hover(function(){
    	$(this).children("ul").fadeIn("fast");
    }, function(){
    	$(this).children("ul").fadeOut("fast");
    });
    
    //로그인 모달
    
    var login_modal = $(".login-modal");
    $(".login-modal [name=autoLogin]").prop("disabled", true);
    
    //로그인 버튼 클릭시
    $(".login-btn").click(()=>{
		login_modal.css("display", "block");
	});
    
    //비밀번호에서 엔터 누를시 login 버튼 클릭
    $(".container [name=password]").keyup((e)=>{
    	if(e.key == 'Enter'){
    		$(".login-modal .login").trigger("click");    		
    	}
    });
    
    $(".login-modal .cancelbtn").click(()=>{
    	login_modal.css("display", "none");
    });
    
    //modal창이 열려 있을 경우, 바탕 클릭시 모달 닫기
	$(window).mousedown(function(e){
		if (e.target == login_modal[0]) {
			login_modal.css("display", "none");
	    }
	});
	
	//ID 저장 체크시 자동로그인 활성화
	$(".login-modal [name=saveId]").change(()=>{
		$(".login-modal [name=autoLogin]").prop("checked", false);
		$(".login-modal [name=autoLogin]").prop("disabled", !$(".login-modal [name=saveId]").prop("checked"));
	});
	
	//로그인 ajax
	$(".login-modal .login").click(()=>{
		var param = {
				memberId : $("input[type=text][name=memberId]").val(),
				password : $("input[type=password][name=password]").val(),
				saveId : $("input[name=saveId]").prop('checked'),
				autoLogin : $("input[name=autoLogin]").prop('checked')
		}
		
		$.ajax({
			url: contextPath+"/member/memberLogin.do",
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
	
	//아이디 저장
	var saveIdCookie = document.cookie.match('(^|;) ?saveIdCookie=([^;]*)(;|$)');
	saveIdCookie = saveIdCookie? saveIdCookie[2]:""
	if(saveIdCookie != null && saveIdCookie != ""){
		$(".login-modal [name=memberId]").val(saveIdCookie);
		$(".login-modal input[type=checkbox][name=saveId]").prop("checked", true);
		$(".login-modal [name=autoLogin]").prop("disabled", !$(".login-modal [name=saveId]").prop("checked"));
	}
	
	//배송지역 검색
	$("#header .srch_delivery").click(()=>{
		sample6_execDaumPostcode('on');
	});
	
});

var toDate = function(prevDate){
	var date = new Date(prevDate);
	
	var month = '' + (date.getMonth() + 1);
    var day = '' + date.getDate();
    var year = date.getFullYear();

    if (month.length < 2) 
        month = '0' + month;
    if (day.length < 2) 
        day = '0' + day;
    
    date = year+'년 '+month+'월 '+day+'일';
    
	return date;
}