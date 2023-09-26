        
UPDATE corp_etl_complaints_incidents i
SET sla_satisfied = 'Y', forwarded = 'Y',sla_complete_dt = (select min(create_ts) from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
    ,forward_dt = (select min(create_ts) from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
    ,forwarded_to = (select incident_status from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
where incident_id = 26101350    ;


update f_complaint_by_date f
set dcmplss_id = 1, sla_complete_date = (select sla_complete_date from d_complaint_current cc where cc.cmpl_bi_id = f.cmpl_bi_id)
where cmpl_bi_id = 5507446;

commit;