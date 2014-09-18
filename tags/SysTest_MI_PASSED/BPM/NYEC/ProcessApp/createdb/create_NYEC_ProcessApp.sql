-- Create NYEC - Process App specific data objects.

-- Delete reduced attributes.

create or replace procedure TPRC_DEL_BPM_ATTRIBUTE (p_attribute_name in varchar2) as
begin
  
  delete from BPM_INSTANCE_ATTRIBUTE where BA_ID in 
    (select BA_ID 
     from BPM_ATTRIBUTE_LKUP bal 
     inner join BPM_ATTRIBUTE ba on (bal.BAL_ID = ba.BAL_ID) 
     where NAME = p_attribute_name);
  
  delete from BPM_ATTRIBUTE where BAL_ID = (select BAL_ID from BPM_ATTRIBUTE_LKUP where NAME = p_attribute_name);
  
  delete from BPM_ATTRIBUTE_LKUP where NAME = p_attribute_name;
  
end;
/

commit;

execute TPRC_DEL_BPM_ATTRIBUTE('Cancel App End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Cancel App Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Cancel Flag'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Close App End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Close App Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Complete App End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Complete App Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Instance Complete Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Instance Status'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Notify Client Pended App End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Perform QC End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Perform Research End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Process App Info End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive and Process MI End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive and Process MI Performed By'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive and Process MI Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive App End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive App Performed By'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Receive App Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Review and Enter Data End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Send Outcome Notification Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Send Outcome Notification End Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Send Outcome Notification Flag'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Send Outcome Notification Start Date'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Send to LDSS Flag'); commit;
execute TPRC_DEL_BPM_ATTRIBUTE('Wait for State Approval End Date'); commit;

drop procedure TPRC_DEL_BPM_ATTRIBUTE;

commit;

-- Add materialized and calculated views.

create or replace procedure TPRC_CR_MV_W_DATE
  (p_datatype in varchar2, 
   p_attribute_name in varchar2, 
   p_view_name in varchar2, 
   p_view_abbr in varchar2) as

  v_create_mv_sql varchar2(2000) := null;
  v_create_index1_sql varchar2(2000) := null;
  v_create_index2_sql varchar2(2000) := null;
  v_create_view_sql varchar2(2000) := null;
  
begin

  v_create_mv_sql := 
    'create materialized view V_D_' || p_view_name ||
   ' tablespace MAXDAT_DATA build immediate using index refresh fast on demand as 
     select 
       d.D_DATE,
       bia.BI_ID,
       bal.BAL_ID,
       bia.BA_ID,
       bia.VALUE_' || p_datatype || ' "' || p_attribute_name || '",
       d.rowid d_dates_rowid,
       bia.rowid ia_rowid,
       ba.rowid a_rowid,
       bal.rowid al_rowid
     from
       BPM_ATTRIBUTE ba,
       BPM_ATTRIBUTE_LKUP bal,
       BPM_INSTANCE_ATTRIBUTE bia,
       BPM_D_DATES d
     where 
       ba.BAL_ID = bal.BAL_ID
       and bal.NAME = ''' || p_attribute_name || '''
       and bia.BA_ID = ba.BA_ID
       and d.D_DATE >= trunc(bia.START_DATE (+)) 
       and d.D_DATE <  trunc(bia.END_DATE (+))';
       
  execute immediate v_create_mv_sql;
  
  BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('NYEC_PROCESS_APP','V_D_' || p_view_name);
  
  v_create_index1_sql := 'create unique index VD' || p_view_abbr || '_UIX1 on V_D_' || p_view_name || ' (D_DATE,BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index1_sql;
  
  v_create_index2_sql := 'create unique index VD' || p_view_abbr || '_UIX2 on V_D_' || p_view_name || ' ("' || p_attribute_name ||'",D_DATE,BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index2_sql;
  
  v_create_view_sql :=
    'create or replace view D_' || p_view_name || 
    ' as
     select
       D_DATE,
       BI_ID,
       BAL_ID,
       BA_ID,
       "' || p_attribute_name || '"
     from V_D_' || p_view_name;
     
  execute immediate v_create_view_sql;
     
end;
/

create or replace procedure TPRC_CR_MV_WO_DATE
  (p_datatype in varchar2, 
   p_attribute_name in varchar2, 
   p_view_name in varchar2, 
   p_view_abbr in varchar2) as

  v_create_mv_sql varchar2(2000) := null;
  v_create_index1_sql varchar2(2000) := null;
  v_create_index2_sql varchar2(2000) := null;
  v_create_view_sql varchar2(2000) := null;
  
