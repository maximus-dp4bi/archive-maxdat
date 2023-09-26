package com.maximus.amp.webapp.validator;

import java.util.Map;

public interface ExpressionEvaluator {

	Boolean evaluateBooleanExpression(String expression, Map<String, Object> variables);
	
	
}
