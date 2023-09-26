
UPDATE corp_etl_list_lkup
SET out_var = out_var||',''Eligibility expansion requested started'',''Outreach No Longer Required'',''ELIG_EXPANSION_REQUEST_STARTED'''
where list_type='INC_STATUS'
and name = 'PI_INCIDNT_STATUS_WITHDRAN_BPM';

UPDATE corp_etl_process_incidents
SET CANCEL_DT = sysdate
,COMPLETE_DT = sysdate
,STAGE_DONE_DT = sysdate
,INSTANCE_STATUS = 'Complete'
,CANCEL_BY = 'MAXDAT'
,CANCEL_METHOD = 'Normal'
,CANCEL_REASON = 'TXEB-12780'
WHERE  instance_status = 'Active'
AND incident_type = 'Eligibility Expansion Request';

commit;