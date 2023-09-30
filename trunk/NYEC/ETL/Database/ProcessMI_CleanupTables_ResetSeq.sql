/*
Created by Raj A. on 23-Aug-2012.
Description:
Before the One-time run of the ETL, run this script to clean the tables for Initial load.
*/
truncate table process_mi_stg;
truncate table nyec_etl_process_mi;

drop sequence maxdat.seq_pms_id;
-- Create sequence 
create sequence MAXDAT.SEQ_PMS_ID
minvalue 1
maxvalue 9999999999999999999999999999
start with 1
increment by 1
cache 20;

alter trigger maxdat.pro_mi_stg_trg compile;