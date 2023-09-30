-- OK if this drop table fails because table does not exist.
drop table BPM_INSTANCE_ATTRIBUTE_TEMP;

create table BPM_INSTANCE_ATTRIBUTE_TEMP
  (BIA_ID       number not null,
   BI_ID        number not null,
   BA_ID        number not null,
   VALUE_NUMBER number,
   VALUE_DATE   date,
   VALUE_CHAR   varchar2(4000),
   START_DATE   date not null,
   END_DATE     date,
   BUE_ID       number not null)
partition by range (BA_ID)
interval(1)
  (partition PT_BIA_BA_LT_0 values less than (0))
tablespace MAXDAT_DATA parallel;

declare

  cursor r_orphan_bia is
    select bia.BIA_ID
    from BPM_INSTANCE_ATTRIBUTE bia
    left outer join BPM_INSTANCE bi on (bia.BI_ID = bi.BI_ID)
    left outer join BPM_UPDATE_EVENT bue on (bia.BUE_ID = bue.BUE_ID)
    where 
      bi.BI_ID is null 
      or bue.BUE_ID is null;
      
  v_count number := 0;
  
  v_procedure_name varchar2(61) := $$PLSQL_UNIT || '.' || 'REPAIR_FACT_TABLE_MFD';
  v_sql_code number := null;
  v_log_message clob := null;
      
begin

  for c_orphan_bia in r_orphan_bia
  loop
  
    delete from BPM_INSTANCE_ATTRIBUTE
    where BIA_ID = c_orphan_bia.BIA_ID;
    
    v_count := v_count + 1;
    
    if v_count = 1000 then
      v_count := 0;
      commit;
    end if;
    
  end loop;
  
  commit;
  
exception
  
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,null,null,null,null,null,v_log_message,v_sql_code);  

end;
/
