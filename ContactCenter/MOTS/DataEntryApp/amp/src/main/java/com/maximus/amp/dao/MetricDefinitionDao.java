package com.maximus.amp.dao;

import java.util.List;

import com.maximus.amp.model.MetricDefinition;


public interface MetricDefinitionDao extends GenericDao<MetricDefinition, Long> {
	
	List<MetricDefinition> search(String searchTerm, boolean applyFilters) throws SearchException;

}
