REMARK This will run the scripts in COEB\EMRS dir
REMARK Change dir value below to point to your project and uncomment

define dir = C:\Soundra\Maxdatsvn\BPM\NCEB\createdb\EMRS
column schema_name_col new_value schema_name noprint
column schemadatelimit_col new_value schemadatelimit noprint
column Dataset new_value Dataset_name print
select case when sys.database_name in ('NCEBUAT','NCEBDEV') then '4/1/2019' else '6/28/2019' end schemadatelimit_col from dual;
select 'EB' schema_name_col from dual;
select 'CC Back office' as Dataset from dual;
@&dir\EMRS_D_CALL_RECORD_SV.sql
@&dir\EMRS_F_CALL_ACTIVITY_SV.sql

select 'Chat Views' as Dataset from dual;
@&dir\EMRS_D_CHAT_REASON_SV.sql
@&dir\EMRS_F_CHAT_ACTIVITY_SV.sql

select 'Enroll Views' as Dataset from dual;
@&dir\EMRS_D_SELECTION_TRANS_SV.sql
REMARK Seed view should not be dropped and recreated everytime. Instead it should be refreshed
REMARK @&dir\EMRS_F_ENROLL_ACTIVITY_STUB_MV.sql
@&dir\EMRS_F_ENROLL_ACTIVITY_CNT_SV_Latest.sql
exit