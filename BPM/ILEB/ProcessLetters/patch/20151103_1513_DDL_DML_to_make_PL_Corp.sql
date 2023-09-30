/*
Created by Raj A. 10/28/2015
Description:
Making ILEB a Corp script. Refer to the master ticket, NYHIX-18388, if needed.
Refer to MAXDAT-2773 for TNRD PL.
*/
alter table CORP_ETL_PROC_LETTERS
add (
  material_request_id       NUMBER(18,0),
  family_member_count       NUMBER(18,0),
  aian_member_count         NUMBER(18,0)
 );
 
 alter table CORP_ETL_PROC_LETTERS_OLTP
add (
  material_request_id       NUMBER(18,0),
  family_member_count       NUMBER(18,0),
  aian_member_count         NUMBER(18,0)
 );
 
 alter table CORP_ETL_PROC_LETTERS_WIP_BPM
add (
  material_request_id       NUMBER(18,0),
  family_member_count       NUMBER(18,0),
  aian_member_count         NUMBER(18,0)
 );
 
 alter table D_PL_CURRENT
add (
  material_request_id       NUMBER(18,0),
  family_member_count       NUMBER(18,0),
  aian_member_count         NUMBER(18,0)
 );
 
ALTER TABLE letters_stg                   MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters         MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_oltp    MODIFY letter_type VARCHAR2(4000);
ALTER TABLE corp_etl_proc_letters_wip_bpm MODIFY letter_type VARCHAR2(4000);
ALTER TABLE d_pl_current                  MODIFY letter_type VARCHAR2(4000);

ALTER TABLE d_pl_current                  MODIFY sla_category VARCHAR2(4000); 

ALTER TABLE letters_stg                   MODIFY letter_status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters         MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_oltp    MODIFY status VARCHAR2(256);
ALTER TABLE corp_etl_proc_letters_wip_bpm MODIFY status VARCHAR2(256);
ALTER TABLE d_pl_current                  MODIFY letter_status VARCHAR2(256);
ALTER TABLE D_PL_LETTER_STATUS            MODIFY letter_status varchar2(256);

--This will be a Corp global control variable for Letters_STG table.
insert into CORP_ETL_CONTROL(name,VALUE_TYPE,value,DESCRIPTION,CREATED_TS,UPDATED_TS) 
values ('LETTERS_STG_LOOK_BACK_DAYS','N','2','Number of days to look back when inserting/updating letters so records will not be missed',sysdate,sysdate);

commit;
