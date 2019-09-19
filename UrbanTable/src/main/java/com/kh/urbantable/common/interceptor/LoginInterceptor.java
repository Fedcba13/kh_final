package com.kh.urbantable.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.urbantable.member.model.vo.Member;

public class LoginInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member)session.getAttribute("memberLoggedIn");
		
		if(memberLoggedIn==null) {
			request.setAttribute("msg", "로그인 후 이용 가능합니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return false;
		}
		
		return super.preHandle(request, response, handler);
	}
	
}
