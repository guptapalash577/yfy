package com.weed.yfy.dao.support;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

/**
 * @author palash
 *
 */
public abstract class AbstractJdbcDaoSupport {

	@Autowired
	private DataSource dataSource;
	
	protected JdbcTemplate getJdbcTemplate() {
		return new JdbcTemplate(dataSource);
	}
	
	protected NamedParameterJdbcTemplate getNamedParameterJdbcTemplate() {
		return new NamedParameterJdbcTemplate(dataSource);
	}
}
