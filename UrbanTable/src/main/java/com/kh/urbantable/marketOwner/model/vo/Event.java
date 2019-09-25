package com.kh.urbantable.marketOwner.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode
public class Event {

	private String eventId;
	private String eventTitle;
	private String eventContent;
	private String eventCompany;
	private String marketNo;
	private int eventCategory;
	private Date eventDateStart;
	private Date eventDateEnd;
	private int eventEnabled;
	
	@Override
	public String toString() {
		return "Event [eventId=" + eventId + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", eventCompany=" + eventCompany + ", marketNo=" + marketNo + ", eventCategory=" + eventCategory
				+ ", eventDateStart=" + eventDateStart + ", eventDateEnd=" + eventDateEnd + ", eventEnabled="
				+ eventEnabled + "]";
	}
	
}
