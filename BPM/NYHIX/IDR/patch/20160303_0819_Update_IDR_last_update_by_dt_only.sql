Update nyhx_etl_idr_incidents i
set last_update_by_dt = (select iH.update_ts from INCIDENT_HEADER_stg IH where i.incident_id = ih.incident_header_id)
where  i.incident_id > 26036846;




commit;
 

