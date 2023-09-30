/*
Created on 09-Oct-2013 by Raj A.
Team: MAXDAT.
Business Process: Manage Enrollment Activity.
*/
create index IDX_CL_ENRL_plan_type_cd on client_enroll_status_stg(plan_type_cd);

CREATE INDEX IDX_SEL_create_dt ON SELECTION_TXN_STG(create_ts);
CREATE INDEX IDX_SEL_STATUS_CD ON SELECTION_TXN_STG(STATUS_CD);
CREATE INDEX IDX_SEL_UPDATE_TS ON SELECTION_TXN_STG(UPDATE_TS);
CREATE INDEX IDX_SEL_source_cd ON SELECTION_TXN_STG(selection_source_cd);

CREATE INDEX IDX_PLAN_TYPE         ON CORP_ETL_MANAGE_ENROLL_OLTP(PLAN_TYPE);
CREATE INDEX IDX_SEL_auto_proc     ON CORP_ETL_MANAGE_ENROLL_OLTP(slct_auto_proc);
CREATE INDEX IDX_CEME_AGE_BUS_DAYS ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_BUSINESS_DAYS);
CREATE INDEX IDX_CEME_AGE_CAL_DAYS ON CORP_ETL_MANAGE_ENROLL_OLTP (AGE_IN_CALENDAR_DAYS);