package com.maximus.amp.model;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import javax.persistence.CascadeType;
import org.hibernate.envers.Audited;
import org.hibernate.envers.NotAudited;
import org.hibernate.envers.RelationTargetAuditMode;


@Entity
@Table(
	name="D_METRIC_VALIDATION_RULE"
	, uniqueConstraints=@UniqueConstraint(columnNames = {"D_METRIC_DEFINITION_ID", "RULE_NAME"})
)
@Audited(targetAuditMode=RelationTargetAuditMode.NOT_AUDITED)
public class MetricValidationRule extends AuditedObject {
	
	public enum MetricValueLocation {
		CURRENT_ACTUAL,
		PRIOR_ACTUAL,
		CURRENT_FORECAST,
		PRIOR_FORECAST
	}
	
	private static final long serialVersionUID = 6535235795041556803L;
	private Long id;
	private MetricDefinition metricDefinition;
	private String ruleName;
	private String ruleDescription;
	private String ruleMessage;
	private String ruleValidationType; // exception, alert
	private String ruleSeverityIndicator; // red, yellow, green, blue
	private String metricValueType; // actual, forecast, target
	private String metricValueLocation; // current period, prior period, current period forecast
	private Boolean preventSubmit;
	private Boolean allowIgnoreWithComment;
	private Boolean isExpressionRule;
	private String ruleExpression;
	private Set<ComparisonMetric> comparisonMetricSet;
	

	public MetricValidationRule() { 
		// add temporary defaults
		ruleSeverityIndicator = "tbd";
		metricValueLocation = "tbd";
		isExpressionRule = true;
		
	}

	public MetricValidationRule(MetricDefinition metricDefinition) {
		this();
		setMetricDefinition(metricDefinition);
	}

	@OneToMany(mappedBy="metricValidationRule")
	@NotAudited
	public Set<ComparisonMetric> getComparisonMetricSet() {
		return comparisonMetricSet;
	}

	public void setComparisonMetricSet(Set<ComparisonMetric> comparisonMetricSet) {
		this.comparisonMetricSet = comparisonMetricSet;
	}

	@Override
	public boolean equals(Object o) {
		
		if (this == o) return true;
		if ( !(o instanceof MetricValidationRule) ) return false;
		
		final MetricValidationRule other = (MetricValidationRule) o;
		
		return new EqualsBuilder()
			.append(metricDefinition, other.getMetricDefinition())
			.append(ruleName, other.getRuleName())
			.append(ruleValidationType, other.getRuleValidationType())
			.isEquals();
		
	}

	@Column(name="ALLOW_IGNORE_WITH_COMMENT")
	public Boolean getAllowIgnoreWithComment() {
		return allowIgnoreWithComment;
	}
	
	@Id
	@Column(name="D_METRIC_VALIDATION_RULE_ID")
	@SequenceGenerator(name = "SEQ_D_METRIC_VALIDATION_RULE", sequenceName="SEQ_D_METRIC_VALIDATION_RULE", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_METRIC_VALIDATION_RULE")
	public Long getId() {
		return id;
	}

	@Column(name="IS_EXPRESSION_RULE")
	public Boolean getIsExpressionRule() {
		return isExpressionRule;
	}

	@ManyToOne(cascade=CascadeType.PERSIST)
	@JoinColumn(name="D_METRIC_DEFINITION_ID")
	public MetricDefinition getMetricDefinition() {
		return metricDefinition;
	}

	@Column(name="METRIC_VALUE_LOCATION")
	public String getMetricValueLocation() {
		return metricValueLocation;
	}

	@Column(name="METRIC_VALUE_TYPE")
	public String getMetricValueType() {
		return metricValueType;
	}

	@Column(name="PREVENT_SUBMIT")
	public Boolean getPreventSubmit() {
		return preventSubmit;
	}

	@Column(name="RULE_DESCRIPTION")
	public String getRuleDescription() {
		return ruleDescription;
	}

	@Column(name="RULE_MESSAGE")
	public String getRuleMessage() {
		return ruleMessage;
	}
	
	@Column(name="RULE_NAME")
	public String getRuleName() {
		return ruleName;
	}

	@Column(name="RULE_SEVERITY_INDICATOR")
	public String getRuleSeverityIndicator() {
		return ruleSeverityIndicator;
	}

	@Column(name="RULE_VALIDATION_TYPE")
	public String getRuleValidationType() {
		return ruleValidationType;
	}

	@Column(name="RULE_EXPRESSION")
	public String getRuleExpression() {
		return ruleExpression;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder()
			.append(metricDefinition)
			.append(ruleName)
			.toHashCode();
	}

	public void setAllowIgnoreWithComment(Boolean allowIgnoreWithComment) {
		this.allowIgnoreWithComment = allowIgnoreWithComment;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setIsExpressionRule(Boolean isExpressionRule) {
		this.isExpressionRule = isExpressionRule;
	}

	public void setMetricDefinition(MetricDefinition metricDefinition) {
		this.metricDefinition = metricDefinition;
	}

	public void setMetricValueLocation(String metricValueLocation) {
		this.metricValueLocation = metricValueLocation;
	}

	public void setMetricValueType(String metricValueType) {
		this.metricValueType = metricValueType;
	}

	public void setPreventSubmit(Boolean preventSubmit) {
		this.preventSubmit = preventSubmit;
	}

	public void setRuleDescription(String ruleDescription) {
		this.ruleDescription = ruleDescription;
	}

	public void setRuleMessage(String ruleMessage) {
		this.ruleMessage = ruleMessage;
	}

	public void setRuleName(String ruleName) {
		this.ruleName = ruleName;
	}

	public void setRuleSeverityIndicator(String ruleSeverityIndicator) {
		this.ruleSeverityIndicator = ruleSeverityIndicator;
	}

	public void setRuleValidationType(String ruleValidationType) {
		this.ruleValidationType = ruleValidationType;
	}

	public void setRuleExpression(String ruleExpression) {
		this.ruleExpression = ruleExpression;
	}

	
	@Override
	public String toString() {
		return ruleName;
	}
	
}
