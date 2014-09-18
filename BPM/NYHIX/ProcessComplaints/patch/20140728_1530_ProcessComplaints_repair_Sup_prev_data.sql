--the next 3 updates relate to nyhix-9721(1123 incidents)

update CORP_ETL_COMPLAINTS_INCIDENTS 
set ASSD_RESOLVE_INCIDENT_SUP = ASSD_RESOLVE_INCIDENT_EES_CSS
where ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and CREATED_BY_SUP = 'Y';

update CORP_ETL_COMPLAINTS_INCIDENTS  
set ased_resolve_incident_ees_css = null,
asf_resolve_incident_ees_css = 'N'
where ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and CREATED_BY_SUP = 'Y' and ased_resolve_incident_ees_css is not null;

update CORP_ETL_COMPLAINTS_INCIDENTS 
set ASSD_RESOLVE_INCIDENT_EES_CSS = null
where ASSD_RESOLVE_INCIDENT_EES_CSS is not null
and CREATED_BY_SUP = 'Y';

--the following update relates to nyhix-9720
update CORP_ETL_COMPLAINTS_INCIDENTS 
set ased_resolve_incident_ees_css = null,
asf_resolve_incident_ees_css = 'N'
where ASSD_RESOLVE_INCIDENT_EES_CSS is  null
and ased_resolve_incident_ees_css is not null
and ASF_RESOLVE_INCIDENT_EES_CSS = 'Y'
and created_by_sup = 'Y';


update corp_etl_complaints_incidents set ased_resolve_incident_doh = complete_dt
  where  INCIDENT_STATUS in ('Incident Closed', 'Referral Closed')
  and  assd_resolve_incident_doh is not null 
  and ased_resolve_incident_doh is null
  and complete_dt is not null; 
  
commit;