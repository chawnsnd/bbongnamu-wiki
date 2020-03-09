package wiki.bbongnamu.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiki.bbongnamu.core.util.PageNavigator;
import wiki.bbongnamu.core.vo.History;

@Repository
public class HistoryDao {
	
	private static final Logger logger = LoggerFactory.getLogger(HistoryDao.class);

	@Autowired
	private SqlSession session;
	
	public boolean insertHistory(History history) {
		logger.debug("신규등록 역사: "+history.toString());
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		if (mapper.insertHistory(history) == 1) {
			return true;
		} else {
			return false;
		}
	}

	public History selectWikiHistory(int num) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		return mapper.selectHistory(num);
	}
	
	public int selectCountByWikinum(int wikinum) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		return mapper.selectCountByWikinum(wikinum);
	}

	public ArrayList<History> selectHistoriesByWikinum(int wikinum, PageNavigator pageNavigator) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		RowBounds rowBounds = new RowBounds(pageNavigator.getStartRecord(), pageNavigator.getCountPerPage());
		return mapper.selectHistoriesByWikinum(wikinum, rowBounds);
	}

	public History selectRecentHistoryByWikinum(int wikinum) {
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		return mapper.selectRecentHistoryByWikinum(wikinum);
	}
	
	public ArrayList<History> selectRecentHistories(){
		HistoryMapper mapper = session.getMapper(HistoryMapper.class);
		return mapper.selectRecentHistories();
	}
}
