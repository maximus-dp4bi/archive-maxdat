/* Obsolete - No longer kept up to date. */
/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AU_NYEC_ETL_SNDIFOTRDPTNR 
after update on NYEC_ETL_SENDINFOTRADPART
for each row

declare
  pragma autonomous_transaction;
  
  v_be_id   number := null;
  v_bem_id  number := 8; -- 'NYEC OPS Send Info to TP'
  v_bi_id   number := null;
  v_bia_id  number := null;
  v_bsl_id  number := 8; -- 'NYEC_ETL_SENDINFOTRADPART'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_source_id varchar2(100) := null;
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
  v_current_date date := sysdate;

  v_sql_code number := null;
  v_error_message clob := null;
  
begin

  select BI_ID into v_bi_id
  from BPM_INSTANCE
  where 
    BEM_ID = v_bem_id
    and BSL_ID = v_bsl_id
    and SOURCE_ID = :new.SITP_ID;

  if :new.INSTANCE_COMPLETE_DT is not null then
    update BPM_INSTANCE
    set 
      END_DATE = :new.INSTANCE_COMPLETE_DT,
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
    
  v_source_id := substr(to_char(:new.SITP_ID),1,100);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,358,:old.AGE_IN_BUSINESS_DAYS,:new.AGE_IN_BUSINESS_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,360,:old.INSTANCE_COMPLETE_DT,:new.INSTANCE_COMPLETE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,361,:old.INSTANCE_STATUS,:new.INSTANCE_STATUS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,362,:old.CANCEL_DATE,:new.CANCEL_DATE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,363,:old.INFO_REQ_CREATE_DT,:new.INFO_REQ_CREATE_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,365,:old.INFO_REQ_SOURCE,:new.INFO_REQ_SOURCE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,370,:old.CALL_FLAG,:new.CALL_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,371,:old.CALL_RESULT,:new.CALL_RESULT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,372,:old.CALL_STATUS_DT,:new.CALL_STATUS_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,373,:old.NEW_CALL_REQ_ID,:new.NEW_CALL_REQ_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,374,:old.LETTER_IMAGE_LINK_DT,:new.LETTER_IMAGE_LINK_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,375,:old.LETTER_REQ_DT,:new.LETTER_REQ_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,376,:old.LETTER_STATUS_DT,:new.LETTER_STATUS_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,377,:old.NEW_LTR_REQ_ID,:new.NEW_LTR_REQ_ID,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,378,:old.INFO_REQ_SENT_DT,:new.INFO_REQ_SENT_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,379,:old.MAN_LETTER_FLAG,:new.MAN_LETTER_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,380,:old.DISTRICT,:new.DISTRICT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,381,:old.SEND_IEDR_DT,:new.SEND_IEDR_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,382,:old.IEDR_ERROR_FLAG,:new.IEDR_ERROR_FLAG,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,383,:old.INFO_REQ_CYCLE_END_DT,:new.INFO_REQ_CYCLE_END_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,384,:old.INFO_REQ_CYCLE_START_DT,:new.INFO_REQ_CYCLE_START_DT,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,385,:old.INFO_REQ_CYCLE_BUS_DAYS,:new.INFO_REQ_CYCLE_BUS_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,387,:old.SLA_DAYS,:new.SLA_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_CHAR ('UPDATE',v_source_id,v_bi_id,388,:old.SLA_DAYS_TYPE,:new.SLA_DAYS_TYPE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,389,:old.SLA_JEOPARDY_DT,:new.SLA_JEOPARDY_DT,v_bue_id);
   
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,390,:old.SLA_JEOPARDY_DAYS,:new.SLA_JEOPARDY_DAYS,v_bue_id);
    
  PRC_BPM_ETL_BIA_UPD_NUM ('UPDATE',v_source_id,v_bi_id,391,:old.SLA_TARGET_DAYS,:new.SLA_TARGET_DAYS,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,393,:old.ASED_RECEIVE_INFO_REQ,:new.ASED_RECEIVE_INFO_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,394,:old.ASSD_RECEIVE_INFO_REQ,:new.ASSD_RECEIVE_INFO_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,395,:old.ASED_PROCESS_IMAGE,:new.ASED_PROCESS_IMAGE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,396,:old.ASSD_PROCESS_IMAGE,:new.ASSD_PROCESS_IMAGE,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,397,:old.ASED_PERFORM_OUTBOUND_CALL,:new.ASED_PERFORM_OUTBOUND_CALL,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,398,:old.ASSD_PERFORM_OUTBOUND_CALL,:new.ASSD_PERFORM_OUTBOUND_CALL,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,399,:old.ASED_CREATE_NEW_CALL_REQ,:new.ASED_CREATE_NEW_CALL_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,400,:old.ASSD_CREATE_NEW_CALL_REQ,:new.ASSD_CREATE_NEW_CALL_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,401,:old.ASED_MAIL_LETTER_REQ,:new.ASED_MAIL_LETTER_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,402,:old.ASSD_MAIL_LETTER_REQ,:new.ASSD_MAIL_LETTER_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,403,:old.ASED_CREATE_NEW_LETTER_REQ,:new.ASED_CREATE_NEW_LETTER_REQ,v_bue_id);
  
  PRC_BPM_ETL_BIA_UPD_DATE ('UPDATE',v_source_id,v_bi_id,404,:old.ASSD_CREATE_NEW_LETTER_REQ,:new.ASSD_CREATE_NEW_LETTER_REQ,v_bue_id);
  
  
 
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