package com.maximus.amp.model;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.envers.Audited;

import com.maximus.amp.Constants;

@Entity
@Audited
@Table(name = "S_METRIC")
@NamedQueries({
	@NamedQuery(
		name="getMetricByForecastsReport"
		, query = "select m from Metric m "
			+ "where m.forecastsReport.project.id = :projectId "
			+ "and m.forecastsReport.program.id = :programId "
			+ "and m.forecastsReport.geographyMaster.id = :geographyMasterId "
			+ "and m.metricDefinition.id = :metricDefinitionId "
			+ "and m.forecastsReport.reportingPeriod.endDate = :reportingPeriodEndDate "
			+ "and m.forecastsReport.reportingPeriod.type = :reportingPeriodType "
	),
	@NamedQuery(
			name="getMetricByActualsReport"
			, query = "select m from Metric m "
				+ "where m.actualsReport.project.id = :projectId "
				+ "and m.actualsReport.program.id = :programId "
				+ "and m.actualsReport.geographyMaster.id = :geographyMasterId "
				+ "and m.metricDefinition.id = :metricDefinitionId "
				+ "and m.actualsReport.reportingPeriod.endDate = :reportingPeriodEndDate "
				+ "and m.actualsReport.reportingPeriod.type = :reportingPeriodType "
		)
})
public class Metric extends AuditedObject {

	private static final long serialVersionUID = -6004091799840501913L;
	
	private Long id;
	private ActualsReport actualsReport;
	private ForecastsReport forecastsReport;
	private MetricDefinition metricDefinition;
	private BigDecimal actualValue;
	private Date actualReceivedDate;
	private Long actualTrendIndicator;
	private Long actualForecastVarianceFormat;
	private BigDecimal forecastValue;
	private Date forecastReceivedDate;
	private String actualValueNotSupplied;
	private String forecastValueNotSupplied;
	private String actualComments;
	private String forecastComments;

	
	public Metric() {}
	
	public Metric(ProjectReport projectReport, MetricDefinition metricDefinition) {
		
		if(projectReport instanceof ActualsReport) {
			this.actualsReport = (ActualsReport) projectReport;	
		} else if (projectReport instanceof ForecastsReport) {
			this.forecastsReport = (ForecastsReport) projectReport;
		}
		
		this.metricDefinition = metricDefinition;
		
		this.setCreatedBy(projectReport.getCreatedBy());
		this.setCreatedDate(projectReport.getCreatedDate());
		this.setModifiedBy(projectReport.getCreatedBy());
		this.setModifiedDate(projectReport.getCreatedDate());
	}
	@Override
	public boolean equals(Object o) {
		
        if (this == o) {
            return true;
        }
        if (!(o instanceof Metric)) {
            return false;
        }

        final Metric other = (Metric) o;

        
		return new EqualsBuilder()
			.append(actualsReport, other.getActualsReport())
			.append(forecastsReport, other.getForecastsReport())
			.append(metricDefinition,  other.getMetricDefinition())
			.append(actualValue, other.getActualValue())
			.append(forecastValue, other.getForecastValue())
			.isEquals();

	}
	@Column(name="comments")
	public String getActualComments() {
		return actualComments;
	}
	
	

	@Column(name="actual_forecast_variance_frmt")
	public Long getActualForecastVarianceFormat() {
		return actualForecastVarianceFormat;
	}
	
//	@JsonCreator
//	public Metric(Map<String,Object> props) {
//		id = (Long) props.get("id");
//		// type = (String) props.get("type");
//	}

	@Column(name="actual_received_date")
	public Date getActualReceivedDate() {
		return actualReceivedDate;
	}

	@ManyToOne
	@JoinColumn(name="s_actuals_project_report_id")
	public ActualsReport getActualsReport() {
		return actualsReport;
	}

	@Column(name="actual_trend_indicator")
	public Long getActualTrendIndicator() {
		return actualTrendIndicator;
	}

	@Column(name="actual_value")
	public BigDecimal getActualValue() {
		return actualValue;
	}

	@Column(name="actual_value_not_supplied")
	public String getActualValueNotSupplied() {
		return (actualValueNotSupplied != null) ? actualValueNotSupplied : Constants.N;
	}

	@Column(name="forecast_comments")
	public String getForecastComments() {
		return forecastComments;
	}
	@Column(name="forecast_received_date")
	public Date getForecastReceivedDate() {
		return forecastReceivedDate;
	}
	
	@ManyToOne
	@JoinColumn(name="s_forecasts_project_report_id")	
	public ForecastsReport getForecastsReport() {
		return forecastsReport;
	}
	
	@Column(name="forecast_value")
	public BigDecimal getForecastValue() {
		return forecastValue;
	}
	

	@Column(name="forecast_value_not_supplied")
	public String getForecastValueNotSupplied() {
		return (forecastValueNotSupplied != null) ? forecastValueNotSupplied : Constants.N;
	}

	@Id
	@SequenceGenerator(name = "SEQ_S_METRIC", sequenceName="SEQ_S_METRIC", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_S_METRIC")
	@Column(name="s_metric_id")
	public Long getId() {
		return id;
	}

	@ManyToOne
	@JoinColumn(name="d_metric_definition_id")
	public MetricDefinition getMetricDefinition() {
		return metricDefinition;
	}

	@Override
	public int hashCode() {

		return new HashCodeBuilder()
			.append(actualsReport)
			.append(metricDefinition)
			.toHashCode();
	}
	
	public void setActualComments(String actualComments) {
		this.actualComments = actualComments;
	}

	public void setActualForecastVarianceFormat(Long actualForecastVarianceFormat) {
		this.actualForecastVarianceFormat = actualForecastVarianceFormat;
	}


	public void setActualReceivedDate(Date actualReceivedDate) {
		this.actualReceivedDate = actualReceivedDate;
	}
	
	public void setActualsReport(ActualsReport actualsReport) {
		this.actualsReport = actualsReport;
	}

	public void setActualTrendIndicator(Long actualTrendIndicator) {
		this.actualTrendIndicator = actualTrendIndicator;
	}

	public void setActualValue(BigDecimal actualValue) {
		this.actualValue = actualValue;
	}

	public void setActualValueNotSupplied(String actualValueNotSupplied) {
		this.actualValueNotSupplied = actualValueNotSupplied;
	}

	public void setForecastComments(String forecastComments) {
		this.forecastComments = forecastComments;
	}

	public void setForecastReceivedDate(Date forecastReceivedDate) {
		this.forecastReceivedDate = forecastReceivedDate;
	}

	public void setForecastsReport(ForecastsReport forecastsReport) {
		this.forecastsReport = forecastsReport;
	}

	public void setForecastValue(BigDecimal forecastValue) {
		this.forecastValue = forecastValue;
	}

	public void setForecastValueNotSupplied(String forecastValueNotSupplied) {
		this.forecastValueNotSupplied = forecastValueNotSupplied;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setMetricDefinition(MetricDefinition metricDefinition) {
		this.metricDefinition = metricDefinition;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE)
		 .append(getMetricDefinition())
		 .append(getActualsReport())
		 .append(getForecastsReport())
		 .toString();
	}

}
