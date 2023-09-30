package com.maximus.amp.search;

import org.apache.lucene.index.Term;
import org.apache.lucene.search.BooleanClause;
import org.apache.lucene.search.BooleanQuery;
import org.apache.lucene.search.CachingWrapperFilter;
import org.apache.lucene.search.Filter;
import org.apache.lucene.search.QueryWrapperFilter;
import org.apache.lucene.search.TermQuery;
import org.hibernate.search.annotations.Factory;

public class IsActiveFilterFactory {
	
	
	@Factory
	public Filter getFilter() {
		
		BooleanQuery query = new BooleanQuery();
		    Term statusTerm = new Term("status", "Active");
		    query.add(new TermQuery(statusTerm), BooleanClause.Occur.MUST);
		
	    return new CachingWrapperFilter(new QueryWrapperFilter(query));
	}
}
