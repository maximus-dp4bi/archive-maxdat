package com.maximus.amp.model;

import java.util.HashMap;
import java.util.Map;

import javax.persistence.CascadeType;
import javax.persistence.DiscriminatorValue;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.MapKeyColumn;
import javax.persistence.OneToMany;

import org.hibernate.envers.Audited;

@Entity
@Audited
@DiscriminatorValue("actuals")
public class ActualsReport extends ProjectReport {
	

	private static final long serialVersionUID = -7723970175743914106L;

	public ActualsReport() { 
		this(null, null, null, null);
	}

	public ActualsReport(Project project, Program program, GeographyMaster geographyMaster, ReportingPeriod reportingPeriod) {
		super(project, program, geographyMaster, reportingPeriod);
		 this.setType(ReportType.ACTUALS.toString());
	}
	
	// Changed fetch to EAGER due to exception loading projectReportList displaytable
	@OneToMany(cascade={CascadeType.PERSIST,CascadeType.MERGE}, mappedBy="actualsReport")
	@MapKeyColumn(name="d_metric_definition_id")
	public Map<Long, Metric> getMetrics() {
		if(metrics == null) {
			//  TODO:  is it necessary to implement metrics as a SortedSet
			// metrics = new TreeSet<Metric>(new MetricComparator());
			metrics = new HashMap<Long, Metric>();
		}
		
		return metrics;
	}

}
