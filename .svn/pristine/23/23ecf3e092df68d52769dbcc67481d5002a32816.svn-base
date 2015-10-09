package com.weed.yfy.util;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.apache.log4j.Logger;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Component;

import com.weed.yfy.dao.support.AbstractJdbcDaoSupport;

/**
 * @author palash
 *
 */
@Component
public class ApplicationProperties extends AbstractJdbcDaoSupport {

	private static final Logger logger = Logger.getLogger(ApplicationProperties.class);
	
	private class ApplicationProperty {

		private String name;
		private String value;

		public String getName() {
			return name;
		}

		public void setName(String name) {
			this.name = name;
		}

		public String getValue() {
			return value;
		}

		public void setValue(String value) {
			this.value = value;
		}
	}

	private Map<String, String> properties = new HashMap<String, String>();
	/**
	 * loads all properties
	 */
	@PostConstruct
	public void init() {
		// load all properties
		logger.info("ApplicationProperties init() LOADING ALL PROPERTIES...");
		List<ApplicationProperty> allPropertiesFromDb = getJdbcTemplate().query("select property_name, property_value from application_properties", new RowMapper<ApplicationProperty>() {
			public ApplicationProperty mapRow(ResultSet rs, int rowNum) throws SQLException {
				ApplicationProperty applicationProperty = new ApplicationProperty();
				applicationProperty.setName(rs.getString("property_name"));
				applicationProperty.setValue(rs.getString("property_value"));
				return applicationProperty;
			}
		});
		
		properties.clear();
		for (ApplicationProperty applicationProperty : allPropertiesFromDb) {
			properties.put(applicationProperty.getName(), applicationProperty.getValue());
		}
		
		logger.info("ApplicationProperties init() LOADING ALL PROPERTIES... DONE");
	}
/**
 *  method to get property by passing propertyName
 * @param propertyName -application property name
 * @return propertyValue
 */
	public String getProperty(String propertyName) {
		logger.debug("ApplicationProperties getProperty() looking property: " + propertyName);
		
		String propertyValue = properties.get(propertyName);
		logger.debug("ApplicationProperties getProperty() property value: " + propertyValue);
		
		return propertyValue;
	}
/**
 * overridden method to get property by passing propertyName and Default
 * @param propertyName-application property name
 * @param Default-default property
 * @return propertyValue
 */
	public String getProperty(String propertyName, String Default) {
		logger.debug("ApplicationProperties getProperty(Default) looking property: " + propertyName);
		
		String propertyValue = properties.get(propertyName) == null? Default : properties.get(propertyName);
		logger.debug("ApplicationProperties getProperty(Default) property value: " + propertyValue);
		
		return propertyValue;
	}
}
