REMARK This will run the scripts in COEB\EMRS\CodeTables dir
REMARK set EMRS script dir below
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\COEB\createdb\EMRS\CodeTables
column schema_name_col new_value schema_name noprint
select case when sys.database_name = 'COEBMXD' then 'EB_CO_DEV' else 'EB' end schema_name_col from dual;
@&dir\EMRS_D_ADDR_TYPE.sql
@&dir\EMRS_D_AID_CATEGORY_SV.sql
@&dir\EMRS_D_BENEFITS_PACKAGE_SV.sql
@&dir\EMRS_D_CARE_SERV_DELIV_AREA_SV.sql
@&dir\EMRS_D_COEB_PROV_ORG_SV.sql
@&dir\EMRS_D_COEB_PROVIDER_SV.sql
@&dir\EMRS_D_CASE_STATUS_SV.sql
@&dir\EMRS_D_CHANGE_REASON_SV.sql
@&dir\EMRS_D_CITIZENSHIP_STATUS_SV.sql
@&dir\EMRS_D_CLIENT_TYPE_SV.sql
@&dir\EMRS_D_COUNTY_SV.sql
@&dir\EMRS_D_ELIG_STATUS_SV.sql
@&dir\EMRS_D_ENROLLMENT_ERROR_CD_SV.sql
@&dir\EMRS_D_ENROLLMENT_STATUS_SV.sql
@&dir\EMRS_D_ENROLL_TRANS_TYPE_SV.sql
@&dir\EMRS_D_ETHNICITY_SV.sql
@&dir\EMRS_D_GENDER_SV.sql
@&dir\EMRS_D_LANGUAGE_SV.sql
@&dir\EMRS_D_MARITAL_STATUS_SV.sql
@&dir\EMRS_D_MI_TYPE_SV.sql
@&dir\EMRS_D_OVERRIDE_REASONS_SV.sql
@&dir\EMRS_D_PHONE_TYPE_SV.sql
@&dir\EMRS_D_PLAN_SERVICE_TYPE_SV.sql
@&dir\EMRS_D_PLAN_SV.sql
@&dir\EMRS_D_PLAN_TYPE_SV.sql
@&dir\EMRS_D_PROGRAM_SV.sql
@&dir\EMRS_D_PROGRAM_TYPE_SV.sql
@&dir\EMRS_D_PROVIDER_SPEC_CD_SV.sql
@&dir\EMRS_D_PROVIDER_TYPE_SV.sql
@&dir\EMRS_D_RACE_SV.sql
@&dir\EMRS_D_RELATIONSHIP_SV.sql
@&dir\EMRS_D_SELECTION_REASON_SV.sql
@&dir\EMRS_D_SELECTION_SOURCE_SV.sql
@&dir\EMRS_D_SELECTION_STATUS_SV.sql
@&dir\EMRS_D_SUB_PROGRAM_SV.sql
@&dir\EMRS_D_TERMINATION_REASON_SV.sql
@&dir\EMRS_D_ZIPCODE_SV.sql
exit
