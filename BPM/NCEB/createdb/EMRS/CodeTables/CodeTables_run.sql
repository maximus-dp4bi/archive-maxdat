REMARK This will run the scripts in NCEB\EMRS\CodeTables dir
REMARK set EMRS script dir below
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\NCEB\createdb\EMRS\CodeTables
column schema_name_col new_value schema_name noprint
select 'EB' schema_name_col from dual;
@&dir\D_CALL_ACTION_REFERRAL_SV.sql
@&dir\EMRS_D_ACTIVITY_STATUS_SV.sql
@&dir\EMRS_D_CALL_REASON_SV.sql
@&dir\EMRS_D_CALL_TYPE_SV.sql
@&dir\EMRS_D_CARE_SERV_DELIV_AREA_SV.sql
@&dir\EMRS_D_COUNTY_SV.sql
@&dir\EMRS_D_DISENROLL_REASON_SV.sql
@&dir\EMRS_D_DISENROLL_TYPE_SV.sql
@&dir\EMRS_D_LANGUAGE_SV.sql
@&dir\EMRS_D_MANAGED_CARE_STATUS_SV.sql
@&dir\EMRS_D_PLAN_SV.sql
@&dir\EMRS_D_PLAN_TYPE_SV.sql
@&dir\EMRS_D_PROGRAM_SV.sql
@&dir\EMRS_D_SELECTION_SOURCE_SV.sql
exit
