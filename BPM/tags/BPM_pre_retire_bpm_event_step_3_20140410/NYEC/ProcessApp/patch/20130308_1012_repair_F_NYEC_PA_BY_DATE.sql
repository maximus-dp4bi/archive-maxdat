alter session set plsql_code_type = native;

alter table F_NYEC_PA_BY_DATE enable row movement;

declare

  cursor c_bad_fact_bi_ids
  is 
  select 
    distinct facts.NYEC_PA_BI_ID,
    coalesce(cur."Complete Date",cur."Cancel Date") end_date
  from F_NYEC_PA_BY_DATE facts
  inner join D_NYEC_PA_CURRENT cur on (facts.NYEC_PA_BI_ID = cur.NYEC_PA_BI_ID)
  where facts.BUCKET_END_DATE < facts.BUCKET_START_DATE
  order by facts.NYEC_PA_BI_ID asc;
  
  v_num_completions number := null;
    
  cursor c_last_facts (p_nyec_pa_bi_id number)
  is
  select facts.*
  from F_NYEC_PA_BY_DATE facts
  where facts.NYEC_PA_BI_ID = p_nyec_pa_bi_id
  order by facts.FNPABD_ID desc;
    
  r_last_fact F_NYEC_PA_BY_DATE%rowtype := null;
  r_next_to_last_fact F_NYEC_PA_BY_DATE%rowtype := null;
  v_procedure_name varchar2(24) := 'REPAIR_F_NYEC_PA_BY_DATE';
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;

begin

  <<NYEC_PA_BI_ID_loop>>
  for r_bad_fact_bi_id in c_bad_fact_bi_ids
  loop
  
    --dbms_output.put_line('NYEC_PA_BI_ID ' || r_bad_fact_bi_id.NYEC_PA_BI_ID || ' ' || r_bad_fact_bi_id.end_date);

    if r_bad_fact_bi_id.end_date is not null then
   
      <<D_DATES_loop>>
      for r_last_facts in c_last_facts(r_bad_fact_bi_id.NYEC_PA_BI_ID)
      loop
      
        --dbms_output.put_line('d_date ' || r_last_facts.D_DATE || ' ' || 'COMPLETION_COUNT ' || r_last_facts.COMPLETION_COUNT);
   
        r_last_fact := r_next_to_last_fact;
        r_next_to_last_fact := r_last_facts;
        
        if r_last_facts.COMPLETION_COUNT = 0 then

          delete from F_NYEC_PA_BY_DATE
          where 
            NYEC_PA_BI_ID = r_bad_fact_bi_id.NYEC_PA_BI_ID
            and FNPABD_ID > r_last_fact.FNPABD_ID;

          --dbms_output.put_line('Dropping NYEC_PA_BI_ID ' || r_bad_fact_bi_id.NYEC_PA_BI_ID || ' with FNPABD_ID > ' || r_last_fact.FNPABD_ID);
     
          -- Instance completed on same day as it was created but staging table updated on later day.
          if r_next_to_last_fact.BUCKET_START_DATE = trunc(r_bad_fact_bi_id.end_date) then
     
            --dbms_output.put_line(r_bad_fact_bi_id.NYEC_PA_BI_ID || ' compl same day');
    
            delete from F_NYEC_PA_BY_DATE
            where FNPABD_ID = r_next_to_last_fact.FNPABD_ID;

            --dbms_output.put_line('Dropping FNPABD_ID = ' || r_next_to_last_fact.FNPABD_ID);
       
            begin
            
              update F_NYEC_PA_BY_DATE
              set
                D_DATE = r_bad_fact_bi_id.end_date,
                BUCKET_START_DATE = r_next_to_last_fact.BUCKET_START_DATE,
                CREATION_COUNT = r_next_to_last_fact.CREATION_COUNT
              where FNPABD_ID = r_last_fact.FNPABD_ID;
       
              --dbms_output.put_line('Updating FNPABD_ID = ' || r_last_fact.FNPABD_ID || ' with ' || r_bad_fact_bi_id.end_date || ' ' || r_next_to_last_fact.BUCKET_START_DATE);
       
            exception
            
              when OTHERS then
                rollback;
                v_sql_code := SQLCODE;
                v_log_message := 'Unable to update F_NYEC_PA_BY_DATE.FNPABD_ID ' ||  r_last_fact.FNPABD_ID || ' when completed same day as created but updated later.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_fact_bi_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
                exit D_DATES_loop;
              
            end;
              
          else
     
            --dbms_output.put_line(r_bad_fact_bi_id.NYEC_PA_BI_ID || ' compl later day');
       
            begin
            
              update F_NYEC_PA_BY_DATE
              set BUCKET_END_DATE = trunc(r_bad_fact_bi_id.end_date)
              where FNPABD_ID = r_next_to_last_fact.FNPABD_ID;
              
              --dbms_output.put_line('Updating FNPABD_ID = ' || r_next_to_last_fact.FNPABD_ID || ' with ' || trunc(r_bad_fact_bi_id.end_date));
              
            exception
            
              when OTHERS then
                rollback;
                v_sql_code := SQLCODE;
                v_log_message := 'Unable to update next to last F_NYEC_PA_BY_DATE.FNPABD_ID ' ||  r_next_to_last_fact.FNPABD_ID || ' when completed different day than created and updated later.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_fact_bi_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
                exit D_DATES_loop;
              
            end;
       
            begin
            
              update F_NYEC_PA_BY_DATE
              set 
                D_DATE = r_bad_fact_bi_id.end_date,
                BUCKET_START_DATE = trunc(r_bad_fact_bi_id.end_date),
                BUCKET_END_DATE = trunc(r_bad_fact_bi_id.end_date)
              where FNPABD_ID = r_last_fact.FNPABD_ID;
       
              --dbms_output.put_line('Updating FNPABD_ID = ' || r_last_fact.FNPABD_ID || ' with ' || trunc(r_bad_fact_bi_id.end_date));

            exception
            
              when OTHERS then
                rollback;
                v_sql_code := SQLCODE;
                v_log_message := 'Unable to update last F_NYEC_PA_BY_DATE.FNPABD_ID ' ||  r_last_fact.FNPABD_ID || ' when completed different day than created and updated later.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_fact_bi_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
                exit D_DATES_loop;
              
            end;

          end if;
       
          commit;
         
          exit D_DATES_loop;
          
        end if;
        
      end loop D_DATES_loop;

    else
    
      dbms_output.put_line('Warning: Unexpected null end_date for ' || r_bad_fact_bi_id.NYEC_PA_BI_ID);
      
    end if;
      
  end loop NYEC_PA_BI_ID_loop;
  
exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);

end;
/

alter table F_NYEC_PA_BY_DATE disable row movement;

alter session set plsql_code_type = interpreted;