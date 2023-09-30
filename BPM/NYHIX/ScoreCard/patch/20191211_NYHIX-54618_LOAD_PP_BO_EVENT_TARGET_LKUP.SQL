alter session set current_schema=MAXDAT;

update MAXDAT.PP_BO_EVENT_TARGET_LKUP
 set END_DATE='31-Oct-2019'
 where END_DATE='20-NOV-2019' 
 and CREATE_BY='CR2441';
 
update MAXDAT.PP_BO_EVENT_TARGET_LKUP
 set start_DATE='1-Nov-2019'
 where start_DATE='21-NOV-2019' 
 and end_date is null;

COMMIT;