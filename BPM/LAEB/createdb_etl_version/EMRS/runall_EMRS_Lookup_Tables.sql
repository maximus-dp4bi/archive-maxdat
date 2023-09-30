--------------------------------------------------------
--  Deploy EMRS tables 
--------------------------------------------------------
column tablespacen new_value tablespace_name noprint 
select 'MAXDAT_LAEB_DATA' tablespacen from dual;
column role_nm new_value role_name noprint
select 'MAXDAT_LAEB_READ_ONLY' role_nm from dual;
@@EMRS_D_ADDRESS_TYPE.sql
@@EMRS_D_AID_CATEGORY.sql
@@EMRS_D_BENEFITS_PACKAGE.sql
@@EMRS_D_CARE_SERV_DELIV_AREA.sql
@@EMRS_D_CASE_STATUS.sql
@@EMRS_D_CHANGE_REASON.sql
@@EMRS_D_CHANNEL.sql
@@EMRS_D_CITIZENSHIP_STATUS.sql
@@EMRS_D_CLIENT_TYPE.sql
@@EMRS_D_COA.sql
@@EMRS_D_COUNTY.sql
@@EMRS_D_ELIGIBILITY_STATUS.sql
@@EMRS_D_ENROLLMENT_ERROR_CD.sql
@@EMRS_D_ENROLLMENT_STATUS.sql
@@EMRS_D_ENROLL_TRANS_TYPE.sql
@@EMRS_D_ENROLL_TYPE.sql
@@EMRS_D_ETHNICITY.sql
@@EMRS_D_GENDER.sql
@@EMRS_D_LANGUAGE.sql
@@EMRS_D_MARITAL_STATUS.sql
@@EMRS_D_MI_TYPE.sql
@@EMRS_D_OVERRIDE_REASONS.sql
@@EMRS_D_PHONE_TYPE.sql
@@EMRS_D_PLAN.sql
@@EMRS_D_PLAN_SERVICE_TYPE.sql
@@EMRS_D_PLAN_TYPE.sql
@@EMRS_D_PROGRAM.sql
@@EMRS_D_PROVIDER_SPEC_CD.sql
@@EMRS_D_PROVIDER_TYPE.sql
@@EMRS_D_RACE.sql
@@EMRS_D_REGION.sql
@@EMRS_D_RELATIONSHIP.sql
@@EMRS_D_SELECTION_REASON.sql
@@EMRS_D_SELECTION_SOURCE.sql
@@EMRS_D_SELECTION_STATUS.sql
@@EMRS_D_SUBPROGRAM_CATEGORY.sql
@@EMRS_D_SUB_PROGRAM.sql
@@EMRS_D_TERMINATION_REASON.sql
@@EMRS_D_TYPE_CASE.sql
@@EMRS_D_ZIP_LOCATIONS.sql
@@EMRS_D_ZIPCODE.sql
@@ins_lookup_table_values.sql
@@insert_EMRS_D_ZIP_LOCATIONS.sql
@@EMRS_S_TABLES.sql
@@EMRS_D_TABLES.sql
@@EMRS_D_VIEWS.sql
@@EMRS_ERR_TABLES.sql
@@EMRS_CONTROL.sql
@@ERMS_Insert_Update_table_pkg.sql
