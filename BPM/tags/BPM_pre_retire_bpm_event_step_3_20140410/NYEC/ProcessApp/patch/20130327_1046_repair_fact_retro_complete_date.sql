alter session set plsql_code_type = native;

declare

  cursor c_bad_facts
  is 
  select 
    distinct facts.NYEC_PA_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Date") end_date
  from F_NYEC_PA_BY_DATE facts
  inner join D_NYEC_PA_CURRENT cur on (facts.NYEC_PA_BI_ID = cur.NYEC_PA_BI_ID)
  where facts.BUCKET_END_DATE < facts.BUCKET_START_DATE
  order by facts.NYEC_PA_BI_ID asc;
   
  v_procedure_name varchar2(40) := 'REPAIR_FACT_RETRO_COMPLETE_DATE';
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;

  v_max_fnpabd_id number := null;
  v_max_d_date date := null;

begin

  for r_bad_fact in c_bad_facts
  loop

    if r_bad_fact.end_date is not null then

      begin

        delete from F_NYEC_PA_BY_DATE 
        where 
          NYEC_PA_BI_ID = r_bad_fact.NYEC_PA_BI_ID
          and BUCKET_START_DATE >= trunc(r_bad_fact.end_date);

        select 
          max(FNPABD_ID),
          max(D_DATE)
        into 
          v_max_fnpabd_id,
          v_max_d_date
        from F_NYEC_PA_BY_DATE facts
        where facts.NYEC_PA_BI_ID = r_bad_fact.NYEC_PA_BI_ID;

        update F_NYEC_PA_BY_DATE
        set BUCKET_END_DATE = trunc(r_bad_fact.end_date)
        where FNPABD_ID = v_max_fnpabd_id;
 
        if trunc(r_bad_fact.end_date) != trunc(v_max_d_date) then

          insert into F_NYEC_PA_BY_DATE 
            (FNPABD_ID, 
             D_DATE, 
             BUCKET_START_DATE,
             BUCKET_END_DATE,
             NYEC_PA_BI_ID, 
             DNPAAS_ID, 
             DNPACOU_ID, 
             DNPAHS_ID, 
             "Receipt Date", 
             INVENTORY_COUNT, 
             CREATION_COUNT, 
             COMPLETION_COUNT,
             DNPACIN_ID,
             DNPAFPBPST_ID,
             DNPAHIAI_ID,
             "Invoiceable Date",
             DNPAHCS_ID) 
          select 
            SEQ_FNPABD_ID.nextval,
            r_bad_fact.end_date,
            trunc(r_bad_fact.end_date),
	    trunc(r_bad_fact.end_date),
            NYEC_PA_BI_ID, 
            DNPAAS_ID, 
            DNPACOU_ID, 
            DNPAHS_ID, 
            "Receipt Date", 
            0, 
            0, 
            1,
            DNPACIN_ID,
            DNPAFPBPST_ID,
            DNPAHIAI_ID,
            "Invoiceable Date",
            DNPAHCS_ID
          from F_NYEC_PA_BY_DATE 
          where FNPABD_ID = v_max_fnpabd_id;


        end if;

        commit;

      exception
            
        when OTHERS then
           rollback;
           v_sql_code := SQLCODE;
           v_log_message := 'Unable to repair F_NYEC_PA_BY_DATE fact.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_fact.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
              
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
  BSL_ID = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;