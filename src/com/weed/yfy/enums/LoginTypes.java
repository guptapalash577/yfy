package com.weed.yfy.enums;

/**
 * @author palash
 *
 */
public enum LoginTypes {
	FB(1),GPLUS(2);
	
	private int val;
	
	private LoginTypes(int val) {
		this.val = val;
	}

	public int getValue() {
		return this.val;
	}
}
