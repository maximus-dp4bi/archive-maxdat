alter session set plsql_code_type = native;

alter function GET_BUS_DATE compile;
alter function GET_INLIST_STR2 compile;	
alter function GET_INLIST_STR3 compile;
alter function GET_WEEKDAY compile;
alter procedure MAINTAIN_BPM_D_DATES compile;
alter package PROCESS_BPM_QUEUE compile;

commit;

alter session set plsql_code_type = interpreted;
