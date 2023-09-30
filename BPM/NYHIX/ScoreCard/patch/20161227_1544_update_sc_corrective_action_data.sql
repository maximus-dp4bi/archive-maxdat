
update SC_CORRECTIVE_ACTION C1
set (CREATE_BY,LAST_UPDATED_BY)  = (select H1.SUPERVISOR_NAME, H1.SUPERVISOR_NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY H1 where H1.STAFF_STAFF_ID = C1.STAFF_ID AND TRUNC(C1.CREATE_DATETIME) <= to_date('14-DEC-16','dd-MON-yy'))
where exists (select 1 FROM DP_SCORECARD.SCORECARD_HIERARCHY H1 WHERE H1.STAFF_STAFF_ID = C1.STAFF_ID and TRUNC(C1.CREATE_DATETIME) <= to_date('14-DEC-16','dd-MON-yy')); 

Commit;

