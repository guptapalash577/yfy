package com.weed.yfy.service.impl;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.weed.yfy.dao.UserDao;
import com.weed.yfy.dto.User;
import com.weed.yfy.service.UserService;
import com.weed.yfy.util.YfYConstants;

/**
 * @author palash
 *
 */
@Service
public class UserServiceImpl implements UserService {

	private static final Logger logger = Logger.getLogger(UserServiceImpl.class);
	
	@Autowired
	private UserDao userDao;
	
	@Override
	@Transactional(rollbackFor=Exception.class)
	public String addUser(User user) {
		logger.info("UserServiceImpl addUser() start");
		int userId = 0;
		try {
			userId = userDao.addUser(user);
		} catch (Exception e) {
			logger.error("UserServiceImpl addUser() error" ,e);
		}
		logger.info("UserServiceImpl addUser() end");
		return userId>0 ? YfYConstants.SUCCESS : YfYConstants.FAIL;
	}

	@Override
	public User getUserByEmailId(String emailId) {
		logger.info("UserServiceImpl getUserByEmailId() start");
		User user = null;
		try {
			user = userDao.getUserByEmailId(emailId);
		} catch (Exception e) {
			logger.error("UserServiceImpl getUserByEmailId() error" ,e);
		}
		logger.info("UserServiceImpl getUserByEmailId() end");
		return user;
	}

	@Override
	public void activateUserByEmail(String emailId) {
		logger.info("UserServiceImpl activateUserByEmail() start");
		try{
			userDao.activateUserByEmail(emailId);
		} catch (Exception e) {
			logger.error("UserServiceImpl activateUserByEmail() error" ,e);
		}
		logger.info("UserServiceImpl activateUserByEmail() end");
	}

	@Override
	public User getUserByEmailIdAndPassword(String emailId, String password) {
		logger.info("UserServiceImpl getUserByEmailIdAndPassword() start");
		User user = null;
		try {
			user = userDao.getUserByEmailIdAndPassword(emailId,password);
		} catch (Exception e) {
			logger.error("UserServiceImpl getUserByEmailIdAndPassword() error" ,e);
		}
		logger.info("UserServiceImpl getUserByEmailIdAndPassword() end");
		return user;
	}

	@Override
	public String saveEmail(String email) {
		logger.info("UserServiceImpl saveEmail() start");
		String status = "";
		try {
			userDao.saveEmail(email);
			status = YfYConstants.SUCCESS;
		} catch (Exception e) {
			logger.error("UserServiceImpl saveEmail() error" ,e);
			status = YfYConstants.FAIL;
		}
		logger.info("UserServiceImpl saveEmail() end");
		return status;
	}
}