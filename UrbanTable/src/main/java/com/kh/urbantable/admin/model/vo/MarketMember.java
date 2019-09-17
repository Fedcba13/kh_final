package com.kh.urbantable.admin.model.vo;

import com.kh.urbantable.marketOwner.model.vo.Market;
import com.kh.urbantable.member.model.vo.Member;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;

public class MarketMember extends Market {

	private Member member;
	
	public MarketMember() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MarketMember(String marketNo, String memberId, String marketResident, String marketTelephone,
			String marketAddress, String marketAddress2, int marketEnabled, int flag, Member member) {
		super(marketNo, memberId, marketResident, marketTelephone, marketAddress, marketAddress2, marketEnabled, flag);
		this.member = member;
	}

	public Member getMember() {
		return member;
	}

	public void setMember(Member member) {
		this.member = member;
	}
	
	@Override
	public String toString() {
		return "Market [marketNo=" + marketNo + ", memberId=" + memberId + ", marketResident=" + marketResident
				+ ", marketTelephone=" + marketTelephone + ", marketAddress=" + marketAddress + ", marketAddress2="
				+ marketAddress2 + ", marketEnabled=" + marketEnabled + ", flag=" + flag + ", memberName="+member.getMemberName()+"]";
	}
	
	
}
