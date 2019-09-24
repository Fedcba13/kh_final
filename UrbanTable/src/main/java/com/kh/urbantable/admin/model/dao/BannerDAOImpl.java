package com.kh.urbantable.admin.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.admin.model.vo.Banner;


@Repository
public class BannerDAOImpl implements BannerDAO{

	@Autowired 
	SqlSessionTemplate sqlSession;

	@Override
	public int insertBanner(Banner banner) {
		
		return sqlSession.insert("banner.insertBanner", banner);
	}

	@Override
	public List<Banner> selectAllList() {
		
		return sqlSession.selectList("banner.selectAllList");
	}

	@Override
	public int updateBanner(Banner banner) {
		
		return sqlSession.update("banner.updateBanner", banner);
	}

	@Override
	public int deleteBanner(String bannerId) {
		
		return sqlSession.delete("banner.deleteBanner", bannerId);
	}

	@Override
	public List<Banner> mainBannerList() {
		
		return sqlSession.selectList("banner.mainBannerList");
	}
}
