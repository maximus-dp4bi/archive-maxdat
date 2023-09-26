truncate table coverva_mio.case_pool;
insert into coverva_mio.case_pool(
APP_RECEIVED_DATE	,
NOTES	,
NUMBER_APPROVED	,
SPECIALTY	,
NOA_SENT	,
TRANSFERRED_TO	,
ADDITIONAL_CASE_OUTCOMES	,
CASE_D_REVIEW	,
CREATED	,
DENIAL_REASON	,
SBT_BTN	,
ASSIGNED	,
TASK_STATUS	,
APPLICANT_NAME	,
CASE_PUT_ON_HOLD	,
VCL_DOC_TYPE_REQUESTED	,
COMPLETED	,
DOC_RECEIVED	,
END_TIME	,
--HELPDESK_TICKETNUMBER	,
START_TIME	,
UNIT	,
TYPE	,
VALIDATOR_ASSIGNED	,
VALIDATOR_COMPLETION_BUCKET	,
VALID	,
ANSWER	,
CASE_TYPE	,
FILEDATE	,
LOG_CREATED_ON	,
WHY	,
PENDING_BUCKET	,
TRANSFERS_BUCKET	,
QUESTION	,
DATE_SENT	,
ASSIGNED_TO	,
BUCKET_DATE	,
COMPLETIONS_BUCKET	,
LOCATION	,
TABLE_NAME	,
VALIDATOR_START_TIME	,
OFFENDER_ID	,
CASE_NUMBER	,
AGE	,
CURRENT_STATE	,
--HELPDESK_TICKETSTATUS	,
VCL_DUE	,
ESCALATION_CREATE_DATE	,
ID	,
VALIDATE_BUCKET_DATE	,
VLD_SBT_BTN	,
MODIFIED_BY	,
ESCALATION_REASON	,
AGE_BUSINESS_DAY	,
AVAILABLETOASSIGN	,
LDAP_ID	,
MIO_SOURCE	,
UPDATED	,
EMAIL_SENT_TO	,
VALIDATOR_PENDING_BUCKET	)
SELECT APP_RECEIVED_DATE	,
NOTES	,
NUMBER_APPROVED	,
SPECIALTY	,
NOA_SENT	,
TRANSFERRED_TO	,
ADDITIONAL_CASE_OUTCOMES	,
CASE_D_REVIEW	,
CREATED	,
DENIAL_REASON	,
SBT_BTN	,
ASSIGNED	,
TASK_STATUS	,
APPLICANT_NAME	,
CASE_PUT_ON_HOLD	,
VCL_DOC_TYPE_REQUESTED	,
COMPLETED	,
DOC_RECEIVED	,
END_TIME	,
--HELPDESK_TICKETNUMBER	,
START_TIME	,
UNIT	,
TYPE	,
VALIDATOR_ASSIGNED	,
VALIDATOR_COMPLETION_BUCKET	,
VALID	,
ANSWER	,
CASE_TYPE	,
FILEDATE	,
current_timestamp() LOG_CREATED_ON	,
WHY	,
PENDING_BUCKET	,
TRANSFERS_BUCKET	,
QUESTION	,
DATE_SENT	,
ASSIGNED_TO	,
BUCKET_DATE	,
COMPLETIONS_BUCKET	,
LOCATION	,
'case_pool' TABLE_NAME	,
VALIDATOR_START_TIME	,
OFFENDER_ID	,
CASE_NUMBER	,
AGE	,
CURRENT_STATE	,
--HELPDESK_TICKETSTATUS	,
VCL_DUE	,
ESCALATION_CREATE_DATE	,
ID	,
VALIDATE_BUCKET_DATE	,
VLD_SBT_BTN	,
MODIFIED_BY	,
ESCALATION_REASON	,
AGE_BUSINESS_DAY	,
AVAILABLETOASSIGN	,
LDAP_ID	,
MIO_SOURCE	,
UPDATED	,
EMAIL_SENT_TO	,
VALIDATOR_PENDING_BUCKET
from coverva_mio.case_pool_sync;
drop table coverva_mio.case_pool_sync;


