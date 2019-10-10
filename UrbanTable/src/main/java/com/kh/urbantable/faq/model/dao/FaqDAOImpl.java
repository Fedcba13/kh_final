package com.kh.urbantable.faq.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.urbantable.faq.model.vo.Faq;

@Repository
public class FaqDAOImpl implements FaqDAO {

	@Autowired
	SqlSessionTemplate sqlSession;

	@Override
	public List<Faq> selectFaqList() {
		//offset
		//limit
//		int offset = (cPage-1)*FaqService.NUM_PER_PAGE;
//		int limit = FaqService.NUM_PER_PAGE;
//		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSession.selectList("faq.selectFaqList");
	}

	@Override
	public Faq selectOneFaq(String noticeNo) {
		return sqlSession.selectOne("faq.selectOneFaq", noticeNo);
	}
	
	@Override
	public int insertFaq(Faq faq) {
		return sqlSession.insert("faq.insertFaq", faq);
	}

	@Override
	public int updateFaq(Faq faq) {
		return sqlSession.update("faq.updateFaq", faq);
	}

	@Override
	public int deleteFaq(String noticeNo) {
		return sqlSession.update("faq.deleteFaq", noticeNo);
	}

	@Override
	public Map<String, String> selectPreNext(String noticeNo) {
		return sqlSession.selectOne("faq.selectPreNext", noticeNo);
	}

}
