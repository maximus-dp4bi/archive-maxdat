/*
Created on 01/22/2015 by Raj A. per NYHIX-13070.
Updated on 08/10/2015 by Guy T. per NYHIX-16299.
Updated on 01/12/2016 by Guy T. per NYHIX-19636
Description: This is a clean up effort after holidays table is updated with 2015 calendar.
*/
update d_mw_v2_current
   set AGE_IN_BUSINESS_DAYS = mw_v2.GET_AGE_IN_BUSINESS_DAYS(CURR_WORK_RECEIPT_DATE,INSTANCE_END_DATE),
       TIMELINESS_STATUS = mw_v2.GET_TIMELINESS_STATUS(
														 INSTANCE_END_DATE,
														 TASK_TYPE_ID,
														 CURR_WORK_RECEIPT_DATE
														 ) 
 where trunc(INSTANCE_END_DATE) >= '1-JAN-2016'
 and trunc(INSTANCE_END_DATE) <= '5-JAN-2016';
commit;

-- update d_mw_current
   -- set "Age in Business Days" = manage_work.GET_AGE_IN_BUSINESS_DAYS("Create Date","Complete Date"),
       -- "Timeliness Status" = manage_work.GET_TIMELINESS_STATUS("Complete Date",
	                                                           -- "SLA Days Type",
															   -- "Age in Business Days",
															   -- "Age in Calendar Days",
															   -- "SLA Days")
 -- where trunc("Complete Date") >= '1-JAN-2016'
 -- and trunc("Complete Date") <= '5-JAN-2016';
-- commit;

update D_APPEALS_CURRENT
   set AGE_IN_BUSINESS_DAYS = nyhix_process_appeals.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,CUR_COMPLETE_DATE),
	   APPEAL_TIMELINESS_STATUS = nyhix_process_appeals.GET_TIMELINESS_STATUS(CREATE_DATE,
																			  SCHEDULE_HEARING_END,
														                      INCIDENT_TYPE)
   where trunc(CUR_COMPLETE_DATE) >= '1-JAN-2016'
   and trunc(CUR_COMPLETE_DATE) <= '5-JAN-2016';
commit;

update d_idr_current
   set  AGE_IN_BUSINESS_DAYS  = idr_incidents.GET_AGE_IN_BUSINESS_DAYS( create_dt, INSTANCE_COMPLETE_DT),
        IDR_TIMELINESS_STATUS = idr_incidents.GET_TIMELY_STATUS(create_dt, 'INFORMAL DISPUTE RESOLUTION', CUR_COMPLETE_DT)
  where trunc(instance_complete_dt) >= '1-JAN-2016'
  and trunc(instance_complete_dt) <= '5-JAN-2016';
commit;

  update D_MFB_CURRENT
   set AGE_IN_BUSINESS_DAYS = MAIL_FAX_BATCH.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,BATCH_COMPLETE_DT),
       TIMELINESS_STATUS    = MAIL_FAX_BATCH.GET_TIMELINESS_STATUS(CREATE_DT,BATCH_COMPLETE_DT,CANCEL_DT)
  where trunc(BATCH_COMPLETE_DT) >= '1-JAN-2016'
  and trunc(BATCH_COMPLETE_DT) <= '5-JAN-2016';   
commit;

-- update D_NYHIX_MFD_CURRENT
   -- set AGE_IN_BUSINESS_DAYS = NYHIX_MAIL_FAX_DOC.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COMPLETE_DT),
       -- TIMELINESS_STATUS    = NYHIX_MAIL_FAX_DOC.GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT,CANCEL_DT)
 -- where trunc(complete_dt) >=  '1-JAN-2016'
 -- and trunc(complete_dt) <=  '5-JAN-2016';
-- commit;

update D_NYHIX_MFD_CURRENT_V2
   set  AGE_IN_BUSINESS_DAYS = NYHIX_MAIL_FAX_DOC_V2.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COMPLETE_DT),
	    TIMELINESS_STATUS = NYHIX_MAIL_FAX_DOC_V2.GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT)
 where trunc(complete_dt) >=  '1-JAN-2016'
 and trunc(complete_dt) <=  '5-JAN-2016'; 
 commit;

 update  D_NYHIX_DOC_NOTIF_CURRENT
  set AGE_IN_BUSINESS_DAYS = NYHIX_DOC_NOTIFICATIONS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DT,COMPLETE_DT),
	  TIMELINESS_STATUS = NYHIX_DOC_NOTIFICATIONS.GET_TIMELINESS_STATUS(CREATE_DT,COMPLETE_DT,CANCEL_DT)
WHERE trunc(complete_dt) >=  '1-JAN-2016'
and trunc(complete_dt) <=  '5-JAN-2016';
commit;

 update  D_PL_CURRENT
  set AGE_IN_BUSINESS_DAYS = PROCESS_LETTERS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DATE),
	  TIMELINESS_STATUS = PROCESS_LETTERS.GET_TIMELINESS_STATUS(LETTER_TYPE,NEWBORN_FLAG,CREATE_DATE,COMPLETE_DATE)
WHERE trunc(complete_date) >=  '1-JAN-2016'
and trunc(complete_date) <=  '5-JAN-2016';
commit;

update  D_COMPLAINT_CURRENT
  set AGE_IN_BUSINESS_DAYS = PROCESS_COMPLAINTS_INCIDENTS.GET_AGE_IN_BUSINESS_DAYS(CREATE_DATE,COMPLETE_DT),
      TIMELINESS_STATUS = PROCESS_COMPLAINTS_INCIDENTS.GET_TIMELINESS_STATUS(CREATE_DATE,COMPLETE_DT,FORWARDED_FLAG,FORWARD_DT,INCIDENT_TYPE)
WHERE trunc(complete_dt) >=  '1-JAN-2016'
and trunc(complete_dt) <=  '5-JAN-2016'; 
commit;