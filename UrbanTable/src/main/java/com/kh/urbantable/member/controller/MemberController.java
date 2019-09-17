package com.kh.urbantable.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.message.APIInit;
import com.kh.urbantable.message.vo.Message;
import com.kh.urbantable.message.vo.MessageModel;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

@Controller
@RequestMapping("/member")
@SessionAttributes("memberLoggedIn")
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MemberService memberService;
	
	@Autowired
	BCryptPasswordEncoder passwordEncoder;

	@RequestMapping("/register")
	public String memberRegister() {

		return "member/memberRegister";
	}

	//임시 -> memberLogin.jsp 로 이동용, 삭제할 예정
	@RequestMapping("/asdf")
	public String memberLogin() {
		
		return "member/memberLogin";
	}
	
	@PostMapping("/memberLogin.do")
	@ResponseBody
	public Map<String, String> memberLogin(@RequestParam String memberId,
							@RequestParam String password,
							Model model) {
		
		logger.debug("로그인 요청");
		System.out.println("a");
		passwordEncoder.encode(password);
		
		//업무로직 : 회원정보 가져오기
		Member member = memberService.selectOneMember(memberId);
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		String msg = "";
		
		//아이디가 존재하지 않는경우
		if(member == null) {
			msg = "아이디가 존재하지 않습니다.";
		}else {
			
			//로그인 성공
			if(passwordEncoder.matches(password, member.getMemberPassword())) {
				msg="로그인 성공";
				
				//memberLoggedIn 세션 속성에 지정
				model.addAttribute("memberLoggedIn",member);
			}
			//비밀번호가 틀린 경우
			else {
				msg="비밀번호가 틀립니다";
			}
		}
		
		map.put("msg", msg);
		
		return map;

	}
	
	@RequestMapping("/sendMessage.do")
	public String sendMessage() {
		Message message = new Message("01044582535", "01040418769", "필요없는 메소드 정리 후 테스트");
		Call<MessageModel> api = APIInit.getAPI().sendMessage(APIInit.getHeaders(), message);
		api.enqueue(new Callback<MessageModel>() {

			@Override
			public void onResponse(Call<MessageModel> call, Response<MessageModel> response) {
				if (response.isSuccessful()) {
					logger.debug("성공");
				} else {
					try {
						System.out.println(response.errorBody().string());
					} catch (IOException e) {
						e.printStackTrace();
					}
				}
			}

			@Override
			public void onFailure(Call<MessageModel> call, Throwable throwable) {
				throwable.printStackTrace();
			}
		});
		return "member/memberRegister";
	}

}
