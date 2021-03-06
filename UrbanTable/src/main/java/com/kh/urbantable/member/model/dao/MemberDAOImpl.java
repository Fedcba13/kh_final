package com.kh.urbantable.member.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.event.model.vo.Coupon;
import com.kh.urbantable.member.model.service.MemberService;
import com.kh.urbantable.member.model.vo.Member;
import com.kh.urbantable.member.model.vo.MemberAutoLogin;

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

	@Override
	public MemberAutoLogin selectAutoLogin(MemberAutoLogin memberAutoLogin) {
		return sqlSession.selectOne("member.selectAutoLogin", memberAutoLogin);
	}

	@Override
	public void insertAutoLogin(MemberAutoLogin memberAutoLogin) {
		sqlSession.insert("member.insertAutoLogin", memberAutoLogin);
	}

	@Override
	public void updateAutoLogin(MemberAutoLogin memberAutoLogin) {
		sqlSession.update("member.updateAutoLogin", memberAutoLogin);
	}

	@Override
	public void deleteAutoLogin(MemberAutoLogin memberAutoLogin) {
		sqlSession.delete("member.deleteAutoLogin", memberAutoLogin);
	}

	@Override
	public int modifyMember(Member member) {
		return sqlSession.update("member.modifyMember", member);
	}

	@Override
	public List<HashMap<String, Object>> selectCouponList(HashMap<String, Object> param) {
		return sqlSession.selectList("pay.getAllCoupons", param);
	}

	@Override
	public List<Map<String, Object>> getMemberPayList(Map<String, Object> param) {
		return sqlSession.selectList("pay.getMemberPayList", param);
	}

	@Override
	public List<Map<String, Object>> getMemberPayDetail(Map<String, Object> param) {
		return sqlSession.selectList("pay.getMemberPayDetail", param);
	}

	@Override
	public int modifyAddr(Map<String, Object> param) {
		return sqlSession.update("member.modifyAddr", param);
	}

	@Override
	public int insertAddr(Map<String, Object> param) {
		return sqlSession.insert("member.insertAddr", param);
	}

	@Override
	public int deleteAddr(Map<String, Object> param) {
		return sqlSession.delete("member.deleteAddr", param);
	}

	@Override
	public int insertStockNotice(Map<String, Object> param) {
		return sqlSession.insert("member.insertStockNotice", param);
	}

	@Override
	public int selectStockNotice(Map<String, Object> param) {
		return sqlSession.selectOne("member.selectStockNotice", param);
	}

	@Override
	public List<HashMap<String, Object>> selectSendMsg() {
		return sqlSession.selectList("member.sendMsgStockNotice");
	}

	@Override
	public int deleteSendMsg(HashMap<String, Object> param) {
		return sqlSession.delete("member.deleteSendMsg", param);
	}
	

}
