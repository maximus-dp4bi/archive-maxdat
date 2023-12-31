--------------------------------------------------------
--  File created - Tuesday-September-17-2013   
--------------------------------------------------------
DROP VIEW "D_MONITOR_DISPUTES_SV";
--------------------------------------------------------
--  DDL for View D_MONITOR_DISPUTES_SV
--------------------------------------------------------

  CREATE OR REPLACE FORCE VIEW "D_MONITOR_DISPUTES_SV" ("MD_ID", "DISPUTE_ID", "DISPUTE_ID_CREATE_DATE", "ACCOUNT_ID", "CHANNEL", "WORK_REQUEST_ID", "DISPUTE_CREATE_DATE", "RECEIPT_DATE", "STAFF_USERID", "STAFF_ROLE", "REPORTER_TYPE", "DISPUTE_STATUS", "DISPUTE_STATUS_DATE", "COMPLETE_DATE", "CANCEL_DATE", "DISPUTE_LEVEL", "DISPUTE_LIABILITY", "LIABILITY_ASSIGNED_DATE", "LIABILITY_AGE_BUSINESS_DAYS", "SENT_TO_STATE_DATE", "DISPUTE_RESOLUTION", "DISPUTE_ACKNOWLEDGE_REQ_ID", "DISPUTE_DISPOSITION", "ASSD_PROCESS_DISPUTES", "ASED_PROCESS_DISPUTES", "ASF_PROCESS_DISPUTES", "STAGE_DONE_DATE", "STG_EXTRACT_DATE", "STG_LAST_UPDATE_DATE", "INSTANCE_STATUS", "INSTANCE_COMPLETE_DATE", "ACCOUNT_NUMBER", "WORK_REQUESTS_COMPLETED", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "STATUS_AGE_IN_BUS_DAYS", "STATUS_AGE_IN_CAL_DAYS") AS select 
   "MD_ID"  ,
	"DISPUTE_ID"  ,
	"DISPUTE_ID_CREATE_DATE"  ,
	"ACCOUNT_ID"  ,
	"CHANNEL" , 
	"WORK_REQUEST_ID"  ,
	"DISPUTE_CREATE_DATE"  ,
	"RECEIPT_DATE"  ,
	"STAFF_USERID" , 
	"STAFF_ROLE" , 
	"REPORTER_TYPE" , 
	"DISPUTE_STATUS" , 
	"DISPUTE_STATUS_DATE"  ,
	"COMPLETE_DATE"  ,
	"CANCEL_DATE"  ,
	"DISPUTE_LEVEL" , 
	"DISPUTE_LIABILITY" , 
	"LIABILITY_ASSIGNED_DATE"  ,
	"LIABILITY_AGE_BUSINESS_DAYS"  ,
	"SENT_TO_STATE_DATE"  ,
	"DISPUTE_RESOLUTION" , 
	"DISPUTE_ACKNOWLEDGE_REQ_ID"  ,
	"DISPUTE_DISPOSITION" , 
	"ASSD_PROCESS_DISPUTES"  ,
	"ASED_PROCESS_DISPUTES"  ,
	"ASF_PROCESS_DISPUTES" , 
	"STAGE_DONE_DATE"  ,
	"STG_EXTRACT_DATE"  ,
	"STG_LAST_UPDATE_DATE"  ,
	"INSTANCE_STATUS" , 
	"INSTANCE_COMPLETE_DATE"  ,
	"ACCOUNT_NUMBER"  ,
	"WORK_REQUESTS_COMPLETED" ,
business_days_between(DISPUTE_CREATE_DATE, sysdate)    as "AGE_IN_BUSINESS_DAYS",
round(sysdate - DISPUTE_CREATE_DATE,0) as "AGE_IN_CALENDAR_DAYS",
  business_days_between(DISPUTE_STATUS_DATE, sysdate) as "STATUS_AGE_IN_BUS_DAYS", 
  round(sysdate - DISPUTE_STATUS_DATE,0 ) as "STATUS_AGE_IN_CAL_DAYS"
   from
   FLHK_ETL_MONITOR_DISPUTES;
/
