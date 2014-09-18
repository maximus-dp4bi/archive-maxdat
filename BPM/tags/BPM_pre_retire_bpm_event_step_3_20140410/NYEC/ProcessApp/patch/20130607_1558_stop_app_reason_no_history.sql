alter table D_NYEC_PA_CURRENT rename column "Cur Stop Application Reason" to "Stop Application Reason";
alter table F_NYEC_PA_BY_DATE drop constraint FNPABD_DNPASAR_FK;
alter table F_NYEC_PA_BY_DATE drop column DNPASAR_ID;
drop view D_NYEC_PA_STOP_APP_REASON_SV;
drop table D_NYEC_PA_STOP_APP_REASON;
drop sequence SEQ_DNPASAR_ID;
--drop public synonym D_NYEC_PA_STOP_APP_REASON_SV;
--drop public synonym D_NYEC_PA_STOP_APP_REASON;

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
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 and INVENTORY_COUNT = 0 then 0
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
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
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
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date",
  DNPAMAR_ID,
  DNPARCR_ID
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;

create or replace view D_NYEC_PA_CURRENT_SV as
select
  NYEC_PA_BI_ID, 
  "Application ID", 
  "Age in Business Days", 
  "Age in Calendar Days", 
  "App Age in Calendar Days",
  "App Complete Result", 
  "Application Type", 
  "Auto Reprocess Flag", 
  "Cancel App Flag", 
  "Cancel App Performed By", 
  "Cancel Date", 
  "Channel" "Channel Name", 
  "Close App Flag", 
  "Close App Performed By", 
  "Complete App Flag", 
  "Complete App Performed By", 
  "Complete Date", 
  "Create Date", 
  "Current Task ID", 
  "Data Entry Task ID",
  "Eligibility Action", 
  "Jeopardy Flag", 
  "KPR App Cycle Business Days", 
  "KPR App Cycle Calendar Days", 
  "KPR App Cycle End Date", 
  "KPR App Cycle Start Date", 
  "Last Mail Date", 
  "MI Received Task Count", 
  "Missing Information Flag", 
  "New MI Flag", 
  "Notify Clnt Pend App Date", 
  "Notify Clnt Pend App Flag", 
  "Notify Clnt Pend App Prfrmd By", 
  "Notify Clnt Pend App Strt Date", 
  "Outcome Notif Req Gateway Flag", 
  "Pend Notification Rqrd Flag", 
  "Perform QC Date", 
  "Perform QC Performed By", 
  "Perform QC Flag", 
  "Perform QC Start Date", 
  "Perform Research Date", 
  "Perform Research Performed By", 
  "Perform Research Flag", 
  "Perform Research Start Date", 
  "Process App Info Date", 
  "Process App Info Flag", 
  "Process App Info Performed By", 
  "Process App Info Start Date", 
  "QC Outcome Flag", 
  "QC Required Flag", 
  "QC Task ID", 
  "Receive and Process MI Flag", 
  "Receive App Flag", 
  "Research Flag", 
  "Research Reason", 
  "Research Task ID", 
  "Review Enter Data Date", 
  "Review Enter Data Performed By", 
  "Review Enter Data Flag", 
  "Review Enter Data Start Date", 
  "SLA Days", 
  "SLA Days Type", 
  "SLA Jeopardy Date", 
  "SLA Jeopardy Days", 
  "SLA Target Days", 
  "State Review Task Count", 
  "State Review Task ID", 
  "Timeliness Status", 
  "Wait State Approval Date", 
  "Wait State Approval Flag", 
  "Wait State Approval Prfrmd By", 
  "Wait State Approval Start Date", 
  "Cur App Status", 
  "Cur App Status Group", 
  "Cur County", 
  "Cur HEART App Status", 
  "Cur HEART Synch Flag", 
  "Cur Receipt Date", 
  "Cur Refer to LDSS Flag",
  "Cur CIN",
  "CIN Date",
  "Provider Name",
  "Cur FPBP Sub-type",
  "Reverse Clearance Indictr",
  "Reverse Clearance Indictr Date",
  "Reverse Clearance Outcome",
  "Upstate/Downstate Indictr",
  "Invoiceable Date",
  "Cur HEART Incomplete App Ind",
  "Days To Timeout",
  "Cur HEART Case Status",
  "State Case Identifier",
  "Cur Reactivation Indicator",
  "Cur Reactivation Date",
  "Cur Reactivation Reason",
  "Cur Reactivated By",
  "Cur Reactivation Number",
  "Cur Mode Code",
  "Cur Mode Label",
  "Cur Outcome Notif Req Flag",
  "Outcome Letter ID",
  "Outcome Letter Type",
  "Cur Outcome Letter Status",
  "Outcome Letter Send Date",
  "Outcome Letter Create Date",
  "Stop Application Reason",
  "Cur Workflow Reactivation Ind", 
  "Cur QC Indicator",
  CUR_MA_REASON,
  PROVIDER_ID,
  APPLICANT_ID,
  REGISTRATION_TASK_ID,
  QC_REGISTRATION_TASK_ID,
  PERFORM_QC_REG_START_DATE,
  PERFORM_QC_REG_PERFORMED_BY,
  REG_AND_ENTER_DATA_PERFORM_BY,
  REG_AND_ENTER_DATA_START_DATE,
  PERFORM_QC_REG_DATE,
  CUR_REVERSE_CLEARANCE_REASON,
  PERFORM_REG_ENTER_DATA_DATE,
  cast (((sysdate - "KPR App Cycle End Date") - 30) as numeric) as "Days Left to Reactivate"
