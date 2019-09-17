package com.kh.urbantable.message.vo;

import com.google.gson.JsonObject;

public class Message {
	
    private JsonObject message = new JsonObject();
    // SMS일 경우는 발신,수신 번호와 내용만 넣으시면 됩니다.
    public Message(String to, String from, String text) {
        this.message.addProperty("to", to);
        this.message.addProperty("from", from);
        this.message.addProperty("text", text);
    }

}