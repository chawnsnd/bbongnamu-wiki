package wiki.bbongnamu.core.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import wiki.bbongnamu.core.dao.WikiDao;
import wiki.bbongnamu.core.exception.NotFoundWikiException;
import wiki.bbongnamu.core.util.PageNavigator;
import wiki.bbongnamu.core.dao.HistoryDao;
import wiki.bbongnamu.core.vo.Wiki;
import wiki.bbongnamu.core.vo.History;

@Service
public class WikiService {
	
	private static final Logger logger = LoggerFactory.getLogger(WikiService.class);
	private static final int HISTORY_COUNT_PER_PAGE = 10;
	private static final int WIKI_COUNT_PER_PAGE = 5;
	private static final int PAGE_PER_GROUP = 5;
	
	@Autowired
	private WikiDao wikiDao;
	
	@Autowired
	private HistoryDao historyDao;
	
	public Wiki searchWikiByNum(int num) {
		Wiki wiki = wikiDao.selectWiki(num);
		History history = historyDao.selectRecentHistoryByWikinum(num);
		wiki.setContent(history.getContent());
		return wiki;
	}
	
	public HashMap<String, Object> searchWikisByTitle(String title, int currentPage) {
		HashMap<String, Object> map = new HashMap<>();
		int totalCount = wikiDao.selectCountByTitle(title);
		PageNavigator pageNavigator = new PageNavigator(WIKI_COUNT_PER_PAGE, PAGE_PER_GROUP, currentPage, totalCount);
		ArrayList<Wiki> wikis = wikiDao.selectWikisByTitle(title, pageNavigator);
		for (Wiki wiki : wikis) {
			String content = historyDao.selectRecentHistoryByWikinum(wiki.getNum()).getContent();
			wiki.setContent(content);
		}
		map.put("wikis", wikis);
		map.put("pageNavigator", pageNavigator);
		return map;
	}

	public Wiki searchWikiByTitle(String title) throws NotFoundWikiException{
		Wiki wiki = wikiDao.selectWikiByTitle(title);
		if(wiki == null) throw new NotFoundWikiException();
		History history = historyDao.selectRecentHistoryByWikinum(wiki.getNum());
		wiki.setContent(history.getContent());
		wiki.setHistorynum(history.getNum());
		return wiki;
	}

	public Wiki searchWikiByTitleAndHistorynum(String title, int historynum) throws NotFoundWikiException{
		Wiki wiki = wikiDao.selectWikiByTitle(title);
		if(wiki == null) throw new NotFoundWikiException();
		History history = null;
		if(historynum == 0) {
			history = historyDao.selectRecentHistoryByWikinum(wiki.getNum());
		}else {
			history = historyDao.selectWikiHistory(historynum);
		}
		wiki.setContent(history.getContent());
		wiki.setHistorynum(historynum);
		wiki.setHistorytype(history.getType());
		return wiki;
	}

	@Transactional
	public boolean editWiki(String title, String content, int usernum, String explanation) {
		logger.debug("신규 위키 등록: "+title+", "+content);
		Wiki oldWiki = wikiDao.selectWikiByTitle(title);
		Wiki newWiki = new Wiki();
		History history = new History();
		if(oldWiki == null) {
			//새로 등록
			int nextvalSeq = wikiDao.selectNextSeq();
			
			newWiki.setNum(nextvalSeq);
			newWiki.setTitle(title);
			
			history.setContent(content);
			history.setType("CREATE");
			history.setExplanation(explanation);
			history.setUsernum(usernum);
			history.setWikinum(nextvalSeq);
			
			if(wikiDao.insertWiki(newWiki) && historyDao.insertHistory(history)) {
				return false;
			}
			return false;
		}else {
			//수정
			history.setExplanation(explanation);
			history.setType("UPDATE");
			history.setUsernum(usernum);
			history.setWikinum(oldWiki.getNum());
			history.setContent(content);
			if(historyDao.insertHistory(history)) {
				return false;
			}
			return true;
		}
	}
	
	public boolean revertWiki(int historynum, int usernum, String explanation) {
		History history = historyDao.selectWikiHistory(historynum);
		history.setExplanation(explanation);
		//다시 삭제하려 할때 
		if(history.getType().equals("DELETE")) {
			history.setContent("");
		}else {
			history.setType("REVERT");
		}
		history.setRevertnum(historynum);
		history.setUsernum(usernum);
		if(historyDao.insertHistory(history)) {
			return false;
		}
		return true;
	}
	
	public boolean deleteWiki(String title, int usernum, String explanation) {
		History history = new History();
		Wiki wiki = wikiDao.selectWikiByTitle(title);
		history.setExplanation(explanation);
		history.setType("DELETE");
		history.setUsernum(usernum);
		history.setWikinum(wiki.getNum());
		history.setContent("");
		if(historyDao.insertHistory(history)) {
			return false;
		}
		return true;
	}
	
	public HashMap<String, Object> searchHistories(String title, int currentPage) {
		HashMap<String, Object> map = new HashMap<>();
		Wiki wiki = wikiDao.selectWikiByTitle(title);
		int totalCount = historyDao.selectCountByWikinum(wiki.getNum());
		PageNavigator pageNavigator = new PageNavigator(HISTORY_COUNT_PER_PAGE, PAGE_PER_GROUP, currentPage, totalCount);
		ArrayList<History> histories = historyDao.selectHistoriesByWikinum(wiki.getNum(), pageNavigator);
		map.put("histories", histories);
		map.put("pageNavigator", pageNavigator);
		return map;
	}

	public ArrayList<Wiki> searchRecentWikis() {
		ArrayList<History> histories = historyDao.selectRecentHistories();
		ArrayList<Wiki> wikis = new ArrayList<>();
		for (History history : histories) {
			wikis.add(wikiDao.selectWiki(history.getWikinum()));
		}
		return wikis;
	}
	
	public Wiki searchRandomWiki(){
		return wikiDao.selectRandomWiki();
	}
	
}