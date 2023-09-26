update corp_etl_control
set value = 2
where name 'DOCNOTIF_LOOKBACK_DAYS';

commit;

