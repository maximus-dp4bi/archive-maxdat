insert into coverva_mio.case_pool_log(ID	,
ACTION	,
CASE_TYPE	,
CASE_NUMBER	,
FILEDATE	,
UNIT	,
TYPE	,
CURRENT_STATE	,
APP_RECEIVED_DATE	,
AGE	,
VCL_DUE	,
DOC_RECEIVED	,
ASSIGNED	,
ASSIGNED_TO	,
TASK_STATUS	,
DENIAL_REASON	,
NOA_SENT	,
TRANSFERRED_TO	,
LOCATION	,
WHY	,
QUESTION	,
ANSWER	,
ADDITIONAL_CASE_OUTCOMES	,
NUMBER_APPROVED	,
VCL_DOC_TYPE_REQUESTED	,
DATE_SENT	,
AVAILABLETOASSIGN	,
CASE_PUT_ON_HOLD	,
CASE_D_REVIEW	,
APPLICANT_NAME	,
EMAIL_SENT_TO	,
BUCKET_DATE	,
START_TIME	,
END_TIME	,
COMPLETIONS_BUCKET	,
PENDING_BUCKET	,
TRANSFERS_BUCKET	,
VALID	,
VALIDATOR_ASSIGNED	,
VALIDATOR_START_TIME	,
VALIDATOR_COMPLETION_BUCKET	,
VALIDATOR_PENDING_BUCKET	,
VALIDATE_BUCKET_DATE	,
SBT_BTN	,
VLD_SBT_BTN	,
NOTES	,
specialty,
COMPLETED	,
CREATED	,
MODIFIED_BY	,
UPDATED	,
LOG_CREATED_ON	,
TABLE_NAME	)
SELECT ID	,
ACTION	,
CASE_TYPE	,
CASE_NUMBER	,
FILEDATE	,
UNIT	,
TYPE	,
CURRENT_STATE	,
APP_RECEIVED_DATE	,
AGE	,
VCL_DUE	,
DOC_RECEIVED	,
ASSIGNED	,
ASSIGNED_TO	,
TASK_STATUS	,
DENIAL_REASON	,
NOA_SENT	,
TRANSFERRED_TO	,
LOCATION	,
WHY	,
QUESTION	,
ANSWER	,
ADDITIONAL_CASE_OUTCOMES	,
NUMBER_APPROVED	,
VCL_DOC_TYPE_REQUESTED	,
DATE_SENT	,
AVAILABLETOASSIGN	,
CASE_PUT_ON_HOLD	,
CASE_D_REVIEW	,
APPLICANT_NAME	,
EMAIL_SENT_TO	,
BUCKET_DATE	,
START_TIME	,
END_TIME	,
COMPLETIONS_BUCKET	,
PENDING_BUCKET	,
TRANSFERS_BUCKET	,
VALID	,
VALIDATOR_ASSIGNED	,
VALIDATOR_START_TIME	,
VALIDATOR_COMPLETION_BUCKET	,
VALIDATOR_PENDING_BUCKET	,
VALIDATE_BUCKET_DATE	,
SBT_BTN	,
VLD_SBT_BTN	,
NOTES	,
specialty,
COMPLETED	,
CREATED	,
MODIFIED_BY	,
UPDATED	,
current_timestamp() LOG_CREATED_ON	,
'case_pool_log' TABLE_NAME	
--DURATION	,
--DURATION_UPDATED	,
--DURATION_APD	,
--DURATION_VDE	,
--DURATION_APD_VDE	
from coverva_mio.case_pool_log_sync sn
where not exists(select 1 from coverva_mio.case_pool_log l where sn.id = l.id);

insert into coverva_mio.case_pool
select *,current_timestamp(),'case_pool'
from coverva_mio.case_pool_sync sn
where not exists(select 1 from coverva_mio.case_pool p where sn.id = p.id);

insert into coverva_mio.cate_unprocessed(id,date_created,date_updated,request_type,employee_table_id,casenumber,submitted_comments,response_comments,status,modified_by,created_by,assigned,notes,log_created_on,table_name,unit)
select id,date_created,date_updated,request_type,employee_table_id,casenumber,submitted_comments,response_comments,status,modified_by,created_by,assigned,notes,current_timestamp(),'cate_unprocessed',unit
from coverva_mio.cate_unprocessed_sync sn
where not exists(select 1 from coverva_mio.cate_unprocessed p where sn.id = p.id);

insert into coverva_mio.clock_punches(id,emp_id,action_id,created,ended,auto_endshift,log_created_on,table_name,unallocated_proc_seconds)
select id,emp_id,action_id,created,ended,auto_endshift,current_timestamp(),'clock_punches',unallocated_proc_seconds
from coverva_mio.clock_punches_sync sn
where not exists(select 1 from coverva_mio.clock_punches p where sn.id = p.id);

insert into coverva_mio.etl_log
select *,current_timestamp(),'etl_log'
from coverva_mio.etl_log_sync sn
where not exists(select 1 from coverva_mio.etl_log p where sn.id = p.id);

insert into coverva_mio.loginsouts
select *,current_timestamp(),'loginsouts'
from coverva_mio.loginsouts_sync sn
where not exists(select 1 from coverva_mio.loginsouts p where sn.id = p.id);

insert into coverva_mio.safe_his
select *,current_timestamp(),'safe_his'
from coverva_mio.safe_his_sync sn
where not exists(select 1 from coverva_mio.safe_his p where sn.id = p.id);

delete from coverva_mio.rpt_riva r
where not exists(select 1 from coverva_mio.rpt_riva_sync p where r.id = p.id);


insert into coverva_mio.upload_pending_verification_doc_tasks
select *,current_timestamp(),'upload_pending_verification_doc_tasks'
from coverva_mio.upload_pending_verification_doc_tasks_sync sn
where not exists(select 1 from coverva_mio.upload_pending_verification_doc_tasks p where sn.id = p.id);

insert into coverva_mio.intake_case_pool_log 
select * from coverva_mio.intake_case_pool_log_sync l
where not exists (select 1 from coverva_mio.intake_case_pool_log g where l.id = g.id);

insert into coverva_mio.page_log
select * from coverva_mio.page_log_sync l
where not exists (select 1 from coverva_mio.page_log g where l.id = g.id);

drop table coverva_mio.intake_case_pool_log_sync;
drop table coverva_mio.intake_case_pool_sync;
drop table coverva_mio.upload_daily_intake_sync;
drop table coverva_mio.page_log_sync;
drop table coverva_mio.safe_his_sync;
drop table coverva_mio.loginsouts_sync;
drop table coverva_mio.etl_log_sync;
drop table coverva_mio.clock_punches_sync;
drop table coverva_mio.cate_unprocessed_sync;
drop table coverva_mio.case_pool_sync;
drop table coverva_mio.case_pool_log_sync;
drop table coverva_mio.upload_pending_verification_doc_tasks_sync;