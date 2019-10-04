package com.kh.urbantable.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.kh.urbantable.food.model.service.FoodServiceImpl;
import com.kh.urbantable.member.model.vo.Member;

public class AdminInerceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {

		HttpSession session = request.getSession();
		Member memberLoggedIn = (Member) session.getAttribute("memberLoggedIn");

		if (memberLoggedIn == null || memberLoggedIn.getMemberCheck() != 9) {
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("loc", "/");
			request.getRequestDispatcher("/WEB-INF/views/common/msg.jsp").forward(request, response);
			return false;
		}

		return super.preHandle(request, response, handler);
	}

}
