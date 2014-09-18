--------------------------------------------------------
--  File created - Wednesday-June-05-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FLHK_INITIATE_RENEWALS_WIP_BPM
--------------------------------------------------------

  CREATE TABLE "FLHK_INITIATE_RENEWALS_WIP_BPM" 
  ("IR_ID" NUMBER, 
  "ACCOUNT_ID" NUMBER,
  "RENEWAL_PERIOD_START_DATE" DATE,
  "APPLICATION_ID" NUMBER,
  "RENEWAL_PERIOD_END_DATE" DATE,
  "RENEWAL_STATUS" VARCHAR2(100),
  "RENEWAL_STATUS_DATE" DATE,
  "CANCEL_DATE" DATE,
  "CANCEL_REASON" DATE, 
  "COMPLETE_DATE" DATE, 
  "RENEWAL_LETTER_REQ_ID" NUMBER,
  "TIME_TO_RENEWAL_CALL_ID" NUMBER,
  "RENEWAL_REMINDER_CALL_ID" NUMBER,
  "RENEWAL_CANCELLATION_CALL_ID" NUMBER,
  "DOR_MATCH_STATUS" VARCHAR2(100), 
  "DOR_MATCH_STATUS_DATE" DATE, 
  "DEO_MATCH_STATUS" VARCHAR2(100), 
  "DEO_MATCH_STATUS_DATE" DATE,
  "ASSD_IDENTIFY_RENEWAL_ACCTS" DATE, 
  "ASED_IDENTIFY_RENEWAL_ACCTS" DATE, 
  "ASF_IDENTIFY_RENEWAL_ACCTS" VARCHAR2(1), 
  "ASPB_IDENTIFY_RENEWAL_ACCTS" VARCHAR2(100),
  "ASSD_REQUEST_NOTIFICATION" DATE,
  "ASED_REQUEST_NOTIFICATION" DATE, 
  "ASF_REQUEST_NOTIFICATION" VARCHAR2(1), 
  "ASPB_REQUEST_NOTIFICATION" VARCHAR2(100),
  "ASSD_WAIT_FOR_ALL_DISENROLLED" DATE,
  "ASED_WAIT_FOR_ALL_DISENROLLED" DATE,
  "ASF_WAIT_FOR_ALL_DISENROLLED" VARCHAR2(1),
  "ASPB_WAIT_FOR_ALL_DISENROLLED" VARCHAR2(100),
  "ASED_CANCEL_RENEWAL" DATE,
  "ASF_CANCEL_RENEWAL" VARCHAR2(1), 
  "GWF_APP_RECEIVED" VARCHAR2(1), 
  "STAGE_DONE_DATE" DATE, 
  "STG_EXTRACT_DATE" DATE, 
  "STG_LAST_UPDATE_DATE" DATE, 
  "INSTANCE_STATUS" VARCHAR2(10),
  "IR_PROCESSED" VARCHAR2(1)
  "INSTANCE_COMPLETE_DATE" DATE,
  "COUNT_OF_ELIGIBLE_MEMBERS" NUMBER, 
  "APP_RECEIVED_DATE" DATE, 
  "APP_ENTERED_BY" VARCHAR2(100)
  "WAITING_FOR_DISENROLLMENT" NUMBER DEFAULT 0));

   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."IR_ID" IS 'Primary key.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ACCOUNT_ID" IS 'The Account ID represents the household account number (unique ID for the account) associated with the account in renewal period';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_PERIOD_START_DATE" IS 'The date the account enters renewal period (two months prior to the last day of continuous eligibility (the end of the current eligibility period). ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."APPLICATION_ID" IS 'Represents the application number (unique identifier) linked to the account for which the renewal was initiated. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_PERIOD_END_DATE" IS 'The date the renewal period ends, which is the last day of continuous eligibility.  ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_STATUS" IS 'The account''s renewal status.  This describes what actions have occurred during the renewal timeline. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_STATUS_DATE" IS 'The date the renewal status was updated. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."CANCEL_DATE" IS 'Date the account in renewal period was identifed as not required to be processed (terminal state) during this renewal period. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."CANCEL_REASON" IS 'The reason the renewal instance was canceled.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."COMPLETE_DATE" IS 'The date the account, which was in its renewal period, reached a termination point in the process. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_LETTER_REQ_ID" IS 'This is the letter request ID of the Renewal Letter notification that was requested when an account entered the renewal process. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."TIME_TO_RENEWAL_CALL_ID" IS 'Renewal Outbound Call ID is the call ID of the outbound call request when an account entered the renewal period. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_REMINDER_CALL_ID" IS 'Renewal Reminder Outbound Call ID is the call ID of the outbound call request to remind the members of the account that the account has initiated the renewal period. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."RENEWAL_CANCELLATION_CALL_ID" IS 'Renewal Cancellation Outbound Call ID is the call ID of the outbound call request to inform account that has been initiated the renewal period that is about to timeout.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."DOR_MATCH_STATUS" IS 'This attribute tracks the status of the request for earned income and unemployment income from the Department of Revenue (DOR).  ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."DOR_MATCH_STATUS_DATE" IS 'This is the date DOR request was sent to or returned from DOR. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."DEO_MATCH_STATUS" IS 'This attribute tracks the status of the request for earned income and unemployment income from the Department of Economic Opportunity (DEO).  ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."DEO_MATCH_STATUS_DATE" IS 'This is the date DEO request was sent to or returned from DEO. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASSD_IDENTIFY_RENEWAL_ACCTS" IS 'The date monitoring begins for an account which will enter renewal. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASED_IDENTIFY_RENEWAL_ACCTS" IS 'The date the account enters the renewal period, which is 2 months prior last day of continuous eligibility (renewal period start date) ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASF_IDENTIFY_RENEWAL_ACCTS" IS 'Indicates when the "Identify Renewal Accounts" Activity is completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASPB_IDENTIFY_RENEWAL_ACCTS" IS 'Name of the system that completed the "Identify Renewal Accounts" activity.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASSD_REQUEST_NOTIFICATION" IS 'The date that the Request Notification Activity begins. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASED_REQUEST_NOTIFICATION" IS 'The date that the Request Notification Activity has completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASF_REQUEST_NOTIFICATION" IS 'Indicates when the "Request Notification" Activity is completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASPB_REQUEST_NOTIFICATION" IS 'Name of the system that completed the "Request Notification" activity.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASSD_WAIT_FOR_ALL_DISENROLLED" IS 'The date that the Wait until all members are disenrolled'' begins.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASED_WAIT_FOR_ALL_DISENROLLED" IS 'The date that the Wait until all members are disenrolled Activity has completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASF_WAIT_FOR_ALL_DISENROLLED" IS 'Indicates when the "Wait until all members are disenrolled" Activity is completed. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASPB_WAIT_FOR_ALL_DISENROLLED" IS 'Name of the system that completed the "Wait until all members are disenrolled" activity.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASED_CANCEL_RENEWAL" IS 'The date that Cancel Renewal Activity has completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."ASF_CANCEL_RENEWAL" IS 'Indicates when the "Wait until all members are disenrolled" Activity is completed. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."GWF_APP_RECEIVED" IS 'Gateway rule for renewal application received or not. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."STAGE_DONE_DATE" IS 'Date the renewal is closed and no futher ETL processing is to occur.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."STG_EXTRACT_DATE" IS 'Date the row was initially extracted from VIDA.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."STG_LAST_UPDATE_DATE" IS 'The last ETL update date for the row. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."INSTANCE_STATUS" IS 'Status of the row ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."IR_PROCESSED" IS 'flag to track updates from the source system.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."INSTANCE_COMPLETE_DATE" IS 'System date when the renewal is finally completed.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."COUNT_OF_ELIGIBLE_MEMBERS" IS 'Count of the number of eligibile members on an account.';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."APP_RECEIVED_DATE" IS 'Date the renewal application was received. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWALS_WIP_BPM"."APP_ENTERED_BY" IS 'Who entered the renewal application. ';
   COMMENT ON COLUMN "FLHK_INITIATE_RENEWAL_OLTP_STG"."WAITING_FOR_DISENROLLMENT" IS 'Count of members waiting for disenrollment in an account.';
/
--------------------------------------------------------
--  Constraints for Table FLHK_INITIATE_RENEWALS_WIP_BPM
--------------------------------------------------------

  ALTER TABLE "FLHK_INITIATE_RENEWALS_WIP_BPM" MODIFY ("IR_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_INITIATE_RENEWALS_WIP_BPM" MODIFY ("ACCOUNT_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_INITIATE_RENEWALS_WIP_BPM" MODIFY ("RENEWAL_PERIOD_START_DATE" NOT NULL ENABLE);
/
--------------------------------------------------------
--  DDL for Trigger FLHK_INITIATE_RENEW_WIP_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "FLHK_INITIATE_RENEW_WIP_TRG" 
   before insert on "FLHK_INITIATE_RENEWALS_WIP_BPM" 
   for each row 
begin  
   if inserting then 
      if :NEW."IR_ID" is null then 
         select FLHK_INITIATE_RENEWAL_WIP_SEQ.nextval into :NEW."IR_ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "FLHK_INITIATE_RENEW_WIP_TRG" ENABLE;
/
