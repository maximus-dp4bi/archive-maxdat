update F_NYEC_PA_BY_DATE
set DNPARI_ID = 285
where DNPARI_ID is null;

commit;

update D_NYEC_PA_CURRENT
set "Cur Reactivation Indicator" = 0
where "Cur Reactivation Indicator" is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPARR_ID = 265
where DNPARR_ID is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPARB_ID = 265
where DNPARB_ID is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPAMC_ID = 265
where DNPAMC_ID is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPAML_ID = 265
where DNPAML_ID is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPAOLS_ID = 265
where DNPAOLS_ID is null;

commit;

update F_NYEC_PA_BY_DATE
set DNPAWRI_ID = 265
where DNPAWRI_ID is null;

commit;

alter session set plsql_code_type = native;

declare
  cursor c_null_onf_dim_ids is
  select 
    facts.FNPABD_ID,
    facts.NYEC_PA_BI_ID,
    nepa.OUTCOME_NOTIFY_RQRD_FLAG
  from F_NYEC_PA_BY_DATE facts
  inner join D_NYEC_PA_CURRENT cur on (facts.NYEC_PA_BI_ID = cur.NYEC_PA_BI_ID)
  inner join NYEC_ETL_PROCESS_APP nepa on (cur."Application ID" = nepa.APP_ID and cur."Cur Reactivation Number" = nepa.REACTIVATION_NBR)
  where facts.DNPAONF_ID is null;

  v_procedure_name varchar2(40) := 'SET_NYEC_PA_REACT_FACTS_DIM_ID_ONF'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_dnpaonf_id number := null;
  v_counter number := 0;
  
begin
  for r_num_onf_dim_id in c_null_onf_dim_ids
  loop
  
    begin
  
      v_counter := v_counter + 1;
  
      if r_num_onf_dim_id.OUTCOME_NOTIFY_RQRD_FLAG is null then
        v_dnpaonf_id := 265;
      elsif r_num_onf_dim_id.OUTCOME_NOTIFY_RQRD_FLAG = 'N' then     
        v_dnpaonf_id := 285;
      elsif r_num_onf_dim_id.OUTCOME_NOTIFY_RQRD_FLAG = 'Y' then     
        v_dnpaonf_id := 286;
      else   
        v_dnpaonf_id := null;
      end if;
  
      update F_NYEC_PA_BY_DATE
      set DNPAONF_ID = v_dnpaonf_id
      where 
        FNPABD_ID = r_num_onf_dim_id.FNPABD_ID
        and DNPAONF_ID is null;
      
      if v_counter = 1000 then
        commit;
        v_counter := 0;
      end if;
    
    exception
  
      when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_num_onf_dim_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);

    end;
  
  end loop;
  
  commit;

exception
            
  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
    
end;   
/


declare
  cursor c_null_sar_dim_ids is
  select 
    facts.FNPABD_ID,
    facts.NYEC_PA_BI_ID,
    nepa.STOP_APP_REASON
  from F_NYEC_PA_BY_DATE facts
  inner join D_NYEC_PA_CURRENT cur on (facts.NYEC_PA_BI_ID = cur.NYEC_PA_BI_ID)
  inner join NYEC_ETL_PROCESS_APP nepa on (cur."Application ID" = nepa.APP_ID and cur."Cur Reactivation Number" = nepa.REACTIVATION_NBR)
  where facts.DNPAONF_ID is null;

  v_procedure_name varchar2(40) := 'SET_NYEC_PA_REACT_FACTS_DIM_ID_SAR'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_dnpasar_id number := null;
  v_counter number := 0;

