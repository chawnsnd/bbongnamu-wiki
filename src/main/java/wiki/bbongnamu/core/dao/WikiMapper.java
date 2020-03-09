package wiki.bbongnamu.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import wiki.bbongnamu.core.vo.Wiki;

public interface WikiMapper {

	public int insertWiki(Wiki wiki);
	
	public int selectNextSeq();

	public Wiki selectWiki(int num);
	
	public Wiki selectWikiByTitle(String title);
	
	public int selectCountByTitle(String title);

	public ArrayList<Wiki> selectWikisByTitle(String title, RowBounds rowBounds);
	
	public Wiki selectRandomWiki();
	
}
