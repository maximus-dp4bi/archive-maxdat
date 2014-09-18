alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_PROCESS_MI
after insert on NYEC_ETL_PROCESS_MI
for each row

declare
  
  v_bem_id  number := 5; -- 'NYEC OPS Process Missing Info'
  v_bi_id   number := null;
  v_bsl_id  number := 5; -- 'NYEC_ETL_PROCESS_MI'
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
    (v_bi_id,v_bem_id,to_char(:new.MI_TASK_ID),7,v_bsl_id,
    :new.MI_TASK_CREATE_DATE,:new.MI_TASK_COMPLETE_DATE,to_char(:new.NEPM_ID),v_current_date,v_current_date);
    
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');

  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,243,          :new.AGE_IN_BUSINESS_DAYS,null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,245,          :new.APP_ID,null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,246,null,:new.ASED_COMPLETE_MI_TASK,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,247,null,:new.ASED_CREATE_STATE_ACCEPT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,248,null,     :new.ASED_DETERMINE_MI_OUTCOME,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,249,null,:new.ASED_PERFORM_QC,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,250,null,:new.ASED_PERFORM_RESEARCH,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,251,          null,:new.ASED_RECEIVE_MI,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,252,null,:new.ASED_SEND_MI_LETTER,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,253,null,     null,:new.ASPB_COMPLETE_MI_TASK,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,254,null,null,:new.ASPB_CREATE_STATE_ACCEPT,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,255,null,     null,:new.ASPB_DETERMINE_MI_OUTCOME,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,256,null,null,:new.ASPB_PERFORM_QC,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,257,null,null,:new.ASPB_PERFORM_RESEARCH,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,258,null,     null,:new.ASPB_RECEIVE_MI,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,259,null,     null,:new.ASPB_SEND_MI_LETTER,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,260,null,:new.ASSD_COMPLETE_MI_TASK,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,261,null,:new.ASSD_CREATE_STATE_ACCEPT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,262,null,     :new.ASSD_DETERMINE_MI_OUTCOME,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,263,null,:new.ASSD_PERFORM_QC,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,264,null,     :new.ASSD_PERFORM_RESEARCH,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,265,null,     :new.ASSD_RECEIVE_MI,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,266,null,     :new.ASSD_SEND_MI_LETTER,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,267,null,     :new.CANCEL_DATE,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,268,:new.CURRENT_TASK_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,269,null,     :new.INSTANCE_COMPLETE_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,270,null,     null,:new.INSTANCE_STATUS,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,271,null,     null,:new.JEOPARDY_FLAG,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,272,:new.MAN_LETTER_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,273,null,     :new.MAN_LETTER_SENT_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,274,null,     null,:new.MI_CALL_CAMPAIGN,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,275,null,     null,:new.MI_CHANNEL,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,276,:new.MI_CYCLE_BUS_DAYS,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,277,null,     :new.MI_CYCLE_END_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,278,null,     :new.MI_CYCLE_START_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,279,:new.MI_LETTER_REQUEST_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,280,null,     null,:new.MI_LETTER_STATUS,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,281,null,     :new.MI_RECEIPT_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,282,null,     :new.MI_TASK_COMPLETE_DATE,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,283,null,     :new.MI_TASK_CREATE_DATE,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,284,:new.MI_TASK_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,285,null,     null,:new.MI_TASK_TYPE,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,286,null,     null,:new.MI_Type,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,287,null,     null,:new.PENDING_MI_TYPE,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,288,:new.QC_TASK_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,289,null,     null,:new.RESEARCH_REASON,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,290,:new.RESEARCH_TASK_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,291,:new.SLA_DAYS,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,292,null,     null,:new.SLA_DAYS_TYPE,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,293,:new.SLA_JEOPARDY_DAYS,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,294,null,     :new.SLA_JEOPARDY_DT,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,295,:new.SLA_TARGET_DAYS,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,296,:new.STATE_REVIEW_TASK_ID,     null,null,:new.MI_TASK_CREATE_DATE,v_max_date,v_bue_id);
 
           
            
  
end;
/

alter session set plsql_code_type = interpreted;