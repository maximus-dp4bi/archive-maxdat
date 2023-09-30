update MAXDAT.PP_BO_EVENT_TARGET_LKUP
set end_date = null
where EVENT_ID 	 = 1525 and start_date = to_date('20170802','yyyymmdd');

commit;

delete from MAXDAT.PP_BO_EVENT_TARGET_LKUP
where EVENT_ID 	 = 1525 
and START_DATE = to_date('1-Dec-2017','dd-mon-yyyy');

commit;
