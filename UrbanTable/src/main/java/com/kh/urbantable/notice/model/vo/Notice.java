package com.kh.urbantable.notice.model.vo;

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
public class Notice {

	private String noticeNo;
	private String noticeTitle;
	private String noticeWriter;
	private String noticeContent;
	private Date noticeDate;
	private int noticeReadcount;
	private String noticeCategory;
	private int noticeEnabled;
	private Date noticeDateModified;
	private String noticeFile;

	@Override
	public String toString() {
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeWriter=" + noticeWriter
				+ ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate + ", noticeReadcount="
				+ noticeReadcount + ", noticeCategory=" + noticeCategory + ", noticeEnabled=" + noticeEnabled
				+ ", noticeDateModified=" + noticeDateModified + ", noticeFile=" + noticeFile + "]";
	}

}
