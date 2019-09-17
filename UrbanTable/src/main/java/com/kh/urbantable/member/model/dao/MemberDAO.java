package com.kh.urbantable.member.model.dao;

import com.kh.urbantable.member.model.vo.Member;

public interface MemberDAO {

	Member selectOneMember(String memberId);

}
