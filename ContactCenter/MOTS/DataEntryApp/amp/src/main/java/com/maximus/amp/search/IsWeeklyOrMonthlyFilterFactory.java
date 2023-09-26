package com.maximus.amp.search;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.CachingWrapperFilter;
import org.apache.lucene.search.Filter;
import org.apache.lucene.search.QueryWrapperFilter;
import org.apache.lucene.search.TermQuery;
import org.hibernate.search.annotations.Factory;


public class IsWeeklyOrMonthlyFilterFactory {

	@Factory
  	  public Filter getFilter() {

		BooleanQuery query = new BooleanQuery();
	  	BooleanQuery booleanQuery = new BooleanQuery();
    	
	  	TermQuery isMonthlyQuery = new TermQuery(new Term("isMonthly", "Y"));
    	TermQuery isWeeklyQuery = new TermQuery(new Term("isWeekly", "Y"));
    	
    	booleanQuery.add(new BooleanClause(isMonthlyQuery, BooleanClause.Occur.SHOULD));
    	booleanQuery.add(new BooleanClause(isWeeklyQuery, BooleanClause.Occur.SHOULD));
    	
    	query.add(new BooleanClause(booleanQuery, BooleanClause.Occur.MUST));
		
		
//		BooleanQuery query = new BooleanQuery();
//  	    Term statusTerm = new Term("isWeekly", "Y");
//  	    query.add(new TermQuery(statusTerm), BooleanClause.Occur.MUST);
    	
  	    return new CachingWrapperFilter(new QueryWrapperFilter(query));
  	    

  	  }
 	
}
