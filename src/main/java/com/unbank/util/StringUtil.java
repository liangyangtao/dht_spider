package com.unbank.util;

public class StringUtil {

	public static String findMiddleByLeftAndRight(String src, String left, String right) {
		int l = src.indexOf(left);
		if (l < 0)
			return null;
		int r = src.indexOf(right, l + left.length());
		
		if (r >= 0) {
			return src.substring(l + left.length(), r);
		}
		return null;
	}
}
