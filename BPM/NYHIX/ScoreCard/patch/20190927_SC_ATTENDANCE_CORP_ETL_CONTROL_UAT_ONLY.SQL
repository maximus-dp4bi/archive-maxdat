update MAXDAT.CORP_ETL_CONTROL
set value = '20190801'
where name = 'DP_SCOTECARD_ATTENDANCE_START_3_YYYYMMDD'
and value = '20191001';


update MAXDAT.CORP_ETL_CONTROL
set value = '78'
where name = 'DP_SCOTECARD_ATTENDANCE_START_3_LIMIT'
and value = '70';

-- commit if 2 rows updated