update nyhx_etl_complaints_incidents set forwarded = 'N' where incident_id in (
select incident_id from nyhx_etl_complaints_incidents where forward_dt is null and incident_id in 
(select incident_id from nyhx_etl_compl_incidents_oltp where forward_dt is not null));

commit;