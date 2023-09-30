package com.maximus.amp.webapp.validator;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.expression.Expression;
import org.springframework.expression.spel.SpelCompilerMode;
import org.springframework.expression.spel.SpelParserConfiguration;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.stereotype.Component;

@Component(value="expressionEvaluator")
public class ExpressionEvaluatorImpl implements ExpressionEvaluator {
	
	protected final Log log = LogFactory.getLog(getClass());

	private SpelExpressionParser parser;
	
	private Map<String, Expression> expressionMap = new ConcurrentHashMap<String, Expression>();
	
	public ExpressionEvaluatorImpl() {
		SpelParserConfiguration config = new SpelParserConfiguration(SpelCompilerMode.IMMEDIATE, this.getClass().getClassLoader());
		parser = new SpelExpressionParser(config);
	}
	
	@Override
	public Boolean evaluateBooleanExpression(String expression, Map<String, Object> variables) {
		
		// logging has a 4x impact on performance;  should be used as a last resort
		// log.debug("evaluating expression:  " + expression);
		
		//  leveraging a hashmap to minimize the number of times parseExpression is called
		//  has a 3x impact on performance when tested with 5,000,000 executions
		Expression expr = expressionMap.get(expression);
		
		if(expr == null) {
			 expr = parser.parseExpression(expression);
			 expressionMap.put(expression, expr);
		}
		
		StandardEvaluationContext evalContext = new StandardEvaluationContext();
		
		for(String key : variables.keySet()) {
			evalContext.setVariable(key, variables.get(key));
		}
	    
	    Boolean result = expr.getValue(evalContext, Boolean.class);
	    
		return result;
	}

}
