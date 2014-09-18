--------------------------------------------------------
--  File created - Monday-July-01-2013   
--------------------------------------------------------
--------------------------------------------------------
--  DDL for Table FLHK_ETL_MEMBER_ELIGIBILITY
--------------------------------------------------------

  CREATE TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" 
  ("ME_ID" NUMBER,
  "COV_RQST_ID" NUMBER,
  "CREATE_DATE" DATE,
  "ELIG_STATUS" VARCHAR2(100),
  "ELIG_STATUS_DATE" DATE,
  "PENDING_REASON" VARCHAR2(100),
  "PENDING_REASON_DATE" DATE,
  "NOT_ELIG_REASON" VARCHAR2(100),
  "NOT_APPLYING_REASON" VARCHAR2(20),
  "PROGRAM" VARCHAR2(100),
  "APPLICATION_ID" NUMBER,
  "ACCOUNT_ID" NUMBER,
  "MEMBER_ID" NUMBER, 
  "LAST_UPDATE_DATE" DATE,
  "LAST_UPDATE_BY_NAME" VARCHAR2(100),
  "MEDICAID_REFERRAL" VARCHAR2(100), 
  "MEDICAID_REFERRAL_SENT_DATE" DATE,
  "MEDICAID_REFERRAL_REC_DATE" DATE,
  "ALL_MI_SATISFIED" VARCHAR2(1),
  "SSN_APPLY_DATE" DATE,
  "RACE_1" VARCHAR2(100), 
  "RACE_2" VARCHAR2(100), 
  "ETHNICITY" VARCHAR2(100), 
  "MEMBER_ZIP_CODE" NUMBER,
  "COUNTY" VARCHAR2(100), 
  "MEMBER_STATE" VARCHAR2(100), 
  "TOTAL_MEMBER_INCOME_AMT" NUMBER(8,2), 
  "INCOME_VERIF_STATUS" VARCHAR2(20),
  "INCOME_VERIF_STATUS_DATE" DATE,
  "CHILDCARE_EXPENSE" NUMBER(8,2),
  "RELATIONSHIP_PARENT1" VARCHAR2(100),
  "RELATIONSHIP_PARENT2" VARCHAR2(100), 
  "UNBORN_CHILD_DUE_DATE" DATE, 
  "OTHER_INSURANCE_ANSWER" VARCHAR2(1), 
  "VOLUNTARY_CANCEL_ANSWER" VARCHAR2(1),
  "LIMITED_IN_ANY_WAY" VARCHAR2(1),
  "NEEDS_SPECIAL_THERAPY" VARCHAR2(1), 
  "USES_MORE_MED_CARE" VARCHAR2(1), 
  "CMSN_OPT_ANSWER" VARCHAR2(20),
  "DENTAL_COVERAGE_FLAG" VARCHAR2(1),
  "CITIZENSHIP_VERIFIED" VARCHAR2(1),
  "CITIZENSHIP_VERIF_DATE" DATE, 
  "CITIZENSHIP_VERIF_SOURCE_DOC" VARCHAR2(100),
  "CITIZENSHIP_INSUFF_REASON" VARCHAR2(100), 
  "IDENTITY_VERIFIED" VARCHAR2(1), 
  "IDENTITY_VERIF_DATE" DATE, 
  "IDENTITY_VERIF_SOURCE_DOC" VARCHAR2(100),
  "IDENTITY_INSUFF_REASON" VARCHAR2(100),
  "TRIBAL_MBRSHIP_VERIFIED" VARCHAR2(1),
  "TRIBAL_MBRSHIP_INSUFF_REASON" VARCHAR2(100),
  "ELIG_RESULT_ID" NUMBER,
  "ELIG_RESULT_DATE" DATE,
  "PRE_ELIG_RUN_DATE" DATE,
  "AGENCY_MATCH" VARCHAR2(1), 
  "AGENCY_MATCH_DATE" DATE,
  "IVIC_WRK_REQ_ID" NUMBER,
  "PENDING_ELIG_NTFY_RQST_ID" NUMBER, 
  "APP_EXPIRED_NTFY_RQST_ID" NUMBER,
  "APP_EXPIRED_NTFY_RQST_DATE" DATE,
  "ELIG_OUTCOME_NTFY_RQST_ID" NUMBER,
  "COMPLETE_DATE" DATE, 
  "ASSD_RVW_ELIG" DATE, 
  "ASED_RVW_ELIG" DATE,
  "ASF_RVW_ELIG" VARCHAR2(1), 
  "ASSD_COV_REQ" DATE, 
  "ASED_COV_REQ" DATE,
  "ASF_COV_REQ" VARCHAR2(1),
  "ASSD_NTFY_OUTCOME" DATE,
  "ASED_NTFY_OUTCOME" DATE, 
  "ASF_NTFY_OUTCOME" VARCHAR2(1),
  "ASSD_RECEIVE_PROCESS_MI" DATE,
  "ASED_RECEIVE_PROCESS_MI" DATE,
  "ASF_RECEIVE_PROCESS_MI" VARCHAR2(1), 
  "ASSD_NTFY_PENDING_ELIG" DATE,
  "ASED_NTFY_PENDING_ELIG" DATE, 
  "ASF_NTFY_PENDING_ELIG" VARCHAR2(1),
  "ASSD_NTFY_TIMEOUT" DATE, 
  "ASED_NTFY_TIMEOUT" DATE,
  "ASF_NTFY_TIMEOUT" VARCHAR2(1), 
  "ASED_CANCEL_REQUEST" DATE,
  "GWF_AUTO_DETERMINED" VARCHAR2(1),
  "GWF_ELIG_DETERMINED" VARCHAR2(1),
  "GWF_MISSING_INFO" VARCHAR2(1),
  "GWF_ELIG_TIMEOUT" VARCHAR2(1), 
  "GWF_TIMEOUT_REV" VARCHAR2(1), 
  "STAGE_DONE_DATE" DATE, 
  "STG_EXTRACT_DATE" DATE DEFAULT SYSDATE, 
  "STG_LAST_UPDATE_DATE" DATE DEFAULT SYSDATE,
  "ME_PROCESSED" VARCHAR2(1) DEFAULT NULL, 
  "INSTANCE_STATUS" VARCHAR2(20),
  "CANCEL_DATE" DATE,
  "IVIC_WRK_REQ_DATE" DATE,
  "IVIC_COMPLETE_DATE" DATE) ;

   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ME_ID" IS 'Primary key';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."COV_RQST_ID" IS 'Unique identifier for the Coverage Request in the source system.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CREATE_DATE" IS 'Create Date is defined as the date that the Coverage Request was created in the Vida system';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ELIG_STATUS" IS 'The results of the eligibility determination. Proces ends at Eligible, Not Eligible, Full Pay, or Not Applying';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ELIG_STATUS_DATE" IS 'The date when the eligibility changed status.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."PENDING_REASON" IS 'Reason why the Eligibility instance is in Pending state and is waiting in the process';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."PENDING_REASON_DATE" IS 'Date when the Pending Reason was set.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."NOT_ELIG_REASON" IS 'Reason why the Eligibility instance is in Not Eligible state or denied';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."NOT_APPLYING_REASON" IS 'Reason why the Eligibility instance is in Not Applying state';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."PROGRAM" IS 'What benefit eligibility for member is being determined. Programs Eligibility determination made in VIDA (CMSN, HK, MK)';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."APPLICATION_ID" IS 'Application ID is defined as a unique identifier for the application in the source system. This identifies the source of the Coverage Request';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ACCOUNT_ID" IS 'This is the ID for a collection of members usually sharing a common household address.  Always headed by a primary account Holder who makes decisions for the beneficiaries.  This is the unique identifier of that account. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEMBER_ID" IS 'This is the unique ID for a member requesting coverage.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."LAST_UPDATE_DATE" IS 'Date the member eligibility request was last updated in source system';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."LAST_UPDATE_BY_NAME" IS 'Name of the staff member that last claimed, modified, worked, escalated or forwarded the member eligibility request. This name should be formatted as: "Last, First MI"';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEDICAID_REFERRAL" IS 'This is the outcome determination for the Medicaid referal. Values Null, Pending, Medicaid Eligible,Not Eligible for Medicaid';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEDICAID_REFERRAL_SENT_DATE" IS 'The date the Medicaid referral was sent';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEDICAID_REFERRAL_REC_DATE" IS 'The date the Medicaid referral was received from the Medicaid agency.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ALL_MI_SATISFIED" IS 'This flag is set when all missing information has been satisfied.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."SSN_APPLY_DATE" IS 'This is the date the member applied for a SSN. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."RACE_1" IS 'This is the first race answer entered on the application for the member requesting coverage. A member may specifiy up to 2 different races on an application';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."RACE_2" IS 'This is the second race answer entered on the application for the member requesting coverage. A member may specify up to 2 different races on an application';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ETHNICITY" IS 'This is the ethnicity entered on the application for the member requesting coverage';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEMBER_ZIP_CODE" IS 'This is the zip code entered on the application';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."COUNTY" IS 'This is the county entered on the application for the member requesting coverage';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."MEMBER_STATE" IS 'This is the member''s state of residence';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."TOTAL_MEMBER_INCOME_AMT" IS 'This is the sum of all of the member''s current income.  A member can potentially have several sources of income (for example, two part-time jobs).  ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."INCOME_VERIF_STATUS" IS 'This is the overall verification status of the member''s current income.  A member can have multiple sources of income.   Current income is defined as a source of income the member is currently receiving (not income from a job they no longer have, or unemployment benefits they are no longer receiving).  Set the value of the member''s Income_verification_status to ''Verified'' when all income statuses for current incomes are verfied and there is at least one current source of income. 
