package com.kh.urbantable.admin.model.dao;

import java.util.List;

import com.kh.urbantable.admin.model.vo.MarketMember;
import com.kh.urbantable.marketOwner.model.vo.Market;

public interface MarketDAO {

	List<MarketMember> selectList();

}
