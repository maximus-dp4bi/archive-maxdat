package com.maximus.amp.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name = "D_DATA_TYPE")
public class DataType implements Serializable {
	

	private static final long serialVersionUID = 5502240245432076994L;
	
	private Long id;
	private String name;
	private Date createDate;
	
	@Column(name="create_date")
	public Date getCreateDate() {
		return createDate;
	}
	
	@Id
	@SequenceGenerator(name = "SEQ_D_DATA_TYPE", sequenceName="SEQ_D_DATA_TYPE", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_D_DATA_TYPE")
	@Column(name="d_data_type_id")
	public Long getId() {
		return id;
	}
	
	@Column(name="name")
	public String getName() {
		return name;
	}
	
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public void setId(Long id) {
		this.id = id;
	}
	public void setName(String name) {
		this.name = name;
	}
	



}