begin

  v_create_mv_sql := 
    'create materialized view V_D_' || p_view_name ||
   ' tablespace MAXDAT_DATA build immediate using index refresh fast on demand as 
     select 
       bia.BI_ID,
       bal.BAL_ID,
       bia.BA_ID,
       bia.VALUE_' || p_datatype || ' "' || p_attribute_name || '",
       bia.rowid ia_rowid,
       ba.rowid a_rowid,
       bal.rowid al_rowid
     from
       BPM_ATTRIBUTE ba,
       BPM_ATTRIBUTE_LKUP bal,
       BPM_INSTANCE_ATTRIBUTE bia
     where 
       ba.BAL_ID = bal.BAL_ID
       and bal.NAME = ''' || p_attribute_name || '''
       and bia.BA_ID = ba.BA_ID';

  execute immediate v_create_mv_sql;
  
  BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('NYEC_PROCESS_APP','V_D_' || p_view_name);
  
  v_create_index1_sql := 'create unique index VD' || p_view_abbr || '_UIX1 on V_D_' || p_view_name || ' (BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index1_sql;
  
  v_create_index2_sql := 'create unique index VD' || p_view_abbr || '_UIX2 on V_D_' || p_view_name || ' ("' || p_attribute_name ||'",BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index2_sql;
  
  v_create_view_sql :=
    'create or replace view D_' || p_view_name || 
    ' as
     select
       BI_ID,
       BAL_ID,
       BA_ID,
       "' || p_attribute_name || '"
     from V_D_' || p_view_name;
     
  execute immediate v_create_view_sql;
     
end;
/

create or replace procedure TPRC_CR_MV_WO_DATE_LONG
  (p_datatype in varchar2, 
   p_attribute_name_long in varchar2,
   p_attribute_name in varchar2, 
   p_view_name in varchar2, 
   p_view_abbr in varchar2) as

  v_create_mv_sql varchar2(2000) := null;
  v_create_index1_sql varchar2(2000) := null;
  v_create_index2_sql varchar2(2000) := null;
  v_create_view_sql varchar2(2000) := null;
  
begin

  v_create_mv_sql := 
    'create materialized view V_D_' || p_view_name ||
   ' tablespace MAXDAT_DATA build immediate using index refresh fast on demand as 
     select 
       bia.BI_ID,
       bal.BAL_ID,
       bia.BA_ID,
       bia.VALUE_' || p_datatype || ' "' || p_attribute_name || '",
       bia.rowid ia_rowid,
       ba.rowid a_rowid,
       bal.rowid al_rowid
     from
       BPM_ATTRIBUTE ba,
       BPM_ATTRIBUTE_LKUP bal,
       BPM_INSTANCE_ATTRIBUTE bia
     where 
       ba.BAL_ID = bal.BAL_ID
       and bal.NAME = ''' || p_attribute_name_long || '''
       and bia.BA_ID = ba.BA_ID';

  execute immediate v_create_mv_sql;
  
  BPM_EVENTS_MV.ADD_TO_REFRESH_GROUP('NYEC_PROCESS_APP','V_D_' || p_view_name);
  
  v_create_index1_sql := 'create unique index VD' || p_view_abbr || '_UIX1 on V_D_' || p_view_name || ' (BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index1_sql;
  
  v_create_index2_sql := 'create unique index VD' || p_view_abbr || '_UIX2 on V_D_' || p_view_name || ' ("' || p_attribute_name ||'",BI_ID) tablespace MAXDAT_INDX compute statistics';
  execute immediate v_create_index2_sql;
  
  v_create_view_sql :=
    'create or replace view D_' || p_view_name || 
    ' as
     select
       BI_ID,
       BAL_ID,
       BA_ID,
       "' || p_attribute_name || '"
     from V_D_' || p_view_name;
     
  execute immediate v_create_view_sql;
     
end;
/

commit;

--

execute dbms_refresh.make(name => 'NYEC_PROCESS_APP',list => '',next_date => trunc(sysdate + 1) + (65/1440),interval => 'trunc(sysdate + 1) + (65/1440)');

