 Alter session set current_schema=MAXDAT;

 update maxdat.PP_BO_EVENT_TARGET_LKUP
  set end_date='31-dec-2019' 
  where end_date='20-Dec-2019'
  and event_id in ( 1425, 1552, 1553 );
  
  update maxdat.PP_BO_EVENT_TARGET_LKUP
  set start_date='1-Jan-2020' 
  where start_date='21-Dec-2019'
  and event_id in ( 1425, 1552, 1553 );  

commit;