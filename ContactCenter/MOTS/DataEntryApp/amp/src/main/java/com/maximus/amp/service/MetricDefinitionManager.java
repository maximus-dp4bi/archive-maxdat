package com.maximus.amp.service;

import java.util.List;

import com.maximus.amp.model.MetricDefinition;


public interface MetricDefinitionManager extends GenericManager<MetricDefinition, Long> {
	
	List<MetricDefinition> search(String searchTerm, boolean applyFilters);
	List<MetricDefinition> search(String searchTerm);

}
