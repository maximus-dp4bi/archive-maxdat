package com.maximus.amp.model;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.Filter;
import org.hibernate.search.annotations.Field;
import org.hibernate.search.annotations.Indexed;

@Entity
@Table(name = "D_PROJECT")
@Indexed
@NamedQueries({
    @NamedQuery(
            name = "getProjectByName",
            query ="SELECT p FROM Project p "
            		+ "WHERE projectName = :projectName  "
    )
})
public class Project extends BaseObject {

	private static final long serialVersionUID = -8795370908206631587L;
	private Long id;
    private String projectName; // required  
    private Division division;
    private Set<ProjectUser> projectUsers = new HashSet<ProjectUser>();
    private Set<Program> programs = new HashSet<Program>();
    private Set<GeographyMaster> geographyMasters = new HashSet<GeographyMaster>();
	private Date createdDate;
	private Date modifiedDate;
	

	public void addGeographyMaster(GeographyMaster geographyMaster) {
		getGeographyMasters().add(geographyMaster);
	}

    public void addProgram(Program program) {
		getPrograms().add(program);
	}

	/**
     * {@inheritDoc}
     */
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof Project)) {
            return false;
        }

        final Project other = (Project) o;
        
        return new EqualsBuilder()
	        .append(projectName, other.getProjectName())
	        .isEquals();

    }

	@Column(name="create_date", nullable = false)
    public Date getCreatedDate() {
		return createdDate;
	}

	@ManyToOne
    @JoinColumn(name="d_division_id")
    public Division getDivision() {
		return division;
	}


	@ManyToMany
    @Fetch(FetchMode.SELECT)
    @JoinTable(
            name = "D_PROJECT_GEOGRAPHY_MASTER",
            joinColumns = { @JoinColumn(name = "D_PROJECT_ID") },
            inverseJoinColumns = @JoinColumn(name = "D_GEOGRAPHY_MASTER_ID")
    )
	public Set<GeographyMaster> getGeographyMasters() {
		return geographyMasters;
	}

	@Id
	@SequenceGenerator(name = "SEQ_D_PROJECT", sequenceName="SEQ_D_PROJECT", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_PROJECT")
	@Column(name="d_project_id")
    public Long getId() {
        return id;
    }
	
    @Column(name="last_modified_date", nullable = false)
    public Date getModifiedDate() {
		return modifiedDate;
	}
    
    @ManyToMany
    @Fetch(FetchMode.SELECT)
    @JoinTable(
            name = "D_PROJECT_PROGRAM",
            joinColumns = { @JoinColumn(name = "D_PROJECT_ID") },
            inverseJoinColumns = @JoinColumn(name = "D_PROGRAM_ID")
    )
    public Set<Program> getPrograms() {
		return programs;
	}

	@Column(name="project_name", nullable = false, length = 50, unique = true)
    @Field
    public String getProjectName() {
        return projectName;
    }

	@OneToMany(mappedBy="project")
    @Filter(
		name = "isActive",
		condition="isActive = 'Y"
    )
	public Set<ProjectUser> getProjectUsers() {
		return this.projectUsers;
	}


	/**
     * {@inheritDoc}
     */
    public int hashCode() {
    	return new HashCodeBuilder()
	        .append(projectName)
	        .toHashCode();
    }


	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}

	
    public void setDivision(Division division) {
		this.division = division;
	}



	public void setGeographyMasters(Set<GeographyMaster> geographyMasters) {
		this.geographyMasters = geographyMasters;
	}
	
	public void setId(Long id) {
		this.id = id;
	}

    public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
    
       
    public void setPrograms(Set<Program> programs) {
		this.programs = programs;
	}
	
    public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public void setProjectUsers(Set<ProjectUser> projectuserSet) {
		this.projectUsers = projectuserSet;
	}
	
	@Override
	public String toString() {
		return projectName;
	}
	
}
