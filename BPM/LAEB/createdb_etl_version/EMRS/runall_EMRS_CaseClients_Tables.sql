--------------------------------------------------------
--  Deploy EMRS tables 
--------------------------------------------------------
column tablespacen new_value tablespace_name noprint 
select 'MAXDAT_LAEB_DATA' tablespacen from dual;
column role_nm new_value role_name noprint
select 'MAXDAT_LAEB_READ_ONLY' role_nm from dual;
@@EMRS_D_OTHER_HEALTH_CARE.sql
@@D_CLIENT_ELIGIBILITY.sql
@@EMRS_D_ADDRESS.sql
@@EMRS_D_ALERT.sql
@@EMRS_D_CASE.sql
@@EMRS_D_CASE_CLIENT.sql
@@EMRS_D_CLIENT_ELIGIBILITY.sql
@@EMRS_D_CLIENT.sql
@@EMRS_D_CLIENT_SUPPLEMENTARY_INFO.sql
@@EMRS_D_PHONE.sql
@@EMRS_D_CLIENT_ENROLL_STATUS.sql
@@EMRS_D_ELIG_SEGMENT_DETAILS.sql
@@EMRS_D_CLIENT_CCM_SV.sql
@@EMRS_D_CLIENT_ELIG_OUTCOME_SV.sql
@@EMRS_D_CLIENT_ELIGIBILITY_SV.sql
@@LTC_MEMBER_ENROLLMENT_SV.sql
@@EMRS_LAEB_ELIG_ETL_PKG.sql
@@EMRS_D_CASE_MAIL_ADDRESS_SV.sql
@@EMRS_D_CASE_RES_ADDRESS_SV.sql
@@EMRS_D_CLIENT_MAIL_ADDRESS_SV.sql
@@EMRS_D_CLIENT_RES_ADDRESS_SV.sql
@@populate_corp_etl_control_eligvar.sql
@@EMRS_LAEB_CASE_CLIENT_ETL_PKG.sql
@@001_alter_table_EMRS_D_ADDRESS.sql
@@001_alter_table_EMRS_D_ALERT.sql
@@001_alter_table_EMRS_D_CASE.sql
@@001_alter_table_EMRS_D_CASE_CLIENT.sql
@@001_alter_table_EMRS_D_CLIENT.sql
@@001_alter_table_EMRS_D_CLIENT_SUPPLEMENTARY_INFO.sql
@@001_alter_table_EMRS_D_PHONE.sql
@@001_alter_table_EMRS_S_ADDRESS_STG.sql
@@001_alter_table_EMRS_S_ALERT_STG.sql
@@001_alter_table_EMRS_S_CASE_CLIENT_STG.sql
@@001_alter_table_EMRS_S_CASES_STG.sql
@@001_alter_table_EMRS_S_CLIENT_STG.sql
@@001_alter_table_EMRS_S_CLIENT_SUPPLEMENTARY_INFO_STG.sql
@@001_alter_table_EMRS_S_PHONE_STG.sql
@@001_insert_CORP_ETL_CONTROL.sql
