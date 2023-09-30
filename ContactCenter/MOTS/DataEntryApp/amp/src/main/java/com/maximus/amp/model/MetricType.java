package com.maximus.amp.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import org.hibernate.search.annotations.Field;

@Entity
@Table(name = "D_METRIC_TYPE")
public class MetricType {

    private Long id;
    private String metricTypeName;   
    private String metricCategory;
    private String metricSubCategory;
	private Long sortOrder;

	/**
     * {@inheritDoc}
     */
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof MetricType)) {
            return false;
        }

        final MetricType metricType = (MetricType) o;

        return !(metricTypeName != null ? !metricTypeName.equals(metricType.getMetricTypeName()) : metricType.getMetricTypeName() != null);

    }
    
    @Id
	@SequenceGenerator(name = "SEQ_D_METRIC_TYPE", sequenceName="SEQ_D_METRIC_TYPE", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_METRIC_TYPE")
    @Column(name="d_metric_type_id")
    public Long getId() {
        return id;
    }
	
    
    
    @Column(name="metric_category", nullable = false, length = 50, unique = false)
    @Field
    public String getMetricCategory() {
        return metricCategory;
    }


	@Column(name="metric_sub_category", nullable = false, length = 50, unique = true)
    public String getMetricSubCategory() {
		return metricSubCategory;
	}


	@Column(name="metric_type_name", nullable = false, length = 50, unique = false)
    @Field
    public String getMetricTypeName() {
        return metricTypeName;
    }
    
    
    @Column(name="sort_order")
    public Long getSortOrder() {
		return sortOrder;
	}
    
    /**
     * {@inheritDoc}
     */
    public int hashCode() {
        return (metricTypeName != null ? metricTypeName.hashCode() : 0);
    }

	public void setId(Long id) {
		this.id = id;
	}
	
	public void setMetricCategory(String metricCategory) {
		this.metricCategory = metricCategory;
	}

	public void setMetricSubCategory(String metricSubCategory) {
		this.metricSubCategory = metricSubCategory;
	}



	
    public void setMetricTypeName(String metricTypeName) {
		this.metricTypeName = metricTypeName;
	}

    public void setSortOrder(Long sortOrder) {
		this.sortOrder = sortOrder;
	}

    /**
     * {@inheritDoc}
     */
    public String toString() {
        ToStringBuilder sb = new ToStringBuilder(this, ToStringStyle.DEFAULT_STYLE)
                .append("metricTypeName", this.metricTypeName);

        return sb.toString();
    }
    
}

