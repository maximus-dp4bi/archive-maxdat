package com.maximus.amp.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.lang3.tuple.ImmutablePair;
import org.apache.commons.lang3.tuple.Pair;

public class ValidationResult implements Serializable {
	
	private static final long serialVersionUID = 487415359360892511L;
	
	private boolean isValid;
	private boolean hasError;
	private boolean hasWarning;
	private String field;
	private List<Pair<String, String>> messages;
	
	private ValidationResult() {  }
	
	public ValidationResult(String field) {
		this();
		
		this.field = field;
		isValid = true;
		hasError = false;
		hasWarning = false;
		messages = new ArrayList<Pair<String, String>>();
	}

	public ValidationResult addMessage(String errorCode, String message) {
		
		isValid = false;
		
		if(errorCode.equals("ERROR")) {
			hasError = true;
		} else if(errorCode.equals("WARNING")){
			hasWarning = true;
		}
		
		getMessages().add(new ImmutablePair<String, String>(errorCode, message));
		
		return this;
	}
	
	public String getField() {
		return field;
	}
	public List<Pair<String,String>> getMessages() {
		return messages;
	}
	public boolean isHasError() {
		return hasError;
	}
	public boolean isHasWarning() {
		return hasWarning;
	}

	public boolean getIsValid() {
		return isValid;
	}



}
