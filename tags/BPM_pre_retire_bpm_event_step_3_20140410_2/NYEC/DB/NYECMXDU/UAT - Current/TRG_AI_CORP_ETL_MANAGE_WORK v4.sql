create or replace
PROCEDURE        PRC_BPM_ETL_BIA_INS 
(
  I_BIA_ID IN NUMBER  
, I_BI_ID IN NUMBER  
, I_BA_ID IN NUMBER  
, I_VALUE_NUMBER IN NUMBER  
, I_VALUE_DATE IN DATE  
, I_VALUE_CHAR IN VARCHAR2  
, I_START_DATE IN DATE  
, I_END_DATE IN DATE  
, I_BUE_ID IN NUMBER  
) AS 
BEGIN

insert into BPM_INSTANCE_ATTRIBUTE
    (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
     VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
  values
    (I_BIA_ID,I_BI_ID,I_BA_ID,I_VALUE_NUMBER,I_VALUE_DATE,
     I_VALUE_CHAR,I_START_DATE,I_END_DATE,I_BUE_ID);

END PRC_BPM_ETL_BIA_INS;
/

create or replace
trigger TRG_AI_CORP_ETL_MANAGE_WORK
after insert on CORP_ETL_MANAGE_WORK
for each row

declare
  
--  v_be_id number := null;
  v_bem_id number := 1; -- 'NYEC OPS Manage Work'
  v_bi_id number := null;
--  v_bia_id number := null;
  v_bsl_id number := 1; -- 'CORP_ETL_MANAGE_WORK'
  v_bue_id number := null;
  v_butl_id number := 1; -- 'ETL'
  
  v_max_date date := to_date('2077-07-07','YYYY-MM-DD');
  
--  v_sql_code number := null;
--  v_error_message varchar2(500) := null;

begin
  
  -- Get new BI_ID
  --select SEQ_BI_ID.nextval into v_bi_id from dual;
  v_bi_id := SEQ_BI_ID.nextval;
  
  -- Get new BUE_ID
  --select SEQ_BUE_ID.nextval into v_bue_id from dual;
  v_bue_id := SEQ_BUE_ID.nextval;

  -- req 1.1, 1.8 to 1.13 Insert record into BPM_INSTANCE
  insert into BPM_INSTANCE 
    (BI_ID,BEM_ID,IDENTIFIER,BIL_ID,BSL_ID,
     START_DATE,END_DATE,SOURCE_ID,CREATION_DATE,LAST_UPDATE_DATE)
  values
    (v_bi_id,v_bem_id,to_char(:new.TASK_ID),3,v_bsl_id,
    :new.CREATE_DATE,:new.COMPLETE_DATE,to_char(:new.CEMW_ID),sysdate,sysdate);
    
  -- req 1.2 and 1.3 - Insert new record into BPM_UPDATE_EVENT
  insert into BPM_UPDATE_EVENT
    (BUE_ID,BI_ID,BUTL_ID,EVENT_DATE,BPMS_PROCESSED)
  values
    (v_bue_id,v_bi_id,v_butl_id,sysdate,'N');
    
  -- req 1.4 to 1.7 - Insert new record in BPM_INSTANCE_ATTRIBUTE for each insert attribute in BPM_ATTRIBUTE
  
  --select SEQ_BIA_ID.nextval into v_bia_id from dual;
  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,1,                :new.AGE_IN_BUSINESS_DAYS,null, null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,2,                :new.AGE_IN_CALENDAR_DAYS,null, null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,3,null,           :new.CANCEL_WORK_DATE, null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,4,null,null,      :new.CANCEL_WORK_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,5,null,           :new.COMPLETE_DATE,  null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,6,null,null,      :new.COMPLETE_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);     
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,7,null,           :new.CREATE_DATE,     null,:new.CREATE_DATE,v_max_date,v_bue_id);    
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,8,null,null,      :new.CREATED_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,9,null,null,      :new.ESCALATED_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);      
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,10,null,null,     :new.ESCALATED_TO_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,11,null,null,     :new.FORWARDED_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,12,null,null,     :new.FORWARDED_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,13,null,null,     :new.GROUP_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,14,null,null,     :new.GROUP_PARENT_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,15,null,null,     :new.GROUP_SUPERVISOR_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,16,null,null,     :new.JEOPARDY_FLAG,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,17,null,null,     :new.LAST_UPDATE_BY_NAME,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,18,null,          :new.LAST_UPDATE_DATE,     null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,19,null,null,     :new.OWNER_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,20,               :new.SLA_DAYS,null,     null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,21,null,null,     :new.SLA_DAYS_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id);     
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,22,               :new.SLA_JEOPARDY_DAYS,null,     null,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,23,               :new.SLA_TARGET_DAYS,null,     null,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,24,               :new.SOURCE_REFERENCE_ID,null,     :new.SOURCE_REFERENCE_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id);   
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,25,null,null,     :new.SOURCE_REFERENCE_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,26,               :new.STATUS_AGE_IN_BUS_DAYS,null,     null,:new.CREATE_DATE,v_max_date,v_bue_id);  
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,27,               :new.STATUS_AGE_IN_CAL_DAYS,null,   null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,28,null,          :new.STATUS_DATE,     null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,29,               :new.TASK_ID,null,     null,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,30,null,null,     :new.TASK_STATUS,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,31,null,null,     :new.TASK_TYPE,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,32,null,null,     :new.TEAM_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,33,null,null,     :new.TEAM_PARENT_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,34,null,null,     :new.TEAM_SUPERVISOR_NAME,:new.CREATE_DATE,v_max_date,v_bue_id); 
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,35,null,null,     :new.TIMELINESS_STATUS,:new.CREATE_DATE,v_max_date,v_bue_id);
  prc_bpm_etl_bia_ins(SEQ_BIA_ID.nextval,v_bi_id,36,null,null,     :new.UNIT_OF_WORK,:new.CREATE_DATE,v_max_date,v_bue_id); 
     
--  commit;
  
/*exception

  when others then
    rollback;
    
    v_sql_code := SQLCODE;
    v_error_message := substr(SQLERRM,1,500); 
    v_be_id := SEQ_BE_ID.nextval;
    
    insert into BPM_ERRORS (BE_ID,ERROR_DATE,RUN_DATA_OBJECT,SOURCE_ID,BI_ID,BIA_ID, ERROR_NUMBER,ERROR_MESSAGE) 
    values(v_be_id,sysdate,'TRG_AI_CORP_ETL_MANAGE_WORK',to_char(:new.CEMW_ID),v_bi_id,null, v_sql_code,v_error_message);

    commit;
    
    dbms_output.put_line('Exception: ' || v_error_message || ' See BPM_ERRORS.BE_ID = ' || v_be_id || ' for more details.');
*/

end;
/