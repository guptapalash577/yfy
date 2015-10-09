package com.weed.yfy.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.weed.yfy.auth.CustomAuthenticationProvider;
import com.weed.yfy.dto.User;
import com.weed.yfy.enums.MailMessageType;
import com.weed.yfy.service.MailingService;
import com.weed.yfy.service.UserService;
import com.weed.yfy.util.ApplicationProperties;
import com.weed.yfy.util.YfYConstants;

/**
 * @author palash
 *
 */
@Controller
public class YfYController {

	private static final Logger logger = Logger.getLogger(YfYController.class);
	
	@Autowired
	UserService userService;
	
	@Autowired
	MailingService mailing;
	
	@Autowired
	ApplicationProperties applicationProperties;
	
	@RequestMapping("/signIn")
	public ModelAndView showSignInPage(@RequestParam(required=false) String status) {
		ModelAndView view = new ModelAndView("sign_in");
		view.addObject("status", status);
		return view;
	}
	
	@RequestMapping("/home")
	public ModelAndView showHomePage() {
		ModelAndView view = new ModelAndView("home");
		
		return view;
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String signUp(@RequestParam String emailId, @RequestParam Long mobileNo, 
			@RequestParam String password) {
		logger.info("YfYController signUp() Start");
		String status = "";
		User existingUser = userService.getUserByEmailId(emailId);
		if (existingUser == null){
			User user = new User();
			user.setEmailId(emailId);
			user.setMobileNo(mobileNo);
			user.setPassword(password);
			
			SimpleMailMessage msg = new SimpleMailMessage();
			msg.setTo(emailId);
			msg.setFrom("YfY");
			msg.setSubject("Confirm Email Id");
			Map<Object,Object> hTemplateVariables = new HashMap<Object,Object>();
			hTemplateVariables.put("url", applicationProperties.getProperty("emailVerificationUrl")+"?emailId="+emailId);
			mailing.send(msg, hTemplateVariables, MailMessageType.EMAIL_VERIFICATION+".vm");
			
			status = userService.addUser(user);
			if (status.equals(YfYConstants.SUCCESS)) {
				return "redirect:/signIn.yfy?status="+YfYConstants.SUCCESS;
			}
		}
		logger.info("YfYController signUp() End");
		return "redirect:/signIn.yfy?status="+YfYConstants.FAIL;
	}
	
	@RequestMapping(value = "/verify_email", method = RequestMethod.GET)
	public void userEmailVerification(@RequestParam String emailId, HttpServletResponse response) throws Exception {
		logger.info("YfYController userEmailVerification() start");
		if (StringUtils.isBlank(emailId)) {
			logger.debug("YfYController userEmailVerification emailId is Blank");
		} else {
			userService.activateUserByEmail(emailId);
		}
		response.sendRedirect("http://localhost:8080/YfY/");
	}
	
	@RequestMapping(value = "/fb_login", method = RequestMethod.POST)
	@ResponseBody
	public String fbLogin(@RequestParam String emailId, HttpServletRequest request) {
		UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(emailId, null);
        CustomAuthenticationProvider customAuthenticationProvider = new CustomAuthenticationProvider();
		try {
			Authentication auth = customAuthenticationProvider.authenticate(token);
			SecurityContextHolder.getContext().setAuthentication(auth);
			HttpSession session = request.getSession();
			User signedInUser = userService.getUserByEmailId(emailId);
			session.setAttribute("yfyUser", signedInUser);
			return "redirect:/home.yfy";
		} catch (Exception e) {
		    return YfYConstants.FAIL;
		}
	}
	
	@RequestMapping(value = "/save_email", method = RequestMethod.POST)
	@ResponseBody
	public String saveEmail(@RequestParam String email) {
		logger.info("YfYController saveEmail() start");
		String status = userService.saveEmail(email);
		logger.info("YfYController saveEmail() end  status:" + status);
		return status;
	}
}
