alter session set plsql_code_type = native;

declare

  cursor c_bad_instances
  is
  select NYEC_PMI_BI_ID
  from F_NYEC_PMI_BY_DATE
  group by NYEC_PMI_BI_ID
  having sum(COMPLETION_COUNT) > 1;
  
  cursor c_facts (p_nyec_pmi_bi_id number)
  is
  select *
  from F_NYEC_PMI_BY_DATE
  where NYEC_PMI_BI_ID = p_nyec_pmi_bi_id
  order by 
    D_DATE asc,
    FNPMIBD_ID asc;
   
  v_procedure_name varchar2(40) := 'REPAIR_FACT_COMPLETE_COUNT';
  v_bsl_id number := 5;
  v_bil_id number := 7; 
  v_log_message clob := null;
  v_sql_code number := null;

  v_num_facts number := null;
  v_max_bucket_start_date date := null;
  v_complete_date date := null;
  v_row_counter number := null;
  v_first_bucket_start_date date := null;
  v_first_bucket_end_date date := null;

begin

  for r_bad_instance in c_bad_instances
  loop

      v_row_counter := 0;
      v_first_bucket_start_date := null;
      v_first_bucket_end_date := null;
      
      begin
      
        select 
          count(*),
          max(BUCKET_START_DATE),
          max(cur."Instance Complete Date")
        into 
          v_num_facts,
          v_max_bucket_start_date,
          v_complete_date
        from F_NYEC_PMI_BY_DATE facts
        inner join D_NYEC_PMI_CURRENT cur on (facts.NYEC_PMI_BI_ID = cur.NYEC_PMI_BI_ID)
        where facts.NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID;

        for r_fact in c_facts(r_bad_instance.NYEC_PMI_BI_ID)
        loop
          v_row_counter := v_row_counter + 1;
          
          -- First fact.
          if v_row_counter = 1 then
                    
            v_first_bucket_start_date:= r_fact.BUCKET_START_DATE;
            v_first_bucket_end_date := r_fact.BUCKET_END_DATE;
          
            if r_fact.CREATION_COUNT = 0 then
            
              update F_NYEC_PMI_BY_DATE
              set CREATION_COUNT = 1
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
            end if;
            
            if r_fact.INVENTORY_COUNT = 0 
               and v_num_facts > 1 
               and r_fact.BUCKET_START_DATE != trunc(v_complete_date) 
            then
            
              update F_NYEC_PMI_BY_DATE
              set INVENTORY_COUNT = 1
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
            end if;
            
            if r_fact.COMPLETION_COUNT = 0
               and r_fact.BUCKET_START_DATE = trunc(v_complete_date)
            then
            
              update F_NYEC_PMI_BY_DATE
              set COMPLETION_COUNT = 1
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
              
            elsif r_fact.COMPLETION_COUNT = 1
                 and (r_fact.BUCKET_START_DATE != trunc(v_complete_date) or v_complete_date is null)
            then
   
              update F_NYEC_PMI_BY_DATE
              set COMPLETION_COUNT = 0
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
            end if;
            
            
          -- Last fact when more then one fact.
          elsif v_row_counter > 1 and v_row_counter = v_num_facts then 
                   
            if r_fact.BUCKET_START_DATE = v_first_bucket_start_date
               and r_fact.BUCKET_END_DATE = v_first_bucket_end_date
            then
                        
              delete from F_NYEC_PMI_BY_DATE
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
            else
          
              if r_fact.CREATION_COUNT = 1 then
            
                update F_NYEC_PMI_BY_DATE
                set CREATION_COUNT = 0
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
              end if;
            
              if r_fact.INVENTORY_COUNT = 1 
                 and r_fact.BUCKET_START_DATE = trunc(v_complete_date)
              then
            
                update F_NYEC_PMI_BY_DATE
                set INVENTORY_COUNT = 0
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
   
              elsif r_fact.INVENTORY_COUNT = 0
                    and ( r_fact.BUCKET_START_DATE != trunc(v_complete_date)
                    or v_complete_date is null) 
              then  
            
                update F_NYEC_PMI_BY_DATE
                set INVENTORY_COUNT = 1
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
              end if;
            
              if r_fact.COMPLETION_COUNT = 0
                 and r_fact.BUCKET_START_DATE = trunc(v_complete_date) 
              then
            
                update F_NYEC_PMI_BY_DATE
                set COMPLETION_COUNT = 1
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
              elsif r_fact.COMPLETION_COUNT = 1
                    and r_fact.BUCKET_START_DATE != trunc(v_complete_date)
              then
            
                update F_NYEC_PMI_BY_DATE
                set COMPLETION_COUNT = 0
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
              end if;
              
          end if;
          
          
          -- Middle facts.
          else
                    
            if r_fact.BUCKET_START_DATE = v_first_bucket_start_date
               and r_fact.BUCKET_END_DATE = v_first_bucket_end_date
            then
            
              delete from F_NYEC_PMI_BY_DATE
              where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
            else
          
              if r_fact.CREATION_COUNT = 1 then
            
                update F_NYEC_PMI_BY_DATE
                set CREATION_COUNT = 0
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
              end if;
            
              if r_fact.INVENTORY_COUNT = 0 then
                  
                update F_NYEC_PMI_BY_DATE
                set INVENTORY_COUNT = 1
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
            
              end if;
            
              if r_fact.COMPLETION_COUNT = 1 then
            
                update F_NYEC_PMI_BY_DATE
                set COMPLETION_COUNT = 0
                where NYEC_PMI_BI_ID = r_bad_instance.NYEC_PMI_BI_ID
                  and FNPMIBD_ID = r_fact.FNPMIBD_ID;
                
              end if;                    
          
            end if;
            
        end if;
 
        end loop;

        commit;

      exception
            
        when OTHERS then
           rollback;
           v_sql_code := SQLCODE;
           v_log_message := 'Unable to repair F_NYEC_PMI_BY_DATE fact.  ' || SQLERRM;
                BPM_COMMON.LOGGER
                  (BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_bad_instance.NYEC_PMI_BI_ID,null,v_log_message,v_sql_code);
              
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