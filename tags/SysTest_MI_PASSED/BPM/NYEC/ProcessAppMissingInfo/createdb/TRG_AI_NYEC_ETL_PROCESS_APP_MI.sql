alter session set plsql_code_type = native;

create or replace trigger TRG_AI_NYEC_ETL_PROCESS_APP_MI
after insert on NYEC_ETL_PROCESS_APP_MI
for each row

declare
  
  v_bem_id  number := 4; -- 'NYEC OPS Process Application MI'
  v_bi_id   number := null;
  v_bsl_id  number := 4; -- 'NYEC_ETL_PROCESS_APP_MI'
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
    (v_bi_id,v_bem_id,to_char(:new.MISSING_INFO_ID),6,v_bsl_id,
    :new.MI_ITEM_CREATE_DT,:new.STAGE_DONE_DATE,to_char(:new.CEPAM_ID),v_current_date,v_current_date);
    
  v_bue_id := SEQ_BUE_ID.nextval;

  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,v_current_date,'N');

  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,221,          :new.APP_ID,null,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,222,          :new.MISSING_INFO_ID,null,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,223,null,null,:new.MI_ITEM_LEVEL,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,224,null,null,:new.MI_ITEM_TYPE,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,225,null,     :new.MI_ITEM_CREATE_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,226,null,null,:new.MI_ITEM_REQUESTED_BY,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,227,null,null,:new.MI_LETTER_REQUIRED_STATUS,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,228,          :new.MI_LETTER_ID,null,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,229,null,null,:new.RFE_STATUS,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,230,null,     :new.RFE_STATUS_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,231,null,null,:new.MI_ITEM_STATUS,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,232,null,     :new.MI_ITEM_STATUS_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,233,null,null,:new.MI_ITEM_STATUS_PERFORMER,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,234,null,null,:new.MI_ITEM_SATISFIED_CHANNEL,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,235,null,     :new.MI_LETTER_CYCLE_START_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,236,null,     :new.MI_LETTER_CYCLE_END_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,237,null,null,:new.MI_ITEM_CREATE_TASK_TYPE,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  -- PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,238,null,null,:new.REFER_TO_DISTRICT_IND,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  -- PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,239,null,     :new.REFER_TO_DISTRICT_IND_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,240,null,null,:new.UNDELIVERABLE_IND,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,241,null,     :new.UNDELIVERABLE_IND_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
  PRC_BPM_ETL_BIA_INS(SEQ_BIA_ID.nextval,v_bi_id,242,null,     :new.MI_VALIDATED_DT,null,:new.MI_ITEM_CREATE_DT,v_max_date,v_bue_id);
end;
/

alter session set plsql_code_type = interpreted;