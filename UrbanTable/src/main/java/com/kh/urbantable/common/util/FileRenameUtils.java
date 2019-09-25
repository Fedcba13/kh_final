package com.kh.urbantable.common.util;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Random;

public class FileRenameUtils {

	public static String getRenamedFileName(String realFile) {
		
		String ext = realFile.substring(realFile.lastIndexOf(".")+1);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd_HHmmssSSS");
		int rndNum = new Random().nextInt(1000);
		String renamed = sdf.format(new Date()) + "_" + rndNum + "." + ext;
		
		return renamed;
	}

}
