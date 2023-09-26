--------------------------------------------------------
--  File created - Friday-December-22-2017   
--------------------------------------------------------
REM update the appeal which was stuck on 10/31/2017
SET DEFINE OFF;
Update NYHBE_ETL_PROCESS_APPEALS
set  CREATED_BY_GROUP=null,CHANNEL='WEB',TRACKING_NUMBER='28920028',APPEAL_DT=to_date('01/12/2018','DD-MON-RR'),RECEIPT_DT=to_date('31-OCT-17','DD-MON-RR'),
INCIDENT_ABOUT='Individual',INCIDENT_STATUS_DT=to_date('21-DEC-17','DD-MON-RR'),LAST_UPDATE_BY_NAME='Barca,Lynette ',LAST_UPDATE_BY_DT=to_date('21-DEC-17','DD-MON-RR'),
REPORTED_BY=null,REPORTER_RELATIONSHIP='Self',LINKED_CLIENT=15239661,CASE_ID=3076446,OTHER_PARTY_NAME=null,INSTANCE_STATUS='Active',
INCIDENT_DESCRIPTION='On 08/21/2017 the Appellant Jeffrey R. was systematically dis-enrolled from UnitedHealthcare Community  Essential Plan 1 effective 09/30/2017 due to not providing proof of Income within the required time-frame. On 08/26/2017 the Appellant Contacted the Marketplace and updated his application. The Appellant was found eligible for APTC of $196/Month effective 10/01/2017. This is based on an Household of 1, residency in Suffolk County, Annual Household Income of $33,644.00, FPL 283.2%. The Appellant disagrees with the eligibility determination made by the marketplace on 08/26/2017 and is requesting his eligibility be re-determined for Essential Plan 1. ',
INCIDENT_STATUS='Hearing Set',PRIORITY='5',APPELLANT_TYPE='0',APPELLANT_TYPE_DESC='INDIVIDUAL APPEAL',ABOUT_PLAN_CODE=null,
ABOUT_PLAN_NAME=null,ABOUT_PROVIDER_ID=null,ABOUT_PROVIDER_NAME=null,
ACTION_TYPE=null,REQUESTED_DAY='FRIDAY',REQUESTED_TIME='PM',APPEAL_HEARING_TIME='10:00:00',APPEAL_HEARING_DT=to_date('12-JAN-18','DD-MON-RR'),
APPEAL_HEARING_LOCATION=null,AID_TO_CONTINUE='N',EXPECTED_REQUEST=0,CURRENT_TASK_ID=37934392,RESOLUTION_DESCRIPTION=null,
RESOLUTION_TYPE=null,CANCEL_BY=null,CANCEL_DT=null,CANCEL_REASON=null,CANCEL_METHOD=null,ASSD_REVIEW_APPEAL=to_date('31-OCT-17','DD-MON-RR'),
ASED_REVIEW_APPEAL=null,ASPB_REVIEW_APPEAL=null,ASF_REVIEW_APPEAL='N',ASSD_DETERMINE_VALID=null,ASED_DETERMINE_VALID=null,
ASPB_DETERMINE_VALID=null,ASF_DETERMINE_VALID='N',ASSD_PROC_VALID_AMEND=null,ASED_PROC_VALID_AMEND=null,ASPB_PROC_VALID_AMEND=null,
ASF_PROC_VALID_AMEND='N',ASSD_GATHER_MISS_INFO=null,ASED_GATHER_MISS_INFO=null,ASPB_GATHER_MISS_INFO=null,ASF_GATHER_MISS_INFO='N',ASSD_SHOP_REVIEW=null,ASED_SHOP_REVIEW=null,ASPB_SHOP_REVIEW=null,ASF_SHOP_REVIEW='N',ASSD_SCHEDULE_HEARING=null,
ASED_SCHEDULE_HEARING=null,ASPB_SCHEDULE_HEARING=null,ASF_SCHEDULE_HEARING='N',ASSD_CON_HEARING_PROC=null,ASED_CON_HEARING_PROC=null,ASPB_CON_HEARING_PROC=null,ASF_CON_HEARING_PROC='N',
ASSD_CONDUCT_ST_REV=null,ASED_CONDUCT_ST_REV=null,ASPB_CONDUCT_ST_REV=null,ASF_CONDUCT_ST_REV='N',ASSD_CANCEL_HEARING=null,ASED_CANCEL_HEARING=null,ASPB_CANCEL_HEARING=null,ASF_CANCEL_HEARING='N',ASSD_ADVISE_WITHDRAW=null,ASED_ADVISE_WITHDRAW=null,
ASPB_ADVISE_WITHDRAW=null,ASF_ADVISE_WITHDRAW='N',STG_EXTRACT_DATE=to_date('31-OCT-17','DD-MON-RR'),STG_LAST_UPDATE_DATE=to_date('21-DEC-17','DD-MON-RR'),
GWF_CHANNEL=null,GWF_APPEAL_INVALID=null,GWF_CHANGE_ELIGIBILITY=null,GWF_VALID=null,GWF_SHOP_REVIEW=null,GWF_RESOLVED=null,GWF_WITHDRAWN_IN_WRITING=null,
STAGE_DONE_DT=null,INSTANCE_COMPLETE_DT=null,COMPLETE_DT=null,MAX_INCI_STAT_HIST_ID=7819430,RECEIVED_DT=null,CURRENT_STEP='Start - Review Appeal',
ACTION_COMMENTS=' 
Hearing Scheduled for 01/12/2018 @ 10:00 AM
Evidence packet assembled;
Notice of Hearing Generated;10204125
Updated to Hearing Set
***Correction***
Note dated 11/06/2017 @ 8:29 AM
28919908 10/30/2017 
date is 10/31/2017.
Outreached to the consumer, the consumer wishes to continue with their appeal.
The Appellant is not requesting Aid to Continue

28919908  10/30/2017
IDR Not Resolved

N171405451732   05/20/2017
Notice of Eligibility for Essential Plan 1 at 20$/month
Requests Proof of Income due by 08/16/2017.

N171405451795   05/20/2017
Notice of Enrollment for Essential Plan 1 UnitedHealthcare Community Plan effective 07/01/2017

N172341839920   08/22/2017
Notice of Disenrollment from Essential Plan 1 UnitedHealthcare Community Plan effective 09/30/2017

N172341848940   08/22/2017 	
Notice of Eligibility for APTC of $288/Month

N172392111370   08/27/2017
Notice of Eligibility for APTC of $196/Month

Updating to Schedule Hearing',
FAIR_HEARING_TRACKING_NBR='AP000000023864',APL_PRIMARY_MEMBER_ID=30649,ACCOUNT_ID='AC0003575596',NYHIX_ID='HX0004725181',PREF_LANGUAGE=null,DECISION_DETAILS=null
where incident_id = 27275408;
