package wiki.bbongnamu.core.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import wiki.bbongnamu.core.dao.UserDao;
import wiki.bbongnamu.core.exception.DuplicateIdException;
import wiki.bbongnamu.core.exception.NotRegularPasswordException;
import wiki.bbongnamu.core.vo.User;

@Component
public class JoinCheck {
	
	@Autowired
	private UserDao userDao;

	public boolean checkId(String id) throws NullPointerException, DuplicateIdException {
		User user = userDao.checkUserId(id);
		if (user == null) {
			return true;
		} else {
			throw new DuplicateIdException();
		}
	}

	public boolean checkPassword(String password) throws NullPointerException, NotRegularPasswordException {
		String reg = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$";
		Matcher matcher = Pattern.compile(reg).matcher(password);
		if (matcher.matches()) {
			return true;
		} else {
			throw new NotRegularPasswordException();
		}
	}

	public boolean checkUser(User user)
			throws NullPointerException, DuplicateIdException, NotRegularPasswordException {
		if (checkId(user.getId()) && checkPassword(user.getPassword())) {
			return true;
		} else {
			return false;
		}
	}
}
