package com.kh.urbantable.message.vo;

import lombok.Data;

@Data
public class MessageModel {

	private String groupId;
	private String messageId;
	private String statusCode;
	private String statusMessage;
	private String to;
	private String type;
	private String from;
	private String customFields;
	private String country;
	private String accountId;

}
