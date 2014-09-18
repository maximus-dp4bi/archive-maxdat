alter session set plsql_code_type = native;

declare

  cursor c_wrong_d_date is
  with most_recent_fact_bi_id as
    (select max(FMWBD_ID) max_fmwbd_id
     from F_MW_BY_DATE
     group by MW_BI_ID) 
  select 
    fmwbd.FMWBD_ID,
    fmwbd.MW_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Work Date") end_date
  from 
    F_MW_BY_DATE fmwbd,
    most_recent_fact_bi_id,
    D_MW_CURRENT cur
  where
    fmwbd.FMWBD_ID = max_fmwbd_id
    and cur.MW_BI_ID = fmwbd.MW_BI_ID
    and coalesce(cur."Complete Date",cur."Cancel Work Date") is not null
    and D_DATE != coalesce(cur."Complete Date",cur."Cancel Work Date");

  v_procedure_name varchar2(24) := 'REPAIR_F_MW_BY_DATE'; 
  v_bsl_id number := 1;
  v_bil_id number := 3; 
  v_log_message clob := null;
  v_sql_code number := null;

begin

  for r_wrong_d_date in c_wrong_d_date
  loop

    update F_MW_BY_DATE
    set D_DATE = r_wrong_d_date.end_date
    where 
      FMWBD_ID = r_wrong_d_date.FMWBD_ID
      and MW_BI_ID = r_wrong_d_date.MW_BI_ID;

    commit;
    
    --dbms_output.put_line('Updating FMWBD_ID = ' || r_wrong_d_date.FMWBD_ID || ' with ' || r_wrong_d_date.end_date);

  end loop;
  
exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

end;
/

alter session set plsql_code_type = interpreted;