execute TPRC_CR_MV_WO_DATE('CHAR','App Complete Result','APP_COMPLETE_RESULT','ACR');
execute TPRC_CR_MV_W_DATE('CHAR','App Status','APP_STATUS','AS');
execute TPRC_CR_MV_W_DATE('CHAR','App Status Group','APP_STATUS_GROUP','ASG');
execute TPRC_CR_MV_WO_DATE('NUMBER','Application ID','APPLICATION_ID','AI');
execute TPRC_CR_MV_WO_DATE('CHAR','Application Type','APPLICATION_TYPE','AT');
execute TPRC_CR_MV_WO_DATE('CHAR','Auto Reprocess Flag','AUTO_REPROCESS_FLAG','ARF');
execute TPRC_CR_MV_WO_DATE('CHAR','Cancel App Flag','CANCEL_APP_FLAG','CAAF');
execute TPRC_CR_MV_WO_DATE('CHAR','Cancel App Performed By','CANCEL_APP_PERFORMED_BY','CAAPB');
execute TPRC_CR_MV_WO_DATE('DATE','Cancel Date','CANCEL_DATE','CD');
execute TPRC_CR_MV_WO_DATE('CHAR','Channel','CHANNEL','CH');
execute TPRC_CR_MV_W_DATE('CHAR','Clockdown Indicator','CLOCKDOWN_INDICATOR','CI');
execute TPRC_CR_MV_WO_DATE('CHAR','Close App Flag','CLOSE_APP_FLAG','CLAF');
execute TPRC_CR_MV_WO_DATE('CHAR','Complete App Performed By','COMPLETE_APP_PERFORMED_BY','CLAPB');
execute TPRC_CR_MV_W_DATE('CHAR','County','COUNTY','CO');
execute TPRC_CR_MV_WO_DATE('NUMBER','Current Task ID','CURRENT_TASK_ID','CTI');
execute TPRC_CR_MV_WO_DATE('NUMBER','Data Entry Task ID','DATA_ENTRY_TASK_ID','DETI');
execute TPRC_CR_MV_WO_DATE('CHAR','Eligibility Action','ELIGIBILITY_ACTION','EA');
execute TPRC_CR_MV_W_DATE('CHAR','HEART App Status','HEART_APP_STATUS','HAS');
execute TPRC_CR_MV_W_DATE('CHAR','HEART Synch Flag','HEART_SYNCH_FLAG','HSF');
execute TPRC_CR_MV_WO_DATE('NUMBER','KPR App Cycle Business Days','KPR_APP_CYCLE_BUS_DAYS','KACBD');
execute TPRC_CR_MV_WO_DATE('DATE','KPR App Cycle End Date','KPR_APP_CYCLE_END_DATE','KACED');
execute TPRC_CR_MV_WO_DATE('DATE','KPR App Cycle Start Date','KPR_APP_CYCLE_START_DATE','KACSD');
execute TPRC_CR_MV_WO_DATE('DATE','Last Mail Date','LAST_MAIL_DATE','LMD');
execute TPRC_CR_MV_WO_DATE('NUMBER','MI Received Task Count','MI_RECEIVED_TASK_COUNT','MRTC');
execute TPRC_CR_MV_WO_DATE('CHAR','Missing Information Flag','MISSING_INFORMATION_FLAG','MIF');
execute TPRC_CR_MV_WO_DATE('CHAR','New MI Flag','NEW_MI_FLAG','NMF');
execute TPRC_CR_MV_WO_DATE('DATE','Notify Client Pended App Date','NOTIFY_CLIENT_PA_DATE','NCPAD');
execute TPRC_CR_MV_WO_DATE('CHAR','Notify Client Pended App Flag','NOTIFY_CLIENT_PA_FLAG','NCPAF');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Notify Client Pended App Performed By','Notify Client Pended App PB','NOTIFY_CLIENT_PA_PB','NCPAPB');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Notify Client Pended App Start Date','Notify Client Pended App Start','NOTIFY_CLIENT_PA_START','NCPAS');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Outcome Notification Required Flag','Outcome Notif Req Flag','OUTCOME_NOTIF_REQ_FLAG','ONRF');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Pend Notification Required Flag','Pend Notification Req Flag','PEND_NOTIFICATION_REQ_FLAG','PNRF');
execute TPRC_CR_MV_WO_DATE('DATE','Perform QC Date','PERFORM_QC_DATE','PQD');
execute TPRC_CR_MV_WO_DATE('CHAR','Perform QC Flag','PERFORM_QC_FLAG','PQF');
execute TPRC_CR_MV_WO_DATE('CHAR','Perform QC Performed By','PERFORM_QC_PERFORMED_BY','PCPB');
execute TPRC_CR_MV_WO_DATE('DATE','Perform QC Start Date','PERFORM_QC_START_DATE','PQSD');
execute TPRC_CR_MV_WO_DATE('DATE','Perform Research Date','PERFORM_RESEARCH_DATE','PRD');
execute TPRC_CR_MV_WO_DATE('CHAR','Perform Research Flag','PERFORM_RESEARCH_FLAG','PRF');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Perform Research Performed By','Perform Research PB','PERFORM_RESEARCH_PB','PRPB');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Perform Research Start Date','Perform Research Start','PERFORM_RESEARCH_START','PRSD');
execute TPRC_CR_MV_WO_DATE('DATE','Process App Info Date','PROCESS_APP_INFO_DATE','PAID');
execute TPRC_CR_MV_WO_DATE('CHAR','Process App Info Flag','PROCESS_APP_INFO_FLAG','PAIF');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Process App Info Performed By','Process App Info PB','PROCESS_APP_INFO_PB','PAIPB');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Process App Info Start Date','Process App Info Start','PROCESS_APP_INFO_START','PAISD');
execute TPRC_CR_MV_WO_DATE('CHAR','QC Outcome Flag','QC_OUTCOME_FLAG','QOF');
execute TPRC_CR_MV_WO_DATE('CHAR','QC Required Flag','QC_REQUIRED_FLAG','QRF');
execute TPRC_CR_MV_WO_DATE('NUMBER','QC Task ID','QC_TASK_ID','QTI');
execute TPRC_CR_MV_W_DATE('CHAR','Receipt Date','RECEIPT_DATE','RD');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Receive and Process MI Flag','Receive Process MI Flag','RECEIVE_PROCESS_MI_FLAG','RAPMF');
execute TPRC_CR_MV_WO_DATE('CHAR','Receive App Flag','RECEIVE_APP_FLAG','RAF');
execute TPRC_CR_MV_W_DATE('CHAR','Refer to LDSS Flag','REFER_TO_LDSS_FLAG','RTLF');
execute TPRC_CR_MV_WO_DATE('CHAR','Research Flag','RESEARCH_FLAG','RF');
execute TPRC_CR_MV_WO_DATE('CHAR','Research Reason','RESEARCH_REASON','RR');
execute TPRC_CR_MV_WO_DATE('NUMBER','Research Task ID','RESEARCH_TASK_ID','RTI');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Review and Enter Data Date','Review Enter Data Date','REVIEW_ENTER_DATA_DATE','REDD');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Review and Enter Data Flag','Review Enter Data Flag','REVIEW_ENTER_DATA_FLAG','REDF');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Review and Enter Data Performed By','Review Enter Data PB','REVIEW_ENTER_DATA_PB','REDP');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Review and Enter Data Start Date','Review Enter Data Start Date','REVIEW_ENTER_START_DATE','RESD');
execute TPRC_CR_MV_WO_DATE('DATE','SLA Jeopardy Date','SLA_JEOPARDY_DATE','SJDT');
execute TPRC_CR_MV_WO_DATE('CHAR','State Review Task ID','STATE_REVIEW_TASK_ID','SRTI');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Wait for State Approval Date','Wait State Approval Date','WAIT_STATE_APPROVAL_DATE','WSAD');
execute TPRC_CR_MV_WO_DATE_LONG('CHAR','Wait for State Approval Performed By','Wait State Approval PB','WAIT_STATE_APPROVAL_PB','WSAPB');
execute TPRC_CR_MV_WO_DATE_LONG('DATE','Wait for State Approval Start Date','Wait State Approval Start','WAIT_STATE_APPROVAL_START','WSASD');
execute TPRC_CR_MV_WO_DATE('CHAR','Wait State Approval Flag','WAIT_STATE_APPROVAL_FLAG','WSAF');

