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

	protected String marketNo;
	protected String memberId;
	protected String marketResident;
	protected String marketTelephone;
	protected String marketAddress;
	protected String marketAddress2;
	protected int marketEnabled;
	protected int flag;
	protected String marketName;
	protected String marketHoliday;
	protected String marketTime;
	
	@Override
	public String toString() {
		return "Market [marketNo=" + marketNo + ", memberId=" + memberId + ", marketName="+marketName+", marketResident=" + marketResident
				+ ", marketTelephone=" + marketTelephone + ", marketAddress=" + marketAddress + ", marketAddress2="
				+ marketAddress2 + ", marketEnabled=" + marketEnabled + ", flag=" + flag + ", marketName="+marketName+", marketHoliday="+marketHoliday+", marketTime="+marketTime+"]";
	}
	
}
