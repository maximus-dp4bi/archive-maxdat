-- CR_1284_PP_BO_EVENT_TARGET_LKUP

update MAXDAT.PP_BO_EVENT_TARGET_LKUP
set CREATE_BY ='CR 1284'			 
where EVENT_ID 	 = 1525 and start_date = to_date('20171201','yyyymmdd');

update MAXDAT.PP_BO_EVENT_TARGET_LKUP
set end_date = to_date('20171130','yyyymmdd')
where EVENT_ID 	 = 1525 and start_date = to_date('20170802','yyyymmdd');

commit;