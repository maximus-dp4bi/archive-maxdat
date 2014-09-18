/* Obsolete - No longer kept up to date. */

/*
alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_INIT_RENEWAL
after insert on NYEC_ETL_MONITOR_RENEWAL
for each row

declare
  
  v_bem_id  number := 6; -- 'NYEC OPS Initiate Renewal'
  v_bi_id   number := null;
  v_bsl_id  number := 6; -- 'NYEC_ETL_MONITOR_RENEWAL'
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
    (v_bi_id,v_bem_id,to_char(:new.APP_ID),2,v_bsl_id,
    :new.REN_FILE_RECEIPT_DT,:new.INSTANCE_COMPLETE_DT,to_char(:new.CEMR_ID),v_current_date,v_current_date);
    
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');

  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,298,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,300,          null,:new.INSTANCE_COMPLETE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,301,null,null,:new.INSTANCE_STATUS,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,302,null,:new.REN_FILE_RECEIPT_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,303,null,     :new.SHELL_CREATE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,304,null,null,:new.SHELL_CREATED_BY,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,305,:new.APP_ID,null,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,306,          null,:new.REN_RECEIPT_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,307,null,:new.AUTH_CHG_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,308,null,     :new.AUTH_END_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,309,null,:new.CANCEL_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,310,null,     :new.CLOSE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,311,null,null,:new.CLOCKDOWN_INDICATOR,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,312,null,null,:new.STATE_CASE_IDEN,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,313,null,     :new.NOTICE_1_DUE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,314,null,     :new.NOTICE_1_CREATE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,315,null,:new.NOTICE_1_COMPLETE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,316,null,null,:new.NOTICE_1_TYPE,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,317,:new.NOTICE_1_SOURCE_ID,     null,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,318,null,:new.NOTICE_2_DUE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,319,null,     :new.NOTICE_2_CREATE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,320,null,     :new.NOTICE_2_COMPLETE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,321,null,    null,:new.NOTICE_2_TYPE,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,322,:new.NOTICE_2_SOURCE_ID,     null,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,323,null,     :new.NOTICE_3_DUE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,324,null,     :new.NOTICE_3_CREATE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,325,null,     :new.NOTICE_3_COMPLETE_DT,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,326,null,     null,:new.NOTICE_3_TYPE,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
  
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,327,:new.NOTICE_3_SOURCE_ID, null,null,:new.REN_FILE_RECEIPT_DT,v_max_date,v_bue_id);
            
  
end;
/

alter session set plsql_code_type = interpreted;
*/