package com.kh.urbantable.member.model.dao;

import java.util.HashMap;

import com.kh.urbantable.member.model.vo.Member;

public interface MemberDAO {

	Member selectOneMember(String memberId);

	Member phoneDuplicate(String phone);

	int insertPhoneAuth(HashMap<String, String> param);

	void deletePhoneAuth(HashMap<String, String> param);

	int checkMessage(HashMap<String, String> param);

	int insertMember(Member member);

}
