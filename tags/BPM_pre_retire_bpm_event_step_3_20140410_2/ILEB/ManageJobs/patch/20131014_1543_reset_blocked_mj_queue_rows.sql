-- Manage Jobs
  
update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null,
  BUE_ID = null,
  WROTE_BPM_EVENT_DATE = null
where 
  BSL_ID = 11;

delete from BPM_UPDATE_EVENT
where BI_ID = 5752039;

delete from BPM_INSTANCE
where
  BI_ID = 5752039
  and BEM_ID = 11
  and IDENTIFIER = '23635';
  
update PROCESS_BPM_QUEUE_JOB_CONFIG
set ENABLED = 'Y'
where BSL_ID = 11;
  
commit;


-- Manage Work

update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null,
  BUE_ID = null,
  WROTE_BPM_EVENT_DATE = null
where BSL_ID = 1;

delete from BPM_UPDATE_EVENT
where BI_ID in (5813239,5813261);

delete from BPM_INSTANCE
where
  BI_ID in (5813239,5813261)
  and BEM_ID = 1;
  
update PROCESS_BPM_QUEUE_JOB_CONFIG
set ENABLED = 'Y'
where BSL_ID = 1;
  
commit;


-- Process Letters

update BPM_UPDATE_EVENT_QUEUE
set 
  PROCESS_BUEQ_ID = null,
  BUE_ID = null,
  WROTE_BPM_EVENT_DATE = null
where BSL_ID = 12;

delete from BPM_UPDATE_EVENT
where BI_ID = 5811221;

delete from BPM_INSTANCE
where
  BI_ID = 5811221
  and BEM_ID = 12;
  
update PROCESS_BPM_QUEUE_JOB_CONFIG
set ENABLED = 'Y'
where BSL_ID = 12;
  
commit;


-- Client Inquiry

declare

  cursor c_identifiers_to_remove
  is 
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where 
    BSL_ID = 13
    and PROCESS_BUEQ_ID is not null
  minus
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where 
    BSL_ID = 13
    and OLD_DATA is null
    and PROCESS_BUEQ_ID is not null
  order by IDENTIFIER asc;
  
  v_procedure_name varchar2(61) := 'RESET_BLOCKED_QUEUE_ROWS.CLIENT_INQUIRY';  
  v_bi_id number := null;
  v_bsl_id number := 13;
  v_sql_code number := null;
  v_log_message clob := null;

begin

  update BPM_UPDATE_EVENT_QUEUE
  set 
    PROCESS_BUEQ_ID = null,
    BUE_ID = null,
    WROTE_BPM_EVENT_DATE = null
  where BSL_ID = 13;
  
  commit;

  for r_identifiers_to_remove in c_identifiers_to_remove
  loop

    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where 
      IDENTIFIER = r_identifiers_to_remove.IDENTIFIER
      and BEM_ID = 13;
  
    delete from BPM_UPDATE_EVENT
    where BI_ID = v_bi_id;
  
    delete from  BPM_INSTANCE
    where
       BI_ID = v_bi_id
       and BEM_ID = 13;
  
    commit;
      
  end loop;
  
  update PROCESS_BPM_QUEUE_JOB_CONFIG
  set ENABLED = 'Y'
  where BSL_ID = 13;
  
  commit;
  
exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset queue rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,null,null,null,v_log_message,v_sql_code);
      raise;

end;
/


--- Manage Enroll

declare

  cursor c_identifiers_to_remove
  is 
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where 
    BSL_ID = 14
    and PROCESS_BUEQ_ID is not null
  minus
  select distinct IDENTIFIER
  from BPM_UPDATE_EVENT_QUEUE
  where 
    BSL_ID = 14
    and OLD_DATA is null
    and PROCESS_BUEQ_ID is not null
  order by IDENTIFIER asc;

  v_procedure_name varchar2(61) := 'RESET_BLOCKED_QUEUE_ROWS.MANAGE_ENROLL';  
  v_bi_id number := null;
  v_bsl_id number := 14;
  v_sql_code number := null;
  v_log_message clob := null;

begin

  update BPM_UPDATE_EVENT_QUEUE
  set 
    PROCESS_BUEQ_ID = null,
    BUE_ID = 14,
    WROTE_BPM_EVENT_DATE = null
  where BSL_ID = 14;
  
  commit;

  for r_identifiers_to_remove in c_identifiers_to_remove
  loop

    select BI_ID
    into v_bi_id
    from BPM_INSTANCE
    where 
      IDENTIFIER = r_identifiers_to_remove.IDENTIFIER
      and BEM_ID = 14;
  
    delete from BPM_UPDATE_EVENT
    where BI_ID = v_bi_id;
  
    delete from  BPM_INSTANCE
    where
       BI_ID = v_bi_id
       and BEM_ID = 14;
  
    commit;
      
  end loop;
  
  update PROCESS_BPM_QUEUE_JOB_CONFIG
  set ENABLED = 'Y'
  where BSL_ID = 14;
  
  commit;
  
exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to reset queue rows.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,null,null,null,null,v_log_message,v_sql_code);
      raise;

end;
/
