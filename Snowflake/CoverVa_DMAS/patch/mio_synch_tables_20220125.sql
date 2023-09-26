insert into coverva_mio.employees
select *,current_timestamp(),'employees'
from coverva_mio.employees_sync sn
where not exists(select 1 from coverva_mio.employees p where sn.id = p.id);

truncate table coverva_mio.intake_case_pool_log;
insert into coverva_mio.intake_case_pool_log (ID,
ABD_INDICATOR,
ACTION,
ANSWER,
ASSIGNED,
ASSIGNED_TO,
AVAILABLETOASSIGN,
BUCKET_DATE,
CASE_NUMBER_ASSOCIATED,
CASE_PUT_ON_HOLD,
CNAME,
COMPLETED,
COMPLETIONS_BUCKET,
CREATED,
DENIAL_REASON,
FILEDATE,
HOLD_REASON,
LDSS_2ND_COMMUNICATION_FORM_SENT,
LDSS_COMMUNICATION_FORM_SENT,
LDSS_FORM_FILE_LOCATION,
LDSS_WORKER_ID,
LOCATION,
MAILING_ADDRESS,
MAILING_CITY,
MAILING_STATE,
MAILING_ZIP,
MODIFIED_BY,
MWS_DATE,
MY_WORKSPACE_DATE,
NOTES,
NUM_APPLICANTS,
PENDING_BUCKET,
PHYSICAL_ADDRESS,
PHYSICAL_CITY,
PHYSICAL_STATE,
PHYSICAL_ZIP,
PREG_SWITCH,
SAME_AS_MAILING_CHKBOX,
SBT_BTN,
SOURCE,
SPECIALTY,
START_TIME,
T_NUMBER,
TASK_STATUS,
TRANSFER_REASON,
TRANSFERRED_TO,
TRANSFERS_BUCKET,
UNIT,
UPDATED,
log_created_on,
table_name)
select ID,
ABD_INDICATOR,
ACTION,
ANSWER,
ASSIGNED,
ASSIGNED_TO,
AVAILABLETOASSIGN,
BUCKET_DATE,
CASE_NUMBER_ASSOCIATED,
CASE_PUT_ON_HOLD,
CNAME,
COMPLETED,
COMPLETIONS_BUCKET,
CREATED,
DENIAL_REASON,
FILEDATE,
HOLD_REASON,
LDSS_2ND_COMMUNICATION_FORM_SENT,
LDSS_COMMUNICATION_FORM_SENT,
LDSS_FORM_FILE_LOCATION,
LDSS_WORKER_ID,
LOCATION,
MAILING_ADDRESS,
MAILING_CITY,
MAILING_STATE,
MAILING_ZIP,
MODIFIED_BY,
MWS_DATE,
MY_WORKSPACE_DATE,
NOTES,
NUM_APPLICANTS,
PENDING_BUCKET,
PHYSICAL_ADDRESS,
PHYSICAL_CITY,
PHYSICAL_STATE,
PHYSICAL_ZIP,
PREG_SWITCH,
SAME_AS_MAILING_CHKBOX,
SBT_BTN,
SOURCE,
SPECIALTY,
START_TIME,
T_NUMBER,
TASK_STATUS,
TRANSFER_REASON,
TRANSFERRED_TO,
TRANSFERS_BUCKET,
UNIT,
UPDATED
,current_timestamp(),'intake_case_pool_log' 
from coverva_mio.intake_case_pool_log_sync l
;


