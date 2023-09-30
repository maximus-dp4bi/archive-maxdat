REMARK This will run the scripts in COEB\EMRS dir
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\NOETL1\createdb\EMRS
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
exit