select count(*) from  coverva_mio.checklist_sync;
insert into coverva_mio.checklist(id,date_created_est,case_identifier,unit,supervisor,worker,disposition,question,answer,emp_id,table_name,log_created_on)
select id,date_created_est,case_identifier,unit,supervisor,worker,disposition,question,answer,emp_id,'checklist',current_timestamp() from coverva_mio.checklist_sync s
where not exists(select 1 from coverva_mio.checklist c where c.id = s.id);
drop table coverva_mio.checklist_sync;

insert into coverva_mio.help_desk
select h.*,'help_desk',current_timestamp()
from coverva_mio.help_desk_sync h
where not exists(select 1 from coverva_mio.help_desk s where h.id = s.id);

insert into coverva_mio.loginsouts
select *,current_timestamp(),'loginsouts'
from coverva_mio.loginsouts_sync sn
where not exists(select 1 from coverva_mio.loginsouts p where sn.id = p.id);

insert into coverva_mio.page_log
select *,current_timestamp(),'page_log'
from coverva_mio.page_log_sync sn
where not exists(select 1 from coverva_mio.page_log p where sn.id = p.id);

insert into coverva_mio.notificationform(DATE_CREATED,
OUTAGE_TYPE,
CREATED_BY,
LOG_CREATED_ON,
MODIFIED_BY,
ETA,
CUSTOM_MESSAGE,
ID,
INCIDENT_NO,
OPERATIONS_IMPACT,
OUTAGE_END,
DATE_UPDATED,
OUTAGE_START,
TABLE_NAME,
ADDITIONAL_MESSAGE_NOTES
)
select DATE_CREATED,
OUTAGE_TYPE,
CREATED_BY,
current_timestamp() LOG_CREATED_ON,
MODIFIED_BY,
ETA,
CUSTOM_MESSAGE,
ID,
INCIDENT_NO,
OPERATIONS_IMPACT,
OUTAGE_END,
DATE_UPDATED,
OUTAGE_START,
'notificationform' TABLE_NAME,
ADDITIONAL_MESSAGE_NOTES
from coverva_mio.notificationform_sync s
where not exists(select 1 from coverva_mio.notificationform f where s.id = f.id);

insert into coverva_mio.etl_log
select *,current_timestamp(),'etl_log'
from coverva_mio.etl_log_sync sn
where not exists(select 1 from coverva_mio.etl_log p where sn.id = p.id);

insert into coverva_mio.cate_unprocessed_log(ASSIGNED,
CREATED_BY,
 TABLE_NAME,
DATE_UPDATED,
EMPLOYEE_TABLE_ID,
LOG_CREATED_ON,
STAP_EMP_ID,
ID,
MODIFIED_BY,
STAP_DATESTAMP,
UNIT,
ACTION,
REQUEST_TYPE,
CASENUMBER,
NEW_REREGISTERED_TNUMBER,
SUBMITTED_COMMENTS,
NOTES,
STATUS,
DATE_CREATED,
RESPONSE_COMMENTS)
select ASSIGNED,
CREATED_BY,
'cate_unprocessed_log' TABLE_NAME,
DATE_UPDATED,
EMPLOYEE_TABLE_ID,
current_timestamp() LOG_CREATED_ON,
STAP_EMP_ID,
ID,
MODIFIED_BY,
STAP_DATESTAMP,
UNIT,
ACTION,
REQUEST_TYPE,
CASENUMBER,
NEW_REREGISTERED_TNUMBER,
SUBMITTED_COMMENTS,
NOTES,
STATUS,
DATE_CREATED,
RESPONSE_COMMENTS
from coverva_mio.CATE_UNPROCESSED_LOG_SYNC h
where not exists(select 1 from coverva_mio.CATE_UNPROCESSED_LOG s where h.id = s.id);

insert into QA_CASE_POOL_LOG
select *, 'qa_case_pool_log',current_timestamp()
from QA_CASE_POOL_LOG_SYNC s
where not exists(select 1 from QA_CASE_POOL_LOG p where s.id = p.id);

delete from QA_CASE_POOL_LOG s
where not exists(select 1 from QA_CASE_POOL_LOG_SYNC p where s.id = p.id);