insert into coverva_mio.intake_case_pool (ID	,
NOTES	,
NUM_APPLICANTS	,
SBT_BTN	,
LDSS_FORM_FILE_LOCATION	,
MAILING_CITY	,
ASSIGNED_TO	,
MODIFIED_BY	,
PHYSICAL_CITY	,
MWS_DATE	,
START_TIME	,
TRANSFERRED_TO	,
TRANSFER_REASON	,
SOURCE	,
LDSS_COMMUNICATION_FORM_SENT	,
LDSS_WORKER_ID	,
MAILING_STATE	,
BUCKET_DATE	,
HOLD_REASON	,
MY_WORKSPACE_DATE	,
TASK_STATUS	,
COMPLETIONS_BUCKET	,
T_NUMBER	,
UNIT	,
ABD_INDICATOR	,
DENIAL_REASON	,
FILEDATE	,
LDSS_2ND_COMMUNICATION_FORM_SENT	,
PREG_SWITCH	,
ANSWER	,
ASSIGNED	,
CASE_NUMBER_ASSOCIATED	,
LOCATION	,
LOG_CREATED_ON	,
SPECIALTY	,
CNAME	,
COMPLETED	,
MAILING_ZIP	,
PENDING_BUCKET	,
PHYSICAL_ADDRESS	,
TABLE_NAME	,
TRANSFERS_BUCKET	,
AVAILABLETOASSIGN	,
CASE_PUT_ON_HOLD	,
CREATED	,
PHYSICAL_STATE	,
SAME_AS_MAILING_CHKBOX	,
UPDATED	,
MAILING_ADDRESS	,
PHYSICAL_ZIP	
)
select ID	,
NOTES	,
NUM_APPLICANTS	,
SBT_BTN	,
LDSS_FORM_FILE_LOCATION	,
MAILING_CITY	,
ASSIGNED_TO	,
MODIFIED_BY	,
PHYSICAL_CITY	,
MWS_DATE	,
START_TIME	,
TRANSFERRED_TO	,
TRANSFER_REASON	,
SOURCE	,
LDSS_COMMUNICATION_FORM_SENT	,
LDSS_WORKER_ID	,
MAILING_STATE	,
BUCKET_DATE	,
HOLD_REASON	,
MY_WORKSPACE_DATE	,
TASK_STATUS	,
COMPLETIONS_BUCKET	,
T_NUMBER	,
UNIT	,
ABD_INDICATOR	,
DENIAL_REASON	,
FILEDATE	,
LDSS_2ND_COMMUNICATION_FORM_SENT	,
PREG_SWITCH	,
ANSWER	,
ASSIGNED	,
CASE_NUMBER_ASSOCIATED	,
LOCATION	,
current_timestamp() LOG_CREATED_ON	,
SPECIALTY	,
CNAME	,
COMPLETED	,
MAILING_ZIP	,
PENDING_BUCKET	,
PHYSICAL_ADDRESS	,
'intake_case_pool' TABLE_NAME	,
TRANSFERS_BUCKET	,
AVAILABLETOASSIGN	,
CASE_PUT_ON_HOLD	,
CREATED	,
PHYSICAL_STATE	,
SAME_AS_MAILING_CHKBOX	,
UPDATED	,
MAILING_ADDRESS	,
PHYSICAL_ZIP	
from coverva_mio.intake_case_pool_sync l
where not exists (select 1 from coverva_mio.intake_case_pool g where l.id = g.id);

delete from coverva_mio.intake_case_pool l
where not exists(select 1 from coverva_mio.intake_case_pool_sync s where l.id = s.id);

delete from COVERVA_MIO.case_pool d
where not exists(select 1 from COVERVA_MIO.case_pool_sync p where d.id = p.id)
and d.id != 90004;

insert into coverva_mio.page_log
select l.*,current_timestamp(),'page_log' from coverva_mio.page_log_sync l
where not exists (select 1 from coverva_mio.page_log g where l.id = g.id);

insert into coverva_mio.safe
select *,current_timestamp(),'safe'
from coverva_mio.safe_sync sn
where not exists(select 1 from coverva_mio.safe p where sn.employee_id = p.employee_id);

delete from coverva_mio.safe sn
where not exists(select 1 from coverva_mio.safe_sync p where sn.employee_id = p.employee_id);

insert into coverva_mio.upload_daily_intake
select *,current_timestamp(),'upload_daily_intake'
from coverva_mio.upload_daily_intake_sync sn
where not exists(select 1 from coverva_mio.upload_daily_intake p where sn.id = p.id);

delete from COVERVA_MIO.UPLOAD_DAILY_INTAKE d
where not exists(select 1 from COVERVA_MIO.UPLOAD_DAILY_INTAKE_sync p where d.id = p.id)

insert into coverva_mio.user_permissions
select *,current_timestamp(),'user_permissions'
from coverva_mio.user_permissions_sync sn
where not exists(select 1 from coverva_mio.user_permissions p where sn.id = p.id);

insert into coverva_mio.user_permissions_his
select *,current_timestamp(),'user_permissions_his'
from coverva_mio.user_permissions_his_sync sn
where not exists(select 1 from coverva_mio.user_permissions_his p where sn.id = p.id);

