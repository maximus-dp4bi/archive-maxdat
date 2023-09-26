update corp_etl_control
 set value = '20160815'
where name = 'IMR_TREND_CALC_START_DT';

update corp_etl_control
 set value = '20160817'
where name = 'IMR_TREND_CALC_END_DT';

COMMIT;