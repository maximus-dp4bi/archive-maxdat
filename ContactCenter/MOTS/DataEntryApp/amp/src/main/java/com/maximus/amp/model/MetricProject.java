package com.maximus.amp.model;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
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
import org.hibernate.envers.RelationTargetAuditMode;


@Entity
@Audited(targetAuditMode=RelationTargetAuditMode.NOT_AUDITED)
@Table(name = "D_METRIC_PROJECT")
@NamedQueries({
    @NamedQuery(
            name = "getMetricsForActualsReport",
            query = "select mp from MetricProject mp "
            		+ "where mp.project.id = :projectId "
            		+ "and mp.program.id = :programId "
            		+ "and mp.geographyMaster.id = :geographyMasterId "
            		+ "and mp.metricDefinition.functionalArea = :functionalArea "
            		+ "and (mp.actualValueProvidedBy = 'Web') "
            		+ "and (mp.metricDefinition.isWeekly = :isWeekly or :isWeekly is null) "
            		+ "and (mp.metricDefinition.isMonthly = :isMonthly or :isMonthly is null) "
            		+ "and (mp.actualEffDate <= :reportingPeriodEndDate) "
            		+ "and (mp.recordEndDate >= :reportingPeriodEndDate or mp.recordEndDate is null) "
    ), @NamedQuery(
    		name = "getMetricsForForecastReport",
            query = "select mp from MetricProject mp "
            		+ "where mp.project.id = :projectId "
            		+ "and mp.program.id = :programId "
            		+ "and mp.geographyMaster.id = :geographyMasterId "
            		+ "and mp.metricDefinition.functionalArea = :functionalArea "
            		+ "and (mp.forecastValueProvidedBy = 'Web') "
            		+ "and (mp.metricDefinition.isWeekly = :isWeekly or :isWeekly is null) "
            		+ "and (mp.metricDefinition.isMonthly = :isMonthly or :isMonthly is null) "
            		+ "and (mp.forecastEffDate <= :reportingPeriodEndDate) "
            		+ "and (mp.recordEndDate >= :reportingPeriodEndDate or mp.recordEndDate is null) "
    ), @NamedQuery(
    		name = "getAllMetricsForProject",
            query = "select mp from MetricProject mp "
            		+ "where mp.project = :project "

    )
})
public class MetricProject extends AuditedObject {

	private static final DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
	
	private static final long serialVersionUID = 6955874629479847611L;
	
	private long id;
	private Project project;
	private Program program;
	private GeographyMaster geographyMaster;
	private MetricDefinition metricDefinition;
	private String supplyForecast;
	private String supplyTarget;
	private String isSla;
	private String slaType;
	private String slaThreshold;
	private Float upperSpecificationLimit;
	private Float lowerSpecificationLimit;
	private String calculateControlChartInd;
	private String trendIndicatorCalculation;
	private String actualValueProvidedBy;
	private String forecastValueProvidedBy;
	private Date actualEffDate;
	private Date forecastEffDate;
	private Date targetEffDate;
	private Date recordEffDate;
	private Date recordEndDate;
	private String isAutoLoad;

	public MetricProject() {}
	
	public MetricProject(Project project) {
		this.project = project;
	}

	@Override
	public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof MetricProject)) {
            return false;
        }

        final MetricProject other = (MetricProject) o;
		
		return new EqualsBuilder()
			.append(project, other.getProject())
			.append(program, other.getProgram())
			.append(geographyMaster, other.getGeographyMaster())
			.append(metricDefinition, other.getMetricDefinition())
			.append(recordEffDate, other.getRecordEffDate())
			.isEquals();
	}

	@Column(name="actual_eff_dt")
	public Date getActualEffDate() {
		return actualEffDate;
	}

	@Column(name="actual_value_provided_by")
	public String getActualValueProvidedBy() {
		return actualValueProvidedBy;
	}

	@Column(name="calculate_control_chart_ind")
	public String getCalculateControlChartInd() {
		return calculateControlChartInd;
	}

	@Column(name="forecast_eff_dt")
	public Date getForecastEffDate() {
		return forecastEffDate;
	}

	@Column(name="forecast_value_provided_by")
	public String getForecastValueProvidedBy() {
		return forecastValueProvidedBy;
	}

	@ManyToOne
	@JoinColumn(name="d_geography_master_id")
	public GeographyMaster getGeographyMaster() {
		return geographyMaster;
	}

	@Id
	@Column(name="d_metric_project_id")
	@SequenceGenerator(name = "SEQ_D_METRIC_PROJECT", sequenceName="SEQ_D_METRIC_PROJECT", initialValue=1, allocationSize=20) // CODEREVIEW:  technically, this is unused
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_METRIC_PROJECT")
	public Long getId() {
		return id;
	}

	@Column(name="is_auto_load")
	public String getIsAutoLoad() {
		return isAutoLoad;
	}

	@Column(name="is_sla")
	public String getIsSla() {
		return isSla;
	}

	@Column(name="lower_specification_limit")
	public Float getLowerSpecificationLimit() {
		return lowerSpecificationLimit;
	}

	@ManyToOne
	@JoinColumn(name="d_metric_definition_id")
	public MetricDefinition getMetricDefinition() {
		return metricDefinition;
	}

	@ManyToOne
	@JoinColumn(name="d_program_id")
	public Program getProgram() {
		return program;
	}
	@ManyToOne
	@JoinColumn(name="d_project_id")
	public Project getProject() {
		return project;
	}
	@Column(name="record_eff_dt")
	public Date getRecordEffDate() {
		return recordEffDate;
	}
	
	@Column(name="record_end_dt")
	public Date getRecordEndDate() {
		return recordEndDate;
	}

	@Column(name="sla_threshold")
	public String getSlaThreshold() {
		return slaThreshold;
	}
	@Column(name="sla_type")
	public String getSlaType() {
		return slaType;
	}
	@Column(name="supply_forecast")
	public String getSupplyForecast() {
		return supplyForecast;
	}
	@Column(name="supply_target")
	public String getSupplyTarget() {
		return supplyTarget;
	}
	
	
	@Column(name="target_eff_dt")
	public Date getTargetEffDate() {
		return targetEffDate;
	}

	@Column(name="trend_indicator_calculation")
	public String getTrendIndicatorCalculation() {
		return trendIndicatorCalculation;
	}

	@Column(name="upper_specification_limit")
	public Float getUpperSpecificationLimit() {
		return upperSpecificationLimit;
	}
	
