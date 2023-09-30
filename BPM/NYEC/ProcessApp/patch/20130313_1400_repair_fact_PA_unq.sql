alter session set plsql_code_type = native;

declare

  cursor c_wrong_d_date is
  with
    bi_unq_errors as
      (select BI_ID
       from BPM_LOGGING
       where 
         RUN_DATA_OBJECT = 'REPAIR_F_NYEC_PA_BY_DATE' 
         and LOG_DATE between to_date('2013-03-12 16:26:34','YYYY-MM-DD HH24:MI:SS') 
           and to_date('2013-03-12 16:27:51','YYYY-MM-DD HH24:MI:SS')),
    most_recent_fact_bi_id as
      (select max(FNPABD_ID) max_fmwbd_id
       from F_NYEC_PA_BY_DATE facts
       inner join bi_unq_errors on (facts.NYEC_PA_BI_ID = bi_unq_errors.BI_ID)
       group by facts.NYEC_PA_BI_ID) 
  select 
    fmwbd.FNPABD_ID,
    fmwbd.NYEC_PA_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Date") end_date
  from 
    F_NYEC_PA_BY_DATE fmwbd,
    most_recent_fact_bi_id,
    D_NYEC_PA_CURRENT cur
  where
    fmwbd.FNPABD_ID = max_fmwbd_id
    and cur.NYEC_PA_BI_ID = fmwbd.NYEC_PA_BI_ID;

  v_procedure_name varchar2(24) := 'REPAIR_FACT_PA_UNQ'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_prev_fnpabd_id number := null;

begin

  for r_wrong_d_date in c_wrong_d_date
  loop

    --dbms_output.put_line('Updating FNPABD_ID = ' || r_wrong_d_date.FNPABD_ID || ' with ' || r_wrong_d_date.end_date);
    
    begin
    
      delete from F_NYEC_PA_BY_DATE
      where 
        FNPABD_ID = r_wrong_d_date.FNPABD_ID
        and NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID;
        
      commit;
      
      begin
    
        v_prev_fnpabd_id := null;
      
        select max(FNPABD_ID)
        into v_prev_fnpabd_id
        from F_NYEC_PA_BY_DATE
        where 
          NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID 
          and FNPABD_ID < r_wrong_d_date.FNPABD_ID;
        
        update F_NYEC_PA_BY_DATE
        set 
          D_DATE = r_wrong_d_date.end_date,
          BUCKET_END_DATE = trunc(r_wrong_d_date.end_date),
          INVENTORY_COUNT = 0,
          COMPLETION_COUNT = 1
        where 
          FNPABD_ID = v_prev_fnpabd_id
          and NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID;
          
        commit;
        
      exception
    
        when NO_DATA_FOUND then
          null;
          
      end;
    
      --dbms_output.put_line('Updating FNPABD_ID = ' || r_wrong_d_date.FNPABD_ID || ' with ' || r_wrong_d_date.end_date);
    
    exception

      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_wrong_d_date.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
    
    end;
    
  end loop;
  
exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

end;
/

alter session set plsql_code_type = interpreted;