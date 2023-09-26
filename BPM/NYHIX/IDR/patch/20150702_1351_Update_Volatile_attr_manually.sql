/*
Created on 07/02/2015 by Raj A.
Description: Created for NYHIX-15879.  These two IDR incidents were erroring out in the IDR_Fetch_OLTP_data_for_update.ktr. So, manually updating for now. 
Code will be updated with a permanent fix soon.
*/
update nyhx_etl_idr_incidents
   set 
priority = to_number('5'),
LAST_UPDATE_BY_DT = to_date('2015/06/11 10:38:00','yyyy/mm/dd hh24:mi:ss'),
LAST_UPDATE_BY_NAME =  CAST(q'[Caslin,Alyssa ]' as VARCHAR2(150)),
UPDATED_BY = CAST(q'[15616]' as VARCHAR2(80)),
ACTION_TYPE = CAST(q'[]' as VARCHAR2(64)),
APPELLANT_TYPE = CAST(q'[0]' as VARCHAR2(32)),
APPELLANT_TYPE_DESC = CAST(q'[INDIVIDUAL APPEAL]' as VARCHAR2(64)),
RESOLUTION_TYPE = CAST(q'[]' as VARCHAR2(64)),
INCIDENT_TYPE = CAST(q'[Informal Dispute Resolution]' as VARCHAR2(80)),
INCIDENT_ABOUT = CAST(q'[Individual]' as VARCHAR2(80)),
ABOUT_PROVIDER_ID = to_number(''),
ABOUT_PLAN_CODE = CAST(q'[]' as VARCHAR2(32)),
REPORTED_BY = CAST(q'[Individual]' as VARCHAR2(80)),
REPORTER_RELATIONSHIP = CAST(q'[Self]' as VARCHAR2(64)),
REPORTER_NAME = CAST(q'[ROBERT ELLISON]' as VARCHAR2(180)),
REPORTER_PHONE = CAST(q'[9149689657]' as VARCHAR2(32)),
OTHER_PARTY_NAME = CAST(q'[]' as VARCHAR2(64)),
COMPLETE_DT = to_date('2015/06/11 10:38:00','yyyy/mm/dd hh24:mi:ss'),
CANCEL_DT = to_date('','yyyy/mm/dd hh24:mi:ss'),
CANCEL_BY = CAST('' as VARCHAR2(150)),
CLIENT_ID = to_number('10935394'),
CASE_ID = to_number('517846'),
CURRENT_TASK_ID = to_number(''),
CANCEL_METHOD = CAST(q'[]' as VARCHAR2(30)),
ENROLLMENT_STATUS = CAST(q'[Other]' as VARCHAR2(50)),
CHANNEL = CAST(q'[PHONE]' as VARCHAR2(80)),
INCIDENT_DESCRIPTION = CAST(q'[AP000000003427 Consumer requests to appeal the level of APTC that their spouse is receiving. Consumer's spouse  was deemed eligible for QHP with APTC +CSR on 07/08/15 with an FPL of 197.1% . The  account holder  receiving Medicare {04/01}. The spouse on the account is not able to apply the new APTC amount. Account holder believes that their spouse should not have to count the account holder's income because the account holder is not applying. No complaint is on file. A defect {NYCSCMDT-21996} was filed on 06/08/15 and closed on 06/09/2015. The account was experiencing RESEQUENCED status at the time of reported Medicare for the account holder. The  consumer  does request a language interpreter service as well as an special need.]' as VARCHAR2(4000)),
RESOLUTION_DESCRIPTION = CAST(q'[]' as VARCHAR2(4000)),
ACTION_COMMENTS = CAST(q'[Application reviewed, confirmed account holder is marked as not applying and LSC has been submitted. Confirmed citizenship status for the spouse not reeiving the APTC has not been confirmed and is most likely the reason for this appeal. 
Agent educated consumer on why they were not able to apply the tax credit. Verified application and account information. Informed the consumer about APTC rules, explained that their spouse may be eligible after the citizenship is approved. Explain that the appeals process is formal.  IDR- unsuccessful]' as VARCHAR2(4000))
where INCIDENT_ID = 26336999;

update nyhx_etl_idr_incidents
   set 
priority = to_number('5'),
LAST_UPDATE_BY_DT = to_date('2015/06/15 19:59:30','yyyy/mm/dd hh24:mi:ss'),
LAST_UPDATE_BY_NAME =  CAST(q'[Caslin,Alyssa ]' as VARCHAR2(150)),
UPDATED_BY = CAST(q'[15616]' as VARCHAR2(80)),
ACTION_TYPE = CAST(q'[]' as VARCHAR2(64)),
APPELLANT_TYPE = CAST(q'[0]' as VARCHAR2(32)),
APPELLANT_TYPE_DESC = CAST(q'[INDIVIDUAL APPEAL]' as VARCHAR2(64)),
RESOLUTION_TYPE = CAST(q'[]' as VARCHAR2(64)),
INCIDENT_TYPE = CAST(q'[Informal Dispute Resolution]' as VARCHAR2(80)),
INCIDENT_ABOUT = CAST(q'[Individual]' as VARCHAR2(80)),
ABOUT_PROVIDER_ID = to_number(''),
ABOUT_PLAN_CODE = CAST(q'[]' as VARCHAR2(32)),
REPORTED_BY = CAST(q'[Individual]' as VARCHAR2(80)),
REPORTER_RELATIONSHIP = CAST(q'[Self]' as VARCHAR2(64)),
REPORTER_NAME = CAST(q'[CHAYA FALKOWITZ]' as VARCHAR2(180)),
REPORTER_PHONE = CAST(q'[8459284836]' as VARCHAR2(32)),
OTHER_PARTY_NAME = CAST(q'[]' as VARCHAR2(64)),
COMPLETE_DT = to_date('2015/06/15 19:59:30','yyyy/mm/dd hh24:mi:ss'),
CANCEL_DT = to_date('','yyyy/mm/dd hh24:mi:ss'),
CANCEL_BY = CAST('' as VARCHAR2(150)),
CLIENT_ID = to_number('12908419'),
CASE_ID = to_number('1667956'),
CURRENT_TASK_ID = to_number(''),
CANCEL_METHOD = CAST(q'[]' as VARCHAR2(30)),
ENROLLMENT_STATUS = CAST(q'[Other]' as VARCHAR2(50)),
CHANNEL = CAST(q'[PHONE]' as VARCHAR2(80)),
INCIDENT_DESCRIPTION = CAST(q'[Consumer requests to appeal their eligibility determination and their spouses denial of special enrollment period. Consumer was deemed eligible for MA on 06/15/15 with an FPL of  189.1%  and their spouse was determined eligible on 06/15/15 for QHP with an FPL of 220.68% . Consumer believes that they should be eligible for previous enrollment of a shared QHP with APTC with the spouse on the account. No complaint is on file. The  consumer  does request a language interpreter service as well as an special need.]' as VARCHAR2(4000)),
RESOLUTION_DESCRIPTION = CAST(q'[]' as VARCHAR2(4000)),
ACTION_COMMENTS = CAST(q'[Agent educated consumer on why they were deemed eligible for MA and why their spouse is not eligible to enroll outside of the open enrollment period with no QLE. Verified the special enrollment guidelines {listed on the NYSOH website} are not met by the household, resulting in the denial of SEP.. Explain the appeals process is formal and a decision can take up to 90 days.  IDR- unsuccessful. AP000000003494]' as VARCHAR2(4000))
where INCIDENT_ID = 26340284;

commit;