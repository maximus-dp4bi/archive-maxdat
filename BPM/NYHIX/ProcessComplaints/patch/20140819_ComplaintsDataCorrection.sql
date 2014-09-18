update CORP_ETL_COMPLAINTS_INCIDENTS
set assd_resolve_incident_sup = assd_resolve_incident_ees_css  
where  created_by_name = created_by_sup_name
and created_by_sup = 'N'
and assd_resolve_incident_sup is null
;

update CORP_ETL_COMPLAINTS_INCIDENTS
set ased_resolve_incident_sup = ased_resolve_incident_ees_css
where  created_by_name = created_by_sup_name
and created_by_sup = 'N'
and ased_resolve_incident_sup is null
;

update CORP_ETL_COMPLAINTS_INCIDENTS
set assd_resolve_incident_ees_css = null
   ,ased_resolve_incident_ees_css = null
   ,created_by_sup = 'Y'
   ,GWF_RESOLVED_EES_CSS = null
where  created_by_name = created_by_sup_name
and created_by_sup = 'N';

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set ased_resolve_incident_sup = complete_dt, gwf_resolved_sup = 'Y'
where created_by_sup = 'Y'
and (cs.GWF_RESOLVED_SUP is null or cs.gwf_resolved_sup = 'N')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set GWF_RESOLVED_EES_CSS = 'Y'
where created_by_sup = 'N'
and (cs.GWF_RESOLVED_EES_CSS is null or cs.GWF_RESOLVED_EES_CSS = 'N')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS
set asf_resolve_incident_ees_css = 'Y'
where ASSD_RESOLVE_INCIDENT_EES_CSS is not null 
and ASED_RESOLVE_INCIDENT_EES_CSS is not null
and asf_resolve_incident_ees_css = 'N';

--referred to state by ees_css
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
     ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;  


--referred to supervisor and then to state
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
; 

--referred to supervisor then closed
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,gwf_resolved_sup = 'Y'
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

--referred to state then closed
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_followup_req = 'N'   
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

--referred to supervisor then to state then Closed
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'
    ,gwf_followup_req = 'N'    
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

--still Active but there is an incident status of Closed
update corp_etl_complaints_incidents
set instance_status = 'Complete'
 ,complete_dt = ased_resolve_incident_doh 
where incident_id =26076552;

