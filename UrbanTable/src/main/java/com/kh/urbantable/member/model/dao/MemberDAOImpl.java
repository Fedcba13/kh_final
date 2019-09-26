package com.kh.urbantable.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public Member phoneDuplicate(HashMap<String, Object> param) {
		return sqlSession.selectOne("member.phoneDuplicate", param);
	}

	@Override
	public int insertPhoneAuth(HashMap<String, Object> param) {
		return sqlSession.insert("member.insertPhoneAuth", param);
	}

	@Override
	public void deletePhoneAuth(HashMap<String, Object> param) {
		sqlSession.delete("member.deletePhoneAuth", param);
	}

	@Override
	public int checkMessage(HashMap<String, Object> param) {
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

	@Override
	public List<Map<String, String>> selectAddress(String memberId) {
		return sqlSession.selectList("member.selectAddress", memberId);
	}
	

}
