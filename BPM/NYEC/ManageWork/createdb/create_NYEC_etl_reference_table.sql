-- 9/25/13 B.Thai NYEC-5301 Incident tracking

CREATE TABLE nyec_etl_manage_work_reference
(nemwr_id                 NUMBER          NOT NULL
,cemw_id                  NUMBER          NOT NULL
,task_id                  NUMBER          NOT NULL
,incident_header_id       NUMBER          NOT NULL
,incident_tracker_number  NUMBER
,stg_extract_date         DATE            NOT NULL
,stg_last_update_date     DATE            NOT NULL
)
TABLESPACE maxdat_data PARALLEL;

ALTER TABLE nyec_etl_manage_work_reference
  ADD CONSTRAINT nyec_etl_mw_reference_pk
  PRIMARY KEY ( nemwr_id )
  USING INDEX TABLESPACE MAXDAT_INDX;

CREATE INDEX nyec_etl_mw_reference_idx01 ON nyec_etl_manage_work_reference
 ( cemw_id )
  LOGGING TABLESPACE MAXDAT_INDX;

CREATE INDEX nyec_etl_mw_reference_idx02 ON nyec_etl_manage_work_reference
 ( task_id )
  LOGGING TABLESPACE MAXDAT_INDX;

CREATE INDEX nyec_etl_mw_reference_idx03 ON nyec_etl_manage_work_reference
 ( incident_header_id )
  LOGGING TABLESPACE MAXDAT_INDX;

CREATE UNIQUE INDEX nyec_etl_mw_reference_uk_idx ON nyec_etl_manage_work_reference
 ( task_id, incident_header_id )
  LOGGING TABLESPACE MAXDAT_INDX;

ALTER TABLE nyec_etl_manage_work_reference ADD 
CONSTRAINT nyec_etl_mw_reference_uk
  UNIQUE ( task_id, incident_header_id )
  ENABLE VALIDATE;

GRANT SELECT ON nyec_etl_manage_work_reference TO MAXDAT_READ_ONLY;


-- Sequence
CREATE SEQUENCE seq_nemwr_id START WITH 1;

--GRANT SELECT ON seq_nemwr_id TO MAXDAT_READ_ONLY;

-- Trigger
CREATE OR REPLACE TRIGGER trg_biu_nyec_etl_mw_reference
BEFORE INSERT OR UPDATE ON nyec_etl_manage_work_reference
REFERENCING NEW AS n OLD AS o
FOR EACH ROW
DECLARE

  /*
  Do not edit these four SVN_* variable values.  
  They are populated when you commit code to SVN and used later to identify deployed code.
  ---------------------------------
  SVN_FILE_URL        = $URL$  
  SVN_REVISION        = $Revision$ 
  SVN_REVISION_DATE   = $Date$
  SVN_REVISION_AUTHOR = $Author$
  ---------------------------------
  */

BEGIN
  IF INSERTING THEN
    IF :n.nemwr_id IS NULL
    THEN :n.nemwr_id := seq_nemwr_id.NEXTVAL;
    END IF;
    --
    :n.stg_extract_date := SYSDATE;
  END IF;
  :n.stg_last_update_date := SYSDATE;
END trg_biu_nyec_etl_mw_reference;
/


