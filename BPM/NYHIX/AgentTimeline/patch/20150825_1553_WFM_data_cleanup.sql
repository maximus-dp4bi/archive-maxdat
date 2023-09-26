/*
Created on 08/25/2015 by Raj A.
Description: In an effort to performance tune the NYHIX PP_WFM_RUNALL kjb, a bug was introduced by the NYHIX-17130 UAT deployment (Load_task.ktr only) and 
hence this cleanup is needed to reload data.
*/
delete PP_WFM_TASK 
where task_start >= to_date('08/24/2015','mm/dd/yyyy');
commit;

insert into corp_etl_job_statistics
(
job_id, job_name, job_status_cd, job_start_date, job_end_date
)
values (
SEQ_JOB_ID.NEXTVAL,
'PP_WFM_RUNALL',
'COMPLETED',
to_date('8/24/2015','mm/dd/yyyy'),
to_date('8/24/2015','mm/dd/yyyy')
);
commit;