drop procedure TPRC_CR_MV_W_DATE;
drop procedure TPRC_CR_MV_WO_DATE;
drop procedure TPRC_CR_MV_WO_DATE_LONG;

commit;

--

create or replace view D_KPR_APP_CYCLE_CAL_DAYS as 
with 
  attr_kpr_app_cycle_start_date as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'KPR App Cycle Start Date' and bal.BAL_ID = ba.BAL_ID)),
  attr_kpr_app_cycle_cal_days as
    (select
       bal.BAL_ID,
       ba.BA_ID,
       ba.BEM_ID
     from BPM_ATTRIBUTE_LKUP bal
     inner join BPM_ATTRIBUTE ba on (bal.NAME = 'KPR App Cycle Calendar Days' and bal.BAL_ID = ba.BAL_ID))
select 
  vdkacsd.BI_ID,
  attr_kpr_app_cycle_cal_days.BAL_ID,
  attr_kpr_app_cycle_cal_days.BA_ID,
  trunc(vdkaced."KPR App Cycle End Date") - trunc(nvl(vdkacsd."KPR App Cycle Start Date",sysdate)) "Age in Calendar Days"
from
  V_D_KPR_APP_CYCLE_START_DATE vdkacsd,
  V_D_KPR_APP_CYCLE_END_DATE vdkaced,
  attr_kpr_app_cycle_start_date,
  attr_kpr_app_cycle_cal_days
where
  vdkacsd.BI_ID = vdkaced.BI_ID (+)
  and vdkacsd.BA_ID = attr_kpr_app_cycle_start_date.BA_ID
  and attr_kpr_app_cycle_start_date.BEM_ID = attr_kpr_app_cycle_cal_days.BEM_ID;