package com.maximus.amp.model;

import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.Column;
import javax.persistence.DiscriminatorColumn;
import javax.persistence.DiscriminatorType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Inheritance;
import javax.persistence.InheritanceType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedNativeQueries;
import javax.persistence.NamedNativeQuery;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.CompareToBuilder;
import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.envers.Audited;
import org.hibernate.envers.RelationTargetAuditMode;

import com.maximus.amp.Constants;


@Entity
@Audited(targetAuditMode=RelationTargetAuditMode.NOT_AUDITED)
@Inheritance(strategy=InheritanceType.SINGLE_TABLE)
@DiscriminatorColumn(
	name="report_type",
	discriminatorType=DiscriminatorType.STRING
)
@Table(name = "S_PROJECT_REPORT")
@NamedQueries({
    @NamedQuery(
            name = "getProjectReportsByUser",
            query ="SELECT DISTINCT pr FROM ProjectReport pr "
            		+ "inner join pr.project as project "
            		+ "inner join project.projectUsers as projectUser "
            		+ "inner join pr.reportingPeriod as reportingPeriod "
            		+ "WHERE projectUser.user = :user "
            		+ "AND  pr.type = :type "
            		+ "AND projectUser.functionalArea = pr.functionalArea "
            		+ "ORDER BY reportingPeriod.endDate DESC, reportingPeriod.type, pr.project.projectName, pr.program.programName"
    ), 
    @NamedQuery(
            name = "getProjectReportByCriteria",
            query ="SELECT pr FROM ProjectReport pr "
            		+ "WHERE pr.project.id = :projectId "
            		+ "AND pr.program.id = :programId "
            		+ "AND pr.geographyMaster.id = :geographyMasterId "
            		+ "AND pr.type = :type "
            		+ "AND pr.functionalArea = :functionalArea "
            		+ "AND pr.reportingPeriod.endDate = :endDate"
    ),
    
})
@NamedNativeQueries({
	@NamedNativeQuery(
		name="SP_MERGE_F_METRIC"
		, query="CALL AMP_PROCS.SP_MERGE_F_METRIC(:projectReportId)"
	), 
	@NamedNativeQuery(
			name="nativeGetProjectReportsByUser"
			, query="SELECT DISTINCT PR.*, RP.END_DATE, RP.TYPE, PRJ.PROJECT_NAME, PRG.PROGRAM_NAME "
					+ "FROM S_PROJECT_REPORT PR  "
					+ "INNER JOIN D_PROJECT PRJ ON PR.D_PROJECT_ID = PRJ.D_PROJECT_ID "
					+ "INNER JOIN D_PROGRAM PRG ON PR.D_PROGRAM_ID = PRG.D_PROGRAM_ID "
					+ "INNER JOIN D_PROJECT_USER PU ON PRJ.D_PROJECT_ID = PU.D_PROJECT_ID AND PR.FUNCTIONAL_AREA = PU.FUNCTIONAL_AREA "
					+ "INNER JOIN D_REPORTING_PERIOD RP ON PR.D_REPORTING_PERIOD_ID = RP.D_REPORTING_PERIOD_ID "
					+ "WHERE PU.APP_USER_ID = :userId "
					+ "AND PR.REPORT_TYPE = :reportType "
					+ "ORDER BY RP.END_DATE DESC, RP.TYPE, PRJ.PROJECT_NAME, PRG.PROGRAM_NAME"
			, resultClass=ProjectReport.class
			)
})
public class ProjectReport extends AuditedObject {
	
	private static final long serialVersionUID = 3674841901103647488L;
		
	public static ProjectReport newProjectReport(String type) {
		if(type.equals(ReportType.ACTUALS.toString())) {
			return new ActualsReport();
		} if(type.equals(ReportType.FORECASTS.toString())) {
			return new ForecastsReport();
		}
		
		return null;
	}
	
	private Long id;
	private Project project;
	private Program program;
	private GeographyMaster geographyMaster;
	private ReportingPeriod reportingPeriod;
	private Boolean approved;
	private Date approvedDate;
	private String type;
	private String status;
	private String isActualsTrendProcessed;
	private String isFutureTrendsProcessed;
	private String functionalArea;
	
	//  metrics are stored in a Map using the MetricDefinition ID as 
	//  the key to allow for fast retrieval of metrics during validation
	protected Map<Long, Metric> metrics;
	
	public ProjectReport() {  }

