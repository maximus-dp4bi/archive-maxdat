use schema coverva_mio;
--created some tables manually - no data in prod
CREATE TABLE coverva_mio.upload_renewals(id number,
recip_id number,
case_id number,
vacms_enrl_id number,
case_d_review date,
file varchar,
filedate date,
createdby varchar,
created timestamp_ntz(9),
updated timestamp_ntz(9));

CREATE TABLE coverva_mio.upload_extend_pend_letters_mailing
(id number,
external_app_id varchar,
consumer_first_name varchar,
consumer_last_name varchar,
address_street varchar,
address_city varchar,
address_state varchar,
address_zip varchar,
written_language varchar,
app_type varchar,
file varchar,
filedate date,
createdby varchar,
created timestamp_ntz(9),
updated timestamp_ntz(9));

CREATE TABLE coverva_mio.notificationform
(id number,
 date_created timestamp_ntz(9),
 date_updated timestamp_ntz(9),
 outage_type varchar,
 outage_start timestamp_ntz(9),
 outage_end timestamp_ntz(9),
 outage_id varchar,
 impact varchar,
 incident_no varchar,
 acknowledged timestamp_ntz(9),
 issue_description varchar,
 modified_by varchar,
 created_by varchar);

alter table ADMIN_MANUALLY_ASSIGN add primary key(maxid);
alter table CALENDAR add primary key(date);
alter table CASE_POOL add primary key(id);
alter table CASE_POOL_LOG add primary key(id);
alter table CATE_LOOK_FACILITY add primary key(id);
alter table CATE_UNPROCESSED add primary key(id);
alter table CLOCK_PUNCHES add primary key(id);
alter table EMAIL_ENABLE_DISABLE add primary key(id);
alter table EMPLOYEES add primary key(id);
alter table EMPLOYEES_HIS add primary key(id);
alter table EMPLOYEES_HIS_LOOKUPS add primary key(id);
alter table EMPLOYEES_LOOK_BUILDING_LOCATION add primary key(id);
alter table EMPLOYEES_LOOK_CONVERSIONINITIATED add primary key(id);
alter table EMPLOYEES_LOOK_EMPLOYEE_STATUS add primary key(id);
alter table EMPLOYEES_LOOK_EMPLOYER add primary key(id);
alter table EMPLOYEES_LOOK_FACILITY add primary key(id);
alter table EMPLOYEES_LOOK_FUNCTIONAL_AREA add primary key(id);
alter table EMPLOYEES_LOOK_INITIAL_MAXIMUS_SYSTEMS_ACCESS add primary key(id);
alter table EMPLOYEES_LOOK_INITIAL_VA_SYSTEMS_ACCESS add primary key(id);
alter table EMPLOYEES_LOOK_JOB_TITLE add primary key(id);
alter table EMPLOYEES_LOOK_SCHEDULE add primary key(id);
alter table EMPLOYEES_LOOK_STAFFING_CATEGORY add primary key(id);
alter table EMPLOYEES_LOOK_TRAINING add primary key(id);
alter table EMPLOYEES_LOOK_TRAINING_STATUS add primary key(id);
alter table ETL_LOG add primary key(id);
alter table LOGINSOUTS add primary key(id);
alter table LOOK_PERMISSIONS add primary key(id);
alter table LOOK_TIME_CLOCK add primary key(id);
alter table LOOK_YESNO_REQUIRED_ENTRY add primary key(id);
alter table NOTIFICATIONFORM add primary key(id); --not in dev, no data in source
alter table RPT_DAILY_CLOCK_ROLLUP add primary key(clock_date,emp_id);
alter table RPT_DAILY_DISPOSITIONS add primary key(id);
alter table RPT_RIVA add primary key(id);
alter table RPT_TOUCHES add primary key(id);
alter table RPT_TRENDING_COMPLETED_OPEN_CASES_BY_DAY add primary key(id);
alter table RPT_CURRENT_WORKED_CASES add primary key(id);
alter table SAFE add primary key(employee_id);
alter table SAFE_HIS add primary key(id);
alter table SAFE_MANUAL_CASES add primary key(id); --not in dev, no data in source
alter table UPLOAD_COMPLETED_CASES add primary key(id);
alter table UPLOAD_COVER_VA_RAW add primary key(id);
alter table UPLOAD_EXPARTE add primary key(id);
alter table UPLOAD_EXTEND_PEND_LETTERS_MAILING add primary key(id); --not in dev, no data in source
alter table UPLOAD_LOOK_PROJECTS add primary key(id);
alter table UPLOAD_LOOK_UPLOAD_FILE_TEMPLATES add primary key(id);
alter table UPLOAD_PENDING_VERIFICATION_DOC_TASKS add primary key(id);
alter table UPLOAD_PW_EXTEND_PEND_LETTERS add primary key(id);
alter table UPLOAD_RENEWALS add primary key(id);
alter table USER_PERMISSIONS add primary key(id);
alter table USER_PERMISSIONS_HIS add primary key(id);
alter table coverva_mio.page_log add primary key(id);
alter table coverva_mio.intake_case_pool add primary key(id);
alter table coverva_mio.intake_case_pool_log add primary key(id);
alter table coverva_mio.upload_daily_intake add primary key(id);
alter table COVERVA_MIO.ALLOCATION_TOOL add primary key (id);
alter table COVERVA_MIO.ESCALATED_INQUIRIES add primary key (id);
alter table COVERVA_MIO.HELP_DESK add primary key (id);


grant select on all tables in schema coverva_mio to role mars_dp4bi_prod_read;