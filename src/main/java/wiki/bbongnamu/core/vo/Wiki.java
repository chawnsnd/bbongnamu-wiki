package wiki.bbongnamu.core.vo;

import lombok.Data;

@Data
public class Wiki {
	private int num;
	private String title;
	private String content;
	private int historynum;
	private String historytype;
}
