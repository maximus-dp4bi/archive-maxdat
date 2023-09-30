package com.maximus.amp.model.envers;

import java.io.Serializable;
import java.text.DateFormat;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.envers.RevisionEntity;
import org.hibernate.envers.RevisionNumber;
import org.hibernate.envers.RevisionTimestamp;

import com.maximus.amp.webapp.listener.AmpRevisionListener;

@Entity
@Table(name = "AMP_REVISION_ENTITY")
@RevisionEntity(AmpRevisionListener.class)
public class AmpRevisionEntity implements Serializable {

	private static final long serialVersionUID = 3978643198920469210L;

	private String username;
	
	@Id
	@SequenceGenerator(name = "SEQ_AMP_REVISION_ENTITY", sequenceName="SEQ_AMP_REVISION_ENTITY", initialValue=1, allocationSize=20)
    @GeneratedValue(strategy=GenerationType.SEQUENCE, generator = "SEQ_AMP_REVISION_ENTITY")
	@RevisionNumber
	private int id;

	@RevisionTimestamp
	private long timestamp;

	@Override
	public boolean equals(Object o) {
		if ( this == o ) {
			return true;
		}
		if ( !(o instanceof AmpRevisionEntity) ) {
			return false;
		}

		final AmpRevisionEntity that = (AmpRevisionEntity) o;
		return id == that.id
				&& timestamp == that.timestamp;
	}

	public int getId() { return id; }

	@Transient
	public Date getRevisionDate() {
		return new Date( timestamp );
	}

	public long getTimestamp() {
		return timestamp;
	}

	public String getUsername() { return username; }

	@Override
	public int hashCode() {
		int result;
		result = id;
		result = 31 * result + (int) (timestamp ^ (timestamp >>> 32));
		return result;
	}


	public void setId(int id) { this.id = id; }
	
    public void setTimestamp(long timestamp) {
		this.timestamp = timestamp;
	}
    
    public void setUsername(String username) { this.username = username; }
    
    @Override
	public String toString() {
		return "DefaultRevisionEntity(id = " + id
				+ ", revisionDate = " + DateFormat.getDateTimeInstance().format( getRevisionDate() ) + ")";
	}

}





