package com.maximus.amp.model;

import java.io.Serializable;

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

@Entity
@Table(name = "D_DIVISION")
public class Division extends BaseObject implements Serializable {

	private static final long serialVersionUID = 400483198714013438L;

	private Long id;
	private String name;
	private Segment segment;

	@Override
	public boolean equals(Object o) {
		
		if (this == o) { return true; }
        if (!(o instanceof Division)) { return false; }

        final Division other = (Division) o;
		
		return new EqualsBuilder()
			.append(segment, other.getSegment())
			.append(name, other.getName())
			.isEquals();
	}

	@Id
	@SequenceGenerator(name = "SEQ_D_DIVISION", sequenceName="SEQ_D_DIVISION", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_DIVISION")
	@Column(name="d_division_id")
	public Long getId() {
		return id;
	}

	@Column(name="division_name")
	public String getName() {
		return name;
	}

	@ManyToOne
	@JoinColumn(name="d_segment_id")
	public Segment getSegment() {
		return segment;
	}

	@Override
	public int hashCode() {

		return new HashCodeBuilder()
			.append(segment)
			.append(name)
			.toHashCode();
	}

	public void setId(Long id) {
		this.id = id;
	}

	public void setName(String name) {
		this.name = name;
	}

	public void setSegment(Segment segment) {
		this.segment = segment;
	}

	@Override
	public String toString() {
		return name;
	}
	

	
}
