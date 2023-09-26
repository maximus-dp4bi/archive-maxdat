update corp_etl_control
 set value = '20191001'
where name = 'IMR_TREND_CALC_START_DT';

update corp_etl_control
 set value = 'X'
where name = 'IMR_TREND_CALC_END_DT';

COMMIT;