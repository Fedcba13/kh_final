package com.kh.urbantable.member.model.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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

}
