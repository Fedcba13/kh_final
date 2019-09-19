package com.kh.urbantable.member.model.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.urbantable.member.model.dao.MemberDAO;
import com.kh.urbantable.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDAO memberDAO;

	@Override
	public Member selectOneMember(String memberId) {
		return memberDAO.selectOneMember(memberId);
	}

	@Override
	public Member phoneDuplicate(String phone) {
		return memberDAO.phoneDuplicate(phone);
	}

	@Override
	public int insertPhoneAuth(HashMap<String, String> param) {
		
		//이전에 보낸 인증 전부 삭제.
		memberDAO.deletePhoneAuth(param);
		
		//인증번호, 전화번호 추가
		
		return memberDAO.insertPhoneAuth(param);
	}

	@Override
	public int checkMessage(HashMap<String, String> param) {
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

}