package com.weed.yfy.service;

import com.weed.yfy.dto.User;

/**
 * @author palash
 *
 */
public interface UserService {

	String addUser(User user);

	User getUserByEmailId(String emailId);

	void activateUserByEmail(String emailId);

	User getUserByEmailIdAndPassword(String emailId, String password);

	String saveEmail(String email);

}
