UPDATE corp_etl_complaints_incidents i
SET sla_satisfied = 'Y', forwarded = 'Y',sla_complete_dt = (select min(create_ts) from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
    ,forward_dt = (select min(create_ts) from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
    ,forwarded_to = (select incident_status from incident_header_stat_hist_stg h where i.incident_id = h.incident_header_id and incident_status like '%State%')
where incident_id in(26091200,
26094424,
26094445,
26097670,
26100074,
26127886,
26136582,
26142179,
26165759)    ;

UPDATE corp_etl_complaints_incidents
SET sla_satisfied = 'Y',sla_complete_dt = complete_dt
where incident_id in(26060635,
26131281,
26103692,
26203622);

update f_complaint_by_date f
set dcmplss_id = 1, sla_complete_date = (select sla_complete_date from d_complaint_current cc where cc.cmpl_bi_id = f.cmpl_bi_id)
where fcmplbd_id in(188333,
971393,
971394,
971395,
971396,
982072,
386147,
971397,
600542,
709643,
971398,
980017,
1216541);

update f_complaint_by_date
set dcmplss_id = 1,sla_complete_date = to_date('09/23/2014 17:37:52','mm/dd/yyyy hh24:mi:ss')
where fcmplbd_id = 1051382;

commit;