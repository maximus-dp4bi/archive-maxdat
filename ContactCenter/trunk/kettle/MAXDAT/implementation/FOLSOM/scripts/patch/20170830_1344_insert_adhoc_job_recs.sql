update FOLSOM_SHARED_CC.cc_a_scheduled_job
set is_running = 0,success = 1,job_end_date = to_date('08/28/2017 21:06:40','mm/dd/yyyy hh24:mi:ss')
where scheduled_job_id = 24781;
  
insert into FOLSOM_SHARED_CC.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2017-08-28 00:00:00','2017-08-29 00:00:00',1, 'AVAYA', 'NA');

insert into FOLSOM_SHARED_CC.cc_a_adhoc_job(adhoc_job_type, start_datetime_param, end_datetime_param, is_pending, ACD_SOURCE, WFM_SOURCE)
values('load_contact_center','2017-08-29 00:00:00','2017-08-30 00:00:00',1, 'AVAYA', 'NA'); 

INSERT INTO FOLSOM_SHARED_CC.CC_A_SCHEDULED_JOB (SCHEDULED_JOB_TYPE, START_DATETIME_PARAM, END_DATETIME_PARAM, JOB_START_DATE, JOB_END_DATE, SUCCESS) 
VALUES ('load_contact_center','2017-08-29 00:00:00','2017-08-30 00:00:00', to_date('2017-08-30 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), to_date('2017-08-30 18:00:00', 'YYYY-MM-DD HH24:MI:SS'),1) ;


COMMIT;  
  