delete from coverkids_approval_stg
where application_id in(126902,
102987,
165003)
and cumulative_ind = 'N';

update corp_etl_control
set value = '2017/02/20 00:00:00'
where name = 'COVERKIDS_RPT_START_DATE';

commit;