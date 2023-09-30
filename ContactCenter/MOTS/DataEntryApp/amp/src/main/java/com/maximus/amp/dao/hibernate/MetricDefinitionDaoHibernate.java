package com.maximus.amp.dao.hibernate;

import java.util.List;

import org.apache.lucene.analysis.Analyzer;
import org.apache.lucene.analysis.StopAnalyzer;
import org.apache.lucene.queryParser.ParseException;
import org.apache.lucene.queryParser.QueryParser;
import org.apache.lucene.search.MatchAllDocsQuery;
import org.apache.lucene.search.Query;
import org.apache.lucene.util.Version;
import org.hibernate.Session;
import org.hibernate.search.FullTextQuery;
import org.hibernate.search.FullTextSession;
import org.hibernate.search.Search;
import org.springframework.stereotype.Repository;

import com.maximus.amp.dao.MetricDefinitionDao;
import com.maximus.amp.dao.SearchException;
import com.maximus.amp.model.MetricDefinition;

@Repository
public class MetricDefinitionDaoHibernate extends GenericDaoHibernate<MetricDefinition, Long> implements MetricDefinitionDao {

    /**
     * Constructor to create a Generics-based version using ProjectReport as the entity
     */
    public MetricDefinitionDaoHibernate() {
        super(MetricDefinition.class);
    }
    
    
    /**
     * {@inheritDoc}
     */
    public List<MetricDefinition> search(String searchTerm, boolean applyFilters) throws SearchException {

        FullTextQuery hibQuery = createFullTextQuery(searchTerm);

        if(applyFilters) {
        	hibQuery.enableFullTextFilter("isWeeklyOrMonthlyFilter");
	        hibQuery.enableFullTextFilter("isActiveFilter");
        }
        
        return hibQuery.list();
    }
	
}
