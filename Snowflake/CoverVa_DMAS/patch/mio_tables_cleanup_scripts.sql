use schema coverva_mio;
select concat('drop table ',table_name,';') drop_stmt
, concat('select count(*) from ',table_name,';') count_stmt
from information_schema.tables
where table_schema = 'COVERVA_MIO';

truncate table coverva_mio.mio_raw_logs;
use schema coverva_mio;
drop table ADMIN_MANUALLY_ASSIGN;
drop table CALENDAR;
drop table CASE_POOL;
drop table CASE_POOL_LOG;
drop table CATE_LOOK_FACILITY;
drop table CATE_UNPROCESSED;
drop table CLOCK_PUNCHES;
drop table EMAIL_ENABLE_DISABLE;
drop table EMPLOYEES;
drop table EMPLOYEES_HIS;
drop table EMPLOYEES_HIS_LOOKUPS;
drop table EMPLOYEES_LOOK_BUILDING_LOCATION;
drop table EMPLOYEES_LOOK_CONVERSIONINITIATED;
drop table EMPLOYEES_LOOK_EMPLOYEE_STATUS;
drop table EMPLOYEES_LOOK_EMPLOYER;
drop table EMPLOYEES_LOOK_FACILITY;
drop table EMPLOYEES_LOOK_FUNCTIONAL_AREA;
drop table EMPLOYEES_LOOK_INITIAL_MAXIMUS_SYSTEMS_ACCESS;
drop table EMPLOYEES_LOOK_INITIAL_VA_SYSTEMS_ACCESS;
drop table EMPLOYEES_LOOK_JOB_TITLE;
drop table EMPLOYEES_LOOK_SCHEDULE;
drop table EMPLOYEES_LOOK_STAFFING_CATEGORY;
drop table EMPLOYEES_LOOK_TRAINING;
drop table EMPLOYEES_LOOK_TRAINING_STATUS;
drop table ETL_LOG;
drop table LOGINSOUTS;
drop table LOOK_PERMISSIONS;
drop table LOOK_TIME_CLOCK;
drop table LOOK_YESNO_REQUIRED_ENTRY;
drop table NOTIFICATIONFORM;
drop table RPT_DAILY_CLOCK_ROLLUP;
drop table RPT_DAILY_DISPOSITIONS;
drop table RPT_RIVA;
drop table RPT_TOUCHES;
drop table RPT_TRENDING_COMPLETED_OPEN_CASES_BY_DAY;
drop table SAFE;
drop table SAFE_HIS;
drop table SAFE_MANUAL_CASES;
drop table UPLOAD_COMPLETED_CASES;
drop table UPLOAD_COVER_VA_RAW;
drop table UPLOAD_EXPARTE;
drop table UPLOAD_EXTEND_PEND_LETTERS_MAILING;
drop table UPLOAD_LOOK_PROJECTS;
drop table UPLOAD_LOOK_UPLOAD_FILE_TEMPLATES;
drop table UPLOAD_PENDING_VERIFICATION_DOC_TASKS;
drop table UPLOAD_PW_EXTEND_PEND_LETTERS;
drop table UPLOAD_RENEWALS;
drop table USER_PERMISSIONS;
drop table USER_PERMISSIONS_HIS;
drop table rpt_current_worked_cases;
drop table VW_EXTERNAL_5PM_FILE_INVENTORY_EXPORT;
drop table VW_LOOK_MANAGER;
drop table VW_LOOK_SUPERVISOR;
drop table VW_SUPERVISOR_MANAGER_COMBINED;
