REMARK This will run the scripts in COEB\EMRS dir
REMARK Change dir value below to point to your project and uncomment

define dir = "C:\Soundra\Maxdatsvn\BPM\NCEB\createdb\Web Surveys"
column schema_name_col new_value schema_name noprint
column schemadatelimit_col new_value schemadatelimit noprint
column Dataset new_value Dataset_name print
select case when sys.database_name in ('NCEBUAT','NCEBDEV') then '4/1/2019' else '6/28/2019' end schemadatelimit_col from dual;
select 'EB' schema_name_col from dual;
select 'Survey' as Dataset from dual;
@"&dir\D_SURVEY_ANSWERS_SV.sql"
@"&dir\D_SURVEY_QUESTIONS_SV.sql"
@"&dir\F_SURVEY_CNT_SV.sql"
@"&dir\F_SURVEY_RESPONSE_CNT_SV.sql"
exit