insert into ARCHIVES_RPT_CURRENT_SCORED_CASES_QA
select *, 'archives_rpt_current_scored_cases_qa' table_name,current_timestamp() log_created_on
from ARCHIVES_RPT_CURRENT_SCORED_CASES_QA_sync s
where not exists(select 1 from ARCHIVES_RPT_CURRENT_SCORED_CASES_QA p where s.id = p.id);

insert into SAFE_HIS 
select *,current_timestamp() log_created_on, 'safe_his' table_name
from SAFE_HIS_SYNC s
where not exists(select 1 from SAFE_HIS p where s.id = p.id);

delete from rpt_daily_clock_rollup s
where not exists(select 1 from rpt_daily_clock_rollup_sync p where s.emp_id = p.emp_id and s.clock_date = p.clock_date);

insert into rpt_daily_clock_rollup
select *,current_timestamp(),'rpt_daily_clock_rollup' from rpt_daily_clock_rollup_sync s
where not exists(select 1 from rpt_daily_clock_rollup p where s.emp_id = p.emp_id and s.clock_date = p.clock_date);

insert into rpt_riva(COMPLETIONS_BUCKET,
DISPOSITION,
QA_QUESTION,
CASE_POOL_LOG_ID,
CASE_TYPE,
EMPLOYEENAME,
ID,
UPDATED,
TRANSFERS_BUCKET,
CATEGORY,
DURATION,
MANAGER,
NUM_APPLICANTS,
TYPE,
TABLE_NAME,
MAX_EMP_ID,
CASE_NUMBER,
UNIT,
DATE_DISPOSITIONED,
EMPLOYEES_TABLE_ID,
SUPERVISOR,
LDAP_ID,
LOG_CREATED_ON,
PENDING_BUCKET)
select COMPLETIONS_BUCKET,
DISPOSITION,
QA_QUESTION,
CASE_POOL_LOG_ID,
CASE_TYPE,
EMPLOYEENAME,
ID,
UPDATED,
TRANSFERS_BUCKET,
CATEGORY,
DURATION,
MANAGER,
NUM_APPLICANTS,
TYPE,
'rpt_riva' TABLE_NAME,
MAX_EMP_ID,
CASE_NUMBER,
UNIT,
DATE_DISPOSITIONED,
EMPLOYEES_TABLE_ID,
SUPERVISOR,
LDAP_ID,
current_timestamp() LOG_CREATED_ON,
PENDING_BUCKET
FROM rpt_riva_sync s
where not exists(select 1 from rpt_riva p where s.id = p.id);

insert into CATE_UNPROCESSED(
TABLE_NAME,
CASENUMBER,
LOG_CREATED_ON,
MODIFIED_BY,
STAP_EMP_ID,
EMPLOYEE_TABLE_ID,
NEW_REREGISTERED_TNUMBER,
REQUEST_TYPE,
STATUS,
ID,
SUBMITTED_COMMENTS,
STAP_DATESTAMP,
ASSIGNED,
CREATED_BY,
NOTES,
DATE_CREATED,
DATE_UPDATED,
RESPONSE_COMMENTS,
UNIT)
SELECT 'cate_unprocessed' TABLE_NAME,
CASENUMBER,
current_timestamp() LOG_CREATED_ON,
MODIFIED_BY,
STAP_EMP_ID,
EMPLOYEE_TABLE_ID,
NEW_REREGISTERED_TNUMBER,
REQUEST_TYPE,
STATUS,
ID,
SUBMITTED_COMMENTS,
STAP_DATESTAMP,
ASSIGNED,
CREATED_BY,
NOTES,
DATE_CREATED,
DATE_UPDATED,
RESPONSE_COMMENTS,
UNIT 
FROM COVERVA_MIO.CATE_UNPROCESSED_SYNC s
where not exists(select 1 from COVERVA_MIO.CATE_UNPROCESSED p where s.id = p.id)
;

