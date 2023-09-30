-- Not updated to latest requiremnets.
/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_PRO_ST_REVW
after insert on NYEC_ETL_STATE_REVIEW
for each row

declare
  
  v_bem_id  number := 7; -- 'NYEC OPS Process State Review'
  v_bi_id   number := null;
  v_bsl_id  number := 7; -- 'NYEC_ETL_STATE_REVIEW'
  v_bue_id  number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  v_current_date date := sysdate;

begin
  
  v_bi_id := SEQ_BI_ID.nextval;
  
  insert into BPM_INSTANCE 
    (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
     START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
  values
    (v_bi_id,v_bem_id,to_char(:new.STATE_REVIEW_TASK_ID),8,v_bsl_id,
    :new.ASSD_RECEIVE_STATE_REVIEW,:new.INSTANCE_COMPLETE_DT,to_char(:new.NESR_ID),v_current_date,v_current_date);
    
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');

  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,328,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,330,          null,null,:new.ALL_MI_SATISFIED,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,331,:new.APP_ID,null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,332,null,null,:new.AUTO_CLOSE_FLAG,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,333, :new.CALL_CAMPAIGN_ID,    null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,334,null,null,:new.CALL_CAMPAIGN_FLAG,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,335,null,:new.CANCEL_DT,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,336,:new.CURRENT_TASK_ID,null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,337,null,:new.INSTANCE_COMPLETE_DT,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,338,null,null,:new.INSTANCE_STATUS,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,339,:new.LETTER_REQ_ID,     null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,340,null,null,:new.LETTER_STATUS,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,341,null,     null,:new.NEW_MI_FLAG,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,342,:new.NEW_STATE_REVIEW_TASK_ID,null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,343,null,null,:new.RFE_STATUS_FLAG,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,344,null,    null,:new.STATE_ACCEPT_IND,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,345,null,     null,:new.STATE_REVIEW_OUTCOME,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,346,:new.STATE_REVIEW_TASK_ID,null,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,347,null,:new.ASED_RECEIVE_STATE_REVIEW,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,348,null,     null,:new.ASPB_RECEIVE_STATE_REVIEW,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,349,null,:new.ASSD_RECEIVE_STATE_REVIEW,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,350,null,     :new.ASED_PROCESS_DC,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,351,null,     null,:new.ASPB_PROCESS_DC,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,352,null,     :new.ASSD_PROCESS_DC,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,353,null,     :new.ASED_RESEARCH,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,354,null,    null,:new.ASPB_RESEARCH,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,355,null,     :new.ASSD_RESEARCH,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,356,null, :new.ASED_REQUEST_MI_NOTICE,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,357,null,    :new.ASSD_REQUEST_MI_NOTICE,null,:new.ASSD_RECEIVE_STATE_REVIEW,v_max_date,v_bue_id);
            
 
end;
/

alter session set plsql_code_type = interpreted;
*/