package com.kh.urbantable.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Good {
	private String targetId;
	private String memberId;
	private int good;
	private int bad;
	private int totalGood;
	private int totalBad;
	
}
