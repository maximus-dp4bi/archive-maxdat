package com.maximus.amp.model;

import java.io.Serializable;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.StandardToStringStyle;
import org.apache.commons.lang3.builder.ToStringBuilder;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;
import org.hibernate.envers.Audited;
import org.hibernate.envers.RelationTargetAuditMode;
import org.hibernate.search.annotations.Analyze;
import org.hibernate.search.annotations.DocumentId;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.FullTextFilterDef;
import org.hibernate.search.annotations.FullTextFilterDefs;
import org.hibernate.search.annotations.Indexed;

import com.maximus.amp.Constants;
import com.maximus.amp.search.IsActiveFilterFactory;
import com.maximus.amp.search.IsWeeklyOrMonthlyFilterFactory;

@Entity
@Audited(targetAuditMode=RelationTargetAuditMode.NOT_AUDITED)
@Table(name = "D_METRIC_DEFINITION")
@Indexed
@FullTextFilterDefs( {
    @FullTextFilterDef(name = "isWeeklyOrMonthlyFilter", impl = IsWeeklyOrMonthlyFilterFactory.class)
    , @FullTextFilterDef(name = "isActiveFilter", impl = IsActiveFilterFactory.class)
})
@NamedQueries({
	@NamedQuery(
		name="getDistinctFunctionalAreas"
		, query="SELECT DISTINCT md.functionalArea FROM MetricDefinition md "
	), @NamedQuery(
			name="getDistinctFunctionalAreasByProject"
			, query= "select distinct md.functionalArea "
			 + "from MetricProject mp "
			+ "inner join mp.metricDefinition as md "
			+ "inner join mp.project as p "
			+ "inner join p.projectUsers as projectUser "
			+ "where mp.project.id = :projectId "
			+ "and projectUser.user = :user "
			+ "and projectUser.functionalArea = md.functionalArea"
	), @NamedQuery(
    		name = "getNewMetricDefinitions",
            query = "select md from MetricDefinition md "
            		+ "where not exists ( "
            		+	"from MetricProject mp "
            		+	"where mp.project.id = :projectId "
            		+	"and mp.program.id = :programId "
            		+	"and mp.geographyMaster.id = :geographyMasterId "
            		+	"and mp.metricDefinition = md "
            		+") "
            		+ "and status = 'Active' "
            		+ "order by functionalArea, label"
    ) ,@NamedQuery(
    		name = "getActiveMetricDefinitions",
            query = "select md from MetricDefinition md "
            		+ "where status = 'Active' "
            		+ "and (isWeekly = 'Y' or isMonthly = 'Y') "
            		+ "and (functionalArea = :functionalArea or :functionalArea = null) "
            		+ "order by functionalArea, category, subCategory, label"
    ) ,@NamedQuery(
    		name = "getMetricDefinitionsSortedByFuncAreaAndName",
            query = "select md from MetricDefinition md "
            		+ "order by functionalArea, label"
    )  
})
public class MetricDefinition extends AuditedObject implements Serializable {

    private static final long serialVersionUID = -1647705116686775079L;
	
	private Long id;
    private String metricName; 
    private String label;
    private Long sortOrder;
//    private MetricType metricType;
//    private DataType dataType;
    private String metricDescription;
    private String dataSource;
    private String helpfulInfo;
    private String example;
    private String formula;
    private String valueType;
    private String displayFormat;
    private String status;
	private String functionalArea;
	private String type;
	private String category;
	private String subCategory;
	private String hasActual;
	private String hasForecast;
    private String isCalculatd;
    private String isMonthly;
    private String isWeekly;
    private Long lowerBound;
    private Long upperBound;
    private Set<MetricValidationRule> validationRules = new HashSet<MetricValidationRule>();
    private Set<MetricValidationRule> actualsValidationRules = new HashSet<MetricValidationRule>();
    private Set<MetricValidationRule> forecastsValidationRules = new HashSet<MetricValidationRule>();
    private Set<MetricValidationRule> targetsValidationRules = new HashSet<MetricValidationRule>();

	private Date recordEffDate;

