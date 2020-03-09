package wiki.bbongnamu.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import wiki.bbongnamu.core.dao.UserDao;
import wiki.bbongnamu.core.util.PasswordUtil;
import wiki.bbongnamu.core.vo.User;

@Service
public class UserService {
	
	private static final Logger logger = LoggerFactory.getLogger(UserService.class);

	@Autowired
	private UserDao userDao;
	
	public boolean join(User user) {
		String salt = PasswordUtil.makeSalt();
		String hashPassword = PasswordUtil.hashBySHA256(user.getPassword(), salt);
		user.setPassword(hashPassword);
		user.setSalt(salt);
		return userDao.insertUser(user);
	}
	
	public User login(User loginReq) {
		User user = userDao.selectNotWithdrawalUserById(loginReq.getId());
		if(user == null) {
			return null;
		}
		String loginPassword = PasswordUtil.hashBySHA256(loginReq.getPassword(), user.getSalt());
		if(user.getPassword().equals(loginPassword)) {
			return user;
		}else {
			return null;
		}
	}
	
	public boolean updatePassword(int num, String oldPassword, String newPassword) {
		User user = userDao.selectUser(num);
		logger.debug(user.toString());
		String hashOldPassword = PasswordUtil.hashBySHA256(oldPassword, user.getSalt());
		if(!hashOldPassword.equals(user.getPassword())) {
			logger.debug("비밀번호 확인 다름");
			return false;
		}
		logger.debug("비밀번호 확인 같음");
		String hashNewPassword = PasswordUtil.hashBySHA256(newPassword, user.getSalt());
		user.setPassword(hashNewPassword);
		return userDao.updatePassword(user);
	}

	public boolean withdrawal(int num, String password) {
		User user = userDao.selectUser(num);
		String hashPassword = PasswordUtil.hashBySHA256(password, user.getSalt());
		if(!hashPassword.equals(user.getPassword())) {
			return false;
		}
		return userDao.updateTypeToWithdrawal(num);
	}
	
	public User info(int num) {
		User info = new User();
		User user = userDao.selectUser(num);
		info.setNum(user.getNum());
		info.setId(user.getId());
		info.setType(user.getType());
		return info;
	}
	
}