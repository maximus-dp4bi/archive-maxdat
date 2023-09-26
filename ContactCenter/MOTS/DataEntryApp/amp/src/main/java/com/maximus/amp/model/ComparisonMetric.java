package com.maximus.amp.model;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import com.maximus.amp.model.MetricValidationRule.MetricValueLocation;

@Entity
@Table(name="D_COMPARISON_METRIC")
public class ComparisonMetric extends BaseObject {

	private static final long serialVersionUID = -125072602668934950L;
	
	private Long id;
	private MetricValidationRule metricValidationRule;
	private MetricDefinition compMetricDef;
	private MetricValueLocation compMetricValueLoc;
	private String alias;
	
	public ComparisonMetric() { }

	public ComparisonMetric(MetricValidationRule validationRule) {
		this.metricValidationRule = validationRule;
	}

	@Override
	public boolean equals(Object o) {

		if (this == o) return true;
		if ( !(o instanceof ComparisonMetric) ) return false;
		
		final ComparisonMetric other = (ComparisonMetric) o;
		
		
		return new EqualsBuilder()
			.append(this.getMetricValidationRule(), other.getMetricValidationRule())
			.append(this.getAlias(), other.getAlias())
			.isEquals();
		
	}

	@Column(name="alias")
	public String getAlias() {
		return alias;
	}
	
	@ManyToOne
	@JoinColumn(name="D_COMPARISON_METRIC_DEF_ID")
	public MetricDefinition getCompMetricDefinition() {
		return compMetricDef;
	}

	@Enumerated(EnumType.STRING)
	@Column(name="COMPARISON_METRIC_LOC")
	public MetricValueLocation getCompMetricValueLocation() {
		return compMetricValueLoc;
	}

	@Id
	@Column(name="D_COMPARISON_METRIC_ID")
	@SequenceGenerator(name = "SEQ_D_COMPARISON_METRIC", sequenceName="SEQ_D_COMPARISON_METRIC", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_COMPARISON_METRIC")
	public Long getId(){
		return id;
	}

	@ManyToOne
	@JoinColumn(name="D_METRIC_VALIDATION_RULE_ID")
	public MetricValidationRule getMetricValidationRule() {
		return metricValidationRule;
	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder()
		.append(this.getMetricValidationRule())
		.append(this.getAlias())
		.toHashCode();
	}
	
	public void setAlias(String alias) {
		this.alias = alias;
	}
	
	public void setCompMetricDefinition(MetricDefinition compMetricDef) {
		this.compMetricDef = compMetricDef;
	}
	
	public void setCompMetricValueLocation(MetricValueLocation compMetricValueLoc) {
		this.compMetricValueLoc = compMetricValueLoc;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setMetricValidationRule(MetricValidationRule metricValidationRule) {
		this.metricValidationRule = metricValidationRule;
	}

	@Override
	public String toString() {
		return alias;
	}
	

}
