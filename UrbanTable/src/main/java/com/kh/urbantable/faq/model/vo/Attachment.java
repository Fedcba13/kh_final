package com.kh.urbantable.faq.model.vo;

import java.sql.Date;

public class Attachment {

	private int attachmentNo;
	private String noticeNo;
	private String originalFileName;
	private String renamedFileName;
	private Date uploadDate;
	private int downloadCount;
	private String status;//기본값 'Y'
	
	public Attachment() {
		super();
	}

	public Attachment(int attachmentNo, String noticeNo, String originalFileName, String renamedFileName, Date uploadDate,
			int downloadCount, String status) {
		super();
		this.attachmentNo = attachmentNo;
		this.noticeNo = noticeNo;
		this.originalFileName = originalFileName;
		this.renamedFileName = renamedFileName;
		this.uploadDate = uploadDate;
		this.downloadCount = downloadCount;
		this.status = status;
	}

	public int getAttachmentNo() {
		return attachmentNo;
	}

	public void setAttachmentNo(int attachmentNo) {
		this.attachmentNo = attachmentNo;
	}

	public String getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(String noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getOriginalFileName() {
		return originalFileName;
	}

	public void setOriginalFileName(String originalFileName) {
		this.originalFileName = originalFileName;
	}

	public String getRenamedFileName() {
		return renamedFileName;
	}

	public void setRenamedFileName(String renamedFileName) {
		this.renamedFileName = renamedFileName;
	}

	public Date getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Date uploadDate) {
		this.uploadDate = uploadDate;
	}

	public int getDownloadCount() {
		return downloadCount;
	}

	public void setDownloadCount(int downloadCount) {
		this.downloadCount = downloadCount;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Attachment [attachmentNo=" + attachmentNo + ", noticeNo=" + noticeNo + ", originalFileName="
				+ originalFileName + ", renamedFileName=" + renamedFileName + ", uploadDate=" + uploadDate
				+ ", downloadCount=" + downloadCount + ", status=" + status + "]";
	}
	
}
