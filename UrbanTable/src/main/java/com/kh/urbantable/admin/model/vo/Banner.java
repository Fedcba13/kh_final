package com.kh.urbantable.admin.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class Banner {

	private String bannerId;
	private int bannerEnabled;
	private Date bannerStartDate;
	private Date bannerEndDate;
	private String bannerTitle;
	private String bannerContent;
	private String bannerURL;
	private String bannerFileRenamed;
	private String bannerFileOriginal;
}
