package com.maximus.amp.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;
import org.apache.commons.lang3.builder.ToStringBuilder;

import com.maximus.amp.Constants;

@Entity
@Table(name = "D_PROJECT_USER")
// TODO:  add Audited
public class ProjectUser extends BaseObject {

	private static final long serialVersionUID = -8795370908206631587L;
	private Long id;
    private Project project;
    private User user;
    private Role role;
    private String functionalArea;
    private String isActiveFlag;
    
    public ProjectUser() {}
    
	public ProjectUser(Project project) {
		this.project = project;
		this.isActiveFlag = Constants.Y;
	}

	/**
     * {@inheritDoc}
     */
    public boolean equals(Object o) {
        if (this == o) {
            return true;
        }
        if (!(o instanceof ProjectUser)) {
            return false;
        }

        final ProjectUser other = (ProjectUser) o;
        
        return new EqualsBuilder()
	        .append(project, other.getProject())
	        .append(user, other.getUser())
	        .append(role, other.getRole())
	        .append(functionalArea, other.getFunctionalArea())
	        .isEquals();

    }

	@Column(name="functional_area", nullable = false)
	public String getFunctionalArea() {
		return functionalArea;
	}

	@Id
	@SequenceGenerator(name = "SEQ_D_PROJECT_ROLE", sequenceName="SEQ_D_PROJECT_ROLE", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_PROJECT_ROLE")
	@Column(name="d_project_user_id")
    public Long getId() {
        return id;
    }

	@Column(name="is_active_flag")
	public String getIsActiveFlag() {
		return isActiveFlag;
	}

	@ManyToOne
    @JoinColumn(name="d_project_id")
	public Project getProject() {
		return project;
	}
	
	@ManyToOne
    @JoinColumn(name="d_project_role_id")
	public Role getRole() {
		return role;
	}


    @ManyToOne
    @JoinColumn(name="app_user_id")
	public User getUser() {
		return user;
	}

       
    /**
     * {@inheritDoc}
     */
    public int hashCode() {
    	return new HashCodeBuilder()
    	 	.append(project)
	        .append(user)
	        .append(role)
	        .append(functionalArea)
	        .toHashCode();
    }
    
	public void setFunctionalArea(String functionalArea) {
		this.functionalArea = functionalArea;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setIsActiveFlag(String isActiveFlag) {
		this.isActiveFlag = isActiveFlag;
	}

    public void setProject(Project project) {
		this.project = project;
	}
    
    public void setRole(Role role) {
		this.role = role;
	}

    public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return new ToStringBuilder(this)
			.append(project)
			.append(user)
			.append(role)
			.append(functionalArea)
			.toString();
	}
	
}
