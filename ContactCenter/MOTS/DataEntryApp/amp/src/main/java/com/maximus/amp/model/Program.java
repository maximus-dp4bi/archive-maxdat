package com.maximus.amp.model;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Indexed;

@Entity
@Table(name = "D_PROGRAM")
public class Program extends BaseObject {

	private static final long serialVersionUID = 3571194601635726239L;

	private Long id;
	private String programName;
	private Date createdDate;
	private Date modifiedDate;
	
	public Program() { }
	
	public Program(String programName) {
		this.programName = programName;
		this.createdDate = new Date();
		this.modifiedDate = new Date();
	}
	
	
	@Override
	public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Program)) {
            return false;
        }

        final Program other = (Program) o;

        return new EqualsBuilder()
	        .append(programName, other.getProgramName())
	        .isEquals();

	}

    @Column(name="create_date", nullable = false)
    public Date getCreatedDate() {
		return createdDate;
	}
	
       
    // TODO:  GenerationType will need to be refactored to be SEQUENCE
	@Id
	@SequenceGenerator(name = "SEQ_D_PROGRAM", sequenceName="SEQ_D_PROGRAM", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_PROGRAM")
	@Column(name="d_program_id")
    public Long getId() {
        return id;
    }

	@Column(name="last_modified_date", nullable = false)
    public Date getModifiedDate() {
		return modifiedDate;
	}

	@Column(name="program_name", nullable = false, length = 50, unique = true)
    @Field
    public String getProgramName() {
        return programName;
    }

	@Override
	public int hashCode() {
		return new HashCodeBuilder()
	        .append(programName)
	        .toHashCode();
	
	}

	
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

    public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
    
       
    public void setProgramName(String programName) {
		this.programName = programName;
	}
	
    @Override
	public String toString() {
		return programName;
	}

}
