package com.kh.urbantable.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.member.model.dao.MemberDAO;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.member.model.vo.MemberAutoLogin;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public Member phoneDuplicate(HashMap<String, Object> param) {
		return memberDAO.phoneDuplicate(param);
	}

	@Override
	public int insertPhoneAuth(HashMap<String, Object> param) {
		
		//이전에 보낸 인증 전부 삭제.
		memberDAO.deletePhoneAuth(param);
		
		//인증번호, 전화번호 추가
		System.out.println(param.toString());
		return memberDAO.insertPhoneAuth(param);
	}

	@Override
	public int checkMessage(HashMap<String, Object> param) {
		//메세지 있는지 확인
		int result = memberDAO.checkMessage(param);
		
		//메세지 정상적으로 확인되면 인증코드 삭제
		if(result>0) {
			memberDAO.deletePhoneAuth(param);
		}
		
		return result;
	}

	@Override
	public int insertMember(Member member) {
		return memberDAO.insertMember(member);
	}

	@Override
	public List<Member> selectListMember() {
		return memberDAO.selectListMember();
	}

	@Override
	public List<Map<String, String>> selectAddress(String memberId) {
		return memberDAO.selectAddress(memberId);
	}
	
	//자동로그인
	@Override
	public Member autoLogin(MemberAutoLogin memberAutoLogin) {
		// cookie key 조회
		MemberAutoLogin cookieAutoLogin = memberDAO.selectAutoLogin(memberAutoLogin);
		Member member = null;
		if(cookieAutoLogin != null) {
			// 사용자 조회
			member = memberDAO.selectOneMember(cookieAutoLogin.getMemberId());
			// 자동로그인 마지막 접속일 수정
			if(member != null) {
				memberDAO.updateAutoLogin(memberAutoLogin);
				// 자동로그인 key 삭제
			}else {
				memberDAO.deleteAutoLogin(memberAutoLogin);
			}
		}
		return member;
	}
	
	//자동로그인 등록
	@Override
	public void insertAutoLogin(MemberAutoLogin memberAutoLogin) {
		memberDAO.insertAutoLogin(memberAutoLogin);
	}

	//자동로그인 정보 삭제
	@Override
	public void removeAutoLogin(MemberAutoLogin memberAutoLogin) {
		memberDAO.deleteAutoLogin(memberAutoLogin);
	}

	@Override
	public int modifyMember(Member member) {
		return memberDAO.modifyMember(member);
	}

	@Override
	public List<HashMap<String, Object>> selectCouponList(HashMap<String, Object> param) {
		return memberDAO.selectCouponList(param);
	}

	@Override
	public List<Map<String, Object>> getMemberPayList(Map<String, Object> param) {
		return memberDAO.getMemberPayList(param);
	}

	@Override
	public List<Map<String, Object>> getMemberPayDetail(Map<String, Object> param) {
		return memberDAO.getMemberPayDetail(param);
	}

	@Override
	public int modifyAddr(Map<String, Object> param) {
		return memberDAO.modifyAddr(param);
	}

	@Override
	public int insertAddr(Map<String, Object> param) {
		return memberDAO.insertAddr(param);
	}

	@Override
	public int deleteAddr(Map<String, Object> param) {
		return memberDAO.deleteAddr(param);
	}

	@Override
	public int insertStockNotice(Map<String, Object> param) {
		return memberDAO.insertStockNotice(param);
	}

	@Override
	public int selectStockNotice(Map<String, Object> param) {
		return memberDAO.selectStockNotice(param);
	}

	@Override
	public List<HashMap<String, Object>> selectSendMsg() {
		return memberDAO.selectSendMsg();
	}

	@Override
	public int deleteSendMsg(HashMap<String, Object> param) {
		return memberDAO.deleteSendMsg(param);
	}

}
