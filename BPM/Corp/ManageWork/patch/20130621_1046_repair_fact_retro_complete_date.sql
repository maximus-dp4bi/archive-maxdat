alter session set plsql_code_type = native;

declare

  cursor c_bad_facts
  is 
  select 
    distinct facts.MW_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Work Date") end_date
  from F_MW_BY_DATE facts
  inner join D_MW_CURRENT cur on (facts.MW_BI_ID = cur.MW_BI_ID)
  where facts.BUCKET_END_DATE < facts.BUCKET_START_DATE
  order by facts.MW_BI_ID asc;
   
  v_procedure_name varchar2(40) := 'REPAIR_FACT_RETRO_COMPLETE_DATE';
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;

  v_max_fmwbd_id number := null;
  v_max_d_date date := null;

begin

  for r_bad_fact in c_bad_facts
  loop

    if r_bad_fact.end_date is not null then

      begin

        delete from F_MW_BY_DATE 
        where 
          MW_BI_ID = r_bad_fact.MW_BI_ID
          and BUCKET_START_DATE >= trunc(r_bad_fact.end_date);

        select 
          max(FMWBD_ID),
          max(D_DATE)
        into 
          v_max_fmwbd_id,
          v_max_d_date
        from F_MW_BY_DATE facts
        where facts.MW_BI_ID = r_bad_fact.MW_BI_ID;

        update F_MW_BY_DATE
        set BUCKET_END_DATE = trunc(r_bad_fact.end_date)
        where FMWBD_ID = v_max_fmwbd_id;
 
        if trunc(r_bad_fact.end_date) != trunc(v_max_d_date) then

          insert into F_MW_BY_DATE 
            (FMWBD_ID, 
             D_DATE, 
             BUCKET_START_DATE,
             BUCKET_END_DATE,
             MW_BI_ID, 
             DMWTT_ID, 
             DMWE_ID, 
             DMWF_ID, 
             DMWO_ID, 
             DMWTS_ID, 
             DMWLUBN_ID,
             "Last Update Date",
             "Status Date",
             CREATION_COUNT, 
             INVENTORY_COUNT,
             COMPLETION_COUNT ) 
          select 
            SEQ_FMWBD_ID.nextval,
            r_bad_fact.end_date,
            trunc(r_bad_fact.end_date),
            trunc(r_bad_fact.end_date),
            MW_BI_ID, 
            DMWTT_ID, 
            DMWE_ID, 
            DMWF_ID, 
            DMWO_ID, 
            DMWTS_ID, 
            DMWLUBN_ID, 
            "Last Update Date",
            "Status Date",
            0, 
            0, 
            1
          from F_MW_BY_DATE 
          where FMWBD_ID = v_max_fmwbd_id;

        end if;

        commit;

      exception
            
        when OTHERS then
           rollback;
           v_sql_code := SQLCODE;
           v_log_message := 'Unable to repair F_MW_BY_DATE fact.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_fact.MW_BI_ID,null,v_log_message,v_sql_code);
              
      end;

    end if;
      
  end loop;
  
exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

end;
/

alter session set plsql_code_type = interpreted;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BSL_ID = 1
  and PROCESS_BUEQ_ID is not null;
  
commit;