delete from coverkids_approval_stg
where application_id in(111055,
130883,
122039);

update corp_etl_control
set value = '2017/02/13 00:00:00'
where name = 'COVERKIDS_RPT_START_DATE';

commit;