alter session set plsql_code_type = native;

create or replace package body BPM_EVENT as

  -- Insert row into BPM_INSTANCE_ATTRIBUTE.
  procedure INSERT_BIA
    (p_bi_id in number,
     p_ba_id in number,
     p_bdl_id in number,
     p_attribute_value in varchar2, 
     p_start_date in date,
     p_bue_id in number)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BIA';
    v_error_message clob := null;  
    v_value_number number := null;
    v_value_char varchar2(100) := null;
    v_value_date date := null;
  begin
    
    if p_bdl_id = 1 then
      v_value_number := to_number(p_attribute_value);
    elsif p_bdl_id = 2 then
      v_value_char := substr(p_attribute_value,1,100);
    elsif p_bdl_id = 3 then
      v_value_date := to_date(p_attribute_value,BPM_COMMON.DATE_FMT);
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BDL_ID value "' || p_bdl_id || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,p_bi_id,p_ba_id,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20013,v_error_message);
    end if;
    
    insert into BPM_INSTANCE_ATTRIBUTE
      (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
       VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
    values
      (SEQ_BIA_ID.nextval,p_bi_id,p_ba_id,v_value_number,v_value_date,
       v_value_char,p_start_date,BPM_COMMON.MAX_DATE,p_bue_id);

  end;
  
   
  -- Insert BPM Event records.
  procedure INSERT_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_EVENT';
    v_error_message clob := null;
    v_bue_id number := null;
  begin
  
    if p_bueq_row.NEW_DATA is null then
      v_error_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA value for IDENTIFIER value "' || p_bueq_row.IDENTIFIER || '".';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20015,v_error_message);   
    end if;
  
    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.BSL_ID = 1 then 
      MANAGE_WORK.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id); 
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 7 then
      NYEC_PROCESS_STATE_REVIEW.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    /*
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.INSERT_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.NEW_DATA,v_bue_id);
    */
    else 
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
    end if;
    
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID,v_bue_id);
    
    commit;
  
  end;

  
  -- Update row into BPM_INSTANCE_ATTRIBUTE.
  procedure UPDATE_BIA
    (p_bi_id in number, 
     p_ba_id in number,
     p_bdl_id in number,
     p_retain_history_flag in varchar2,
     p_attribute_value_old in varchar2,
     p_attribute_value_new in varchar2,
     p_bue_id in number,
     p_event_date in date)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BIA';
    v_error_message clob := null;
    v_bia_id number := null;
    v_be_id  number := null;
    
    v_value_number number := null;
    v_value_char varchar2(100) := null;
    v_value_date date := null;

  begin
  
    if (p_attribute_value_old is null and p_attribute_value_new is null)
      or (p_attribute_value_old = p_attribute_value_new) then
      -- Data unchanged.  No need to update.
      return;
    end if;
    
    if p_bdl_id = 1 then
      v_value_number := to_number(p_attribute_value_new);
    elsif p_bdl_id = 2 then
      v_value_char := substr(p_attribute_value_new,1,100);
    elsif p_bdl_id = 3 then
      v_value_date := to_date(p_attribute_value_new,BPM_COMMON.DATE_FMT);
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BDL_ID value "' || p_bdl_id || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,p_bi_id,p_ba_id,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20013,v_error_message);
    end if;

    v_bia_id := SEQ_BIA_ID.nextval;
  
    if p_retain_history_flag = 'Y' then

      update BPM_INSTANCE_ATTRIBUTE
      set END_DATE = p_event_date
      where 
        BI_ID = p_bi_id
        and BA_ID = p_ba_id
        and END_DATE = BPM_COMMON.MAX_DATE;

      insert into BPM_INSTANCE_ATTRIBUTE
        (BIA_ID,BI_ID,BA_ID,VALUE_NUMBER,VALUE_DATE,
         VALUE_CHAR,START_DATE,END_DATE,BUE_ID)
      values
        (v_bia_id,p_bi_id,p_ba_id,v_value_number,v_value_date,
         v_value_char,p_event_date,BPM_COMMON.MAX_DATE,p_bue_id);
         
    else
    
      update BPM_INSTANCE_ATTRIBUTE
      set  
        VALUE_NUMBER = v_value_number,
        VALUE_DATE = v_value_date,
        VALUE_CHAR = v_value_char,
        BUE_ID = p_bue_id
      where 
        BI_ID = p_bi_id
        and BA_ID = p_ba_id 
        and END_DATE = BPM_COMMON.MAX_DATE;

    end if;

  end;
  
  -- Update BPM Event records.
  procedure UPDATE_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'UPDATE_BPM_EVENT';
    v_error_message clob := null;
    v_bue_id number := null;  
  begin
  
    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      v_error_message := 'Cannot process update from queue.  BPM_UPDATE_EVENT_QUEUE .OLD_DATA and/or NEW_DATA record is null in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,null,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20014,v_error_message);    
    end if;
  
    if p_bueq_row.BSL_ID = 1 then 
      --UPD_CORP_ETL_MANAGE_WORK_BE(p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
      MANAGE_WORK.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 2 then 
      NYEC_PROCESS_APP.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 4 then 
      NYEC_PROCESS_APP_MI.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 5 then 
      NYEC_PROCESS_MI.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 6 then 
      NYEC_INITIATE_RENEWAL.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    elsif p_bueq_row.BSL_ID = 7 then 
      NYEC_PROCESS_STATE_REVIEW.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    /*
    elsif p_bueq_row.BSL_ID = 8 then 
      NYEC_SEND_INFO_TP.UPDATE_BPM_EVENT(p_bueq_row.DATA_VERSION,p_bueq_row.OLD_DATA,p_bueq_row.NEW_DATA,v_bue_id);
    */
    else
      v_error_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BSL_ID value "' || p_bueq_row.BSL_ID || '" in procedure ' || v_procedure_name || '.';
      BPM_COMMON.ERROR_MSG(sysdate,v_procedure_name,p_bueq_row.IDENTIFIER,null,null,null,v_error_message);
      RAISE_APPLICATION_ERROR(-20012,v_error_message);  
      return;
    end if;
    
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID,v_bue_id);
    
    commit;
  
  end;
  
  
  -- Update BPM queue with date data added to data model.
  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number,
     p_bue_id number)
  as
  begin
    if p_bue_id is not null then
      update BPM_UPDATE_EVENT_QUEUE
      set 
        BUE_ID = p_bue_id,
        WROTE_BPM_EVENT_DATE = sysdate
      where BUEQ_ID = p_bueq_id;
    end if;
  end;

end;
/

commit;

alter session set plsql_code_type = interpreted;