package com.kh.urbantable.member.model.service;

import java.util.HashMap;

import com.kh.urbantable.member.model.vo.Member;

public interface MemberService {

	Member selectOneMember(String memberId);

	Member phoneDuplicate(String phone);

	int insertPhoneAuth(HashMap<String, String> param);

	int checkMessage(HashMap<String, String> param);

	int insertMember(Member member);

}