insert into archives_rpt_current_worked_cases
(REASON	,
TASK_NAME	,
DISPOSITION_DATE	,
T	,
PRIMARY_PROCESSING_OPTION	,
ES	,
H	,
HTMLID2	,
REPORT_LEVEL	,
SUPERVISOR	,
P	,
D	,
HTMLID	,
ID	,
V	,
AGE_BUSINESS_DAY	,
O	,
SPECIALTY	,
TASK_STATUS	,
TIMECLOCK_STATUS	,
L	,
UPDATED	,
"2V"	,
A	,
AGE	,
CASE_NUMBER	,
DATE_RAN	,
EMPLOYEE	,
LDAP_ID	,
Q	,
VCL_DUE	,
EMPID	,
UNIT	,
table_name,
log_created_on)
SELECT REASON	,
TASK_NAME	,
DISPOSITION_DATE	,
T	,
PRIMARY_PROCESSING_OPTION	,
ES	,
H	,
HTMLID2	,
REPORT_LEVEL	,
SUPERVISOR	,
P	,
D	,
HTMLID	,
ID	,
V	,
AGE_BUSINESS_DAY	,
O	,
SPECIALTY	,
TASK_STATUS	,
TIMECLOCK_STATUS	,
L	,
UPDATED	,
"2V",
A	,
AGE	,
CASE_NUMBER	,
DATE_RAN	,
EMPLOYEE	,
LDAP_ID	,
Q	,
VCL_DUE	,
EMPID	,
UNIT	,
'archives_rpt_current_worked_cases',
current_timestamp()
FROM archives_rpt_current_worked_cases_sync s
where not exists(select 1 from COVERVA_MIO.ARCHIVES_RPT_CURRENT_WORKED_CASES p where s.id = p.id);

insert into RPT_CVIU_RENEWALS(id,
renewal_month,
case_number,
disposition,
disposition_date_est,
why,
unit,
case_type,
exparte,
table_name,
log_created_on)
select id,
renewal_month,
case_number,
disposition,
disposition_date_est,
why,
unit,
case_type,
exparte,
'rpt_cviu_renewals',
current_timestamp()
from COVERVA_MIO.RPT_CVIU_RENEWALS_SYNCH s
where not exists(select 1 from COVERVA_MIO.RPT_CVIU_RENEWALS p where s.id = p.id);

delete from case_pool_log s
where not exists(select 1 from case_pool_log_synch p where s.id = p.id)
and id <= 5066481;

insert into case_pool_log(
id,
action,
case_type,
case_number,
filedate,
unit,
type,
current_state,
app_received_date,
age,
age_business_day,
vcl_due,
doc_received,
assigned,
assigned_to,
task_status,
denial_reason,
noa_sent,
transferred_to,
location,
why,
question,
answer,
additional_case_outcomes,
number_approved,
vcl_doc_type_requested,
escalation_reason,
escalation_create_date,
date_sent,
availabletoassign,
case_put_on_hold,
case_d_review,
applicant_name,
email_sent_to,
bucket_date,
start_time,
end_time,
completions_bucket,
pending_bucket,
transfers_bucket,
valid,
validator_assigned,
validator_start_time,
validator_completion_bucket,
validator_pending_bucket,
validate_bucket_date,
sbt_btn,
vld_sbt_btn,
notes,
specialty,
completed,
mio_source,
offender_id,
ldap_id,
application_source,
alternative_case_number,
created,
modified_by,
updated,
table_name,
log_created_on)
select id,
action,
case_type,
case_number,
filedate,
unit,
type,
current_state,
app_received_date,
age,
age_business_day,
vcl_due,
doc_received,
assigned,
assigned_to,
task_status,
denial_reason,
noa_sent,
transferred_to,
location,
why,
question,
answer,
additional_case_outcomes,
number_approved,
vcl_doc_type_requested,
escalation_reason,
escalation_create_date,
date_sent,
availabletoassign,
case_put_on_hold,
case_d_review,
applicant_name,
email_sent_to,
bucket_date,
start_time,
end_time,
completions_bucket,
pending_bucket,
transfers_bucket,
valid,
validator_assigned,
validator_start_time,
validator_completion_bucket,
validator_pending_bucket,
validate_bucket_date,
sbt_btn,
vld_sbt_btn,
notes,
specialty,
completed,
mio_source,
offender_id,
ldap_id,
application_source,
alternative_case_number,
created,
modified_by,
updated,
'case_pool_log' table_name,
current_timestamp() log_created_on
from case_pool_log_synch s
where not exists(select 1 from case_pool_log p where s.id = p.id);