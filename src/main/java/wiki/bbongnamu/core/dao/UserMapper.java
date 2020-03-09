package wiki.bbongnamu.core.dao;

import wiki.bbongnamu.core.vo.User;

public interface UserMapper {

	public int insertUser(User user);

	public User selectNotWithdrawalUserById(String id);

	public User selectUserById(String id);
	
	public User selectUser(int num);
		
	public int updatePassword(User user);
	
	public int updateTypeToWithdrawal(int num); //회원탈퇴처리
	
	public int deleteUser(int num); //회원완전삭제
	
}