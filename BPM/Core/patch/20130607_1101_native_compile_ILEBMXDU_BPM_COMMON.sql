alter session set plsql_code_type = native;

alter package BPM_COMMON compile;

commit;

alter session set plsql_code_type = interpreted;
