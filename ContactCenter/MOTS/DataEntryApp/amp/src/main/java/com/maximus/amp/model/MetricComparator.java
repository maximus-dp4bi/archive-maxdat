package com.maximus.amp.model;

import java.util.Comparator;

import org.apache.commons.lang3.builder.CompareToBuilder;

public class MetricComparator implements Comparator<Metric> {

	public int compare(Metric metric1, Metric metric2) {
		
		if(metric1.getMetricDefinition() == null && metric2.getMetricDefinition() == null) return 0;
		if(metric1.getMetricDefinition() == null && metric2.getMetricDefinition() != null) return -1;
		if(metric1.getMetricDefinition() != null && metric2.getMetricDefinition() == null) return 1;
		
		MetricDefinition def1 = metric1.getMetricDefinition();
		MetricDefinition def2 = metric2.getMetricDefinition();
		
//		int typeComparison = def1.getMetricType().getSortOrder().compareTo(def2.getMetricType().getSortOrder());
//		if(typeComparison == 0) {
//			return def1.getSortOrder().compareTo(def2.getSortOrder());
//		} else {
//			return typeComparison;
//		}
		
		CompareToBuilder comparator = new CompareToBuilder();
		
		comparator.append(def1.getFunctionalArea(), def2.getFunctionalArea())
			.append(def1.getType(), def2.getType())
			.append(def1.getCategory(), def2.getCategory())
			.append(def1.getSubCategory(), def2.getSubCategory())
			.append(def1.getSortOrder(), def2.getSortOrder());
		
		return comparator.toComparison();
		
		
		
	}

	

}

