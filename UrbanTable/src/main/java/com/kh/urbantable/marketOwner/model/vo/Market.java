package com.kh.urbantable.marketOwner.model.vo;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Market {

	private String marketNo;
	private String marketMemberId;
	private String marketResident;
	private String marketTelephone;
	private String marketAddress;
	private String marketAddress2;
	private int marketEnabled;
	private int flag;
	
	@Override
	public String toString() {
		return "Market [marketNo=" + marketNo + ", marketMemberId=" + marketMemberId + ", marketResident=" + marketResident
				+ ", marketTelephone=" + marketTelephone + ", marketAddress=" + marketAddress + ", marketAddress2="
				+ marketAddress2 + ", marketEnabled=" + marketEnabled + ", flag=" + flag + "]";
	}
	
}
