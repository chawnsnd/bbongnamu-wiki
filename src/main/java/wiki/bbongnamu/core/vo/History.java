package wiki.bbongnamu.core.vo;

import lombok.Data;

@Data
public class History {
	private int num;
	private int wikinum;
	private int usernum;
	private String content;
	private String type;
	private int revertnum;
	private String explanation;
	private String writedate;
	private String userId;
}
