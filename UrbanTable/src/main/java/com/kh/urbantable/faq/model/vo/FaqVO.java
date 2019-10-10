package com.kh.urbantable.faq.model.vo;

import java.sql.Date;
import java.util.List;

public class FaqVO extends Faq {

	private List<Attachment> attachList;

	public FaqVO() {
		super();
	}

	public FaqVO(String noticeNo, String noticeTitle, String noticeWriter, String noticeContent, Date noticeDate,
			int readCount, String noticeCategory, int noticeEnabled, Date noticeDateModified,
			List<Attachment> attachList) {
		super(noticeNo, noticeTitle, noticeWriter, noticeContent, noticeDate, readCount, noticeCategory, noticeEnabled,
				noticeDateModified);
		this.attachList = attachList;
	}

	public List<Attachment> getAttachList() {
		return attachList;
	}

	public void setAttachList(List<Attachment> attachList) {
		this.attachList = attachList;
	}

	@Override
	public String toString() {
		return "FaqVO [attachList=" + attachList + ", noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle
				+ ", noticeWriter=" + noticeWriter + ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate
				+ ", readCount=" + readCount + ", noticeCategory=" + noticeCategory + ", noticeEnabled=" + noticeEnabled
				+ ", noticeDateModified=" + noticeDateModified + "]";
	}
	
}
