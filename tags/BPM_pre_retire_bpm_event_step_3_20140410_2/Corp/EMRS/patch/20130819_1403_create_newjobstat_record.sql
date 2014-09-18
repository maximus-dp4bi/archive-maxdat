DELETE FROM corp_etl_job_statistics
WHERE job_name = 'ETL_Enrollment';

INSERT INTO corp_etl_job_statistics(job_id,job_name,job_status_cd,job_start_date,job_end_date)
VALUES(SEQ_JOB_ID.nextval,'ETL_Enrollment','COMPLETED',TO_DATE('08/07/2013','MM/DD/YYYY'), TO_DATE('08/07/2013','MM/DD/YYYY'));

commit;

