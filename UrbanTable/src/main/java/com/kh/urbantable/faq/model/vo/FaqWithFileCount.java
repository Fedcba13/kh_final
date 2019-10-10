package com.kh.urbantable.faq.model.vo;

import java.sql.Date;

public class FaqWithFileCount extends Faq {

	private int fileCount;

	public FaqWithFileCount() {
		super();
	}

	public FaqWithFileCount(String noticeNo, String noticeTitle, String noticeWriter, String noticeContent,
			Date noticeDate, int readCount, String noticeCategory, int noticeEnabled, Date noticeDateModified,
			int fileCount) {
		super(noticeNo, noticeTitle, noticeWriter, noticeContent, noticeDate, readCount, noticeCategory, noticeEnabled,
				noticeDateModified);
		this.fileCount = fileCount;
	}

	public int getPageCount() {
		return fileCount;
	}

	public void setFileCount(int fileCount) {
		this.fileCount = fileCount;
	}

	@Override
	public String toString() {
		return "FaqWithFileCount [fileCount=" + fileCount + ", noticeNo=" + noticeNo + ", noticeTitle=" + noticeTitle
				+ ", noticeWriter=" + noticeWriter + ", noticeContent=" + noticeContent + ", noticeDate=" + noticeDate
				+ ", readCount=" + readCount + ", noticeCategory=" + noticeCategory + ", noticeEnabled=" + noticeEnabled
				+ ", noticeDateModified=" + noticeDateModified + "]";
	}
	
}
