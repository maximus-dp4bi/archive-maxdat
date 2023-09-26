package com.maximus.amp.webapp.validator;

import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;

import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Ignore;
import org.junit.Test;

public class ExpressionEvaluatorImplTest {
	
	protected final Log log = LogFactory.getLog(getClass());
	
	ExpressionEvaluatorImpl evaluator = new ExpressionEvaluatorImpl();
	
	@Test
	public void testComparisonOperatorExpression() {
		
	    Boolean result = null; 
	    Map<String, Object> variables = null;
	    
	    variables = new HashMap<String, Object>();
	    variables.put("metric", 100F);
	    variables.put("other", 10F);
	    
	    result = evaluator.evaluateBooleanExpression("#metric <= #other", variables);
	    
	    assertThat(result, is(false));
	    
	    variables = new HashMap<String, Object>();
	    variables.put("metric", 10F);
	    variables.put("other", 10F);
	    
	    result = evaluator.evaluateBooleanExpression("#metric == #other", variables);

	    assertThat(result, is(true));

	    variables = new HashMap<String, Object>();
	    variables.put("metric", 10F);
	    variables.put("other", 100F);
	    
	    result = evaluator.evaluateBooleanExpression("#metric > #other", variables);
	    
	    assertThat(result, is(false));
	    
	}
	
	@Test
	public void testPercentageCalculationExpression() {
		
	    Boolean result = null; 
	    Map<String, Object> variables = null;

	    variables = new HashMap<String, Object>();
	    variables.put("metric", 140F);
	    variables.put("other", 100F);
	    
	    result = evaluator.evaluateBooleanExpression("#metric / #other < 1.2 and #metric / #other > 0.8", variables);
	    
	    assertThat(result, is(false));
	    
	    variables = new HashMap<String, Object>();
	    variables.put("metric", 110F);
	    variables.put("other", 100F);
	    
	    result = evaluator.evaluateBooleanExpression("#metric / #other <= 1.2 and #metric / #other >= 0.8", variables);
	    
	    assertThat(result, is(true));
		
	}
	
	@Test
	@Ignore("this test should not be run as a part of the standard build")
	public void loadTestExpressions() {
		
		long start = System.currentTimeMillis();
		
	    Boolean result = null; 
	    Map<String, Object> variables = null;
	    
	    Random random = new Random(100);
	    
		for(int i=0; i<1000000; i++) {

			Float metric = random.nextFloat()*100;
			Float other = random.nextFloat()*100;
			
		    variables = new HashMap<String, Object>();
		    variables.put("metric", metric);
		    variables.put("other", other);
			
		    result = evaluator.evaluateBooleanExpression("#metric <= #other", variables);
		    
		    result = evaluator.evaluateBooleanExpression("#metric == #other", variables);
		    		    
		    result = evaluator.evaluateBooleanExpression("#metric > #other", variables);
		    		    
		    result = evaluator.evaluateBooleanExpression("#metric / #other < 1.2 and #metric / #other > 0.8", variables);
		    
		    result = evaluator.evaluateBooleanExpression("#metric / #other <= 1.2 and #metric / #other >= 0.8", variables);
		    
			
		}
		
		long end = System.currentTimeMillis();
		
		log.debug(end-start);
	}

}
