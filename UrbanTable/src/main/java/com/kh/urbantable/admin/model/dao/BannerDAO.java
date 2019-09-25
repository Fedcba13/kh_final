package com.kh.urbantable.admin.model.dao;

import java.util.List;

import com.kh.urbantable.admin.model.vo.Banner;

public interface BannerDAO {

	int insertBanner(Banner banner);

	List<Banner> selectAllList();

	int updateBanner(Banner banner);

	int deleteBanner(String bannerId);

	List<Banner> mainBannerList();

}
