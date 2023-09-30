package com.maximus.amp.model;

import java.io.Serializable;

import org.apache.commons.lang3.builder.EqualsBuilder;
import org.apache.commons.lang3.builder.HashCodeBuilder;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "D_SEGMENT")
public class Segment extends BaseObject implements Serializable {
	
	private static final long serialVersionUID = 6682218470704449890L;
	
	private Long id;
	private String name;

	@Override
	public boolean equals(Object o) {
		
		if (this == o) { return true; }
        if (!(o instanceof Segment)) { return false; }

        final Segment other = (Segment) o;
		
		return new EqualsBuilder()
			.append(name, other.getName())
			.isEquals();
	}

	@Id
	@SequenceGenerator(name = "SEQ_D_SEGMENT", sequenceName="SEQ_D_SEGMENT", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_SEGMENT")
	@Column(name="d_segment_id")
	public Long getId() {
		return id;
	}

	@Column(name="segment_name")
	public String getName() {
		return name;
	}

	@Override
	public int hashCode() {
		return new HashCodeBuilder()
		.append(name)
		.toHashCode();
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return name;
	}

}
