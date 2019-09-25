package com.kh.urbantable.admin.model.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.urbantable.admin.model.dao.BannerDAO;
import com.kh.urbantable.admin.model.vo.Banner;

@Service
public class BannerServiceImpl implements BannerService{

	@Autowired
	BannerDAO bannerDAO;

	@Override
	public int insertBanner(Banner banner) {
		
		return bannerDAO.insertBanner(banner);
	}

	@Override
	public List<Banner> selectAllList() {
		
		return bannerDAO.selectAllList();
	}

	@Override
	public int updateBanner(Banner banner) {
		
		return bannerDAO.updateBanner(banner);
	}

	@Override
	public int deleteBanner(String bannerId) {
		
		return bannerDAO.deleteBanner(bannerId);
	}

	@Override
	public List<Banner> mainBannerList() {
		
		return bannerDAO.mainBannerList();
	}
}
