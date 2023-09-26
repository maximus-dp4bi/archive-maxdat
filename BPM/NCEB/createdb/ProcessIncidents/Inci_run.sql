REMARK This will run the scripts in NCEB/Process Incidents dir
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\NCEB\createdb\Process Incidents
column schema_name_col new_value schema_name noprint
column schemadatelimit_col new_value schemadatelimit noprint
column Dataset new_value Dataset_name print
select case when sys.database_name in ('NCEBUAT','NCEBDEV') then '4/1/2019' else '6/28/2019' end schemadatelimit_col from dual;
select 'EB' schema_name_col from dual;
select 'Incidents' as Dataset from dual;
@"&dir\D_PI_INCIDENT_ABOUT_SV.sql"
@"&dir\D_PI_INCIDENT_REASON_SV.sql"
@"&dir\D_PI_INCIDENT_STATUS_SV.sql"
@"&dir\D_PI_PLAN_SV.sql"
@"&dir\D_PI_CURRENT_SV.sql"
@"&dir\F_PI_BY_DATE_SV.sql"
exit