Set to ''Not Verified'' when at least one current income status is not verified.
Set to null if there is no income associated to this member that is current.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."INCOME_VERIF_STATUS_DATE" IS 'The date the income verification status was set. 
If Income Verification Status is null, set to null. 
If Income Verification Status is ''Verified'' set to the most current income verification date of all current incomes. If Income Verification Status = Not verified, set to the most current date of income verification status where the income verification status for the individual member income is ''Not Verified''';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CHILDCARE_EXPENSE" IS 'This is the member''s current childcare expense.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."RELATIONSHIP_PARENT1" IS 'This is the member''s relationship to Parent 1. Self
child, stepchild, grandchild, neice,nephew,other, non-dependent, null ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."RELATIONSHIP_PARENT2" IS 'This is the member''s relationship to Parent 2. Self
child, stepchild, grandchild, neice,nephew,other, non-dependent, null ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."UNBORN_CHILD_DUE_DATE" IS 'If  in the application the member indicated that they were pregnant, this is the due date of their unborn child. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."OTHER_INSURANCE_ANSWER" IS 'This is the member''s current answer to the question ''do you have other insurance''. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."VOLUNTARY_CANCEL_ANSWER" IS 'This is the member''s current answer to the question ''did you voluntarily cancel your insurance''. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."LIMITED_IN_ANY_WAY" IS 'This is the member''s current answer to the first CMSN question (Is this child limited or prevented in any way in his or her ability to do things most children of the same age can do) .';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."NEEDS_SPECIAL_THERAPY" IS 'This is the member''s current answer to the second CMSN question (Does the child need to get special therapy).';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."USES_MORE_MED_CARE" IS 'This is the member''s current answer to the third CMSN question in the application (Does this child need or use more medical care, mental health or education services than is usual for most children of the same). Values (Y, N, null)';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CMSN_OPT_ANSWER" IS 'This is the member''s current choice to opt in or opt out of CMSN in the application (health coverage for disabled children). Values (In, Out, Null)';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."DENTAL_COVERAGE_FLAG" IS 'This is the member''s current dental coverage choice in the application (opt in or opt out). ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CITIZENSHIP_VERIFIED" IS 'Denotes whether a member''s citizenship was verified or not. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CITIZENSHIP_VERIF_DATE" IS 'The date the member''s citizenship was verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CITIZENSHIP_VERIF_SOURCE_DOC" IS 'This is the source document used to verify the member''s citizenship. A source document is required when a member''s citizenship is verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CITIZENSHIP_INSUFF_REASON" IS 'This is the reason a member''s Citizenship could not be verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IDENTITY_VERIFIED" IS 'Denotes whether a member''s identity was verified or not.  When a member''s identity is verified in the source system, this flag is set to ''Y''. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IDENTITY_VERIF_DATE" IS 'The date the member''s identity was verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IDENTITY_VERIF_SOURCE_DOC" IS 'This is the source document used to verify the member''s Identity. A source document is required when a member''s identity are verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IDENTITY_INSUFF_REASON" IS 'This is the reason a member''s Identity could not be verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."TRIBAL_MBRSHIP_VERIFIED" IS 'Denotes whether a member whose race is either Alaskan Native or American Indian, has their tribal membership verified or not.  When a member''s tribal membership is verified in the source system, this falg is set to ''Y''. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."TRIBAL_MBRSHIP_INSUFF_REASON" IS 'This is the reason a member''s Tribal Membership could not be verified. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ELIG_RESULT_ID" IS 'This is the unique identifier for a specific run of the eligibility rules against current, verified member information.  This attribute references the last time eligibility was run for the member.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ELIG_RESULT_DATE" IS 'This is the date eligibility was run.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."PRE_ELIG_RUN_DATE" IS 'This is the date when the preliminary eligibility run is completed.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."AGENCY_MATCH" IS 'This flag is set when all the agency matches have been completed';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."AGENCY_MATCH_DATE" IS 'This is the date the  agency matches were completed';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IVIC_WRK_REQ_ID" IS 'This is the unique ID of the work request associated to the Income and Identity Verification task.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."PENDING_ELIG_NTFY_RQST_ID" IS 'This is the ID of the missing information notification that was requested on the application during eligibility.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."APP_EXPIRED_NTFY_RQST_ID" IS 'This is the ID of the request for a call campaign to notify that an application has expired during eligibility.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."APP_EXPIRED_NTFY_RQST_DATE" IS 'This is the date of the timeout notification call that was requested on the application during eligibility.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ELIG_OUTCOME_NTFY_RQST_ID" IS 'This is the ID of the eligibility outcome notification that was requested at the completion of eligibility determination.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."COMPLETE_DATE" IS 'Complete date is defined as the date the eligibility instance is canceled or disregarded OR there is an eligibility outcome.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_RVW_ELIG" IS 'Complete date is defined as the date the eligibility instance is canceled or disregarded OR there is an eligibility outcome.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_RVW_ELIG" IS 'The date the review eligibility activity ended. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_RVW_ELIG" IS 'When worker completes IVIC work request';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_COV_REQ" IS 'The date the coverage request activity started. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_COV_REQ" IS 'The date the coverage request activity ended. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_COV_REQ" IS 'When the coverage request has been created. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_NTFY_OUTCOME" IS 'The date the Request Outcome Notice activity started.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_NTFY_OUTCOME" IS 'The date the Request Outcome Notice activity ended. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_NTFY_OUTCOME" IS 'When notification has been requested for the client outcome of eligibility.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_RECEIVE_PROCESS_MI" IS 'The Receive and Process All MI Start Date is the date the " Receive and Process All MI" activity started. This step begins when an outcome notice is requested due a member being autodenied.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_RECEIVE_PROCESS_MI" IS 'The Receive and Process All MI End Date is the date the "Receive and Process All MI " activity ended. This step ends when notification has been created for client outcome of eligibility';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_RECEIVE_PROCESS_MI" IS 'When the time out deadline has been reached or all MI has been processed.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_NTFY_PENDING_ELIG" IS 'The Notify Client of Pended Eligibility Start Date is the date the "Notify Client of Pended Eligibility" activity started. This step begins when MI has been identified.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_NTFY_PENDING_ELIG" IS 'The Notify Client of Pended Eligibility End Date is the date the "Notify Client of Pended Eligibility" activity ended. This step ends when Mail,Phone or email notification have been generated.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_NTFY_PENDING_ELIG" IS 'When the nofiication has been requested for pending eligibility. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASSD_NTFY_TIMEOUT" IS 'The Request Timeout Notification Start Date is the date the "Request Timeout Notification" activity started. This step begins when system has not received response from client after XX  days';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_NTFY_TIMEOUT" IS 'The Request Timeout Notification End Date is the date the "Request Timeout Notification" activity ended. This step ends when notification hs been generated. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASF_NTFY_TIMEOUT" IS 'Set to ''Y'' when Eligibility outcome notice has been created.
';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ASED_CANCEL_REQUEST" IS 'The Cancel Member Eligibility Request End Date is the date the "Cancel Member Eligibility Request" activity ended. This step ends when:
 - a request is physically or logically deleted or cancelled';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."GWF_AUTO_DETERMINED" IS 'Set to ''Y'' when the Vida eligibility engine is able to determine an outcome and a value has been set.
';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."GWF_ELIG_DETERMINED" IS 'Set to ''Y'' when the Vida eligibility engine is able to determine an outcome and a value has been set.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."GWF_MISSING_INFO" IS 'Set to ''Y'' when there are no missing information during the Review Eligibilty activity step.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."GWF_ELIG_TIMEOUT" IS 'Is the ELIG_STATUS in cancel status?';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."GWF_TIMEOUT_REV" IS 'Is the ELIG_STATUS set to expired? ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."STAGE_DONE_DATE" IS 'All updates are completed on the row. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."STG_EXTRACT_DATE" IS 'Date the row was extracted from the source system.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."STG_LAST_UPDATE_DATE" IS 'ETL staging last update date';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."ME_PROCESSED" IS 'Row is processed in the ETL step.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."INSTANCE_STATUS" IS 'ETL status of COV_RQST_ID';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."CANCEL_DATE" IS 'Cancel date for the coverage request row.';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IVIC_WRK_REQ_DATE" IS 'Date the IVIC work request row was created. ';
   COMMENT ON COLUMN "FLHK_ETL_MEMBER_ELIGIBILITY"."IVIC_COMPLETE_DATE" IS 'Date the IVIC work requested was moved to resolved status.';
/
--------------------------------------------------------
--  DDL for Index FLHK_ETL_MEMBER_ELIGIBILI_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "FLHK_ETL_MEMBER_ELIGIBILI_PK" ON "FLHK_ETL_MEMBER_ELIGIBILITY" ("ME_ID") ;
/
--------------------------------------------------------
--  Constraints for Table FLHK_ETL_MEMBER_ELIGIBILITY
--------------------------------------------------------

  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("STG_LAST_UPDATE_DATE" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("STG_EXTRACT_DATE" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("ELIG_STATUS_DATE" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("MEMBER_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("ACCOUNT_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("APPLICATION_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("ELIG_STATUS" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("CREATE_DATE" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("COV_RQST_ID" NOT NULL ENABLE);
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" ADD CONSTRAINT "FLHK_ETL_MEMBER_ELIGIBILI_PK" PRIMARY KEY ("ME_ID") ENABLE;
  ALTER TABLE "FLHK_ETL_MEMBER_ELIGIBILITY" MODIFY ("ME_ID" NOT NULL ENABLE);
/
--------------------------------------------------------
--  DDL for Trigger ETL_MEMBER_ELIGIBILITY_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "ETL_MEMBER_ELIGIBILITY_TRG" 
   before insert on "FLHK_ETL_MEMBER_ELIGIBILITY" 
   for each row 
begin  
   if inserting then 
      if :NEW."ME_ID" is null then 
         select ETL_MEMBER_ELIGIBILITY_SEQ.nextval into :NEW."ME_ID" from dual; 
      end if; 
   end if; 
end;
/
ALTER TRIGGER "ETL_MEMBER_ELIGIBILITY_TRG" ENABLE;
/
