package com.kh.urbantable.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import org.springframework.web.bind.support.SessionStatus;

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

	@PostMapping("/memberLogin.do")
	@ResponseBody
	public Map<String, String> memberLogin(@RequestParam String memberId, @RequestParam String password, Model model) {

		logger.debug("로그인 요청");
		System.out.println("a");
		passwordEncoder.encode(password);

		// 업무로직 : 회원정보 가져오기
		Member member = memberService.selectOneMember(memberId);

		HashMap<String, String> map = new HashMap<String, String>();

		String msg = "";

		// 아이디가 존재하지 않는경우
		if (member == null) {
			msg = "아이디가 존재하지 않습니다.";
		} else {

			// 로그인 성공
			if (passwordEncoder.matches(password, member.getMemberPassword())) {
				msg = "로그인 성공";

				// memberLoggedIn 세션 속성에 지정
				model.addAttribute("memberLoggedIn", member);
			}
			// 비밀번호가 틀린 경우
			else {
				msg = "비밀번호가 틀립니다";
			}
		}

		map.put("msg", msg);

		return map;

	}

	@RequestMapping("/sendMessage.do")
	@ResponseBody
	public synchronized HashMap<String, String> sendMessage(@RequestParam("phone") String phone, HttpServletRequest request) {

		// 리턴할 map
		HashMap<String, String> map = new HashMap<String, String>();

		// 세션 객체 생성
		HttpSession session = request.getSession(true);

		logger.debug("phone={}", phone);

		boolean isUsable = memberService.phoneDuplicate(phone) == null;

		if (isUsable) {

			int rnd = (int) (Math.random() * 1000000);

			String auth = "" + rnd;

			while (auth.length() != 6) {
				auth = "0" + auth;
			}

			Message message = new Message(phone, "01040418769", "[" + auth + "] UrbanTable 인증번호를 입력해주세요.");
			Call<MessageModel> api = APIInit.getAPI().sendMessage(APIInit.getHeaders(), message);
	        api.enqueue(new Callback<MessageModel>() {
	        	@Override
	            public void onResponse(Call<MessageModel> call, Response<MessageModel> response) {
	                // 성공 시 200이 출력됩니다.
	                if (response.isSuccessful()) {
	                	logger.debug("성공");
	                } else {
	                	logger.debug("실패");
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
			
			// 이전에 보낸것들 삭제
			logger.debug("코드 DB에 추가");
			HashMap<String, String> param = new HashMap<String, String>();
			param.put("phone", phone);
			param.put("authCode", auth);
			int result = memberService.insertPhoneAuth(param);
	        
			if (result > 0) {
				map.put("msg", "인증번호 발송 성공!");
				session.setMaxInactiveInterval(10 * 60);
				session.setAttribute("phone", System.currentTimeMillis());
			} else {
				map.put("msg", "다시 시도해주세요.");
			}

		}

		// 중복된 번호가 있을 경우
		else {
			map.put("msg", "이미 가입된 번호가 있습니다.");
		}

		return map;
	}

	@RequestMapping("/checkMessage.do")
	@ResponseBody
	public HashMap<String, String> checkMessage(@RequestParam("phone") String phone,
												@RequestParam("authCode") String authCode) {
		HashMap<String, String> result = new HashMap<String, String>();

		HashMap<String, String> param = new HashMap<String, String>();
		param.put("phone", phone);
		param.put("authCode", authCode);

		result.put("msg", memberService.checkMessage(param) > 0 ? "인증 성공" : "인증 실패");

		return result;
	}
	
	@RequestMapping("/register.do")
	public String registerEnd(Member member) {
		logger.debug(member.toString());
		//암호화
		member.setMemberPassword(passwordEncoder.encode(member.getMemberPassword()));
		logger.debug(member.toString());
		
		int result = memberService.insertMember(member);
		
		return "redirect:/";
	}
	
	@RequestMapping("/memberLogout.do")
	public String memberLogout(SessionStatus sessionStatus) {
		logger.debug("로그아웃 요청");
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}
		
		return "redirect:/";
	}

}
