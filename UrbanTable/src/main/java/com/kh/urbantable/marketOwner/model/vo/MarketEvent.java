package com.kh.urbantable.marketOwner.model.vo;

import java.util.List;

import com.kh.urbantable.event.model.vo.Event;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class MarketEvent extends Market {

	private List<Event> eventList;

	@Override
	public String toString() {
		return "MarketEvent [eventList=" + eventList + ", marketNo=" + marketNo + ", memberId=" + memberId
				+ ", marketResident=" + marketResident + ", marketTelephone=" + marketTelephone + ", marketAddress="
				+ marketAddress + ", marketAddress2=" + marketAddress2 + ", marketEnabled=" + marketEnabled + ", flag="
				+ flag + ", marketName=" + marketName + ", marketHoliday=" + marketHoliday + ", marketTime="
				+ marketTime + "]";
	}
	
}
