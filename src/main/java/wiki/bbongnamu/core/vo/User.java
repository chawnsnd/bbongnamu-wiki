package wiki.bbongnamu.core.vo;

import lombok.Data;

@Data
public class User {
	private int num;
	private String id;
	private String password;
	private String salt;
	private String type;
}