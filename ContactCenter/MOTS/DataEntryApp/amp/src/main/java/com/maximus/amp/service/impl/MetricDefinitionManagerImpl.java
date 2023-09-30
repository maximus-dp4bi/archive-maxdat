package com.maximus.amp.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.maximus.amp.dao.MetricDefinitionDao;
import com.maximus.amp.model.MetricDefinition;
import com.maximus.amp.service.MetricDefinitionManager;


@Service("metricDefinitionManager")
public class MetricDefinitionManagerImpl extends GenericManagerImpl<MetricDefinition, Long> implements MetricDefinitionManager {

	
	private MetricDefinitionDao metricDefinitionDao;

	@Autowired
	public MetricDefinitionManagerImpl(MetricDefinitionDao metricDefinitionDao) {
		super(metricDefinitionDao);
		this.metricDefinitionDao = metricDefinitionDao;
	}
	
	@Override
	public List<MetricDefinition> search(String searchTerm, boolean applyFilters) {
		return metricDefinitionDao.search(searchTerm, applyFilters);
	}

	@Override
	public List<MetricDefinition> search(String searchTerm) {
		return metricDefinitionDao.search(searchTerm, false);
	}

}
