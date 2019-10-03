package com.kh.urbantable.event.model.vo;

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
	private String marketNo;
	private String eventCategory;
	private Date eventDateStart;
	private Date eventDateEnd;
	private int eventEnabled;
	private int eventPrice;
	
	

	@Override
	public String toString() {
		return "Event [eventId=" + eventId + ", eventTitle=" + eventTitle + ", eventContent=" + eventContent
				+ ", marketNo=" + marketNo + ", eventCategory=" + eventCategory
				+ ", eventDateStart=" + eventDateStart + ", eventDateEnd=" + eventDateEnd + ", eventEnabled="
				+ eventEnabled + ", eventPrice=" + eventPrice + "]";
	}
	
}