begin
  for r_num_sar_dim_id in c_null_sar_dim_ids
  loop
  
    begin
      v_counter := v_counter + 1;
  
      if r_num_sar_dim_id.STOP_APP_REASON is null then
        v_dnpasar_id := 265;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Original App ID for case that has an active Agency Conference, and already has a new shell created. ' then     
        v_dnpasar_id := 609;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Case has already been signed off on by DOH under an old app id (Duplicate App ID)' then     
        v_dnpasar_id := 610;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Application received on case closed with a CSD (I89 case reason)' then     
        v_dnpasar_id := 611;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Case has been Withdrawn from HEART (and has NOT already been processed in HEART)' then     
        v_dnpasar_id := 612;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Application received on case closed with a Managed Care Guarantee (Y99 case reason)' then     
        v_dnpasar_id := 613;
      elsif r_num_sar_dim_id.STOP_APP_REASON = 'Application received on case closed F10 after the AED' then     
        v_dnpasar_id := 614;
      else   
        v_dnpasar_id := null;
      end if;
  
      update F_NYEC_PA_BY_DATE
      set DNPASAR_ID = v_dnpasar_id
      where 
        FNPABD_ID = r_num_sar_dim_id.FNPABD_ID
        and DNPASAR_ID is null;
      
      if v_counter = 1000 then
        commit;
        v_counter := 0;
      end if;
      
    exception
    
      when OTHERS then
        v_sql_code := SQLCODE;
        v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_num_sar_dim_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
  
    end;
    
  end loop;
  
  commit;

exception

  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
  
end;   
/


declare
  cursor c_null_qi_dim_ids is
  select 
    facts.FNPABD_ID,
    facts.NYEC_PA_BI_ID,
    nepa.QC_IND
  from F_NYEC_PA_BY_DATE facts
  inner join D_NYEC_PA_CURRENT cur on (facts.NYEC_PA_BI_ID = cur.NYEC_PA_BI_ID)
  inner join NYEC_ETL_PROCESS_APP nepa on (cur."Application ID" = nepa.APP_ID and cur."Cur Reactivation Number" = nepa.REACTIVATION_NBR)
  where facts.DNPAONF_ID is null;

  v_procedure_name varchar2(40) := 'SET_NYEC_PA_REACT_FACTS_DIM_ID_QI'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_log_message clob := null;
  v_sql_code number := null;
  
  v_dnpaqi_id number := null;
  v_counter number := 0;

begin
  for r_num_qi_dim_id in c_null_qi_dim_ids
  loop
  
    begin
  
      v_counter := v_counter + 1;
  
      if r_num_qi_dim_id.QC_IND is null then
        v_dnpaqi_id := 265;
      elsif r_num_qi_dim_id.QC_IND = 'N' then     
        v_dnpaqi_id := 285;
      elsif r_num_qi_dim_id.QC_IND = 'Y' then     
        v_dnpaqi_id := 286;
      else   
        v_dnpaqi_id := null;
      end if;
  
      update F_NYEC_PA_BY_DATE
      set DNPAQI_ID = v_dnpaqi_id
      where 
        FNPABD_ID = r_num_qi_dim_id.FNPABD_ID
        and DNPAQI_ID is null;
      
      if v_counter = 1000 then
        commit;
        v_counter := 0;
      end if;
      
    exception
    
     when OTHERS then
       v_sql_code := SQLCODE;
       v_log_message := SQLERRM;
       BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_num_qi_dim_id.NYEC_PA_BI_ID,null,v_log_message,v_sql_code);
    
    end;
    
  end loop;
  
  commit;

exception

  when OTHERS then
    v_sql_code := SQLCODE;
    v_log_message := SQLERRM;
    BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,null,v_log_message,v_sql_code);
    
end;   
/

alter session set plsql_code_type = interpreted;

alter table F_NYEC_PA_BY_DATE modify
  (DNPACIN_ID number not null,
   DNPAFPBPST_ID number not null,
   DNPAHIAI_ID number not null,
   DNPARI_ID number not null, 
   DNPARR_ID number not null,
   DNPARB_ID number not null,
   DNPARN_ID number not null,
   DNPAMC_ID number not null,
   DNPAML_ID number not null,
   DNPAONF_ID number not null,
   DNPAOLS_ID number not null,
   DNPASAR_ID number not null,
   DNPAWRI_ID number not null,
   DNPAQI_ID number not null);
   
create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  case 
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE >= fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpabd.BUCKET_END_DATE
union all
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;

