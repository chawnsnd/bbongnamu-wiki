package wiki.bbongnamu.core.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import wiki.bbongnamu.core.vo.History;

public interface HistoryMapper {

	public int insertHistory(History history);
	
	public History selectHistory(int num);
	
	public int selectCountByWikinum(int wikinum);

	public ArrayList<History> selectHistoriesByWikinum(int wikinum, RowBounds rb);

	public History selectRecentHistoryByWikinum(int wikinum);
	
	public ArrayList<History> selectRecentHistories();
}
