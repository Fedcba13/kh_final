package com.kh.urbantable.notice.model.vo;

import java.sql.Date;

public class Notice {

	private String noticeNo;
	private String noticeTitle;
	private String noticeWriter;
	private String noticeContent;
	private Date noticeDate;
	private int notice_readCount;
	private String noticeCategory;
	private int noticeEnabled;
	private Date noticeDateModified;

	public Notice() {
		// TODO Auto-generated constructor stub
	}

	public Notice(String noticeNo, String noticeTitle, String noticeWriter, String noticeContent, Date noticeDate,
			int notice_readCount, String noticeCategory, int noticeEnabled, Date noticeDateModified) {
		super();
		this.noticeNo = noticeNo;
		this.noticeTitle = noticeTitle;
		this.noticeWriter = noticeWriter;
		this.noticeContent = noticeContent;
		this.noticeDate = noticeDate;
		this.notice_readCount = notice_readCount;
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

	public int getNotice_readCount() {
		return notice_readCount;
	}

	public void setNotice_readCount(int notice_readCount) {
		this.notice_readCount = notice_readCount;
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
		return "Notice [noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle + ", noticeWriter=" + noticeWriter
				+ ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate + ", notice_readCount="
				+ notice_readCount + ", noticeCategory=" + noticeCategory + ", noticeEnabled=" + noticeEnabled
				+ ", noticeDateModified=" + noticeDateModified + "]";
	}

}
