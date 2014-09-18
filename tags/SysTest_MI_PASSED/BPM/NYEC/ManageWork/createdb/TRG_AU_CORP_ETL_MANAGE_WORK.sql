alter session set plsql_code_type = native;

create or replace
trigger TRG_AU_CORP_ETL_MANAGE_WORK 
after update on CORP_ETL_MANAGE_WORK
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id number := null;
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
  v_bia_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');

  v_sql_code number := null;
  v_error_message varchar2(500) := null;
  
  v_end_date date := coalesce(:new.COMPLETE_DATE,:new.CANCEL_WORK_DATE);
  v_current_date date := sysdate;
  
begin
  
  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.CEMW_ID;

  if v_end_date is not null then
    update BPM_INSTANCE
    set
      END_DATE = v_end_date,
      LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  else
    update BPM_INSTANCE
    set LAST_UPDATE_DATE = v_current_date
    where BI_ID = v_bi_id;
  end if;

  commit;

  v_bue_id := SEQ_BUE_ID.nextval;
  
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');
  
  v_source_id := substr(to_char(:new.CEMW_ID),1,100);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,  1,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,  3,:old.CANCEL_WORK_DATE,:new.CANCEL_WORK_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,  5,:old.COMPLETE_DATE,:new.COMPLETE_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,  9,:old.ESCALATED_FLAG,:new.ESCALATED_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 10,:old.ESCALATED_TO_NAME,:new.ESCALATED_TO_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 11,:old.FORWARDED_BY_NAME,:new.FORWARDED_BY_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 12,:old.FORWARDED_FLAG,:new.FORWARDED_FLAG,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 13,:old.GROUP_NAME,:new.GROUP_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 14,:old.GROUP_PARENT_NAME,:new.GROUP_PARENT_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 15,:old.GROUP_SUPERVISOR_NAME,:new.GROUP_SUPERVISOR_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 17,:old.LAST_UPDATE_BY_NAME,:new.LAST_UPDATE_BY_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id, 18,:old.LAST_UPDATE_DATE,:new.LAST_UPDATE_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 19,:old.OWNER_NAME,:new.OWNER_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 20,:old.SLA_DAYS,:new.SLA_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 21,:old.SLA_DAYS_TYPE,:new.SLA_DAYS_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 22,:old.SLA_JEOPARDY_DAYS,:new.SLA_JEOPARDY_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 23,:old.SLA_TARGET_DAYS,:new.SLA_TARGET_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 24,:old.SOURCE_REFERENCE_ID,:new.SOURCE_REFERENCE_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 25,:old.SOURCE_REFERENCE_TYPE,:new.SOURCE_REFERENCE_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id, 26,:old.STATUS_AGE_IN_BUS_DAYS,:new.STATUS_AGE_IN_BUS_DAYS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id, 28,:old.STATUS_DATE,:new.STATUS_DATE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 30,:old.TASK_STATUS,:new.TASK_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 31,:old.TASK_TYPE,:new.TASK_TYPE,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 32,:old.TEAM_NAME,:new.TEAM_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 33,:old.TEAM_PARENT_NAME,:new.TEAM_PARENT_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id, 34,:old.TEAM_SUPERVISOR_NAME,:new.TEAM_SUPERVISOR_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id, 36,:old.UNIT_OF_WORK,:new.UNIT_OF_WORK,v_bue_id);

  commit;
  
exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500);
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS 
      (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID,
       ERROR_NUMBER,ERROR_MESSAGE) 
    values 
      (v_be_id,v_current_date,$$PLSQL_UNIT,v_source_id,v_bi_id,v_bia_id,
       v_sql_code,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');
  
end;
/

alter session set plsql_code_type = interpreted;