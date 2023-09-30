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
   ,asf_resolve_incident_ees_css = 'N'
where  created_by_name = created_by_sup_name
and created_by_sup = 'N';


update CORP_ETL_COMPLAINTS_INCIDENTS cs
set GWF_RESOLVED_EES_CSS = 'Y',cs.ASF_RESOLVE_INCIDENT_EES_CSS = 'Y', ASED_RESOLVE_INCIDENT_EES_CSS = incident_status_dt
where created_by_sup = 'N'
and (cs.GWF_RESOLVED_EES_CSS is null or cs.GWF_RESOLVED_EES_CSS = 'N')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor');

--referred to state then closed
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y' 
    ,gwf_followup_req = CASE WHEN staff_type_cd = 'STATE' THEN 'N' ELSE null end
    ,gwf_return_to_state = CASE WHEN staff_type_cd != 'STATE' THEN 'N' ELSE null end        
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'N'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_RESOLVE_INCIDENT_DOH = (select max(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASSD_PERFORM_FOLLOWUP = (select max(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
    ,ASED_PERFORM_FOLLOWUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,cs.ASF_RESOLVE_INCIDENT_DOH = 'Y'     
    ,gwf_followup_req = 'Y'
    ,asf_perform_followup = 'Y'
where created_by_sup = 'N'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and followup_flag = 'Y'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Referred to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Referred to Supervisor')
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
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
    ased_resolve_incident_ees_css = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Referred to Supervisor')
    ,cs.ASSD_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status = 'Referred to Supervisor')
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
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;


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
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor');

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
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor');


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
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y',
   cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,gwf_resolved_sup = 'Y'
    ,instance_status = 'Complete'
    ,stage_done_dt = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,complete_dt = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,incident_status = 'Incident Closed'
where created_by_sup = 'N'
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_id = 26143028;


update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = null, asf_resolve_incident_ees_css = 'N',
   cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')    
    ,ASSD_RESOLVE_INCIDENT_DOH = case when assd_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%') else assd_resolve_incident_doh end
    ,ASED_RESOLVE_INCIDENT_DOH = case when ased_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%') else ased_resolve_incident_doh end
    ,cs.ASF_RESOLVE_INCIDENT_DOH = case when asf_resolve_incident_doh = 'N' then 'Y' else asf_resolve_incident_doh end            
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = 'N'
    ,gwf_resolved_sup = 'N'
where created_by_sup = 'Y'
and ASSD_RESOLVE_INCIDENT_SUP is not null 
and ASED_RESOLVE_INCIDENT_SUP is null
and incident_status like '%Close%'
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor');

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = null, asf_resolve_incident_ees_css = 'N',
   cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')    
     ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = null
    ,gwf_resolved_sup = 'Y'
where incident_id = 26141681;

update CORP_ETL_COMPLAINTS_INCIDENTS
set assd_resolve_incident_sup = assd_resolve_incident_ees_css  
where created_by_sup = 'Y'
and ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and assd_resolve_incident_sup is null
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set ased_resolve_incident_sup = ased_resolve_incident_ees_css
where  created_by_sup = 'Y'
and ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and assd_resolve_incident_sup is null;

update CORP_ETL_COMPLAINTS_INCIDENTS
set assd_resolve_incident_ees_css = null
   ,ased_resolve_incident_ees_css = null 
   ,GWF_RESOLVED_EES_CSS = null
   ,asf_resolve_incident_ees_css = 'N'
where   created_by_sup = 'Y'
and GWF_RESOLVED_EES_CSS is not null
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is not null;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_sup = 'Y'
where created_by_sup = 'Y'
and assd_resolve_incident_sup is not null
and ased_resolve_incident_sup is not null
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%'); 

update CORP_ETL_COMPLAINTS_INCIDENTS
set gwf_escalate_to_state = null
where gwf_escalate_to_state = 'Y'
and created_by_sup = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS
set asf_resolve_incident_ees_css = 'N'
where ASSD_RESOLVE_INCIDENT_EES_CSS is null 
and ASF_RESOLVE_INCIDENT_EES_CSS = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS
set ASF_RESOLVE_INCIDENT_SUP = 'Y'
where ASF_RESOLVE_INCIDENT_SUP = 'N' 
and ASED_RESOLVE_INCIDENT_SUP is not null;


UPDATE CORP_ETL_COMPLAINTS_INCIDENTS
set GWF_FOLLOWUP_REQ = 'Y'
where GWF_FOLLOWUP_REQ = 'N' 
and FOLLOWUP_FLAG = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS
set asf_resolve_incident_ees_css = 'N',gwf_escalate_to_state = null
where ASED_RESOLVE_INCIDENT_EES_CSS is null 
and ASF_RESOLVE_INCIDENT_EES_CSS = 'Y';

UPDATE  CORP_ETL_COMPLAINTS_INCIDENTS
set GWF_ESCALATE_TO_STATE = 'N'
where ASED_RESOLVE_INCIDENT_SUP is not null
and GWF_ESCALATE_TO_STATE is null
and created_by_sup = 'N';

UPDATE CORP_ETL_COMPLAINTS_INCIDENTS
set GWF_RESOLVED_EES_CSS = 'N'
where ASED_RESOLVE_INCIDENT_EES_CSS is not null 
and GWF_RESOLVED_EES_CSS is null
and incident_status like '%Close%';


update CORP_ETL_COMPLAINTS_INCIDENTS
set ased_perform_followup = incident_status_dt
where ASSD_PERFORM_FOLLOWUP is not null 
and ASED_PERFORM_FOLLOWUP is null
and incident_status like '%Close%';

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set ASSD_RESOLVE_INCIDENT_SUP = assd_resolve_incident_ees_css
where created_by_sup = 'Y'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;
 
update CORP_ETL_COMPLAINTS_INCIDENTS cs
set assd_resolve_incident_ees_css = null,
  ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
 ,ASSD_RESOLVE_INCIDENT_DOH = case when assd_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%') else assd_resolve_incident_doh end
    ,ASED_RESOLVE_INCIDENT_DOH = case when ased_resolve_incident_doh is null then (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%') else ased_resolve_incident_doh end
    ,cs.ASF_RESOLVE_INCIDENT_DOH = case when asf_resolve_incident_doh = 'N' then 'Y' else asf_resolve_incident_doh end            
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = null
    ,gwf_resolved_sup = 'N'    
where created_by_sup = 'Y'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and not  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;


update CORP_ETL_COMPLAINTS_INCIDENTS cs
set ASSD_RESOLVE_INCIDENT_SUP = assd_resolve_incident_ees_css
where created_by_sup = 'Y'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and   exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = null, asf_resolve_incident_ees_css = 'N',assd_resolve_incident_ees_css = null        
    ,cs.ASED_RESOLVE_INCIDENT_SUP = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%Close%')
    ,asf_resolve_incident_sup = 'Y'
    ,gwf_escalate_to_state = null
    ,gwf_resolved_sup = 'Y'    
where created_by_sup = 'Y'
and assd_resolve_incident_ees_css is not null
and ased_resolve_incident_ees_css is null
and ASSD_WITHDRAW_INCIDENT is null
and incident_status not like '%Open%'
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%Close%')
and not exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status like '%State%')
and  exists(select 1 from INCIDENT_HEADER_STAT_HIST_STG stg where cs.incident_id = stg.incident_header_id and stg.incident_status = 'Referred to Supervisor')
;

commit;

