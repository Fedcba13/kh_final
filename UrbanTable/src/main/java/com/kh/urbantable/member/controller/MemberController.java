package com.kh.urbantable.member.controller;

import java.io.IOException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.message.APIInit;
import com.kh.urbantable.message.vo.Message;
import com.kh.urbantable.message.vo.MessageModel;

import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;

@Controller
@RequestMapping("/member")
public class MemberController {

	Logger logger = LoggerFactory.getLogger(getClass());

	@Autowired
	MemberService memberSerivce;

	@RequestMapping("/register")
	public String memberRegister() {

		return "member/memberRegister";
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
