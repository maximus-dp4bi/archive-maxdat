package com.maximus.amp.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.search.annotations.Field;

@Entity
@Table(name = "D_GEOGRAPHY_MASTER")
public class GeographyMaster extends BaseObject {

	private static final long serialVersionUID = -8795370908206631587L;
	private Long id;
    private String geographyName; // required  
	private Date createdDate;
	private Date modifiedDate;
	private Long countryId;
	private Long stateId;
	private Long provinceId;
	private Long districtId;
	private Long regionId;
	

	public GeographyMaster() {}

	public GeographyMaster(String geographyName) {
		this.createdDate = new Date();
		this.modifiedDate = new Date();
		this.geographyName = geographyName;
		
		//  removing init of FKs to 0 (Unknown) to avoid unique constraint error;
		//  TODO:  revisit creation of new Geography Masters;  
//		this.countryId = 0L;
//		this.stateId = 0L;
//		this.provinceId = 0L;
//		this.districtId = 0L;
//		this.regionId = 0L;
	}

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

        final GeographyMaster project = (GeographyMaster) o;

        return !(geographyName != null ? !geographyName.equals(project.getGeographyName()) : project.getGeographyName() != null);

    }

	@Column(name="country_id")
	public Long getCountryId() {
		return countryId;
	}

	@Column(name="create_date", nullable = false)
    public Date getCreatedDate() {
		return createdDate;
	}

	@Column(name="district_id")
	public Long getDistrictId() {
		return districtId;
	}
	
    @Column(name="geography_name", nullable = false, length = 50, unique = true)
    @Field
    public String getGeographyName() {
        return geographyName;
    }
    
    
    @Id
	@SequenceGenerator(name = "SEQ_D_GEO_MASTER", sequenceName="SEQ_D_GEO_MASTER", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_GEO_MASTER")
	@Column(name="d_geography_master_id")
    public Long getId() {
        return id;
    }
	
       
    @Column(name="last_modified_date", nullable = false)
    public Date getModifiedDate() {
		return modifiedDate;
	}


	@Column(name="province_id")
	public Long getProvinceId() {
		return provinceId;
	}


	@Column(name="region_id")
	public Long getRegionId() {
		return regionId;
	}

	
    @Column(name="state_id")
	public Long getStateId() {
		return stateId;
	}


    /**
     * {@inheritDoc}
     */
    public int hashCode() {
        return (geographyName != null ? geographyName.hashCode() : 0);
    }

    public void setCountryId(Long countryId) {
		this.countryId = countryId;
	}

	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	public void setDistrictId(Long districtId) {
		this.districtId = districtId;
	}

	public void setGeographyName(String geographyName) {
		this.geographyName = geographyName;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
	public void setProvinceId(Long provinceId) {
		this.provinceId = provinceId;
	}

	public void setRegionId(Long regionId) {
		this.regionId = regionId;
	}

	public void setStateId(Long stateId) {
		this.stateId = stateId;
	}

	@Override
    public String toString() {
        return geographyName;
    }
    
}
