update corp_etl_control
set name = 'MAX_UPDATE_TS_CASES'
  ,value_type = 'D'
  ,value = '2016/01/12 01:01:01'
  ,description = 'Max Last_Update_TS for the CASES_STG table'
where name = 'MAX_CASE_ID_CASES';

commit;
