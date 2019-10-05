package com.kh.urbantable.member.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.kh.urbantable.common.util.Utils;
import com.kh.urbantable.marketOwner.model.service.MarketOwnerService;
import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.member.model.vo.MemberAutoLogin;
import com.kh.urbantable.message.vo.Message;

@Controller
@RequestMapping("/member")
@SessionAttributes("memberLoggedIn")
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MemberService memberService;
	
	@Autowired
	MarketOwnerService marketOwnerService;

	@Autowired
	BCryptPasswordEncoder passwordEncoder;


	@RequestMapping("/register")
	public String memberRegister() {

		return "member/memberRegister";
	}

	@PostMapping("/memberLogin.do")
	@ResponseBody
	public Map<String, String> memberLogin(
				@RequestParam String memberId,
				@RequestParam String password,
				Model model,
				HttpServletResponse response,
				HttpServletRequest request,
				@RequestParam(value="autoLogin", defaultValue="false") String autoLogin,
				@RequestParam(value="saveId", defaultValue="saveId") String saveId) {

		logger.debug("로그인 요청");
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
				
				if(autoLogin.equals("true")) {
					logger.debug("로그인 유지");
					
					//쿠키 생성
					MemberAutoLogin memberAutoLogin = new MemberAutoLogin();
					String cookieKey = Utils.getKey(100);
					
					// client 정보
					memberAutoLogin.setMemberId(memberId);
					memberAutoLogin.setCookieKey(cookieKey);
					memberService.insertAutoLogin(memberAutoLogin);
					
					Cookie autoLoginCookie = new Cookie("autoLoginCookie", cookieKey);
					autoLoginCookie.setPath("/");
					autoLoginCookie.setMaxAge(60*60*24*7);
					
					//쿠키 저장
					response.addCookie(autoLoginCookie);
				}else if(saveId.equals("true")) {
					logger.debug("아이디 저장");
					
					//쿠키 생성
					Cookie saveIdCookie = new Cookie("saveIdCookie", memberId);
					saveIdCookie.setPath("/");
					saveIdCookie.setMaxAge(60*60*24*7);
					
					response.addCookie(saveIdCookie);
				}else if(saveId.equals("false")) {
					logger.debug("아이디 저장 취소");
					
					//쿠키 삭제
					Cookie saveIdCookie = new Cookie("saveIdCookie", null);
					saveIdCookie.setPath("/");
					saveIdCookie.setMaxAge(0);
					
					response.addCookie(saveIdCookie);
				}
				
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
	public synchronized HashMap<String, String> sendMessage(
			@RequestParam("phone") String phone, 
			@RequestParam(value="flag", defaultValue="1") int flag, 
			@RequestParam(value="name", defaultValue="") String name,
			@RequestParam(value="id", defaultValue="") String id,
			HttpServletRequest request) {

		// 리턴할 map
		HashMap<String, String> map = new HashMap<String, String>();

		// 세션 객체 생성
		HttpSession session = request.getSession(true);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("phone", phone);
		param.put("name", name);
		param.put("id", id);

		boolean isUsable = false;
		
		if(flag == 1) {
			logger.debug("회원가입");
			isUsable = memberService.phoneDuplicate(param) == null;
		}else if(flag == 2 || flag == 3) {
			logger.debug("ID찾기 / PW찾기");
			isUsable = memberService.phoneDuplicate(param) != null;
		}
		
		if (isUsable) {

			int rnd = (int) (Math.random() * 1000000);

			String auth = "" + rnd;

			while (auth.length() != 6) {
				auth = "0" + auth;
			}			

			Message message = new Message(phone, "01040418769", "[" + auth + "] UrbanTable 인증번호를 입력해주세요.");
			Utils.sendMessage(message);
			
			// 이전에 보낸것들 삭제
			logger.debug("코드 DB에 추가");
			
			HashMap<String, Object> insertParam = new HashMap<String, Object>();
			insertParam.put("phone", phone);
			insertParam.put("authCode", auth);
			insertParam.put("flag", flag);
			
			logger.debug("{}", insertParam);
			
			int result = memberService.insertPhoneAuth(insertParam);
	        
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
			if(flag == 2 || flag == 3) {
				map.put("msg", "가입된 번호가 없습니다.");
			}else {
				map.put("msg", "이미 가입된 번호가 있습니다.");
			}
		}

		return map;
	}

	@RequestMapping("/checkMessage.do")
	@ResponseBody
	public HashMap<String, Object> checkMessage(@RequestParam("phone") String phone,
												@RequestParam("authCode") String authCode,
												@RequestParam("flag") int flag) {
		HashMap<String, Object> result = new HashMap<String, Object>();

		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("phone", phone);
		param.put("authCode", authCode);
		param.put("flag", flag);

		int authResult = memberService.checkMessage(param);
		
		result.put("msg", authResult > 0 ? "인증 성공" : "인증 실패");
		
		if(authResult > 0 && (flag == 2 || flag == 3)) {
			result.put("member", memberService.phoneDuplicate(param));
		}

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
	public String memberLogout(SessionStatus sessionStatus, HttpServletRequest request) {
		logger.debug("로그아웃 요청");
		
		//세션 제거
		if(!sessionStatus.isComplete()) {
			sessionStatus.setComplete();
		}
		
		//쿠키 제거
	    String cookieKey = Utils.getCookies(request, "autoLoginCookie");
	    if(cookieKey != null) {
	      MemberAutoLogin memberAutoLogin = new MemberAutoLogin();
	      memberAutoLogin.setCookieKey(cookieKey);
	      memberService.removeAutoLogin(memberAutoLogin);
	      
	      //자동로그인 쿠키 삭제 시 
	      
	    }
		
		return "redirect:/";
	}
	
	@ResponseBody
	@RequestMapping("/nearMarket.do")
	public HashMap<String, String> nearMarket(@RequestParam("address") String address) {
		
		HashMap<String, String> result = new HashMap<String, String>();
		
		HashMap<String, Double> map = Utils.getLocation(address);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
        param.put("flag", 2);
        
        //현재 오픈된 매장만 가져옵니다.
        List<Market> list = marketOwnerService.selectMarketList(param);
        
		double nearLenth = Double.MAX_VALUE;
		result.put("msg", "배송 불가 지역");
		
		if(list == null || list.size() == 0) {
			
		}else {
			for(int i = 0; i<list.size(); i++) {
				HashMap<String, Double> difMap = Utils.getLocation(list.get(i).getMarketAddress());
				
				double distanceMile = Utils.distance(map, difMap, "kilometer");
				
				if(distanceMile < nearLenth) {
					nearLenth = distanceMile;
					result.put("nearMarket", list.get(i).getMarketNo());
				}
			}
		}
		
		if(nearLenth < 10) {
			result.put("msg","샛별 배송 가능 지역");
		}else if(nearLenth<30) {
			result.put("msg", "일반 배송 가능 지역");
		}
		
		return result;
	}
	
	@ResponseBody
	@RequestMapping("/checkIdDuplicate.do")
	public Map<String, Object> checkIdDuplicate(@RequestParam String memberId) {
		
		logger.debug("id 중복체크");
		
		Map<String, Object> map = new HashMap<String, Object>();

		boolean isUsable = memberService.selectOneMember(memberId) == null;
		
		map.put("isUsable", isUsable);
		
		return map;
		
	}
	
	@RequestMapping("/memberAddress")
	public void memberAddress(@RequestParam String memberId,
							  Model model) {
		logger.debug(memberId);
		List<Map<String, String>> list = memberService.selectAddress(memberId);
		model.addAttribute("addressList",list);
	}
	
	@RequestMapping("/memberFind/{type}")
	public String memberFind(@PathVariable String type, Model model) {
		model.addAttribute("type", type);
		return "member/memberFind";
	}
	
	@RequestMapping("/modifyPw.do")
	@ResponseBody
	public Map<String, Object> modifyPw(@RequestParam String memberId,
											@RequestParam String memberPassword){
		
		logger.debug("memberId : " + memberId +", password : " + memberPassword);
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		Member member = memberService.selectOneMember(memberId);
		member.setMemberPassword(passwordEncoder.encode(memberPassword));
		
		logger.debug("modifyPw.member@MemberController : " + member );
		
		int resultModifyPw = memberService.modifyMember(member);
		
		result.put("msg", resultModifyPw > 0 ? "비밀번호 변경 성공":"비밀번호 변경 실패");
		
		
		
		return result;
	}
	
	@RequestMapping("/myPage")
	public String myPage() {
		
		return "member/memberMyPage";
	}
	
	@RequestMapping("/myPage.do")
	@ResponseBody
	public Map<String, Object> myPageEnd(@RequestParam String memberId,
							@RequestParam(defaultValue = "") String reMemberPassword,
							@RequestParam(defaultValue = "") String memberPassword,
							@RequestParam(defaultValue = "") String memberAddress,
							@RequestParam(defaultValue = "") String memberAddress2,
							Model model){
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		boolean isContinue = true;
		int updateResult = 0;
		
		logger.debug("member@myPage.do = {}" + reMemberPassword + memberPassword + memberAddress + memberAddress2);
		
		
		//현재 멤버
		Member curMember = memberService.selectOneMember(memberId);
		logger.debug("curMember@myPage.do = {}", curMember);
		
		//변경할 멤버
		//비밀번호 변경
		if(isContinue && reMemberPassword != null && !reMemberPassword.equals("")) {
			if(passwordEncoder.matches(memberPassword, curMember.getMemberPassword())) {
				//비밀번호가 같을때 => 비밀번호 변경
				curMember.setMemberPassword(passwordEncoder.encode(reMemberPassword));
				
				//패스워드 변경 여부 => 변경시 로그아웃 처리
				result.put("pw", "true");
			}else {
				//비밀번호 불일치 => 비밀번호가 틀립니다, 리턴
				isContinue = false;
				result.put("msg", "비밀번호가 일치하지 않습니다.");
			}
		}
		
		//주소 변경
		if(isContinue) {
			curMember.setMemberAddress(memberAddress);
			curMember.setMemberAddress2(memberAddress2);
			updateResult = memberService.modifyMember(curMember);
			result.put("msg", updateResult > 0 ? "회원정보 수정 성공" : "회원정보 수정 실패");
		}		
		
		return result;
	}
	
	@RequestMapping("/myCoupon")
	public String myCoupon() {
		
		return "/member/memberCoupon";
	}
	
	@RequestMapping("/myCoupon.do")
	@ResponseBody
	public List<HashMap<String, Object>> myCouponEnd(HttpSession session, @RequestParam(defaultValue = "") String enabled){

		String memberId = ((Member)session.getAttribute("memberLoggedIn")).getMemberId();

		logger.debug("memberId : " + memberId);
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		
		param.put("memberId", memberId);
		param.put("enabled", enabled);

		List<HashMap<String, Object>> couponList = memberService.selectCouponList(param);
		
		logger.debug("couponList = {}", couponList);

		return couponList;
	}
	
	@RequestMapping("/payList")
	public String myPayList() {
		
		return "/member/memberPayList";
	}
	
}