--referred to sup then to state with followup flag = Y and refer to state status count >1
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select max(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASSD_PERFORM_FOLLOWUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_PERFORM_FOLLOWUP = (select max(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,cs.ASF_PERFORM_FOLLOWUP = 'Y'
    ,gwf_resolved_sup = 'N'    
    ,gwf_followup_req = 'Y' 
    ,gwf_return_to_state = 'Y'
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'Y'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and (select count(1) from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%') > 1
;

--referred to sup then to state with followup flag = Y and refer to state status count =1
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASSD_PERFORM_FOLLOWUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'
    ,gwf_followup_req = 'Y'    
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'Y'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and (select count(1) from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%') = 1
;

--referred to sup then to state with followup flag = N and refer to state status count >1
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select max(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'        
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'N'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and (select count(1) from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%') > 1
;

--referred to sup then to state with followup flag = N and refer to state status count =1
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')    
    ,gwf_resolved_sup = 'N'        
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'N'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and (select count(1) from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%') = 1
;


--still in Open status but should be referred to state already
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,incident_status = (select incident_status from INCIDENT_HEADER_STAT_HIST_STG hs where cs.incident_id = hs.incident_header_id and hs.incident_status like '%State%')
   ,incident_status_dt = assd_resolve_incident_doh
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status like '%Open%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;  

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
    ,incident_status_dt = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,incident_status = (select incident_status from INCIDENT_HEADER_STAT_HIST_STG hs where cs.incident_id = hs.incident_header_id and hs.incident_status like '%State%' 
                    and incident_header_stat_hist_id = (select min(incident_header_stat_hist_id) from INCIDENT_HEADER_STAT_HIST_STG hs2 where hs.incident_header_id = hs2.incident_header_id
                     and hs2.incident_status like '%State%' ))
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status like '%Open%'
--and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and cs.incident_id < 26149982; 

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status like '%Open%'
--and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and cs.incident_id < 26149982; 

update corp_etl_complaints_incidents
set asf_resolve_incident_ees_css = 'N'
where ASED_RESOLVE_INCIDENT_EES_CSS is null 
and ASF_RESOLVE_INCIDENT_EES_CSS = 'Y';

update corp_etl_complaints_incidents
set ased_perform_followup = incident_status_dt
where ASSD_PERFORM_FOLLOWUP > ASED_PERFORM_FOLLOWUP
and incident_status like '%Close%';

update CORP_ETL_COMPLAINTS_INCIDENTS
set ased_resolve_incident_doh = incident_status_dt,
    ased_perform_followup = incident_status_dt
where ASSD_RESOLVE_INCIDENT_DOH > ASED_RESOLVE_INCIDENT_DOH
and incident_status like '%Close%';  

update CORP_ETL_COMPLAINTS_INCIDENTS
set ased_perform_followup = incident_status_dt
where ASSD_PERFORM_FOLLOWUP is not null 
and ASED_PERFORM_FOLLOWUP is null
and incident_status like '%Close%';

update CORP_ETL_COMPLAINTS_INCIDENTS
set ASED_RESOLVE_INCIDENT_DOH = incident_status_dt
where ASSD_RESOLVE_INCIDENT_DOH is not null 
and ASED_RESOLVE_INCIDENT_DOH is null
and incident_status like '%Close%';

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y'   
    ,assd_resolve_incident_sup = null
    --,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y'        
where created_by_sup = 'N' 
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y',gwf_resolved_ees_css = null,gwf_escalate_to_state = null
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y'        
where created_by_sup = 'Y' 
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y',gwf_resolved_ees_css = null,gwf_escalate_to_state = null
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y'        
where created_by_sup = 'Y' 
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y',gwf_resolved_ees_css = 'N',gwf_escalate_to_state = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = case when assd_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%') else assd_resolve_incident_doh end
    ,ASED_RESOLVE_INCIDENT_DOH = case when ased_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%') else ased_resolve_incident_doh end
    ,cs.ASF_RESOLVE_INCIDENT_DOH = case when asf_resolve_incident_doh = 'N' then 'Y' else asf_resolve_incident_doh end        
where created_by_sup = 'N' 
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
   cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,gwf_resolved_sup = 'Y'
where created_by_sup = 'N'
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS
set gwf_escalate_to_state = null
where created_by_sup = 'Y'
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and gwf_escalate_to_state = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
where forwarded = 'Y' 
and GWF_ESCALATE_TO_STATE = 'Y' 
and ASSD_RESOLVE_INCIDENT_DOH is null 
and GWF_RESOLVED_EES_CSS = 'N'
and created_by_sup = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = null
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
where forwarded = 'Y' 
and GWF_ESCALATE_TO_STATE = 'Y' 
and ASSD_RESOLVE_INCIDENT_DOH is null 
and GWF_RESOLVED_EES_CSS = 'N'
and created_by_sup = 'Y'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set cs.ASSD_RESOLVE_INCIDENT_SUP = null
    ,ased_resolve_incident_sup = null
    ,asf_resolve_incident_sup = 'N'
    --,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = null
where forwarded = 'Y' 
and GWF_ESCALATE_TO_STATE = 'Y' 
and ASSD_RESOLVE_INCIDENT_DOH is null 
and GWF_RESOLVED_EES_CSS = 'N'
and created_by_sup = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')   
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = null
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
where forwarded = 'Y' 
and GWF_ESCALATE_TO_STATE = 'Y' 
and ASSD_RESOLVE_INCIDENT_DOH is null 
and GWF_RESOLVED_EES_CSS = 'N'
and created_by_sup = 'Y'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y'--,gwf_resolved_ees_css = null,gwf_escalate_to_state = null
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')   
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where created_by_sup = 'N'
and assd_resolve_incident_sup is not null
and ased_resolve_incident_sup is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status  like '%Open%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')   
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where created_by_sup = 'N'
and assd_resolve_incident_sup is not null
and ased_resolve_incident_sup is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status  like '%Open%'
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')   
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where created_by_sup = 'N'
and assd_resolve_incident_sup is not null
and ased_resolve_incident_sup is null
and ASSD_WITHDRAW_INCIDENT is null
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'
    ,gwf_followup_req = 'N'    
where created_by_sup = 'N'
and ASSD_RESOLVE_INCIDENT_SUP is not null
and ASeD_RESOLVE_INCIDENT_SUP is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status  like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%');
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where incident_id in(26067865,
26073994,
26118974,
26149971,
26149973);

update CORP_ETL_COMPLAINTS_INCIDENTS  cs
set ased_resolve_incident_doh = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,ASF_RESOLVE_INCIDENT_DOH = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,instance_status = 'Complete'    
    ,complete_dt = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,stage_done_dt = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
where incident_id in(26084813,
26080296,
26130121);

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_escalate_to_state = 'N'
where gwf_escalate_to_state = 'Y'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set GWF_RESOLVED_EES_CSS = null
where cs.GWF_RESOLVED_EES_CSS is not null
and created_by_sup = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS 
set gwf_escalate_to_state = null 
where gwf_escalate_to_state = 'Y'
and created_by_sup = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')   
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')   
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')    
where created_by_sup = 'N'
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and trunc(create_dt) < to_date('08/20/2014','mm/dd/yyyy')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y'   
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'  
where  ased_resolve_incident_sup < assd_resolve_incident_sup
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ased_resolve_incident_sup = null
    ,assd_resolve_incident_sup = null
    ,asf_resolve_incident_sup = 'N'
    ,cs.GWF_RESOLVED_SUP = null
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y'  
where incident_id = 26085891
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_resolved_sup = 'N'
where incident_id = 26135236;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,gwf_resolved_sup = null
    ,cs.ASF_RESOLVE_INCIDENT_SUP = 'N'
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = null
    ,cs.ASED_RESOLVE_INCIDENT_SUP = null
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
     ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where incident_id in(26057029,
26092702,
26127037,
26130076,
26085577,
26090622);

update CORP_ETL_COMPLAINTS_INCIDENTS
set ASeD_RESOLVE_INCIDENT_DOH = null, assd_perform_followup = null, gwf_followup_req = null, asf_resolve_incident_doh = 'N'
where incident_id = 26057029;

update CORP_ETL_COMPLAINTS_INCIDENTS
set GWF_RESOLVED_EES_CSS = 'Y'
where incident_id = 26100074;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
     ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and ASED_RESOLVE_INCIDENT_EES_CSS is not null
and ASSD_RESOLVE_INCIDENT_sup is null
and ASSD_RESOLVE_INCIDENT_doh is null
and ASSD_WITHDRAW_INCIDENT is null
and GWF_RESOLVED_EES_CSS = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%'); 

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_resolved_sup = 'N'
where incident_id in(
26035550,
26035872,
26142251);

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y',asf_resolve_incident_ees_css = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')      
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where ASSD_RESOLVE_INCIDENT_EES_CSS is  null
and ASED_RESOLVE_INCIDENT_EES_CSS is  null
and ASSD_RESOLVE_INCIDENT_sup is not null
and ASSD_RESOLVE_INCIDENT_doh is null
and ASSD_WITHDRAW_INCIDENT is null
--and GWF_RESOLVED_EES_CSS = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Refer to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set  gwf_resolved_sup = 'N',  cs.ASF_RESOLVE_INCIDENT_SUP = 'Y',asf_resolve_incident_ees_css = 'N'
    ,ased_resolve_incident_sup = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')  
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')      
    ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where ASSD_RESOLVE_INCIDENT_EES_CSS is  null
and ASED_RESOLVE_INCIDENT_EES_CSS is  null
and ASSD_RESOLVE_INCIDENT_sup is not null
and ASSD_RESOLVE_INCIDENT_doh is null
and ASSD_WITHDRAW_INCIDENT is null
--and GWF_RESOLVED_EES_CSS = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Refer to Supervisor')
where incident_id in(26139179,
26139347,
26139073,
26139456,
26142003);


update CORP_ETL_COMPLAINTS_INCIDENTS cs
set max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where incident_id in(26035668,
26039970,
26043156,
26040591,
26047622,
26038725,
26044029,
26049282,
26055475,
26060622,
26057407,
26055185,
26051238,
26073198,
26074620,
26074906,
26076672,
26079870,
26093639,
26093629,
26098972,
26099411,
26101105,
26119091,
26117598,
26116433,
26117890,
26125295,
26125294,
26123793,
26123480,
26122832,
26132309,
26145817,
26148414,
26146113,
26148605);

commit;


