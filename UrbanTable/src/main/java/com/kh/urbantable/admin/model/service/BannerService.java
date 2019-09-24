package com.kh.urbantable.admin.model.service;

import java.util.List;

import com.kh.urbantable.admin.model.vo.Banner;

public interface BannerService {

	int insertBanner(Banner banner);

	List<Banner> selectAllList();

	int updateBanner(Banner banner);

	int deleteBanner(String bannerId);

	List<Banner> mainBannerList();


}
