delete from pp_a_adhoc_job
where adhoc_job_id = 21;

commit;

INSERT INTO PP_A_ADHOC_JOB (START_DATETIME_PARAM, END_DATETIME_PARAM, ADHOC_JOB_TYPE) 
VALUES ( '2014-08-11 00:00:00', '2014-12-31 00:00:00', 'production_planning'); 

commit;