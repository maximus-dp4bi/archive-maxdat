set define off;



UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
SET 
     RECEIPT_DT = to_date ('2016-10-19 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INSTANCE_STATUS = 'Complete'
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Refusal of Coverage'
    , INCIDENT_DESCRIPTION = q'"HOC called in to make a complaint against his current PCP I.D.# 036088926 Jalal Dahshe 4817 W. 83rd st. Burbank Il. 60459 08-425-3135.HOC stated his PCP is denying him insulin prescription for his diabetes. HOC also ssaid the PCP is very rude and talks to him with an attitude. HOC just didn't think it was fair for this PCP to speak down on his patients and not be concerned about his patients medical needs."'
    , INCIDENT_STATUS = 'Complaint Closed'
    , INCIDENT_STATUS_DT = to_date('10/26/2016','mm/dd/yyyy')
    , COMPLETE_DT = to_date('10/26/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-10-19 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('10/26/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('10/26/2016','mm/dd/yyyy')
    , ASED_PROCESS_INCIDENT = to_date('10/26/2016','mm/dd/yyyy')
    , ASF_PROCESS_INCIDENT = 'Y'
    , RESOLUTION_DESCRIPTION = 'Sent to MCO staff for review.'
WHERE INCIDENT_ID = 5940516;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-10-27 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INSTANCE_STATUS = 'Complete'
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Refusal of Coverage'
    , INCIDENT_DESCRIPTION = q'"HOC received a bill for an in home nurse that is usually covered by Medicare. Outreach for PCP education on billing with LTSS plan for HOC on file."'
    , INCIDENT_STATUS = 'Complaint Closed'
    , INCIDENT_STATUS_DT = to_date('10/27/2016','mm/dd/yyyy')
    , COMPLETE_DT = to_date('10/27/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-10-27 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('10/27/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('10/27/2016','mm/dd/yyyy')
    , ASED_PROCESS_INCIDENT = to_date('10/27/2016','mm/dd/yyyy')
    , ASF_PROCESS_INCIDENT = 'Y'
    , RESOLUTION_DESCRIPTION = 'Issue closed, Client said this has been taken care of with American Choice Health care, they understand LTSS program. HFS Spoke with client on 12/12/16.'
WHERE INCIDENT_ID = 5961106;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-11-01 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INSTANCE_STATUS = 'Complete'
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Refusal of Coverage'
    , INCIDENT_DESCRIPTION = q'"AR called to file complaint against PCP for not giving services due to LTSS plan on file. Cavero Medical Group(Clinic) 4007 W 63rd St, Chicago, IL 60629 Dr.Guadalupe, Bustamante (773)767-2266"'
    , INCIDENT_STATUS = 'Complaint Closed'
    , INCIDENT_STATUS_DT = to_date('11/01/2016','mm/dd/yyyy')
    , COMPLETE_DT = to_date('11/01/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-11-01 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('11/01/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('11/01/2016','mm/dd/yyyy')
    , ASED_PROCESS_INCIDENT = to_date('11/01/2016','mm/dd/yyyy')
    , ASF_PROCESS_INCIDENT = 'Y'
    , RESOLUTION_DESCRIPTION = 'Issue closed, HFS spoke to Dr. Bustamante office on 12/8/16 to Adelene she said client was seen by Dr. on 12/6/16 and that they do understand how the LTSS plans work and that this client is Medicare and Medicaid.'
WHERE INCIDENT_ID = 5972180;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-11-12 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INSTANCE_STATUS = 'Complete'
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Refusal of Coverage'
    , INCIDENT_DESCRIPTION = q'"Member: Yolanda Nunez RIN:133631440 Yolanda called due to her PCP/Cardiologist indicating she will not be able to see him because he does not accept Aetna MLTSS. Doctor: Dr. John P. Monteverde Phone number: 773-486-4800 or (312) 633-5866 2222 W Division St # 100, Chicago, IL 60622"'
    , INCIDENT_STATUS = 'Complaint Closed'
    , INCIDENT_STATUS_DT = to_date('11/12/2016','mm/dd/yyyy')
    , COMPLETE_DT = to_date('11/12/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-11-12 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('11/12/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('11/12/2016','mm/dd/yyyy')
    , ASED_PROCESS_INCIDENT = to_date('11/12/2016','mm/dd/yyyy')
    , ASF_PROCESS_INCIDENT = 'Y'
    , RESOLUTION_DESCRIPTION = 'Issue closed, HFS called Dr. office, Dr. John Monteverde and spoke with Evelyn and they said client did not show her Medicare and Medicaid card when she came in, only showed them the LTSS card please explain to client that the Meridian LTSS that she has now is not to be showed at her Dr. office or at Hospital this card is for LTSS nursing home or Waivers services such as home health care services she is receiving.'
WHERE INCIDENT_ID = 5975519;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-11-22 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INSTANCE_STATUS = 'Complete'
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Refusal of Coverage'
    , INCIDENT_DESCRIPTION = q'"HOC CALLING DUE TO HER EYE DOCTOR APPOINTMENT BEING DENIED DUE TO LTSS IN BCC. TORRE OPTICAL: 2425 N Milwaukee Ave, Chicago, IL 60647 PHONE#7737722020, COULD NOT FIND IN SYSTEM AND PLACED LARRY DAWSON IN SELECT PROVIDER INFO SPACE."'
    , INCIDENT_STATUS = 'Complaint Closed'
    , INCIDENT_STATUS_DT = to_date('11/22/2016','mm/dd/yyyy')
    , COMPLETE_DT = to_date('11/22/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-11-22 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('11/22/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('11/22/2016','mm/dd/yyyy')
    , ASED_PROCESS_INCIDENT = to_date('11/22/2016','mm/dd/yyyy')
    , ASF_PROCESS_INCIDENT = 'Y'
    , RESOLUTION_DESCRIPTION = 'HFS called Torre Optical spoke with Marisol  on 1/6/17 @1:35pm and Client can reschedule a appointment but should show only her Medicare card and paper Medicaid card, do not show BCC LTSS card.'
WHERE INCIDENT_ID = 6039920;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-11-29 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Suspected Fraud or Abuse'
    , INCIDENT_DESCRIPTION = q'"HOC called to inform that she did not make change to her children online. Requesting they keep the same FHN plan for both children RIN#210929295 Jesus Luna-Reyes and RIN#199315359 and Alexandra Luna . Part of the John Lee issue. She said she never made the online change and does not know who the doctor is."'
    , INCIDENT_STATUS = 'Referred to HFS'
    , INCIDENT_STATUS_DT = to_date('12/01/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-11-29 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('12/01/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('12/01/2016','mm/dd/yyyy')
--    , ASED_PROCESS_INCIDENT = to_date('10/27/2016','mm/dd/yyyy')
--    , ASF_PROCESS_INCIDENT = 'Y'
--    , RESOLUTION_DESCRIPTION = 'Issue closed, Client said this has been taken care of with American Choice Health care, they understand LTSS program. HFS Spoke with client on 12/12/16.'
WHERE INCIDENT_ID = 6054794;

UPDATE MAXDAT.CORP_ETL_PROCESS_INCIDENTS
Set   RECEIPT_DT = to_date ('2016-10-27 14:30:09', 'YYYY-MM-DD HH24:MI:SS')
    , INCIDENT_TYPE = 'Complaint'
    , INCIDENT_ABOUT = 'PCP'
    , INCIDENT_REASON = 'Suspected Fraud or Abuse'
    , INCIDENT_DESCRIPTION = q'"Plan change back to FHN due to fraud. Part of John Lee issue. Both children were changed without the consent of the HOC online RIN# 162846646 Johnathan Saez and RIN#217913136 Jake Saez-Vinalay . They were switched to Blue Cross. She wants them back on FHN. "'
    , INCIDENT_STATUS = 'Referred to HFS'
    , INCIDENT_STATUS_DT = to_date('12/09/2016','mm/dd/yyyy')
--    , COMPLETE_DT = to_date('10/27/2016','mm/dd/yyyy')
    , STG_EXTRACT_DATE = to_date ('2016-12-09 16:14:11', 'YYYY-MM-DD HH24:MI:SS')
    , STG_LAST_UPDATE_DATE = sysdate
    , ASED_IDENTIFY_RSRCH_INCIDENT = to_date('12/09/2016','mm/dd/yyyy')
    , ASSD_PROCESS_INCIDENT = to_date('12/09/2016','mm/dd/yyyy')
--    , ASED_PROCESS_INCIDENT = to_date('10/27/2016','mm/dd/yyyy')
--    , ASF_PROCESS_INCIDENT = 'Y'
--    , RESOLUTION_DESCRIPTION = 'Issue closed, Client said this has been taken care of with American Choice Health care, they understand LTSS program. HFS Spoke with client on 12/12/16.'
WHERE INCIDENT_ID = 6092553;

commit;

