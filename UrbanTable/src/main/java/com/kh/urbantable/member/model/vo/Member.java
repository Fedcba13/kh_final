package com.kh.urbantable.member.model.vo;

import java.util.Date;

import lombok.Data;

@Data
public class Member {
	private String memberId;
	private String memberPassword;
	private String memberName;
	private int memberPoint;
	private String memberAddress;
	private String memberAddress2;
	private String memberPhone;
	private Date memberEnrolldate;
	private int memberCheck;
	private int memberEnabled;
	@Override
	public String toString() {
		return "Member [memberId=" + memberId + ", memberPassword=" + memberPassword + ", memberName=" + memberName
				+ ", memberPoint=" + memberPoint + ", memberAddress=" + memberAddress + ", memberAddress2="
				+ memberAddress2 + ", memberPhone=" + memberPhone + ", memberEnrolldate=" + memberEnrolldate
				+ ", memberCheck=" + memberCheck + ", memberEnabled=" + memberEnabled + "]";
	}
	
	
}
