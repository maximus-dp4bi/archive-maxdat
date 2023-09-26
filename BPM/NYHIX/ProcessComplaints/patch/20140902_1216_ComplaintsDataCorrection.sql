update CORP_ETL_COMPLAINTS_INCIDENTS
set asf_resolve_incident_ees_css = 'N'
where ASSD_RESOLVE_INCIDENT_EES_CSS is null 
and ASF_RESOLVE_INCIDENT_EES_CSS = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS
set ASF_RESOLVE_INCIDENT_SUP = 'Y'
where ASF_RESOLVE_INCIDENT_SUP = 'N' 
and ASED_RESOLVE_INCIDENT_SUP is not null;

UPDATE CORP_ETL_COMPLAINTS_INCIDENTS
set assd_resolve_incident_sup = ased_resolve_incident_sup,
    assd_resolve_incident_doh = ased_resolve_incident_sup,
    gwf_escalate_to_state = null ,
    max_inci_stat_hist_id = 334020    
where incident_id = 26122104;

UPDATE CORP_ETL_COMPLAINTS_INCIDENTS
set GWF_ESCALATE_TO_STATE = 'Y'
where incident_id = 26117838;


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

update CORP_ETL_COMPLAINTS_INCIDENTS cs
set gwf_resolved_ees_css = 'N', asf_resolve_incident_ees_css = 'Y'   
    ,gwf_escalate_to_state = 'Y'
    ,ASSD_RESOLVE_INCIDENT_DOH = (select min(create_ts) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
     ,max_inci_stat_hist_id = (select min(incident_header_stat_hist_id) from incident_header_stat_hist_stg hs where hs.incident_header_id = cs.incident_id and hs.incident_status like '%State%')
where incident_id = 26100074
;  


commit;