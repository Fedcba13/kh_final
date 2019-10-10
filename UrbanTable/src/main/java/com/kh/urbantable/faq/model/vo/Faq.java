package com.kh.urbantable.faq.model.vo;

import java.sql.Date;

public class Faq {
	protected String noticeNo;
	protected String noticeTitle;
	protected String noticeWriter;
	protected String noticeContent;
	protected Date noticeDate;
	protected int readCount;
	protected String noticeCategory;
	protected int noticeEnabled;
	protected Date noticeDateModified;
	
	public Faq() {
		super();
	}

	public Faq(String noticeNo, String noticeTitle, String noticeWriter, String noticeContent, Date noticeDate,
			int readCount, String noticeCategory, int noticeEnabled, Date noticeDateModified) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeWriter = noticeWriter;
		this.noticeContent = noticeContent;
		this.noticeDate = noticeDate;
		this.readCount = readCount;
		this.noticeCategory = noticeCategory;
		this.noticeEnabled = noticeEnabled;
		this.noticeDateModified = noticeDateModified;
	}

	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getNoticeWriter() {
		return noticeWriter;
	}

	public void setNoticeWriter(String noticeWriter) {
		this.noticeWriter = noticeWriter;
	}

	public String getNoticeContent() {
		return noticeContent;
	}

	public void setNoticeContent(String noticeContent) {
		this.noticeContent = noticeContent;
	}

	public Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public String getNoticeCategory() {
		return noticeCategory;
	}

	public void setNoticeCategory(String noticeCategory) {
		this.noticeCategory = noticeCategory;
	}

	public int getNoticeEnabled() {
		return noticeEnabled;
	}

	public void setNoticeEnabled(int noticeEnabled) {
		this.noticeEnabled = noticeEnabled;
	}

	public Date getNoticeDateModified() {
		return noticeDateModified;
	}

	public void setNoticeDateModified(Date noticeDateModified) {
		this.noticeDateModified = noticeDateModified;
	}

	@Override
	public String toString() {
		return "Faq [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeWriter=" + noticeWriter
				+ ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate + ", readCount=" + readCount
				+ ", noticeCategory=" + noticeCategory + ", noticeEnabled=" + noticeEnabled + ", noticeDateModified="
				+ noticeDateModified + "]";
	}
	
}