insert into coverva_mio.rpt_trending_completed_open_cases_by_day
select *,current_timestamp(),'rpt_trending_completed_open_cases_by_day'
from coverva_mio.rpt_trending_completed_open_cases_by_day_sync sn
where not exists(select 1 from coverva_mio.rpt_trending_completed_open_cases_by_day p where sn.id = p.id);

insert into coverva_mio.rpt_daily_clock_rollup
select *,current_timestamp(),'rpt_daily_clock_rollup'
from coverva_mio.rpt_daily_clock_rollup_sync sn
where not exists(select 1 from coverva_mio.rpt_daily_clock_rollup p where sn.emp_id = p.emp_id and sn.clock_date = p.clock_date);


insert into coverva_mio.rpt_touches
select l.*,current_timestamp(),'rpt_touches' from coverva_mio.rpt_touches_sync l
where not exists (select 1 from coverva_mio.rpt_touches g where l.id = g.id);

insert into coverva_mio.rpt_riva(ID,
CASE_POOL_LOG_ID,
CASE_NUMBER,
DATE_DISPOSITIONED,
CATEGORY,
EMPLOYEENAME,
SUPERVISOR,
MANAGER,
MAX_EMP_ID,
CASE_TYPE,
COMPLETIONS_BUCKET,
PENDING_BUCKET,
TRANSFERS_BUCKET,
EMPLOYEES_TABLE_ID,
UNIT,
TYPE,
UPDATED,
DURATION,
LOG_CREATED_ON,
TABLE_NAME,
DISPOSITION,
NUM_APPLICANTS,
LDAP_ID)
select ID,
CASE_POOL_LOG_ID,
CASE_NUMBER,
DATE_DISPOSITIONED,
CATEGORY,
EMPLOYEENAME,
SUPERVISOR,
MANAGER,
MAX_EMP_ID,
CASE_TYPE,
COMPLETIONS_BUCKET,
PENDING_BUCKET,
TRANSFERS_BUCKET,
EMPLOYEES_TABLE_ID,
UNIT,
TYPE,
UPDATED,
DURATION,
current_timestamp() LOG_CREATED_ON,
'rpt_riva' TABLE_NAME,
DISPOSITION,
NUM_APPLICANTS,
LDAP_ID
from coverva_mio.rpt_riva_sync s
where not exists(select 1 from coverva_mio.rpt_riva p where s.id = p.id);
DROP TABLE coverva_mio.rpt_riva_sync;

insert into coverva_mio.rpt_daily_dispositions
select ID,	
EMP_ID	,
FULLNAME,	
SUPERVISOR	,
LDAP_ID	,
CASE_NUMBER	,
TASK_STATUS	,
DENIAL_REASON	,
TRANSFERRED_TO	,
LOCATION	,
WHY	,
ADDITIONAL_CASE_OUTCOMES	,
NUMBER_APPROVED	,
VCL_DOC_TYPE_REQUESTED	,
VCL_DUE,
DISPOSITION_DATE	,
current_timestamp()	,
'rpt_daily_dispositions',
TYPE	,
TRANSFERS_BUCKET	,
PENDING_BUCKET	,
CASE_TYPE	,
UNIT	,
COMPLETIONS_BUCKET	,
PHYSICAL_ADDRESS	,
SOURCE	,
HOLD_REASON	,
APP_RECD_DATE,
MY_WORKSPACE_DATE,
MAILING_ADDRESS	,
CASE_HEAD	,
TRANSFER_REASON	,
CASE_NUMBER_ASSOCIATED,
specialty,
notes
from coverva_mio.rpt_daily_dispositions_sync sn
where not exists(select 1 from coverva_mio.rpt_daily_dispositions p where sn.id = p.id);

insert into coverva_mio.employees_his
select *,current_timestamp(),'employees_his'
from coverva_mio.employees_his_sync sn
where not exists(select 1 from coverva_mio.employees_his p where sn.id = p.id);

truncate table spanish_translation;
insert into spanish_translation(id,case_pool_id,english_to_be_translated,document_type,other_type,translation,original_assigned_to,created,modified_by,updated,table_name,log_created_on)
select id,case_pool_id,english_to_be_translated,document_type,other_type,translation,original_assigned_to,created,modified_by,updated,table_name,log_created_on
from spanish_translation_sync;

