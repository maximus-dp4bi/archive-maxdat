alter table corp_etl_proc_letters
modify (cancel_reason varchar2(100));

alter table  CORP_ETL_PROC_LETTERS_OLTP
modify (cancel_reason varchar2(100));

alter table  CORP_ETL_PROC_LETTERS_OLTP_T
modify (cancel_reason varchar2(100));

alter table  CORP_ETL_PROC_LETTERS_WIP_BPM
modify (cancel_reason varchar2(100));

alter table  CORP_ETL_PROC_LETTERS_WIP_T  
modify (cancel_reason varchar2(100));

alter table d_pl_current
modify (cancel_reason varchar2(100));
