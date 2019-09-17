package com.kh.urbantable.member.model.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.member.model.vo.Member;

@Repository
public class MemberDAOImpl implements MemberDAO {
	
	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public Member selectOneMember(String memberId) {
		return sqlSession.selectOne("member.selectOneMember", memberId);
	}

	@Override
	public Member phoneDuplicate(String phone) {
		return sqlSession.selectOne("member.phoneDuplicate", phone);
	}

	@Override
	public int insertPhoneAuth(HashMap<String, String> param) {
		return sqlSession.insert("member.insertPhoneAuth", param);
	}

	@Override
	public void deletePhoneAuth(HashMap<String, String> param) {
		sqlSession.delete("member.deletePhoneAuth", param);
	}

	@Override
	public int checkMessage(HashMap<String, String> param) {
		return sqlSession.selectOne("member.checkMessage", param);
	}

	@Override
	public int insertMember(Member member) {
		return sqlSession.insert("member.insertMember", member);
	}

	@Override
	public List<Member> selectListMember() {
		return sqlSession.selectList("member.selectListMember");
	}

}
