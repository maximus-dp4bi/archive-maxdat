alter table F_NYEC_PA_BY_DATE enable row movement;

delete from F_NYEC_PA_BY_DATE
where   
  NYEC_PA_BI_ID = 935566
  and FNPABD_ID > 1797134;

update F_NYEC_PA_BY_DATE
set
  D_DATE = to_date('2012-02-07 09:49:40','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2012-12-07','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2012-12-07','YYYY-MM-DD'),
  INVENTORY_COUNT = 0,
  COMPLETION_COUNT = 1
where
  NYEC_PA_BI_ID = 935566
  and FNPABD_ID = 1797134;
  
commit;
  
delete from F_NYEC_PA_BY_DATE
where   
  NYEC_PA_BI_ID = 1126014
  and FNPABD_ID > 3737611;
  
update F_NYEC_PA_BY_DATE
set
  D_DATE = to_date('2013-01-10 12:51:31','YYYY-MM-DD HH24:MI:SS'),
  BUCKET_START_DATE = to_date('2013-01-10','YYYY-MM-DD'),
  BUCKET_END_DATE = to_date('2013-01-10','YYYY-MM-DD'),
  INVENTORY_COUNT = 0,
  COMPLETION_COUNT = 1
where
  NYEC_PA_BI_ID = 1126014
  and FNPABD_ID = 3737611;
  
commit;

alter session set plsql_code_type = native;

declare

  cursor c_wrong_d_date is
  with most_recent_fact_bi_id as
    (select max(FNPABD_ID) max_fmwbd_id
     from F_NYEC_PA_BY_DATE
     group by NYEC_PA_BI_ID) 
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
    and cur.NYEC_PA_BI_ID = fmwbd.NYEC_PA_BI_ID
    and coalesce(cur."Complete Date",cur."Cancel Date") is not null
    and D_DATE != coalesce(cur."Complete Date",cur."Cancel Date");

  v_procedure_name varchar2(24) := 'REPAIR_F_NYEC_PA_BY_DATE'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_prev_fnpabd_id number := null;

begin

  for r_wrong_d_date in c_wrong_d_date
  loop

    update F_NYEC_PA_BY_DATE
    set 
      D_DATE = r_wrong_d_date.end_date,
      BUCKET_START_DATE = trunc(r_wrong_d_date.end_date)
    where 
      FNPABD_ID = r_wrong_d_date.FNPABD_ID
      and NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID;
      
    begin
    
      select max(FNPABD_ID)
      into v_prev_fnpabd_id
      from F_NYEC_PA_BY_DATE 
      where 
        NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID 
        and FNPABD_ID < r_wrong_d_date.FNPABD_ID;
        
    exception
    
      when NO_DATA_FOUND then
        null;
          
    end;
    
    if v_prev_fnpabd_id is not null then
    
      update F_NYEC_PA_BY_DATE
      set BUCKET_END_DATE = trunc(r_wrong_d_date.end_date)
      where 
        FNPABD_ID = v_prev_fnpabd_id
        and NYEC_PA_BI_ID = r_wrong_d_date.NYEC_PA_BI_ID;
        
    end if;

    commit;
    
    --dbms_output.put_line('Updating FNPABD_ID = ' || r_wrong_d_date.FNPABD_ID || ' with ' || r_wrong_d_date.end_date);

  end loop;
  
exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

end;
/

alter session set plsql_code_type = interpreted;

alter table F_NYEC_PA_BY_DATE disable row movement;