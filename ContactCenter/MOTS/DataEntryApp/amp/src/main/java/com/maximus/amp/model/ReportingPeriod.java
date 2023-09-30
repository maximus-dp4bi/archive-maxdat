package com.maximus.amp.model;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Indexed;

import com.fasterxml.jackson.annotation.JsonFormat;

@Entity
@Table(name = "D_REPORTING_PERIOD")
@NamedQueries({
	@NamedQuery(
		name="getAvailableActualsReportingPeriods",
		query="select rp from ReportingPeriod rp "
				+ "where type = :reportingPeriodType "
				+ "and endDate <= current_date() "
				+ "and year(endDate) = :reportingPeriodYear "
				+ "and rp.id not in ( "
					+ "select pr.reportingPeriod.id "
					+ "from ProjectReport pr "
					+ "where project.id = :projectId "
					+ "and program.id = :programId "
					+ "and geographyMaster.id = :geographyMasterId "
					+ "and type = :reportType "
					+ "and functionalArea = :functionalArea "
				+ ") "
				+ "order by endDate desc"
	), 	@NamedQuery(
			name="getAvailableForecastsReportingPeriods",
			query="select rp from ReportingPeriod rp "
					+ "where type = :reportingPeriodType "
					+ "and year(endDate) = :reportingPeriodYear "
					+ "and rp.id not in ( "
						+ "select pr.reportingPeriod.id "
						+ "from ProjectReport pr "
						+ "where project.id = :projectId "
						+ "and program.id = :programId "
						+ "and geographyMaster.id = :geographyMasterId "
						+ "and type = :reportType "
						+ "and functionalArea = :functionalArea "
					+ ") "
					+ "order by endDate"
		)		
})
public class ReportingPeriod extends AuditedObject implements Serializable, Comparable<ReportingPeriod> {

	private static final long serialVersionUID = -8795370908206631587L;
	private Long id;
    private String type; // required
    @JsonFormat(pattern = "MM/dd/yyyy")
    private Date startDate;
    @JsonFormat(pattern = "MM/dd/yyyy")
    private Date endDate;
	
    public ReportingPeriod() {  }
    
    public ReportingPeriod(String type, Date startDate, Date endDate) {
    	this.type = type;
    	this.startDate = startDate;
    	this.endDate = endDate;
    }

	/**
     * {@inheritDoc}
     */
    public boolean equals(Object o) {
    	
        if (this == o) {
            return true;
        }
        if (!(o instanceof ReportingPeriod)) {
            return false;
        }

        final ReportingPeriod other = (ReportingPeriod) o;

        return new EqualsBuilder()
	        .append(type, other.getType())
	        .append(startDate, other.getStartDate())
	        .append(endDate, other.getEndDate())
	        .isEquals();

    }

    @Column(name="end_date", nullable = false)
    @Field
    public Date getEndDate() {
		return endDate;
	}
	
    @Transient
    public String getFormattedEndDate() {
    	if(type != "Hourly") {
			SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy"); // Set your date format
			return sdf.format(endDate);
    	} else {
    		return endDate.toString();
    	}
	}
	
       
    // TODO:  GenerationType will need to be refactored to be SEQUENCE
	@Id
	@SequenceGenerator(name = "SEQ_D_REPORTING_PERIOD", sequenceName="SEQ_D_REPORTING_PERIOD", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_REPORTING_PERIOD")
	@Column(name="d_reporting_period_id")
    public Long getId() {
        return id;
    }

	@Column(name="start_date", nullable = false)
	@Field
	public Date getStartDate() {
		return startDate;
	}

	@Column(name="type", nullable = false, length = 50)
    public String getType() {
        return type;
    }

	/**
     * {@inheritDoc}
     */
    public int hashCode() {
    	
    	return new HashCodeBuilder()
	        .append(type)
	        .append(startDate)
	        .append(endDate)
	        .toHashCode();
    	
    }

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	
    public void setType(String type) {
		this.type = type;
	}

	@Override
	public String toString() {
		SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yyyy"); // Set your date format
		if(endDate != null) {
			return sdf.format(endDate);
		}
		return null;
	}
	
    public enum ReportingPeriodType {
    	WEEKLY("WEEKLY", "Weekly"), MONTHLY("MONTHLY", "Monthly");
    	private String value;
    	private String label;
    	
    	private ReportingPeriodType(String value, String label) {
    		this.value = value;
    		this.label = label;
    	}

    	public String getValue(){
    		return value;
    	}
    	
    	public String getLabel(){
    		return label;
    	}
    }

	@Override
	public int compareTo(ReportingPeriod other) {
		return endDate.compareTo(other.getEndDate());

	}
    
}
