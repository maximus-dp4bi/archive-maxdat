package com.maximus.amp.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import org.hibernate.envers.Audited;

@Audited
@MappedSuperclass
public abstract class AuditedObject extends BaseObject {

	private String createdBy;
	private String modifiedBy;
	private Date createdDate;
	private Date modifiedDate;
	
    @Column(name="created_by", nullable = false)
	public String getCreatedBy() {
		return createdBy;
	}

    
    @Column(name="create_date", nullable = false)
    public Date getCreatedDate() {
		return createdDate;
	}
    
    
    @Column(name="updated_by", nullable = false)
	public String getModifiedBy() {
		return modifiedBy;
	}

    @Column(name="last_modified_date", nullable = false)
    public Date getModifiedDate() {
		return modifiedDate;
	}
	
	
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	
	

}
