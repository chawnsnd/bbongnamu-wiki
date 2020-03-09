package wiki.bbongnamu.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiki.bbongnamu.core.util.PageNavigator;
import wiki.bbongnamu.core.vo.Wiki;

@Repository
public class WikiDao {
	
	private static final Logger logger = LoggerFactory.getLogger(WikiDao.class);

	@Autowired
	private SqlSession session;
	
	public boolean insertWiki(Wiki wiki) {
		logger.debug("신규 등록 위키: "+wiki.toString());
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		if(mapper.insertWiki(wiki) == 1) {
			return true;
		}else {
			return false;
		}
	}

	public int selectNextSeq() {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		return mapper.selectNextSeq();
	}
	
	public Wiki selectWiki(int num) {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		return mapper.selectWiki(num);
	}

	public int selectCountByTitle(String title) {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		return mapper.selectCountByTitle(title);
	}

	public ArrayList<Wiki> selectWikisByTitle(String title, PageNavigator pageNavigator) {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		RowBounds rowBounds = new RowBounds(pageNavigator.getStartRecord(), pageNavigator.getCountPerPage());
		return mapper.selectWikisByTitle(title, rowBounds);
	}

	public Wiki selectWikiByTitle(String title) {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		return mapper.selectWikiByTitle(title);
	}
	
	public Wiki selectRandomWiki() {
		WikiMapper mapper = session.getMapper(WikiMapper.class);
		return mapper.selectRandomWiki();
	}
	
}
