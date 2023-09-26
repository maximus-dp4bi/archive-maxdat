update corp_etl_control
set value = 26036846  -- resets IDR_ID to 1 Jan 2014 will reprocess ~ 11K records to update the update_ts
where name in (
'LAST_IDR_INCIDENT_ID');

commit;
