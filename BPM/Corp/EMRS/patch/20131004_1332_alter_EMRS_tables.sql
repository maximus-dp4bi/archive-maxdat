ALTER TABLE emrs_s_enrollment_stg
ADD enrollment_id NUMBER(*,0);

ALTER TABLE corp_etl_job_statistics
ADD parent_job_id NUMBER;

CREATE INDEX IDX3_ENROLLSTG ON emrs_s_enrollment_stg(SOURCE_CASE_ID) TABLESPACE MAXDAT_INDX;            
CREATE INDEX IDX4_ENROLLSTG ON emrs_s_enrollment_stg(ENROLLMENT_ID) TABLESPACE MAXDAT_INDX;            