from D_NYEC_PA_CURRENT dnpacur
with read only;


update BPM_ATTRIBUTE
set RETAIN_HISTORY_FLAG = 'N'
where BA_ID = 481
  and BAL_ID = 397
  and BEM_ID = 2;

commit;

-- Consolidate history into one record per instance using latest values.
declare

  v_procedure_name varchar2(40) := 'STOP_APP_REASON_NO_HISTORY'; 
  v_bsl_id number := 2;
  v_bil_id number := 2; 
  v_ba_id number := 481;
  v_log_message clob := null;
  v_sql_code number := null;

  cursor c_sap_bi_ids
  is
  select 
    BI_ID,
    min(BIA_ID) min_bia_id,
    min(START_DATE) min_start_date
  from BPM_INSTANCE_ATTRIBUTE
  where BA_ID = v_ba_id
  group by BI_ID
  having count(*) > 1;
  
  v_bia_id number := null;

begin

  for r_sap_bi_id in c_sap_bi_ids
  loop
  
    begin
    
      select BIA_ID
      into v_bia_id
      from BPM_INSTANCE_ATTRIBUTE
      where
        BI_ID = r_sap_bi_id.BI_ID
        and BA_ID = v_ba_id
        and END_DATE = BPM_COMMON.MAX_DATE;
        
      delete from BPM_INSTANCE_ATTRIBUTE
      where
        BI_ID = r_sap_bi_id.BI_ID
        and BA_ID = v_ba_id
        and END_DATE != BPM_COMMON.MAX_DATE;
        
      update BPM_INSTANCE_ATTRIBUTE
      set 
        BIA_ID = r_sap_bi_id.min_bia_id,
        START_DATE = r_sap_bi_id.min_start_date
      where
        BI_ID = r_sap_bi_id.BI_ID
        and BA_ID = v_ba_id
        and END_DATE = BPM_COMMON.MAX_DATE;
        
      commit;
      
    exception
    
      when OTHERS then
      rollback;
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,r_sap_bi_id.BI_ID,v_ba_id,v_log_message,v_sql_code);  
        
    end;
  
  end loop;

exception

    when OTHERS then
      v_sql_code := SQLCODE;
      v_log_message := SQLERRM;
      BPM_COMMON.LOGGER(BPM_COMMON.LOG_LEVEL_SEVERE,null,v_procedure_name,v_bsl_id,v_bil_id,null,null,v_ba_id,v_log_message,v_sql_code);

end;
/

/* Test
select BI_ID 
from BPM_INSTANCE_ATTRIBUTE
where BA_ID = 481
group by BI_ID
having count(*) > 1;

select * 
from BPM_INSTANCE_ATTRIBUTE
where BI_ID = 1884566 and BA_ID = 481;
*/