truncate table safe_manual_cases;
insert into safe_manual_cases(employee_id,assigned,case_number,created,id,log_created_on,table_name)
select employee_id,assigned,case_number,created,id,log_created_on,table_name
from safe_manual_cases_sync;


insert into coverva_mio.case_pool
(TRANSFERRED_TO	,
CASE_D_REVIEW	,
ASSIGNED	,
DENIAL_REASON	,
SBT_BTN	,
APPLICANT_NAME	,
CASE_PUT_ON_HOLD	,
VCL_DOC_TYPE_REQUESTED	,
COMPLETED	,
END_TIME	,
UNIT	,
TYPE	,
FILEDATE	,
BUCKET_DATE	,
LOCATION	,
ASSIGNED_TO	,
VALIDATOR_START_TIME	,
AGE	,
VALIDATE_BUCKET_DATE	,
VCL_DUE	,
MODIFIED_BY	,
VLD_SBT_BTN	,
CURRENT_STATE	,
AGE_BUSINESS_DAY	,
UPDATED	,
EMAIL_SENT_TO	,
APP_RECEIVED_DATE	,
NUMBER_APPROVED	,
NOTES	,
SPECIALTY	,
NOA_SENT	,
CREATED	,
TASK_STATUS	,
ADDITIONAL_CASE_OUTCOMES	,
DOC_RECEIVED	,
VALIDATOR_ASSIGNED	,
START_TIME	,
VALIDATOR_COMPLETION_BUCKET	,
VALID	,
DATE_SENT	,
LOG_CREATED_ON	,
ANSWER	,
CASE_TYPE	,
WHY	,
TRANSFERS_BUCKET	,
PENDING_BUCKET	,
QUESTION	,
CASE_NUMBER	,
TABLE_NAME	,
COMPLETIONS_BUCKET	,
OFFENDER_ID	,
ID	,
ESCALATION_REASON	,
AVAILABLETOASSIGN	,
MIO_SOURCE	,
VALIDATOR_PENDING_BUCKET	)
SELECT TRANSFERRED_TO	,
CASE_D_REVIEW	,
ASSIGNED	,
DENIAL_REASON	,
SBT_BTN	,
APPLICANT_NAME	,
CASE_PUT_ON_HOLD	,
VCL_DOC_TYPE_REQUESTED	,
COMPLETED	,
END_TIME	,
UNIT	,
TYPE	,
FILEDATE	,
BUCKET_DATE	,
LOCATION	,
ASSIGNED_TO	,
VALIDATOR_START_TIME	,
AGE	,
VALIDATE_BUCKET_DATE	,
VCL_DUE	,
MODIFIED_BY	,
VLD_SBT_BTN	,
CURRENT_STATE	,
AGE_BUSINESS_DAY	,
UPDATED	,
EMAIL_SENT_TO	,
APP_RECEIVED_DATE	,
NUMBER_APPROVED	,
NOTES	,
SPECIALTY	,
NOA_SENT	,
CREATED	,
TASK_STATUS	,
ADDITIONAL_CASE_OUTCOMES	,
DOC_RECEIVED	,
VALIDATOR_ASSIGNED	,
START_TIME	,
VALIDATOR_COMPLETION_BUCKET	,
VALID	,
DATE_SENT	,
current_timestamp() LOG_CREATED_ON	,
ANSWER	,
CASE_TYPE	,
WHY	,
TRANSFERS_BUCKET	,
PENDING_BUCKET	,
QUESTION	,
CASE_NUMBER	,
'case_pool' TABLE_NAME	,
COMPLETIONS_BUCKET	,
OFFENDER_ID	,
ID	,
ESCALATION_REASON	,
AVAILABLETOASSIGN	,
MIO_SOURCE	,
VALIDATOR_PENDING_BUCKET	
from coverva_mio.case_pool_sync sn
where not exists(select 1 from coverva_mio.case_pool p where sn.id = p.id);

truncate table coverva_mio.safe_manual_cases;
insert into coverva_mio.safe_manual_cases(employee_id,assigned,case_number,created,id,log_created_on,table_name)
select employee_id,assigned,case_number,created,id,current_timestamp(),'safe_manual_cases'
from coverva_mio.safe_manual_cases_sync;
drop table coverva_mio.safe_manual_cases_sync;