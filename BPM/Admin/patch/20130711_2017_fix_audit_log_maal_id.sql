declare

  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'FIX_MAAL_ID';
  v_sql_code number := null;
  v_log_message clob := null;
    
  cursor c_maals
  is
  select MAAL_ID
  from MAXDAT_ADMIN_AUDIT_LOGGING
  order by MAAL_ID asc;

begin

  for r_maal in c_maals
  loop
     update MAXDAT_ADMIN_AUDIT_LOGGING
     set MAAL_ID = SEQ_MAAL_ID.nextval
     where MAAL_ID = r_maal.MAAL_ID;
  end loop;
  
  commit;

  exception
    when others then
      v_sql_code := SQLCODE;
      v_log_message := 'Unable to fix MAAL_ID.  ' || SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);  
      
end;
/