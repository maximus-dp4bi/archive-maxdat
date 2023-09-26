update MAXDAT.CORP_ETL_CONTROL set value = '1-JAN-16'
where name = 'APPEALS_SCHED_LAST_UPDATE_DT';

commit;
