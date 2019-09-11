package com.kh.urbantable.message;

import com.kh.urbantable.message.vo.Message;
import com.kh.urbantable.message.vo.MessageModel;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.Header;
import retrofit2.http.POST;

public interface SolapiMsgV4 {
    // 심플 메시지
    @POST("/messages/v4/send")
    Call<MessageModel> sendMessage(@Header("Authorization") String auth,
                                   @Body Message message);
}