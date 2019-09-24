package com.kh.urbantable.admin.controller;

import java.io.File;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kh.urbantable.admin.model.service.BannerService;
import com.kh.urbantable.admin.model.vo.Banner;
import com.kh.urbantable.common.util.FileRenameUtils;

@Controller
@RequestMapping("/banner")
public class BannerController {

	@Autowired
	BannerService bannerService;

	private Logger logger = LoggerFactory.getLogger(getClass());

	@RequestMapping("/bannerList.do")
	public String bannerList(Model model) {
		
		List<Banner> list = bannerService.selectAllList();
		
		model.addAttribute("list", list);
		
		return "/admin/bannerList";
	}

	@RequestMapping("/insertBanner.do")
	public String insertBanner() {
		
		return "/admin/insertBanner";
	}
	
	@RequestMapping(value = "/insertBannerEnd.do", method = RequestMethod.POST)
	public String insertEndBanner(Banner banner, @RequestParam("bannerFile1") MultipartFile bannerFile,
			MultipartHttpServletRequest request) {
		logger.info("banner1={}", banner);
		logger.info("upFile={}", bannerFile);
		
		 try {
		  
		  
		  String saveDirectory = request.getSession().getServletContext()
				  				.getRealPath("/resources/images/banner");
		  logger.info("saveDirectory={}", saveDirectory);
		  
		  
		  
		  String realFile = bannerFile.getOriginalFilename(); 
		  String renamed = FileRenameUtils.getRenamedFileName(realFile);
		  banner.setBannerFileOriginal(realFile);
		  banner.setBannerFileRenamed(renamed);
		  
		  try {
			  
			  bannerFile.transferTo(new File(saveDirectory + "/" + renamed));
			  
		  } catch(Exception e) {
			  e.printStackTrace(); 
			  
		  }
		  
		  
		  
		  logger.info("banner2={}", banner); }catch(Exception e){
		  
		  }
		 
		 int result = bannerService.insertBanner(banner);

		return "/admin/insertBanner";
	}
	
	@RequestMapping("/updateBanner.do")
	public String updateBanner(Banner banner, @RequestParam("bannerFile1") MultipartFile bannerFile,
			MultipartHttpServletRequest request, Model model) {
		
		logger.info("banner={}", banner);
		
		 try {
			  
			  
			  String saveDirectory = request.getSession().getServletContext()
					  				.getRealPath("/resources/images/banner");
			  logger.info("saveDirectory={}", saveDirectory);
			  
			  
			  
			  String realFile = bannerFile.getOriginalFilename(); 
			  String renamed = FileRenameUtils.getRenamedFileName(realFile);
			  banner.setBannerFileOriginal(realFile);
			  banner.setBannerFileRenamed(renamed);
			  
			  try {
				  
				  bannerFile.transferTo(new File(saveDirectory + "/" + renamed));
				  
			  } catch(Exception e) {
				  e.printStackTrace(); 
				  
			  }
			  
			  
			  
			  logger.info("banner2={}", banner); }catch(Exception e){
			  
			  }
		 
		int result = bannerService.updateBanner(banner);
		
		List<Banner> list = bannerService.selectAllList();
		
		model.addAttribute("list", list);
		
		return "/admin/bannerList";
	}
	
	@RequestMapping("/deleteBanner.do")
	public String deleteBanner(String bannerId, Model model) {
		
		logger.info("bannerId={}", bannerId);
		
		bannerService.deleteBanner(bannerId);
		
		List<Banner> list = bannerService.selectAllList();
		
		model.addAttribute("list", list);
		
		return "/admin/bannerList";
	}
	
	@RequestMapping("/mainBannerList.do")
	@ResponseBody
	public List<Banner> mainBannerList() {
		
		List<Banner> list = bannerService.mainBannerList();
		
		return list;
	}
	
}