	public ProjectReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		this.project = project;
		this.program = program;
		this.geographyMaster = geographyMaster;
		this.reportingPeriod = reportingPeriod;
		this.status = Status.PENDING.toString();
		this.approved = false;
		this.isActualsTrendProcessed = Constants.N;
		this.isFutureTrendsProcessed = Constants.N;
	}

	@Override
	public boolean equals(Object o) {
		
        if (this == o) {
            return true;
        }
        if (!(o instanceof ProjectReport)) {
            return false;
        }

        final ProjectReport other = (ProjectReport) o;

        
		return new EqualsBuilder()
			.append(project, other.getProject())
			.append(program,  other.getProgram())
			.append(geographyMaster, other.getGeographyMaster())
			.append(reportingPeriod, other.getReportingPeriod())
			.isEquals();
		
	}

	@Column(name="approved")
	public Boolean getApproved() {
		return approved;
	}

	@Column(name="approved_date")
	public Date getApprovedDate() {
		return approvedDate;
	}

	@Column(name="functional_area")
	public String getFunctionalArea() {
		return functionalArea;
	}
	
	@ManyToOne
	@JoinColumn(name="d_geography_master_id")
	public GeographyMaster getGeographyMaster() {
		return geographyMaster;
	}
	
	@Id
	@SequenceGenerator(name = "SEQ_S_PROJECT_REPORT", sequenceName="SEQ_S_PROJECT_REPORT", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_S_PROJECT_REPORT")
	@Column(name="s_project_report_id")
	public Long getId() {
		return id;
	}

	@Column(name="IS_ACTUALS_TREND_PROCESSED")
	public String getIsActualsTrendProcessed() {
		return isActualsTrendProcessed;
	}
	
	@Column(name="IS_FUTURE_TRENDS_PROCESSED")
	public String getIsFutureTrendsProcessed() {
		return isFutureTrendsProcessed;
	}

	@Transient
	public Metric getMetricByDef(MetricDefinition metricDefinition) {
		return metrics.get(metricDefinition.getId());
	}
	
	@Transient
	public Map<Long, Metric> getMetrics() {
		return metrics;
	}
	
	@Transient
	public Map<Long, Metric> getSortedMetrics() {
		
		List<Entry<Long, Metric>> list = new LinkedList<Entry<Long, Metric>>(metrics.entrySet());
		
		Collections.sort(list, new Comparator<Entry<Long, Metric>>() {
	            public int compare(Entry<Long, Metric> o1, Entry<Long, Metric> o2) {
	            	
	            	MetricDefinition def1 = o1.getValue().getMetricDefinition();
	        		MetricDefinition def2 = o2.getValue().getMetricDefinition();
	        			            	
	        		if(def1 == null && def2 == null) return 0;
	        		if(def1 == null && def2 != null) return -1;
	        		if(def1 != null && def2 == null) return 1;
	        		
	        		CompareToBuilder comparator = new CompareToBuilder();
	        		
	        		comparator.append(def1.getSortOrder(), def2.getSortOrder());
	        		
	        		return comparator.toComparison();

	            }
	        });
		
		Map<Long, Metric> sortedMetrics = new LinkedHashMap<Long, Metric>();
        for (Entry<Long, Metric> entry : list)
        {
            sortedMetrics.put(entry.getKey(), entry.getValue());
        }
		
		return sortedMetrics;
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

	@ManyToOne
	@JoinColumn(name="d_reporting_period_id")
	public ReportingPeriod getReportingPeriod() {
		return reportingPeriod;
	}

	/*
	 * TODO:  refactor status as a separate class/table with a display label
	 * 
	 * The display value of statuses is controlled in the ApplicationResources.properties file
	 * with the projectReport.status.X properties.  The jsp pages use the message tag in the 
	 * following manner:
	 * 
	 * 		<fmt:message key="projectReport.status.${projectReport.status}" />
	 * 
	 */
	@Column(name="status")
	public String getStatus() {
		return status;
	}
	
	@Column(name="report_type", insertable=false, updatable=false)
	public String getType() {
		 return type;
	}

	@Override
	public int hashCode() {
    	return new HashCodeBuilder()
        .append(project)
        .append(program)
        .append(geographyMaster)
        .append(reportingPeriod)
        .toHashCode();
	}

	public void setApproved(Boolean approved) {
		this.approved = approved;
	}
	
	public void setApprovedDate(Date approvedDate) {
		this.approvedDate = approvedDate;
	}

	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}

	public void setGeographyMaster(GeographyMaster geographyMaster) {
		this.geographyMaster = geographyMaster;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setIsActualsTrendProcessed(String isActualsTrendProcessed) {
		this.isActualsTrendProcessed = isActualsTrendProcessed;
	}

	public void setIsFutureTrendsProcessed(String isFutureTrendsProcessed) {
		this.isFutureTrendsProcessed = isFutureTrendsProcessed;
	}

	public void setMetrics(Map<Long, Metric> metrics) {
		this.metrics = metrics;
	}
	
	public void setProgram(Program program) {
		this.program = program;
	}

	public void setProject(Project project) {
		this.project = project;
	}

	public void setReportingPeriod(ReportingPeriod reportingPeriod) {
		this.reportingPeriod = reportingPeriod;
	}
	
	public void setStatus(String status) {
		this.status = status;
	}

	
    public void setType(String type) {
		this.type = type;
	}

    @Override
	public String toString() {
		return new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE)
		 .append(getProject())
		 .append(getProgram())
		 .append(getGeographyMaster())
		 .append(getReportingPeriod())
		 .append(getType())
		 .toString();

	}


	public static enum ReportType {
    	ACTUALS("actuals"), 
    	FORECASTS("forecasts"), 
    	TARGETS("targets");
    	
    	public static boolean contains(String test) {
    		for (ReportType rt : ReportType.values()) {
    	        if (rt.toString().equals(test)) {
    	            return true;
    	        }
    	    }

    	    return false;
    	}
    	
    	private String type;
    	
    	private ReportType(String type) {
    		this.type = type;
    	}
    	
    	public String toString() {
    		return type;
    	}
    }

	public static enum Status {
    	PENDING("Pending"), 
    	CONFIRMED("Confirmed"), 
    	APPROVED("Approved");
    	
    	public static boolean contains(String test) {
    		for (Status s : Status.values()) {
    	        if (s.toString().equals(test)) {
    	            return true;
    	        }
    	    }

    	    return false;
    	}
    	
    	private String status;
    	
    	private Status(String status) {
    		this.status = status;
    	}
    	
    	public String toString() {
    		return status;
    	}
    }

}

