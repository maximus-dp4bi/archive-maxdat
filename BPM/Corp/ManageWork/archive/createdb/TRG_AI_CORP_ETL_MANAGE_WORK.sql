/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace
trigger TRG_AI_CORP_ETL_MANAGE_WORK
after insert on CORP_ETL_MANAGE_WORK
for each row

declare
  
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_end_date date := coalesce(:new.COMPLETE_DATE,:new.CANCEL_WORK_DATE);
  v_current_date date := sysdate;

begin
  
  v_bi_id := SEQ_BI_ID.nextval;
  
  insert into BPM_INSTANCE 
    (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
     START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
  values
    (v_bi_id,v_bem_id,to_char(:new.TASK_ID),3,v_bsl_id,
    :new.CREATE_DATE,v_end_date,to_char(:new.CEMW_ID),v_current_date,v_current_date);

  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 1,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 3,null,     :new.CANCEL_WORK_DATE,null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 5,null,     :new.COMPLETE_DATE,null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 7,null,     :new.CREATE_DATE,null,:new.CREATE_DATE,v_max_date,v_bue_id);    
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 8,null,null,:new.CREATED_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id, 9,null,null,:new.ESCALATED_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);      
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,10,null,null,:new.ESCALATED_TO_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,11,null,null,:new.FORWARDED_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,12,null,null,:new.FORWARDED_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,13,null,null,:new.GROUP_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,14,null,null,:new.GROUP_PARENT_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,15,null,null,:new.GROUP_SUPERVISOR_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,17,null,null,:new.LAST_UPDATE_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,18,null,     :new.LAST_UPDATE_DATE,null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,19,null,null,:new.OWNER_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,20,          :new.SLA_DAYS,null,null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,21,null,null,:new.SLA_DAYS_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id);     
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,22,          :new.SLA_JEOPARDY_DAYS,null,null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,23,          :new.SLA_TARGET_DAYS,null,null,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,24,          :new.SOURCE_REFERENCE_ID,null,null,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,25,null,null,:new.SOURCE_REFERENCE_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,26,          :new.STATUS_AGE_IN_BUS_DAYS,null,null,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,28,null,     :new.STATUS_DATE,null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,29,          :new.TASK_ID,null,null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,30,null,null,:new.TASK_STATUS,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,31,null,null,:new.TASK_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,32,null,null,:new.TEAM_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,33,null,null,:new.TEAM_PARENT_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,34,null,null,:new.TEAM_SUPERVISOR_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,36,null,null,:new.UNIT_OF_WORK,:new.CREATE_DATE,v_max_date,v_bue_id); 
     
end;
/

alter session set plsql_code_type = interpreted;
*/