	private Date recordEndDate;    
    
    
    /**
     * {@inheritDoc}
     */
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof User)) {
            return false;
        }

        final MetricDefinition metricDefinition = (MetricDefinition) o;

        return !(metricName != null ? !metricName.equals(metricDefinition.getMetricName()) : metricDefinition.getMetricName() != null);

    }
	@Column(name="category")
	public String getCategory() {
		return category;
	}

	@Transient
	public String getCollectionFrequency() {
				
		if(getIsWeekly().equals(Constants.Y) && getIsMonthly().equals(Constants.Y)) return "Weekly, Monthly";
		if(getIsWeekly().equals(Constants.Y)) return "Weekly";
		if(getIsMonthly().equals(Constants.Y)) return "Monthly";
		
		return "";
		
	}
	
	@Column(name="data_source")
	public String getDataSource() {
		return dataSource;
	}
	
	@Transient
	public String getDefinition() {
		
		StringBuilder sb = new StringBuilder();
		
		sb.append(metricDescription);
		
		if(dataSource != null) sb.append(Constants.NEW_LINE).append("<b>Data Source:</b>  ").append(dataSource);
		if(formula != null) sb.append(Constants.NEW_LINE).append("<b>Formula:</b>  ").append(formula);
		if(helpfulInfo != null) sb.append(Constants.NEW_LINE).append("<b>Helpful Info:</b>  ").append(helpfulInfo);
		if(example != null) sb.append(Constants.NEW_LINE).append("<b>Example(s):</b>  ").append(example);
		
		return sb.toString();
		
	}
	
	@Column(name="display_format")
	public String getDisplayFormat() {
		return displayFormat;
	}
	
	@Column(name="example")
	public String getExample() {
		return example;
	}
	
	@Column(name="formula")
	public String getFormula() {
		return formula;
	}
	
	@Column(name="functional_area")
	public String getFunctionalArea() {
		return functionalArea;
	}
	
	@Column(name="has_actual")
	public String getHasActual() {
		return hasActual;
	}

