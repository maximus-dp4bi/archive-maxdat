update corp_etl_complaints_incidents  stg set assd_resolve_incident_sup = null
where created_by_sup = 'N'
and not exists (select incident_header_id from incident_header_stat_hist_stg where incident_header_id = stg.incident_id and  status_cd in ( 'REFERRED_TO_SUPERVISOR'))
and assd_resolve_incident_sup is not null;

commit;