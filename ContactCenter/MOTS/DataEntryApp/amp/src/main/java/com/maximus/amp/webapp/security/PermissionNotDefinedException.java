package com.maximus.amp.webapp.security;

public class PermissionNotDefinedException extends RuntimeException {

	private static final long serialVersionUID = -4698626027922788371L;

	public PermissionNotDefinedException(String message) {
		super(message);
	}

}
