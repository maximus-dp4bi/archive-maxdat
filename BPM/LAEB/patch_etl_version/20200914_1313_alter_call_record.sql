alter session set current_schema = MAXDAT_LAEB;

ALTER TABLE s_call_record_stg MODIFY CALLER_LAST_NAME VARCHAR2(60);
ALTER TABLE d_call_record MODIFY CALLER_LAST_NAME VARCHAR2(60);