//	@ManyToOne
//    @JoinColumn(name="d_data_type_id")
//	public DataType getDataType() {
//		return dataType;
//	}


	@Column(name="has_forecast")
	public String getHasForecast() {
		return hasForecast;
	}

	@Column(name="helpful_info", length = 4000)
	public String getHelpfulInfo() {
		return helpfulInfo;
	}


	@Id
	@SequenceGenerator(name = "SEQ_D_METRIC_DEFINITION", sequenceName="SEQ_D_METRIC_DEFINITION", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_METRIC_DEFINITION")
    @Column(name="d_metric_definition_id")
	@DocumentId
    public Long getId() {
        return id;
    }

	@Column(name="is_calculated")
	public String getIsCalculatd() {
		return isCalculatd;
	}


	@Column(name="is_monthly")
	@Field(analyze = Analyze.NO) // set analyze to NO to enable the full text filter
	public String getIsMonthly() {
		return ((isMonthly == null) ? "N" : isMonthly);
	}

	@Column(name="is_weekly")
	@Field(analyze = Analyze.NO) // set analyze to NO to enable the full text filter
    public String getIsWeekly() {
		return ((isWeekly == null) ? "N" : isWeekly);
	}


	@Column(name="label")
	@Field
    public String getLabel() {
		return label;
	}

	@Column(name="lower_bound")
    public Long getLowerBound() {
		return lowerBound;
	}


	@Column(name="description", nullable = false, length = 4000, unique = true)
    @Field
    public String getMetricDescription() {
        return metricDescription;
    }

	@Column(name="name", nullable = false, length = 50, unique = true)
    public String getMetricName() {
        return metricName;
    }


//	@ManyToOne
//    @JoinColumn(name="d_metric_type_id")
//    public MetricType getMetricType() {
//		return metricType;
//	}

	@Column(name="record_eff_dt")
	public Date getRecordEffDate() {
		return recordEffDate;
	}


	@Column(name="record_end_dt")
	public Date getRecordEndDate() {
		return recordEndDate;
	}

	@Transient
	public Set<MetricValidationRule> getRulesForReportType(String type) {
		switch(type) {
			case "actuals" : return actualsValidationRules; 
			case "forecasts" : return forecastsValidationRules;
			case "targets" : return targetsValidationRules;
			default : return null;
		}

	}


	@Column(name="sort_order")
    public Long getSortOrder() {
		return sortOrder;
	}

	@Column(name="status")
	@Field(analyze=Analyze.NO)
	public String getStatus() {
		return status;
	}


	@Column(name="sub_category")
	public String getSubCategory() {
		return subCategory;
	}


	@Column(name="type")
	public String getType() {
		return type;
	}
	
	@Column(name="upper_bound")
	public Long getUpperBound() {
		return upperBound;
	}
	
	@OneToMany(mappedBy="metricDefinition", fetch=FetchType.LAZY)
	@LazyCollection(LazyCollectionOption.EXTRA)
    public Set<MetricValidationRule> getValidationRules() {
		return validationRules;
	}
	@Column(name="value_type")
	public String getValueType() {
		return valueType;
	}
	@Transient
	public boolean hasBounds() {
		return (lowerBound != null || upperBound != null);
	}
	/**
     * {@inheritDoc}
     */
    public int hashCode() {
        return new HashCodeBuilder()
        	.append(metricName)
        	.toHashCode();
    }
	
    
    @Transient
	public boolean hasValidationRules() {
		return getValidationRules().size() > 0 ;
	}


	public void setCategory(String category) {
		this.category = category;
	}

//	public void setDataType(DataType dataType) {
//		this.dataType = dataType;
//	}


	public void setDataSource(String dataSource) {
		this.dataSource = dataSource;
	}


	public void setDisplayFormat(String displayFormat) {
		this.displayFormat = displayFormat;
	}


	public void setExample(String example) {
		this.example = example;
	}



	public void setFormula(String formula) {
		this.formula = formula;
	}

	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}
	
	public void setHasActual(String hasActual) {
		this.hasActual = hasActual;
	}
    
    
    public void setHasForecast(String hasForecast) {
		this.hasForecast = hasForecast;
	}

    public void setHelpfulInfo(String helpfulInfo) {
		this.helpfulInfo = helpfulInfo;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public void setIsCalculatd(String isCalculatd) {
		this.isCalculatd = isCalculatd;
	}

	public void setIsMonthly(String isMonthly) {
		this.isMonthly = isMonthly;
	}
	
    public void setIsWeekly(String isWeekly) {
		this.isWeekly = isWeekly;
	}

    public void setLabel(String label) {
		this.label = label;
	}

    public void setLowerBound(Long lowerBound) {
		this.lowerBound = lowerBound;
	}

//    public void setMetricType(MetricType metricType) {
//		this.metricType = metricType;
//	}

    public void setMetricDescription(String metricDescription) {
		this.metricDescription = metricDescription;
	}


	public void setMetricName(String metricName) {
		this.metricName = metricName;
	}

	public void setRecordEffDate(Date recordEffDate) {
		this.recordEffDate = recordEffDate;
		
	}
	

	public void setRecordEndDate(Date recordEndDate) {
		this.recordEndDate = recordEndDate;
		
	}

    public void setSortOrder(Long sortOrder) {
		this.sortOrder = sortOrder;
	}


	public void setStatus(String status) {
		this.status = status;
	}
    
    public void setSubCategory(String subCategory) {
		this.subCategory = subCategory;
	}
	public void setType(String type) {
		this.type = type;
	}
    
	public void setUpperBound(Long upperBound) {
		this.upperBound = upperBound;
	}
    
	public void setValidationRules(Set<MetricValidationRule> validationRules) {
		this.validationRules = validationRules;
		
		if(validationRules == null) return;
		
		for(MetricValidationRule rule : validationRules) {
			//  check for null value due to cascade operation on saving a rule
			if(rule.getMetricValueType()!=null) {
				if (rule.getMetricValueType().equals("Actuals")) {
					this.actualsValidationRules.add(rule);
				} else if (rule.getMetricValueType().equals("Forecasts")) {
					this.forecastsValidationRules.add(rule);
				} else if (rule.getMetricValueType().equals("Targets")) {
					this.targetsValidationRules.add(rule);
				}
			}
		}
		
	}
	
	public void setValueType(String valueType) {
		this.valueType = valueType;
	}
    
	/**
     * {@inheritDoc}
     */
    public String toString() {

    	StandardToStringStyle style = new StandardToStringStyle();
    	style.setFieldSeparator(" | ");
    	style.setUseClassName(false);
    	style.setUseIdentityHashCode(false);
    	style.setContentStart(null);
    	style.setContentEnd(null);
    	
    	ToStringBuilder tsb = new ToStringBuilder(this, style);

    	tsb.append(getFunctionalArea())
//    		.append(getCategory())
//    		.append(getSubCategory())
    		.append(getLabel());
    	
    	return tsb.build();
    	
    }

   
}

