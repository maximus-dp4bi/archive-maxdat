alter table F_NYEC_PMI_BY_DATE enable row movement;

alter session set plsql_code_type = native;

declare

  cursor c_wrong_d_date is
  with most_recent_fact_bi_id as
    (select max(FNPMIBD_ID) max_fnpmibd_id
     from F_NYEC_PMI_BY_DATE
     group by NYEC_PMI_BI_ID) 
  select 
    fmwbd.FNPMIBD_ID,
    fmwbd.NYEC_PMI_BI_ID,
    cur."Instance Complete Date" end_date
  from 
    F_NYEC_PMI_BY_DATE fmwbd,
    most_recent_fact_bi_id,
    D_NYEC_PMI_CURRENT cur
  where
    fmwbd.FNPMIBD_ID = max_fnpmibd_id
    and cur.NYEC_PMI_BI_ID = fmwbd.NYEC_PMI_BI_ID
    and cur."Instance Complete Date" is not null
    and D_DATE != cur."Instance Complete Date";

  v_procedure_name varchar2(30) := 'REPAIR_F_NYEC_PMI_BY_DATE'; 
  v_bsl_id number := 5;
  v_bil_id number := 7; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_prev_fnpabd_id number := null;

begin

  for r_wrong_d_date in c_wrong_d_date
  loop

    --dbms_output.put_line('Updating FNPMIBD_ID = ' || r_wrong_d_date.FNPMIBD_ID || ' with ' || r_wrong_d_date.end_date);
    
    begin
    
      update F_NYEC_PMI_BY_DATE
      set 
        D_DATE = r_wrong_d_date.end_date,
        BUCKET_START_DATE = trunc(r_wrong_d_date.end_date)
      where 
        FNPMIBD_ID = r_wrong_d_date.FNPMIBD_ID
        and NYEC_PMI_BI_ID = r_wrong_d_date.NYEC_PMI_BI_ID;
      
      begin
    
        v_prev_fnpabd_id := null;
        
        select max(FNPMIBD_ID)
        into v_prev_fnpabd_id
        from F_NYEC_PMI_BY_DATE
        where 
          NYEC_PMI_BI_ID = r_wrong_d_date.NYEC_PMI_BI_ID 
          and FNPMIBD_ID < r_wrong_d_date.FNPMIBD_ID;
          
        update F_NYEC_PMI_BY_DATE
        set BUCKET_END_DATE = trunc(r_wrong_d_date.end_date)
        where 
          FNPMIBD_ID = v_prev_fnpabd_id
          and NYEC_PMI_BI_ID = r_wrong_d_date.NYEC_PMI_BI_ID;
        
      exception
    
        when NO_DATA_FOUND then
          null;
          
      end;

      commit;
    
      --dbms_output.put_line('Updating FNPMIBD_ID = ' || r_wrong_d_date.FNPMIBD_ID || ' with ' || r_wrong_d_date.end_date);
      
    exception

      when OTHERS then
        rollback;
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
        BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_wrong_d_date.NYEC_PMI_BI_ID,null,v_log_message,v_sql_code);
    
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

alter table F_NYEC_PMI_BY_DATE disable row movement;