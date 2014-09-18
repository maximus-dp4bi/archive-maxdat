/* Obsolete - No longer kept up to date. */
/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_SNDIFOTRDPTNR
after insert on NYEC_ETL_SENDINFOTRADPART
for each row

declare
  
  v_bem_id  number := 8; -- 'NYEC OPS Send Info to TP'
  v_bi_id   number := null;
  v_bsl_id  number := 8; -- 'NYEC_ETL_SENDINFOTRADPART'
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
    (v_bi_id,v_bem_id,to_char(:new.INFO_REQ_ID),9,v_bsl_id,
    :new.INFO_REQ_CREATE_DT,:new.INSTANCE_COMPLETE_DT,to_char(:new.SITP_ID),v_current_date,v_current_date);
    
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');

  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,358,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,360,          null,:new.INSTANCE_COMPLETE_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,361,null,null,:new.INSTANCE_STATUS,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,362,null,:new.CANCEL_DATE,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,363, null,    :new.INFO_REQ_CREATE_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,364,:new.INFO_REQ_ID,null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,365,null,null,:new.INFO_REQ_SOURCE,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,369,:new.APP_ID,     null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,370,null,null,:new.CALL_FLAG,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,371,null,     null,:new.CALL_RESULT,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
 
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,372,null,:new.CALL_STATUS_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,373,:new.NEW_CALL_REQ_ID,null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,374,null,    :new.LETTER_IMAGE_LINK_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,375,null,     :new.LETTER_REQ_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,376,null,:new.LETTER_STATUS_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,377,:new.NEW_LTR_REQ_ID,null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,378,null,     :new.INFO_REQ_SENT_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,379,null,null,:new.MAN_LETTER_FLAG,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,380,null,     null,:new.DISTRICT,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,381,null,     :new.SEND_IEDR_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,382,null,     null,:new.IEDR_ERROR_FLAG,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,383,null,     :new.INFO_REQ_CYCLE_END_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,384,null,    :new.INFO_REQ_CYCLE_START_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,385,:new.INFO_REQ_CYCLE_BUS_DAYS,     null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,387,:new.SLA_DAYS,   null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,388,null,   null,:new.SLA_DAYS_TYPE,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,389,null,   :new.SLA_JEOPARDY_DT,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,390,:new.SLA_JEOPARDY_DAYS,   null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,391,:new.SLA_TARGET_DAYS,   null,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,393,null,   :new.ASED_RECEIVE_INFO_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,394,null,   :new.ASSD_RECEIVE_INFO_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,395,null,   :new.ASED_PROCESS_IMAGE,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,396,null,   :new.ASSD_PROCESS_IMAGE,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,397,null,   :new.ASED_PERFORM_OUTBOUND_CALL,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,398,null,   :new.ASSD_PERFORM_OUTBOUND_CALL,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,399,null,   :new.ASED_CREATE_NEW_CALL_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,400,null,   :new.ASSD_CREATE_NEW_CALL_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,401,null,   :new.ASED_MAIL_LETTER_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,402,null,   :new.ASSD_MAIL_LETTER_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,403,null,   :new.ASED_CREATE_NEW_LETTER_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,404,null,   :new.ASSD_CREATE_NEW_LETTER_REQ,null,:new.INFO_REQ_CREATE_DT,v_max_date,v_bue_id);
   
end;
/

alter session set plsql_code_type = interpreted;
*/