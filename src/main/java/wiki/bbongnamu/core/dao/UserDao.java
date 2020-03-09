package wiki.bbongnamu.core.dao;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wiki.bbongnamu.core.vo.User;

@Repository
public class UserDao {
	
	private static final Logger logger = LoggerFactory.getLogger(UserDao.class);

	@Autowired
	private SqlSession session;
	
	public boolean insertUser(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		if (mapper.insertUser(user) == 1) {
			return true;
		} else {
			return false;
		}
	}

	public User checkUserId(String id) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User user = mapper.selectUserById(id);
		return user;
	}

	public User selectUser(int num) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User user = mapper.selectUser(num);
		return user;
	}

	public User selectNotWithdrawalUserById(String id) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User user = mapper.selectNotWithdrawalUserById(id);
		return user;
	}

	public User selectUserById(String id) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		User user = mapper.selectUserById(id);
		return user;
	}
	
	public boolean updatePassword(User user) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		if (mapper.updatePassword(user) == 1) {
			return true;
		} else {
			return false;
		}
	}

	public boolean updateTypeToWithdrawal(int num) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		if (mapper.updateTypeToWithdrawal(num) == 1) {
			return true;
		} else {
			return false;
		}
	}

	public boolean deleteUser(int num) {
		UserMapper mapper = session.getMapper(UserMapper.class);
		if (mapper.deleteUser(num) == 1) {
			return true;
		} else {
			return false;
		}
	}
}
