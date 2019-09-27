package com.kh.urbantable.common.interceptor;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.urbantable.common.util.Utils;
import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.member.model.vo.MemberAutoLogin;

public class AutoLoginInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	MemberService memberService;

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		//자동로그인 처리
		boolean isMember = request.getSession().getAttribute("memberLoggedIn") == null;
		
		if(isMember) {
			String cookieKey = Utils.getCookies(request, "autoLoginCookie");
			
			if(cookieKey != null) {
				MemberAutoLogin memberAutoLogin = new MemberAutoLogin();
				memberAutoLogin.setCookieKey(cookieKey);
				
				Member member = memberService.autoLogin(memberAutoLogin);
				
				//로그인 세션 추가/쿠키 재설정
				if(member != null) {
					//세션 추가
					request.getSession().setAttribute("memberLoggedIn", member);
					
					System.out.println(member.toString());
					
					//쿠키 재설정
					Cookie cookie = new Cookie("autoLoginCookie", cookieKey);
					cookie.setPath("/");
					cookie.setMaxAge(60*60*24*7);
					
					response.addCookie(cookie);
				}
				//로그인 실패시 자동로그인 쿠키 제거
				else {
					Cookie cookie = new Cookie("autoLoginCookie", null);
					cookie.setPath("/");
					cookie.setMaxAge(0);
					response.addCookie(cookie);
				}
			}
			
		}
		
		return super.preHandle(request, response, handler);
		
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		super.postHandle(request, response, handler, modelAndView);
	}

}
