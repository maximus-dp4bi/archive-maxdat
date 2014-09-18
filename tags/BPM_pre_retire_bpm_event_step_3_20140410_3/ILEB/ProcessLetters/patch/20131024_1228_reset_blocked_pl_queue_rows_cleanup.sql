declare

  cursor c_identifiers_to_remove
  is 
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where BSL_ID = 12
  AND OLD_DATA IS NULL;
  
  v_procedure_name varchar2(61) := 'RESET_BLOCKED_QUEUE_ROWS.PROCESS_LETTERS';  
  v_bi_id number := null;
  v_bsl_id number := 12;
  v_sql_code number := null;
  v_log_message clob := null;
  v_identifier varchar2(35) := null;

begin

 for r_identifiers_to_remove in c_identifiers_to_remove
  loop

  update BPM_UPDATE_EVENT_QUEUE
  set 
    PROCESS_BUEQ_ID = null,
    BUE_ID = null,
    WROTE_BPM_EVENT_DATE = null,
    WROTE_BPM_SEMANTIC_DATE = null
    where BSL_ID = 12
    and IDENTIFIER = r_identifiers_to_remove.IDENTIFIER;

    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where 
      IDENTIFIER = r_identifiers_to_remove.IDENTIFIER
      and BEM_ID = 12;
  
    delete from BPM_INSTANCE_ATTRIBUTE
    where BI_ID = v_bi_id;

    delete from BPM_UPDATE_EVENT
    where BI_ID = v_bi_id;
  
     delete from F_PL_BY_DATE 
     Where PL_BI_ID  = v_bi_id;
  
    delete from D_PL_CURRENT
    where PL_BI_ID  = v_bi_id;     

    delete from  BPM_INSTANCE
    where
       BI_ID = v_bi_id
       and BEM_ID = 12;  
    
  
    commit;

v_identifier := r_identifiers_to_remove.IDENTIFIER;
      
  end loop;


  
  update PROCESS_BPM_QUEUE_JOB_CONFIG
  set ENABLED = 'Y'
  where BSL_ID = 12;
  
  commit;
  
exception

    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE (v_bi_id);

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset queue rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;

end;
/
