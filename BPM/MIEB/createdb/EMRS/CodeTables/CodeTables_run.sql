REMARK This will run the scripts in MIEB\EMRS\CodeTables dir
REMARK set EMRS script dir below

define dir = C:\Soundra\MaxDatsvn\BPM\MIEB\createdb\EMRS\CodeTables
@&dir\EMRS_D_AA_CONTRACT_SV.sql
@&dir\EMRS_D_AA_COUNTYCONTRACT_SV.sql
@&dir\EMRS_D_AID_CATEGORY_SV.sql
@&dir\EMRS_D_CHANGE_REASON_SV.sql
@&dir\EMRS_D_CITIZENSHIP_STATUS_SV.sql
@&dir\EMRS_D_CLIENT_ENRL_STATUS_SV.sql
@&dir\EMRS_D_COUNTY_SV.sql
@&dir\EMRS_D_COVERAGE_CATEGORY_SV.sql
@&dir\EMRS_D_DATE_PERIOD_SV.sql
@&dir\EMRS_D_ENROLLMENT_STATUS_SV.sql
@&dir\EMRS_D_ENROLL_ACTION_STATUS_SV.sql
@&dir\EMRS_D_FEDERAL_POVERTY_LVL_SV.sql
@&dir\EMRS_D_LANGUAGE_SV.sql
@&dir\EMRS_D_PLAN_SUBPROGRAM_SV.sql
@&dir\EMRS_D_PLAN_SV.sql
@&dir\EMRS_D_PLAN_TYPE_SV.sql
@&dir\EMRS_D_POVERTY_LVL_SV.sql
@&dir\EMRS_D_PROGRAM_SV.sql
@&dir\EMRS_D_PROVIDER_REF_SV.sql
@&dir\EMRS_D_PROVIDER_SPECIALTY_SV.sql
@&dir\EMRS_D_PROVIDER_SPEC_CD_SV.sql
@&dir\EMRS_D_PROVIDER_SV.sql
@&dir\EMRS_D_PROVIDER_TYPE_SV.sql
@&dir\EMRS_D_RACE_SV.sql
@&dir\EMRS_D_REJECTION_ERROR_RSN_SV.sql
@&dir\EMRS_D_RISK_GROUP_SV.sql
@&dir\EMRS_D_SELECTION_REASON_SV.sql
@&dir\EMRS_D_SELECTION_SOURCE_SV.sql
@&dir\EMRS_D_SELECTION_STATUS_SV.sql
@&dir\EMRS_D_STATUS_IN_GROUP_SV.sql
@&dir\EMRS_D_SUB_PROGRAM_SV.sql
@&dir\EMRS_D_TERMINATION_REASON_SV.sql
@&dir\EMRS_D_TIME_PERIOD_SV.sql
@&dir\EMRS_D_ZIPCODE_SV.sql
exit