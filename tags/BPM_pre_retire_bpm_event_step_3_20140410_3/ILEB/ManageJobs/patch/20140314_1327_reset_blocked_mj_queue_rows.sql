declare

  v_procedure_name varchar2(61) := 'RESET_BLOCKED_QUEUE_ROWS.Manage_Jobs';  
  v_bi_id number := null;
  v_bsl_id number := 11;
  v_sql_code number := null;
  v_log_message clob := null;
  v_identifier varchar2(35) := null;
  
cursor c_identifiers_to_remove
  is 
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where BSL_ID = 11;
  --AND OLD_DATA IS NULL;

begin

 for r_identifiers_to_remove in c_identifiers_to_remove
  loop

  update BPM_UPDATE_EVENT_QUEUE
  set 
    PROCESS_BUEQ_ID = null,
    BUE_ID = null,
    WROTE_BPM_EVENT_DATE = null,
    WROTE_BPM_SEMANTIC_DATE = null
    where BSL_ID = 11
    and IDENTIFIER = r_identifiers_to_remove.IDENTIFIER;
 commit;
 
 begin 
    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where 
      IDENTIFIER = r_identifiers_to_remove.IDENTIFIER
      and BEM_ID = 11;
  
    delete from BPM_INSTANCE_ATTRIBUTE
    where BI_ID = v_bi_id;

    delete from BPM_UPDATE_EVENT
    where BI_ID = v_bi_id;
  
     delete from f_mj_by_date 
     Where MJ_BI_ID  = v_bi_id;
  
    delete from d_mj_current
    where MJ_BI_ID  = v_bi_id;     

    delete from  BPM_INSTANCE
    where
       BI_ID = v_bi_id
       and BEM_ID = 11; 
 commit;
 
 EXCEPTION
 WHEN NO_DATA_FOUND THEN
  dbms_output.put_line('New BPM event Id: '||r_identifiers_to_remove.IDENTIFIER);
 WHEN OTHERS THEN
  v_sql_code    := SQLCODE;
  v_log_message := 'Unable to reset queue rows.  ' || SQLERRM;
  BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,NULL,v_procedure_name,v_bsl_id,NULL,NULL,NULL,NULL,v_log_message,v_sql_code);
--  dbms_output.put_line('Unable to reset queue rows.  '||r_identifiers_to_remove.IDENTIFIER||v_bi_id);
 END;
 
dbms_output.put_line(r_identifiers_to_remove.IDENTIFIER);
v_identifier := r_identifiers_to_remove.IDENTIFIER;
      
  end loop;


  
  update PROCESS_BPM_QUEUE_JOB_CONFIG
  set ENABLED = 'Y'
  where BSL_ID = 11;
  
  commit;
  
exception

   when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset queue rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,v_identifier,v_bi_id,null,v_log_message,v_sql_code);
      raise;

end;
/
