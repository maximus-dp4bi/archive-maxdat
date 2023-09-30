/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_PROCESS_APP_MI 
after update on NYEC_ETL_PROCESS_APP_MI
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 4; -- 'NYEC OPS Process Application MI'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 4; -- 'NYEC_ETL_PROCESS_APP_MI'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_current_date date := sysdate;

  v_sql_code number := null;
  v_error_message clob := null;
  
   v_end_date date:=null;
  v_app_complete_date date:=null;
  
begin

  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.CEPAM_ID;
    
    if (:new.MI_ITEM_STATUS='Unsatisfied') then
      
      begin
        
        select COMPLETE_DT 
        into v_app_complete_date
        from NYEC_ETL_PROCESS_APP
        where app_id=:new.app_id;
        
        exception
        when NO_DATA_FOUND then
        null;
      end;
      
      v_end_date:=coalesce(v_app_complete_date,BPM_COMMON.MAX_DATE);
      else if (:new.MI_ITEM_STATUS='Satisfied' or :new.MI_ITEM_STATUS='Removed') then
      v_end_date:=coalesce(:new.MI_ITEM_STATUS_DT,BPM_COMMON.MAX_DATE);
      else
      v_end_date:=BPM_COMMON.MAX_DATE;
  end if;
  end if;

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
    
  v_source_id := substr(to_char(:new.CEPAM_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,228,:old.MI_LETTER_ID,:new.MI_LETTER_ID,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,229,:old.RFE_STATUS,:new.RFE_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,230,:old.RFE_STATUS_DT,:new.RFE_STATUS_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,231,:old.MI_ITEM_STATUS,:new.MI_ITEM_STATUS,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('INSERT',v_source_id,v_bi_id,232,:old.MI_ITEM_STATUS_DT,:new.MI_ITEM_STATUS_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('INSERT',v_source_id,v_bi_id,233,:old.MI_ITEM_STATUS_PERFORMER,:new.MI_ITEM_STATUS_PERFORMER,v_bue_id);
 -- PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,234,:old.MI_ITEM_SATISFIED_CHANNEL,:new.MI_ITEM_SATISFIED_CHANNEL,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,235,:old.MI_LETTER_CYCLE_START_DT,:new.MI_LETTER_CYCLE_START_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,236,:old.MI_LETTER_CYCLE_END_DT,:new.MI_LETTER_CYCLE_END_DT,v_bue_id);
  -- PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,238,:old.REFER_TO_DISTRICT_IND,:new.REFER_TO_DISTRICT_IND,v_bue_id);-- Commented as per Elizabeth T Wright's suggestion 11/13/12
  -- PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,239,:old.REFER_TO_DISTRICT_IND_DT,:new.REFER_TO_DISTRICT_IND_DT,v_bue_id);-- Commented as per Elizabeth T Wright's suggestion 11/13/12
  -- PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,240,:old.UNDELIVERABLE_IND,:new.UNDELIVERABLE_IND,v_bue_id);-- Commented as per Elizabeth T Wright's suggestion 11/13/12
  -- PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,241,:old.UNDELIVERABLE_IND_DT,:new.UNDELIVERABLE_IND_DT,v_bue_id); -- Commented as per Elizabeth T Wright's suggestion 11/13/12
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,242,:old.MI_VALIDATED_DT,:new.MI_VALIDATED_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,420,:old.HEART_MI_DUE_DT,:new.HEART_MI_DUE_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_DATE('UPDATE',v_source_id,v_bi_id,421,:old.MAXE_MI_DUE_DT,:new.MAXE_MI_DUE_DT,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,422,:old.MI_TYPE_NAME,:new.MI_TYPE_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,423,:old.MI_LETTER_NAME,:new.MI_LETTER_NAME,v_bue_id);
  PRC_BPM_ETL_BIA_UPD_CHAR('UPDATE',v_source_id,v_bi_id,424,:old.MI_ITEM_SATISFIED_REASON,:new.MI_ITEM_SATISFIED_REASON,v_bue_id);

  commit;
  
exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := SQLERRM;
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
*/