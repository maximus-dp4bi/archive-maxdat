UPDATE maxdat.corp_etl_control
set value = TO_CHAR(to_date('2018/03/01 00:00:00','YYYY/MM/DD HH24:MI:SS'), 'YYYY/MM/DD HH24:MI:SS')
WHERE name = 'UNDERAGE_OI_RPT_START_DATE';
commit;