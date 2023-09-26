update corp_etl_complaints_incidents
set incident_reason = 'County Services-Application/Renewal Processing Delay'
,incident_about = 'Complaint-LDSS/HRA'
where incident_id = 26101350;


update f_complaint_by_date
set dcmplia_id = 287
    ,dcmplir_id = 292
    ,inventory_count = 0
    ,completion_count = 1
    ,bucket_end_date = bucket_start_date
where fcmplbd_id =    226619; 


update corp_etl_complaints_incidents
set ased_perform_followup = complete_dt
where INCIDENT_STATUS in ('Incident Closed', 'Referral Closed')
and complete_dt is not null
and ((ASED_PERFORM_FOLLOWUP is null and ASSD_PERFORM_FOLLOWUP is not null)
or trunc(ASED_PERFORM_FOLLOWUP) < trunc(ASSD_PERFORM_FOLLOWUP ));

update corp_etl_complaints_incidents
set ased_resolve_incident_sup = to_date('10/07/2014 14:02:08','mm/dd/yyyy hh24:mi:ss')
   ,assd_resolve_incident_doh = to_date('10/07/2014 14:02:08','mm/dd/yyyy hh24:mi:ss')
   ,ased_resolve_incident_doh = to_date('10/14/2014 09:50:16','mm/dd/yyyy hh24:mi:ss')
   ,gwf_resolved_sup = 'N'
   ,asf_resolve_incident_doh = 'Y'
where incident_id = 26149990;

commit;