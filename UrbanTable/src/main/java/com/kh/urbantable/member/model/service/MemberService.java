package com.kh.urbantable.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.kh.urbantable.event.model.vo.Coupon;
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

	int modifyMember(Member member);

	List<HashMap<String, Object>> selectCouponList(HashMap<String, Object> param);

	List<Map<String, Object>> getMemberPayList(Map<String, Object> param);

	List<Map<String, Object>> getMemberPayDetail(Map<String, Object> param);

	int modifyAddr(Map<String, Object> param);

	int insertAddr(Map<String, Object> param);

	int deleteAddr(Map<String, Object> param);

	int insertStockNotice(Map<String, Object> param);

	int selectStockNotice(Map<String, Object> param);

}
