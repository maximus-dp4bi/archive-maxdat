REMARK This will run the scripts in COEB\EMRS dir
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\COEB\createdb\EMRS
column schema_name_col new_value schema_name noprint
select case when sys.database_name = 'COEBMXD' then 'EB_CO_DEV' else 'EB' end schema_name_col from dual;
@&dir\EMRS_D_ADDRESS_SV.sql
@&dir\EMRS_D_ALERT_SV.sql
@&dir\EMRS_D_CASE_ADDRESS_SV.sql
@&dir\EMRS_D_CASE_BUSINESS_PHONE_SV.sql
@&dir\EMRS_D_CASE_CLIENT.sql
@&dir\EMRS_D_CASE_HOME_PHONE_SV.sql
@&dir\EMRS_D_CASE_MISC_1_PHONE_SV.sql
@&dir\EMRS_D_CASE_MISC_2_PHONE_SV.sql
@&dir\EMRS_D_CASE_MOBILE_PHONE_SV.sql
@&dir\EMRS_D_CASE_SV.sql
@&dir\EMRS_D_CLIENT_ADDRESS_SV.sql
@&dir\EMRS_D_CLIENT_BUSINESS_PHONE_SV.sql
@&dir\EMRS_D_CLIENT_ENRL_STATUS_SV.sql
@&dir\EMRS_D_CLIENT_HOME_PHONE_SV.sql
@&dir\EMRS_D_CLIENT_MISC_1_PHONE_SV.sql
@&dir\EMRS_D_CLIENT_MISC_2_PHONE_SV.sql
@&dir\EMRS_D_CLIENT_MOBILE_PHONE_SV.sql
@&dir\EMRS_D_CLIENT_PLAN_ELIG_SV.sql
@&dir\EMRS_D_CLIENT_SV.sql
@&dir\EMRS_D_PROVIDER_SPECIALTY_SV.sql
@&dir\EMRS_D_PROVIDER_SV.sql
@&dir\EMRS_D_SELECTION_MI_SV.sql
@&dir\EMRS_D_SELECTION_RES_ADDR_SV.sql
@&dir\EMRS_D_SELECTION_TRANS_SV.sql
@&dir\EMRS_F_ENROLLMENT_SV.sql
@&DIR\EMRS_D_CALL_RECORD_SV.sql
@&DIR\EMRS_F_ENROLL_ACTIVITY_SV.sql
@&DIR\EMRS_D_CLIENT_PLAN_SV.sql
@&DIR\EMRS_F_TRANSFER_START_CNT_SV
@&DIR\EMRS_F_ENRL_MONTH_CNT_SV.sql
exit