update CORP_ETL_PROC_LETTERS_OLTP
set STATUS = substr(STATUS,1,64);

update CORP_ETL_PROC_LETTERS_WIP_BPM
set STATUS = substr(STATUS,1,64);

commit;

alter table CORP_ETL_PROC_LETTERS_OLTP modify (STATUS varchar2(64));
alter table CORP_ETL_PROC_LETTERS_WIP_BPM modify (STATUS varchar2(64));