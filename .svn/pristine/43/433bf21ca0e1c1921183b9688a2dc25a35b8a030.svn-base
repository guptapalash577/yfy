package com.weed.yfy.service;

import java.util.Map;

import org.springframework.mail.SimpleMailMessage;

/**
 * @author palash
 *
 */
public interface MailingService {
/**
	* Sends e-mail using Velocity template for the body and
	* the properties passed in as Velocity variables.
	*
	* @param msg The e-mail message to be sent, except for the body.
	* @param hTemplateVariables Variables to use when processing the template.
	* @param templateFileName - template file to be used
	*/
	public void send(SimpleMailMessage msg, Map<Object, Object> hTemplateVariables,String templateFileName);
		
	/**
	* Sends e-mail using Velocity template for the body and
	* the properties passed in as Velocity variables.
	*
	* @param msg The e-mail message to be sent, except for the body.
	* @param attachmentFile The attachment to be sent with the mail.
	* @param hTemplateVariables Variables to use when processing the template.
	* @param templateFileName - template file to be used.
	*/
	public void sendEmailWithAttachment(SimpleMailMessage msg, String attachmentFile, Map<Object, Object> hTemplateVariables,String templateFileName);
}
