delete from corp_etl_complaints_incidents
where incident_id = '26108036'
;

delete from corp_etl_compl_incidents_oltp
where incident_id = '26108036'
;

delete from CORP_ETL_COMPL_INCIDN_WIP_BPM
where incident_id = '26108036'
;

delete from F_COMPLAINT_BY_DATE
where cmpl_bi_id in (select cmpl_bi_id from D_COMPLAINT_CURRENT where incident_id = '26108036')
;

delete from D_COMPLAINT_CURRENT
where incident_id = '26108036'
;

DELETE FROM BPM_UPDATE_EVENT_QUEUE
where BSL_ID = 22 
and identifier in('26108036')
;

commit;
