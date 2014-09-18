alter session set plsql_code_type = native;

create or replace package BPM_EVENT as

  -- Do not edit these four SVN_* variable values.  They are populated when you commit code to SVN and used later to identify deployed code.
  SVN_FILE_URL varchar2(200) := '$URL$'; 
  SVN_REVISION varchar2(20) := '$Revision$'; 
  SVN_REVISION_DATE varchar2(60) := '$Date$'; 
  SVN_REVISION_AUTHOR varchar2(20) := '$Author$';

  procedure INSERT_BIA
    (p_bi_id in number,
     p_ba_id in number,
     p_bdl_id in number,
     p_attribute_value in varchar2, 
     p_start_date in date,
     p_bue_id in number);

  procedure INSERT_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BIA
    (p_bi_id in number, 
     p_ba_id in number,
     p_bdl_id in number,
     p_retain_history_flag in varchar2,
     p_attribute_value_old in varchar2,
     p_attribute_value_new in varchar2,
     p_bue_id in number,
     p_event_date in date);
     
  procedure INSERT_BPM_ATTRIBUTE_LKUP
    (p_bal_id in number,
     p_bdl_id in number,
     p_name in varchar2,
     p_purpose in varchar2);

  procedure UPDATE_BPM_EVENT
    (p_bueq_row in BPM_UPDATE_EVENT_QUEUE%rowtype);

  procedure UPDATE_BPM_QUEUE
    (p_bueq_id number,
     p_bue_id number);

end;
/


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
    v_sql_code number := null;
    v_log_message clob := null;
    v_error_number number := null;
    v_value_number number := null;
    v_value_char varchar2(4000) := null;
    v_value_date date := null;
  begin

    begin
      if p_bdl_id = 1 then
        v_value_number := to_number(p_attribute_value);
      elsif p_bdl_id = 2 then
        if length(p_attribute_value) > 4000 then
          v_log_message := 'Value was > 4000 characters and substringed to fit.  "' || p_attribute_value || '"'; 
          v_error_number := -20050;
          BPM_COMMON.LOGGER
            (BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,p_bi_id,p_ba_id,v_log_message,v_error_number);
          v_value_char := substr(p_attribute_value,1,4000);
        else
          v_value_char := p_attribute_value;
        end if;
      elsif p_bdl_id = 3 then
        v_value_date := to_date(p_attribute_value,BPM_COMMON.DATE_FMT);
      else
        v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BDL_ID value "' || p_bdl_id || '".';
        v_error_number := -20013;
        BPM_COMMON.LOGGER
          (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,p_bi_id,p_ba_id,v_log_message,v_error_number);
        RAISE_APPLICATION_ERROR(v_error_number,v_log_message);  
     end if;
     
    exception
    
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := 'Unable to convert attribute value "' || p_attribute_value || '" with BDL_ID = ' || p_bdl_id || '.' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,p_bi_id,p_ba_id,v_log_message,v_sql_code); 
        raise;
     
    end;

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
    v_log_message clob := null;
    v_error_number number := null;
    v_bue_id number := null;
  begin
  
    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process from queue.  Null BPM_UPDATE_EVENT_QUEUE.NEW_DATA record for IDENTIFIER value "' || p_bueq_row.IDENTIFIER || '".';
      v_error_number := -20015;
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,null);
      RAISE_APPLICATION_ERROR(v_error_number ,v_log_message);   
    end if;
 
    BPM_EVENT_PROJECT.INSERT_BPM_EVENT(p_bueq_row,v_bue_id);
    UPDATE_BPM_QUEUE(p_bueq_row.BUEQ_ID,v_bue_id);
    
    commit;

  end;
  
  -- Insert into BPM_ATTRIBUTE_LKUP and ignore duplicate insert errors.
  procedure INSERT_BPM_ATTRIBUTE_LKUP
    (p_bal_id in number,
     p_bdl_id in number,
     p_name in varchar2,
     p_purpose in varchar2)
  as
    v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'INSERT_BPM_ATTRIBUTE_LKUP';
    v_sql_code number := null;
    v_log_message clob := null;
  begin
  
    insert into BPM_ATTRIBUTE_LKUP (BAL_ID,BDL_ID,NAME,PURPOSE) values (p_bal_id,p_bdl_id,p_name,p_purpose);
    
  exception
  
    when DUP_VAL_ON_INDEX then
      -- Ignore duplicate insert errors.
      return;
      
    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := 'BPM_ATTRIBUTE_LKUP.BAL_ID = ' || p_bal_id || ' for "' || p_name || '".  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code); 
      raise;
      
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
    v_sql_code number := null;
    v_log_message clob := null;
    v_error_number number := null;
    v_bia_id number := null;
    v_be_id  number := null;

    v_value_number number := null;
    v_value_char varchar2(4000) := null;
    v_value_date date := null;

  begin

    if (p_attribute_value_old is null and p_attribute_value_new is null)
      or (p_attribute_value_old = p_attribute_value_new) then
      -- Data unchanged.  No need to update.
      return;
    end if;

    begin
      if p_bdl_id = 1 then
        v_value_number := to_number(p_attribute_value_new);
      elsif p_bdl_id = 2 then
        if length(p_attribute_value_new) > 4000 then
          v_log_message := 'Value was > 4000 characters and substringed to fit.  "' || p_attribute_value_new || '"'; 
          v_error_number := -20050;
          BPM_COMMON.LOGGER
            (BPM_COMMON.LOG_LEVEL_WARNING,null,v_procedure_name,null,null,null,p_bi_id,p_ba_id,v_log_message,v_error_number);
          v_value_char := substr(p_attribute_value_new,1,4000);
        else
          v_value_char := p_attribute_value_new;
        end if;
      elsif p_bdl_id = 3 then
        v_value_date := to_date(p_attribute_value_new,BPM_COMMON.DATE_FMT);
      else
        v_log_message := 'Unexpected BPM_UPDATE_EVENT_QUEUE.BDL_ID value "' || p_bdl_id || '".';
        v_error_number := -20013;
        BPM_COMMON.LOGGER
         (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,
          null,p_bi_id,p_ba_id,v_log_message,v_error_number);
        RAISE_APPLICATION_ERROR(v_error_number,v_log_message);
      end if;
      
    exception
    
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := 'Unable to convert attribute value "' || p_attribute_value_new || '" with BDL_ID = ' || p_bdl_id || '.' || SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,p_bi_id,p_ba_id,v_log_message,v_sql_code); 
        raise;
     
    end;

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
    v_log_message clob := null;
    v_bue_id number := null;
  begin
  
    if p_bueq_row.WROTE_BPM_EVENT_DATE is not null then
      return;
    end if;
  
    if p_bueq_row.OLD_DATA is null or p_bueq_row.NEW_DATA is null then
      v_log_message := 'Cannot process update from queue.  Null BPM_UPDATE_EVENT_QUEUE .OLD_DATA or .NEW_DATA record(s).';
      BPM_COMMON.LOGGER
        (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,p_bueq_row.BSL_ID,p_bueq_row.BIL_ID,
         p_bueq_row.IDENTIFIER,null,null,v_log_message,null);
      return;
    end if;

    BPM_EVENT_PROJECT.UPDATE_BPM_EVENT(p_bueq_row,v_bue_id);
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
      set WROTE_BPM_EVENT_DATE = sysdate
      where BUEQ_ID = p_bueq_id;
    end if;
  end;

end;
/

alter session set plsql_code_type = interpreted;