//	@OneToMany(fetch=FetchType.LAZY, mappedBy="metricProject")
//	public Set<ControlChartParameters> getControlChartParametersSet() {
//		return controlChartParametersSet;
//	}
	
	@Override
	public int hashCode() {
		return new HashCodeBuilder()
		.append(project)
		.append(program)
		.append(geographyMaster)
		.append(metricDefinition)
		.append(recordEffDate)
		.toHashCode();
	}

	public void setActualEffDate(Date actualEffDate) {
		this.actualEffDate = actualEffDate;
	}

	public void setActualValueProvidedBy(String actualValueProvidedBy) {
		this.actualValueProvidedBy = actualValueProvidedBy;
	}

	public void setCalculateControlChartInd(String calculateControlChartInd) {
		this.calculateControlChartInd = calculateControlChartInd;
	}

	public void setForecastEffDate(Date forecastEffDate) {
		this.forecastEffDate = forecastEffDate;
	}

	public void setForecastValueProvidedBy(String forecastValueProvidedBy) {
		this.forecastValueProvidedBy = forecastValueProvidedBy;
	}

	public void setGeographyMaster(GeographyMaster geographyMaster) {
		this.geographyMaster = geographyMaster;
	}

	public void setId(long id) {
		this.id = id;
	}

	public void setIsAutoLoad(String isAutoLoad) {
		this.isAutoLoad = isAutoLoad;
	}

	public void setIsSla(String isSla) {
		this.isSla = isSla;
	}

	public void setLowerSpecificationLimit(Float lowerSpecificationLimit) {
		this.lowerSpecificationLimit = lowerSpecificationLimit;
	}

	public void setMetricDefinition(MetricDefinition metricDefinition) {
		this.metricDefinition = metricDefinition;
	}

	public void setProgram(Program program) {
		this.program = program;
	}

//	public void setControlChartParametersSet(
//			Set<ControlChartParameters> controlChartParametersSet) {
//		this.controlChartParametersSet = controlChartParametersSet;
//	}

	public void setProject(Project project) {
		this.project = project;
	}

	public void setRecordEffDate(Date recordEffDate) {
		this.recordEffDate = recordEffDate;
	}

	public void setRecordEndDate(Date recordEndDate) {
		this.recordEndDate = recordEndDate;
	}

	public void setSlaThreshold(String slaThreshold) {
		this.slaThreshold = slaThreshold;
	}

	public void setSlaType(String slaType) {
		this.slaType = slaType;
	}

	public void setSupplyForecast(String supplyForecast) {
		this.supplyForecast = supplyForecast;
	}

	public void setSupplyTarget(String supplyTarget) {
		this.supplyTarget = supplyTarget;
	}

	public void setTargetEffDate(Date targetEffDate) {
		this.targetEffDate = targetEffDate;
	}

	public void setTrendIndicatorCalculation(String trendIndicatorCalculation) {
		this.trendIndicatorCalculation = trendIndicatorCalculation;
	}

	public void setUpperSpecificationLimit(Float upperSpecificationLimit) {
		this.upperSpecificationLimit = upperSpecificationLimit;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE)
		 .append(getMetricDefinition())
		 .append(getProject())
		 .append(getProgram())
		 .append(getGeographyMaster())
		 .toString();
	}

}
