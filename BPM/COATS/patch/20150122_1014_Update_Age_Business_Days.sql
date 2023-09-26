/*
Description: This is a clean up effort after holidays table is updated with 2015 calendar.
*/
update d_mw_current
   set "Age in Business Days" = manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
       "Timeliness Status" = manage_work.GET_TIMELINESS_STATUS("Complete Date",
	                                                           "SLA Days Type",
															   "Age in Business Days",
															   "Age in Calendar Days",
															   "SLA Days")
 where trunc("Complete Date") >= '1-JAN-2015';
commit;

