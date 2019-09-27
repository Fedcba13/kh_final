package com.kh.urbantable.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.member.model.vo.MemberAutoLogin;

public interface MemberService {

	Member selectOneMember(String memberId);

	Member phoneDuplicate(HashMap<String, Object> param);

	int insertPhoneAuth(HashMap<String, Object> param);

	int checkMessage(HashMap<String, Object> param);

	int insertMember(Member member);

	List<Member> selectListMember();

	List<Map<String, String>> selectAddress(String memberId);
	
	Member autoLogin(MemberAutoLogin memberAutoLogin);
	
	void insertAutoLogin(MemberAutoLogin memberAutoLogin);
	
	void removeAutoLogin(MemberAutoLogin memberAutoLogin);

}
