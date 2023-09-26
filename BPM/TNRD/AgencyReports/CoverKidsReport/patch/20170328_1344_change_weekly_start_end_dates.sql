UPDATE corp_etl_control
SET value =  '2017/03/24 00:00:00'
WHERE name = 'COVERKIDS_WKLY_RPT_START_DATE'; 

UPDATE corp_etl_control
SET value =  '2017/03/31 23:00:00'
WHERE name = 'COVERKIDS_WKLY_RPT_END_DATE';

delete from coverkids_approval_stg
where application_id in(111032,115026)
and cumulative_ind = 'W';

commit;