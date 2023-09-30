delete from coverkids_approval_stg
where application_id in(210841,64031)
and cumulative_ind = 'N';

update corp_etl_control
set value = '2017/03/12 00:00:00'
where name = 'COVERKIDS_RPT_START_DATE';

commit;