alter session set current_schema = MAXDAT;

alter table corp_etl_proc_letters         add (CREATION_GROUP number(18,0));
alter table corp_etl_proc_letters_oltp    add (CREATION_GROUP number(18,0));
alter table corp_etl_proc_letters_wip_bpm add (CREATION_GROUP number(18,0));
alter table letters_stg                   add (CREATION_GROUP number(18,0));