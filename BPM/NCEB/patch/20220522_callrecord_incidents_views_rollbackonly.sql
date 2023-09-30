DROP VIEW MAXDAT_SUPPORT.EMRS_D_CALL_RECORD_SV;


  CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."EMRS_D_CALL_RECORD_SV" ("CALL_DATE", "CALL_TYPE_CD", "CALL_TYPE", "CALLER_TYPE_CD", "CALLER_TYPE", "CALL_ACTION", "CALLER_PHONE", "EXT_TELEPHONY_REF", "CALLER_FIRST_NAME", "CALLER_LAST_NAME", "PARENT_CALL_RECORD_ID", "CREATE_TS", "UPDATE_TS", "CREATED_BY", "UPDATED_BY", "NOTE_REF_ID", "CALL_START_TS", "CALL_END_TS", "RECORD_NAME", "CALL_RECORD_ID", "EVENT_ID", "EVENT_TYPE_CD", "CONTEXT", "SELECTION_TXN_ID", "SELECTION_SEGMENT_ID", "WORKER_ID", "WORKER_USERNAME", "CASE_ID", "CLIENT_ID", "TRANSACTION_TYPE_CD", "PLAN_ID", "PLAN_ID_EXT", "CONTRACT_ID", "PROVIDER_ID", "PROVIDER_ID_EXT", "TO_PLAN_ID", "TO_PLAN_ID_EXT", "TO_CONTRACT_ID", "TO_PROVIDER_ID", "TO_PROVIDER_ID_EXT", "PLAN_SERVICE_TYPE_CD", "SELECTION_START_DATE", "SELECTION_END_DATE", "DISENROLL_REASON_CD_1", "DISENROLL_REASON_CD_2", "SELECTION_SOURCE_CD", "CHOICE_REASON_CD", "ERROR_CODE", "ACCEPTED_DATE", "CALL_REASON_TYPE_CD", "CHAT_REASON_CD", "FIRST_CALL_RESOLUTION", "FIRST_CALL_RESOLUTION_ANSWERED", "REFERRAL_TO", "REFERRAL_REASON", "CALL_LANGUAGE_CD", "MANAGED_CARE_STATUS", "MEDCHAT_ID", "EFFECTIVE_END_DATE","CALL_EVENT_ORDER") AS 
  SELECT
CA.CALL_DATE
, CA.CALL_TYPE_CD
, CA.call_type
, CA.CALLER_TYPE_CD
, CA.caller_type
, CA.CALL_ACTION
, CA.CALLER_PHONE
, CA.ext_telephony_ref
, CA.caller_first_name
, CA.caller_last_name
, CA.parent_call_record_id
, CA.CREATE_TS
, CA.UPDATE_TS
, CA.created_by
, CA.updated_by
, CA.note_ref_id
, CA.CALL_sTART_TS
, CA.CALL_END_TS
, CA.RECORD_NAME
, CA.CALL_RECORD_ID
, CA.EVENT_ID
, CA.EVENT_TYPE_CD
, CA.CONTEXT
, CA.SELECTION_TXN_ID
, CA.SELECTION_SEGMENT_ID
, CA.WORKER_ID
, CA.WORKER_USERNAME
, CA.CASE_ID
, CA.CLIENT_ID
, CA.TRANSACTION_TYPE_CD
, CA.PLAN_ID PLAN_ID
, CA.PLAN_ID_EXT PLAN_ID_EXT
, CA.CONTRACT_ID
, CA.PROVIDER_ID
, CA.PROVIDER_ID_EXT
, CA.TO_PLAN_ID
, CA.TO_PLAN_ID_EXT
, CA.TO_CONTRACT_ID
, CA.TO_PROVIDER_ID
, CA.TO_PROVIDER_ID_EXT
, COALESCE(CON.PLAN_SERVICE_TYPE_CD,CA.PLAN_SERVICE_TYPE_CD) PLAN_sERVICE_TYPE_CD
, CA.SELECTION_START_DATE
, CA.SELECTION_END_DATE
, CA.DISENROLL_REASON_CD_1
, CA.DISENROLL_REASON_CD_2
, CA.SELECTION_SOURCE_CD
, CA.CHOICE_REASON_CD
, CA.ERROR_CODE
, CA.ACCEPTED_DATE
, CA.CALL_REASON_TYPE_CD
, CA.CHAT_REASON_CD
, CA.FIRST_CALL_RESOLUTION
, CA.FIRST_CALL_RESOLUTION_ANSWERED
, CA.REFERRAL_TO
, CA.REFERRAL_REASON
, CA.LANGUAGE_CD CALL_LANGUAGE_CD
, CA.MANAGED_CARE_STATUS
, CA.MEDCHAT_ID
, ca.EFFECTIVE_END_DATE
, ROW_NUMBER() OVER(PARTITION BY CA.CALL_RECORD_ID ORDER BY CA.EVENT_ID desc) CALL_EVENT_ORDER
FROM
(
SELECT
CR.CALL_RECORD_ID
, CR.CALL_TYPE_CD
, ct.report_label call_type
, CR.CALLER_TYPE_CD
, crt.report_label caller_type
, CASE WHEN E2.EVENT_ID IS NULL THEN E.CONTEXT ELSE E2.CONTEXT END CALL_ACTION
, CR.WORKER_ID
, CR.WORKER_USERNAME
, CR.LANGUAGE_CD
-- below is until https://jira.maximus.com/browse/NCEB-1574 is fixed by baseline. Medchat to EB, the Call_start_ts is UTC, need to change to Eastern
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN (cast(FROM_TZ(cast( CR.CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE (CR.CALL_START_TS) END CALL_START_TS
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN (cast(FROM_TZ(cast( CR.CALL_END_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE TRUNC(CR.CALL_END_TS) END CALL_END_TS
, CASE WHEN CR.CALL_TYPE_CD = 'WEBCHAT' and CR.MEDCHAT_ID is not NULL THEN TRUNC(cast(FROM_TZ(cast( CR.CALL_sTART_TS AS TIMESTAMP),'UTC') AT TIME ZONE 'US/EASTERN' as date)) ELSE TRUNC(CR.CALL_START_TS) END CALL_DATE
--, CR.CALL_START_TS
--, CR.CALL_END_TS
--, TRUNC(CR.CALL_START_TS) CALL_DATE
, CR.CALLER_PHONE
, cr.ext_telephony_ref
, cr.caller_first_name
, cr.caller_last_name
, cr.parent_call_record_id
, CR.CREATE_TS
, CR.UPDATE_TS
, cr.created_by
, cr.updated_by
, null note_ref_id
, CRL.CASE_ID
, CRL.EXT_CASE_NUM
, CRL.CLIENT_ID
, CRL.EXT_CLIENT_NUM
, CRL.CLIENT_LAST_NAME
, CRL.CLIENT_FIRST_NAME
, CRL.CLIENT_MI
, CASE WHEN E2.EVENT_ID IS NULL THEN E.EVENT_ID ELSE E2.EVENT_ID END EVENT_ID
, CASE WHEN E2.EVENT_ID IS NULL THEN E.EVENT_TYPE_CD ELSE E2.EVENT_TYPE_CD END EVENT_TYPE_CD
, CASE WHEN E2.EVENT_ID IS NULL THEN E.CONTEXT ELSE E2.CONTEXT END CONTEXT
, CASE WHEN E2.EVENT_ID IS NULL THEN E.COMMENTS ELSE E2.COMMENTS END COMMENTS
, CASE WHEN E2.EVENT_ID IS NULL THEN E.CREATE_TS ELSE E2.CREATE_TS END EVENT_CREATE_TS
, CASE WHEN E2.EVENT_ID IS NULL THEN E.REF_TYPE ELSE E2.REF_TYPE END EVENT_REF_TYPE
, CASE WHEN E2.EVENT_ID IS NULL THEN E.REF_ID ELSE E2.REF_ID END EVENT_REF_ID
, CR.CREATED_BY RECORD_NAME
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.SELECTION_SEGMENT_ID ELSE ST.PRIOR_SELECTION_SEGMENT_ID END, SELC.SELECTION_SEGMENT_ID) SELECTION_SEGMENT_ID
, ST.PRIOR_SELECTION_SEGMENT_ID SELP_SELECTION_SEGMENT_ID
, SELC.SELECTION_SEGMENT_ID SELC_SELECTION_SEGMENT_ID
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.START_DATE ELSE ST.PRIOR_SELECTION_START_DATE END, SELC.START_DATE) SELECTION_START_DATE
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.END_DATE ELSE ST.PRIOR_SELECTION_END_DATE END, SELC.END_DATE) SELECTION_END_DATE
, ST.SELECTION_TXN_ID
, ST.TRANSACTION_TYPE_CD
, ST.SELECTION_SOURCE_CD
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.CONTRACT_ID else ST.PRIOR_CONTRACT_ID END, SELC.CONTRACT_ID) CONTRACT_ID
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.PLAN_ID ELSE ST.PRIOR_PLAN_ID END, SELC.PLAN_ID) PLAN_ID
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.PLAN_ID_EXT ELSE ST.PRIOR_PLAN_ID_EXT END, SELC.PLAN_ID_EXT) PLAN_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.PROVIDER_ID else ST.PRIOR_PROVIDER_ID END PROVIDER_ID
, COALESCE(CASE WHEN ST.TRANSACTION_TYPE_CD IN ('NewEnrollment') then ST.PROVIDER_ID_EXT ELSE ST.PRIOR_PROVIDER_ID_EXT END, SELC.PROVIDER_ID_EXT) PROVIDER_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer') then ST.PLAN_ID else null end TO_PLAN_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer') then ST.PLAN_ID_EXT else null end TO_PLAN_ID_EXT
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer') then ST.CONTRACT_ID else null end TO_CONTRACT_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer') then ST.PROVIDER_ID else null end TO_PROVIDER_ID
, CASE WHEN ST.TRANSACTION_TYPE_CD IN ('Transfer') then ST.PROVIDER_ID_EXT else null end TO_PROVIDER_ID_EXT
, ST.PRIOR_PROVIDER_ID TO_
, EAID.SUBPROGRAM_CODES PLAN_SERVICE_TYPE_CD
, SMID.ERROR_CODE
, ST.CHOICE_REASON_CD
, ST.DISENROLL_REASON_CD_1
, ST.DISENROLL_REASON_CD_2
, CSCL.CSCL_CLNT_CLIENT_ID
, (SELECT MAX(TRUNC(sh.create_ts))
      FROM EB.selection_txn_status_history sh
      WHERE sh.selection_txn_id = st.selection_txn_id AND sh.status_cd = 'acceptedByState'
      ) ACCEPTED_DATE
, UPPER(CRSN.VALUE) CALL_REASON_TYPE_CD
, UPPER(CHRSN.REPORT_LABEL) CHAT_REASON_CD
, CASE WHEN UPPER(CR.CALL_RECORD_FIELD1) = 'TRUE' THEN 1 ELSE 0 END FIRST_CALL_RESOLUTION
, CASE WHEN UPPER(CR.CALL_RECORD_FIELD1) in ('TRUE','FALSE') THEN 1 ELSE 0 END FIRST_CALL_RESOLUTION_ANSWERED
, CASE WHEN E2.EVENT_ID IS NULL THEN CASE WHEN UPPER(E.CONTEXT) LIKE '%REFER%' THEN TRIM(substr(REFF.report_label,instr(REFF.REPORT_LABEL,'- ')+1)) ELSE NULL END
       ELSE CASE WHEN UPPER(E2.CONTEXT) LIKE '%REFER%' THEN TRIM(substr(REFF2.REPORT_LABEL,instr(REFF2.REPORT_LABEL,'- ')+1)) ELSE NULL END
       END referral_reason
, CASE WHEN E2.EVENT_ID IS NULL THEN
  CASE WHEN upper(E.CONTEXT) LIKE 'REFER%STATE%' THEN 'To State-Operated Call Centers'
            when upper(E.CONTEXT) like 'REFER%PHP%' then 'To PHP'
            when upper(E.CONTEXT) like 'REFER%HEALTH%' then 'To PHP'
            when upper(E.CONTEXT) like 'REFER%OMBUD%' then 'To Ombudsman'
            when upper(E.CONTEXT) like 'REFER%DSS%' THEN 'To County DSS and PHHS Offices'
            when upper(E.CONTEXT) like 'REFER%EBCITRIBAL%' THEN 'To EBCI Tribal' -- Add to recognize Tribal
            else NULL
            end
  ELSE
  CASE WHEN upper(E2.CONTEXT) LIKE 'REFER%STATE%' THEN 'To State-Operated Call Centers'
            when upper(E2.CONTEXT) like 'REFER%PHP%' then 'To PHP'
            when upper(E2.CONTEXT) like 'REFER%HEALTH%' then 'To PHP'
            when upper(E2.CONTEXT) like 'REFER%OMBUD%' then 'To Ombudsman'
            when upper(E2.CONTEXT) like 'REFER%DSS%' THEN 'To County DSS and PHHS Offices'
            when upper(E2.CONTEXT) like 'REFER%EBCITRIBAL%' THEN 'To EBCI Tribal' -- Add to recognize Tribal
            else NULL
            end
  END
  REFERRAL_TO
  , ELIG.SEGMENT_DETAIL_VALUE_2 MANAGED_CARE_STATUS
, ROW_NUMBER() OVER(PARTITION BY CR.CALL_RECORD_ID, NVL(E2.EVENT_ID,E.EVENT_ID) ORDER BY ABS(SELC.CLIENT_ID - CRL.CLIENT_ID), (SELC.CREATE_TS - CR.CALL_START_TS), ELIG.CREATE_TS DESC) ROWN
, MEDCHAT_ID
, CRSN.effective_end_date EFFECTIVE_END_DATE
FROM EB.CALL_RECORD CR
JOIN EB.enum_call_type ct                     ON (cr.call_type_cd = ct.value)
--JOIN EB.ENUM_LANGUAGE LANG ON LANG.VALUE = CR.LANGUAGE_CD
LEFT JOIN EB.ENUM_CALL_REASONS CRSN ON UPPER(CRSN.VALUE) = UPPER(CR.CALL_RECORD_FIELD2)
LEFT JOIN EB.ENUM_MEDCHAT_TOPIC CHRSN ON UPPER(CHRSN.VALUE)=UPPER(substr(CR.MEDCHAT_TOPIC,1,32))
LEFT JOIN EB.enum_caller_type crt       ON (cr.caller_type_cd = crt.value)
LEFT JOIN EB.CALL_RECORD_LINK CRL ON CRL.CALL_RECORD_ID = CR.CALL_RECORD_ID
LEFT JOIN EB.EVENT E ON E.CALL_RECORD_ID = CR.CALL_RECORD_ID AND E.EVENT_TYPE_CD = 'INBOUND_CALL'
LEFT JOIN EB.EVENT E2 ON E2.CALL_RECORD_ID = CR.CALL_RECORD_ID AND E2.EVENT_TYPE_CD NOT IN ( 'INBOUND_CALL','LINK_TO_CALL')
LEFT JOIN EB.ENUM_MANUAL_CALL_ACTION REFF ON REFF.CATEGORIES like 'REFERRAL' AND REFF.VALUE = E.CONTEXT
LEFT JOIN EB.ENUM_MANUAL_CALL_ACTION REFF2 ON REFF2.CATEGORIES like 'REFERRAL' AND REFF2.VALUE = E2.CONTEXT
LEFT JOIN EB.CASE_CLIENT CSCL ON CSCL.CSCL_CASE_ID = CRL.CASE_ID
                              AND CSCL.CSCL_CLNT_CLIENT_ID = NVL(CRL.CLIENT_ID, CSCL.CSCL_CLNT_CLIENT_ID)
                              AND CSCL.STATUS_BEGIN_NDT < CSCL.STATUS_END_NDT
                              AND CSCL.STATUS_BEGIN_NDT <= CR.CALL_START_NDT
                              AND CSCL.STATUS_END_NDT > CR.CALL_START_NDT
LEFT JOIN EB.ELIG_SEGMENT_AND_DETAILS ELIG ON ELIG.CLIENT_ID = CSCL.CSCL_CLNT_CLIENT_ID
                                        AND ELIG.START_ND < ELIG.END_ND
                                        AND ELIG.START_ND = CSCL.ELIG_BEGIN_ND
--                                      AND ELIG.START_ND * POWER(10,9) <= CR.CALL_START_NDT
--                                      AND ELIG.END_ND * POWER(10,9) >= CR.CALL_START_NDT
                                      AND ELIG.SEGMENT_TYPE_CD = 'ME'
LEFT JOIN EB.ENUM_AID_CATEGORY EAID ON EAID.VALUE = CSCL.CSCL_ADLK_ID
LEFT JOIN EB.SELECTION_SEGMENT SELC ON (SELC.CLIENT_ID = CSCL.CSCL_CLNT_CLIENT_ID AND SELC.PROGRAM_TYPE_CD = 'MEDICAID'
                                AND SELC.PLAN_TYPE_CD = 'MEDICAL'
                                AND (LEAST(SELC.CREATE_TS, SELC.START_DATE) <= CR.CALL_sTART_TS)
                                )
LEFT JOIN EB.SELECTION_TXN ST ON NVL(E2.REF_TYPE,e.ref_type) = 'SELECTION_TXN' and NVL(E2.REF_ID,e.ref_id) = st.selection_txn_id
LEFT JOIN EB.SELECTION_MISSING_INFO_DETAILS SMID ON SMID.MISSING_INFO_ID = ST.MISSING_INFO_ID AND SMID.ERROR_CODE = 'M028'
WHERE 1=1
AND CR.CALL_END_TS IS NOT NULL
--AND CR.CALL_RECORD_ID = 26051113--26051085
) CA
LEFT JOIN EB.CONTRACT CON ON CON.CONTRACT_ID = CA.CONTRACT_ID
WHERE CA.ROWN = 1
AND CA.CALL_DATE >= GREATEST(TO_DATE('3/1/2021','MM/DD/YYYY'), ADD_MONTHS(TRUNC(SYSDATE), -13));

  GRANT SELECT ON "MAXDAT_SUPPORT"."EMRS_D_CALL_RECORD_SV" TO "MAXDAT_REPORTS";
  GRANT SELECT ON "MAXDAT_SUPPORT"."EMRS_D_CALL_RECORD_SV" TO "MAXDATSUPPORT_READ_ONLY";
  
DROP VIEW MAXDAT_SUPPORT.D_PI_CURRENT_SV;

CREATE OR REPLACE FORCE EDITIONABLE VIEW "MAXDAT_SUPPORT"."D_PI_CURRENT_SV" ("PI_BI_ID", "INCIDENT_TRACKING_NUMBER", "RECEIPT_DATE", "CREATE_DATE", "CREATED_BY_GROUP", "ORIGIN_ID", "CHANNEL", "AGE_IN_BUSINESS_DAYS", "AGE_IN_CALENDAR_DAYS", "PROCESS_CLIENT_NOTIFICATION_ID", "CUR_INSTANCE_STATUS", "CANCEL_DATE", "INCIDENT_TYPE", "DPIIA_ID", "CUR_INCIDENT_ABOUT", "DPIIR_ID", "CUR_INCIDENT_REASON", "ABOUT_PROVIDER_ID", "ABOUT_PLAN_CODE", "CUR_INCIDENT_STATUS", "CUR_INCIDENT_STATUS_DATE", "STATUS_AGE_IN_BUSINESS_DAYS", "STATUS_AGE_IN_CALENDAR_DAYS", "CUR_JEOPARDY_STATUS", "JEOPARDY_STATUS_DATE", "COMPLETE_DATE", "REPORTED_BY", "REPORTER_RELATIONSHIP", "CASE_ID", "REPORTER_FIRST_NAME", "REPORTER_LAST_NAME", "REPORTER_FULL_NAME", "REPORTER_PHONE", "CUR_ENROLLMENT_STATUS", "PRIORITY", "PROGRAM", "SUB_PROGRAM", "CUR_LAST_UPDATE_DATE", "CUR_LAST_UPDATE_BY_NAME", "PLAN_ID", "PROVIDER_ID", "ACTION_TYPE", "RESOLUTION_TYPE", "NOTIFY_CLIENT_FLAG", "PROCESS_CLNT_NOTIFY_START_DT", "PROCESS_CLNT_NOTIFY_END_DT", "PROCESS_CLNT_NOTIFY_FLAG", "ESCALATE_INCIDENT_FLAG", "ESCALATE_TO_STATE_DT", "CUR_TASK_ID", "STATE_RECEIVED_APPEAL_DATE", "HEARING_DATE", "SELECTION_ID", "TIMELINESS_STATUS", "EB_FOLLOWUP_NEEDED_FLAG", "OTHER_PARTY_NAME", "RESEARCH_INCIDENT_ST_DT", "RESEARCH_INCIDENT_END_DT", "PROCESS_INCIDENT_ST_DT", "PROCESS_INCIDENT_END_DT", "PROCESS_INCIDENT_FLAG", "RETURN_INCIDENT_FLAG", "COMPLETE_INCIDENT_ST_DT", "COMPLETE_INCIDENT_END_DT", "COMPLETE_INCIDENT_FLAG", "RETURN_TO_MMS_DT", "CREATED_BY_NAME", "GENERIC_FIELD_1", "GENERIC_FIELD_2", "GENERIC_FIELD_3", "GENERIC_FIELD_4", "GENERIC_FIELD_5", "ENROLLEE_RIN", "RESEARCH_INCIDENT_FLAG", "CANCEL_BY", "CANCEL_REASON", "CANCEL_METHOD", "COUNTY_CODE", "COUNTY_NAME", "ACTION_COMMENTS", "INCIDENT_DESCRIPTION", "RESOLUTION_DESCRIPTION", "CLIENT_ID", "CREATED_BY_ID", "CREATED_BY_EMPID", "RECIPIENT_NAME", "RECIPIENT_ADDRESS", "RECIPIENT_PHONE") AS 
SELECT i.incident_header_id PI_BI_ID ,
    i.tracking_number INCIDENT_TRACKING_NUMBER ,
    i.received_ts RECEIPT_DATE ,
    i.create_ts CREATE_DATE ,
    g.group_name CREATED_BY_GROUP ,
    i.origin_id ,
    o.report_label CHANNEL ,
    (CASE WHEN i.create_ts IS NOT NULL
      AND ( CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts ELSE sysdate END) IS NOT NULL THEN
        (SELECT
          CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
        FROM MAXDAT_SUPPORT.D_DATES
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN i.CREATE_TS AND (
          CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts ELSE sysdate END)
        )
      ELSE 0 END ) AGE_IN_BUSINESS_DAYS ,
    TRUNC(CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED')
      THEN i.status_ts
      ELSE sysdate
    END) - TRUNC(i.create_ts) AGE_IN_CALENDAR_DAYS ,
    0 PROCESS_CLIENT_NOTIFICATION_ID ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 'Complete' ELSE 'Active'  END CUR_INSTANCE_STATUS ,
    NULL CANCEL_DATE ,
    t.report_label INCIDENT_TYPE ,
    apt.value AS DPIIA_ID,
    apt.report_label CUR_INCIDENT_ABOUT ,
    aps.value AS DPIIR_ID,
    aps.report_label CUR_INCIDENT_REASON ,
    n.provider_id_ext ABOUT_PROVIDER_ID ,
    COALESCE(pl.plan_code, '0') ABOUT_PLAN_CODE ,
    s.report_label CUR_INCIDENT_STATUS ,
    i.status_ts CUR_INCIDENT_STATUS_DATE ,
    (
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 0
        ELSE (CASE WHEN i.create_ts IS NOT NULL AND i.status_ts IS NOT NULL
          THEN
            (SELECT
              CASE WHEN (COUNT(*)-1) < 0 THEN 0 ELSE COUNT(*)-1 END
            FROM MAXDAT_SUPPORT.D_DATES
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN i.CREATE_TS AND i.status_ts )
          ELSE 0
        END )  END) STATUS_AGE_IN_BUSINESS_DAYS ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 0 ELSE TRUNC(sysdate) - TRUNC(i.status_ts) END STATUS_AGE_IN_CALENDAR_DAYS ,
    CASE
      WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN 'NA' ELSE
        CASE WHEN TRUNC(sysdate) - TRUNC(i.create_ts) >= 20 THEN 'Y' ELSE 'N' END  END CUR_JEOPARDY_STATUS ,
    sysdate JEOPARDY_STATUS_DATE ,
    CASE WHEN i.status_cd IN('CLOSED','STATE_COMPLETED') THEN i.status_ts  ELSE NULL END COMPLETE_DATE ,
    r.report_label REPORTED_BY ,
    rr.report_label REPORTER_RELATIONSHIP ,
    COALESCE(i.case_id, 0) CASE_ID ,
    i.reporter_first_name,
    i.reporter_last_name,
    CASE WHEN LENGTH(reporter_last_name) > 1  THEN i.reporter_first_name||' '||i.reporter_last_name  ELSE NULL END AS reporter_full_name,
    CASE WHEN i.reporter_phone IS NOT NULL THEN '('||SUBSTR( i.reporter_phone,1,3)||')'||SUBSTR( i.reporter_phone,4,3)||'-'|| SUBSTR( i.reporter_phone,7) END reporter_phone,
    NULL CUR_ENROLLMENT_STATUS ,
    p.report_label PRIORITY ,
    'MEDICAID' PROGRAM ,
    COALESCE(i.GENERIC_FIELD1, '0') AS SUB_PROGRAM ,
    i.update_ts CUR_LAST_UPDATE_DATE ,
    COALESCE(us.last_name||','||us.first_name||' '||us.middle_name, i.updated_by) CUR_LAST_UPDATE_BY_NAME,
    slct.plan_id PLAN_ID ,
    slct.provider_id_ext PROVIDER_ID ,
    rl.report_label ACTION_TYPE ,
    rt.report_label RESOLUTION_TYPE ,
    'N' NOTIFY_CLIENT_FLAG ,
    NULL PROCESS_CLNT_NOTIFY_START_DT ,
    NULL PROCESS_CLNT_NOTIFY_END_DT ,
    NULL PROCESS_CLNT_NOTIFY_FLAG ,
    NULL ESCALATE_INCIDENT_FLAG ,
    NULL ESCALATE_TO_STATE_DT ,
    si.step_instance_id CUR_TASK_ID ,
    NULL STATE_RECEIVED_APPEAL_DATE ,
    NULL HEARING_DATE ,
    slct.selection_segment_id SELECTION_ID ,
    CASE
      WHEN i.status_cd IN('STATE_COMPLETED')
      THEN
        CASE
          WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30
          THEN 'Processed Timely'
          ELSE 'Processed Untimely'
        END
      WHEN i.status_cd NOT IN( 'CLOSED','STATE_COMPLETED')
      THEN 'Not Processed'
      ELSE NULL
    END TIMELINESS_STATUS ,
    (
    CASE
      WHEN (i.eb_follow_up_needed_ind IS NULL
      OR i.eb_follow_up_needed_ind=0 )
      THEN 'N'
      WHEN i.eb_follow_up_needed_ind=1
      THEN 'Y'
      ELSE NULL
    END) EB_FOLLOWUP_NEEDED_FLAG ,
    opt.report_label OTHER_PARTY_NAME ,
    NULL RESEARCH_INCIDENT_ST_DT ,
    NULL RESEARCH_INCIDENT_END_DT ,
    NULL PROCESS_INCIDENT_ST_DT ,
    NULL PROCESS_INCIDENT_END_DT ,
    NULL PROCESS_INCIDENT_FLAG ,
    NULL RETURN_INCIDENT_FLAG ,
    NULL COMPLETE_INCIDENT_ST_DT ,
    NULL COMPLETE_INCIDENT_END_DT ,
    NULL COMPLETE_INCIDENT_FLAG ,
    NULL RETURN_TO_MMS_DT ,
    (
    CASE
      WHEN i.responsible_staff_id IS NOT NULL
      THEN COALESCE( rs.last_name||','||rs.first_name||' '||rs.middle_name, TO_CHAR(i.responsible_staff_id))
      WHEN i.responsible_staff_id IS NULL
      THEN COALESCE(cs.last_name||','||cs.first_name||' '||cs.middle_name, i.created_by) ELSE NULL END) CREATED_BY_NAME ,
    i.generic_field1 GENERIC_FIELD_1 ,
    i.generic_field2 GENERIC_FIELD_2 ,
    i.generic_field3 GENERIC_FIELD_3 ,
    i.generic_field4 GENERIC_FIELD_4 ,
    i.generic_field5 GENERIC_FIELD_5 ,
    CASE WHEN i.client_id IS NULL THEN ccs.clnt_cin ELSE c.clnt_cin END ENROLLEE_RIN ,
    'N' RESEARCH_INCIDENT_FLAG ,
    NULL CANCEL_BY ,
    NULL CANCEL_REASON ,
    NULL CANCEL_METHOD ,
    a.addr_ctlk_id AS COUNTY_CODE ,
    b.description AS COUNTY_NAME ,
    REPLACE(REPLACE(substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,1),1,2000)||substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,2001),1,2000), '<action>', CHR(13)||CHR(10)), '</action>', '') ACTION_COMMENTS ,
    substrb(dbms_lob.substr(i.description,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.description,2000, 2001),1,2000) INCIDENT_DESCRIPTION ,
    CASE WHEN i.status_cd IN( 'CLOSED','STATE_COMPLETED') THEN substrb(dbms_lob.substr(i.resolution,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.resolution,2000, 2001),1,2000) ELSE NULL END RESOLUTION_DESCRIPTION ,
    i.client_id CLIENT_ID,
    COALESCE(TO_CHAR(i.responsible_staff_id),i.created_by) created_by_id,
    COALESCE(TO_CHAR(rs.ext_staff_number),cs.ext_staff_number) created_by_empid,
    CASE WHEN i.client_id IS NULL THEN ccs.clnt_fname||CASE WHEN ccs.clnt_mi IS NULL THEN ' ' ELSE ' '||ccs.clnt_mi||' ' END||ccs.clnt_lname
      ELSE c.clnt_fname||CASE WHEN c.clnt_mi IS NULL THEN ' ' ELSE ' '||c.clnt_mi||' ' END||c.clnt_lname END recipient_name,
    a.addr_street_1||' '||a.addr_street_2||' '||a.addr_city||' '||a.addr_state_cd||' '||a.addr_zip recipient_address,
    CASE WHEN p.phon_phone_number IS NOT NULL THEN '('||p.phon_area_code||')'||SUBSTR(p.phon_phone_number,1,3)||'-'||SUBSTR(p.phon_phone_number,4,4) ELSE NULL END recipient_phone
  FROM eb.incident_header i
  LEFT JOIN eb.address a                       ON (a.addr_case_id = i.case_id AND UPPER(a.addr_type_cd) = 'RS' AND a.addr_end_date IS NULL AND a.clnt_client_id IS NULL)
  LEFT JOIN eb.phone_number p                  ON (p.phon_case_id = i.case_id AND UPPER(p.phon_type_cd) = 'HM' AND p.phon_end_date IS NULL AND p.clnt_client_id IS NULL)
  LEFT JOIN eb.ENUM_COUNTY b                   ON (a.addr_ctlk_id = b.VALUE)
  LEFT JOIN eb.client c                        ON (c.clnt_client_id = i.client_id)
  LEFT JOIN eb.cases cs                        ON (i.case_id = cs.case_id)
  LEFT JOIN eb.client ccs                      ON (cs.clnt_client_id = ccs.clnt_client_id) --get the client info from case if incident client id is null
  LEFT JOIN eb.enum_action_taken rl            ON (rl.value=i.action_taken_cd)
  JOIN (SELECT * FROM eb.enum_affected_party_subtype
        WHERE effective_end_date IS NULL AND scope = 'INCIDENT') aps ON (aps.value=i.affected_party_subtype_cd)
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'INCIDENT') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=i.status_cd)
  LEFT JOIN eb.enum_incident_header_type t     ON (t.value=i.incident_header_type_cd)
  LEFT JOIN eb.enum_incident_origin o          ON (o.value=i.origin_cd)
  LEFT JOIN eb.enum_other_party_type opt       ON (opt.value=i.other_party_type_cd)
  LEFT JOIN eb.enum_priority p                 ON (p.value=i.priority_cd)
  LEFT JOIN eb.enum_relationship rr            ON (rr.value=i.reporter_relationship)
  LEFT JOIN eb.enum_reporter_type r            ON (r.value=i.reporter_type_cd)
  LEFT JOIN eb.enum_resolution_type rt         ON (rt.value=i.resolution_type_cd)
  LEFT JOIN eb.groups g                        ON (g.group_id=i.responsible_staff_group_id)
  LEFT JOIN eb.network n                       ON (n.network_id_ext=i.network_id_ext)
  LEFT JOIN eb.plans pl                        ON (pl.plan_id_ext = i.plan_id_ext AND rownum=1)
  LEFT JOIN eb.staff rs                        ON (rs.staff_id = i.responsible_staff_id)
  LEFT JOIN eb.staff cs                        ON (TO_CHAR(cs.staff_id) = (i.created_by))
  LEFT JOIN eb.staff us                        ON (TO_CHAR(us.staff_id) = (i.updated_by))
  LEFT JOIN
    (SELECT si.ref_id, MAX(step_instance_id) step_instance_id FROM eb.step_instance si
    JOIN eb.step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
    WHERE si.ref_type='incident_header'
    AND si.completed_ts IS NULL
    GROUP BY si.ref_id
    ) si ON (si.ref_id=i.incident_header_id) 
   LEFT JOIN (SELECT *
              FROM (SELECT slct.selection_segment_id, slct.plan_id, pl.plan_name, slct.client_id,slct.provider_id_ext,cc.cscl_case_id case_id
                           ,ROW_NUMBER() OVER(PARTITION BY cc.cscl_case_id ORDER BY selection_segment_id) rn
                    FROM eb.selection_segment slct                      
                      JOIN eb.case_client cc ON slct.client_id = cc.cscl_clnt_client_id   
                      LEFT JOIN eb.plans pl ON pl.plan_id = slct.plan_id
                      LEFT JOIN eb.contract con ON con.PLAN_ID = slct.plan_id              
                    WHERE 1=1
                    AND cc.cscl_status_End_date IS NULL 
                    AND con.end_date IS NULL
                    AND slct.start_nd < slct.end_nd
                    AND slct.program_type_cd = 'MEDICAID'
                    AND slct.plan_type_cd = 'MEDICAL'
                    AND slct.status_cd = 'OPEN')
                WHERE rn = 1) slct ON slct.case_id = cs.case_id               
  WHERE i.incident_header_type_cd = 'COMPLAINT'
    AND (i.received_ts >= ADD_MONTHS(TRUNC(SYSDATE), -13)) 
       OR i.status_cd not IN('CLOSED','STATE_COMPLETED' )
 UNION ALL
SELECT NULL	PI_BI_ID	,
NULL	INCIDENT_TRACKING_NUMBER	,
NULL	RECEIPT_DATE	,
dd.d_date	CREATE_DATE	,
NULL	CREATED_BY_GROUP	,
NULL	ORIGIN_ID	,
NULL	CHANNEL	,
NULL	AGE_IN_BUSINESS_DAYS	,
NULL	AGE_IN_CALENDAR_DAYS	,
NULL	PROCESS_CLIENT_NOTIFICATION_ID	,
'Active'	CUR_INSTANCE_STATUS	,
NULL	CANCEL_DATE	,
NULL	INCIDENT_TYPE	,
apt.DPIIA_ID,
apt.CUR_INCIDENT_ABOUT ,
apt.DPIIR_ID,
apt.CUR_INCIDENT_REASON ,
NULL	ABOUT_PROVIDER_ID	,
NULL	ABOUT_PLAN_CODE	,
NULL	CUR_INCIDENT_STATUS	,
NULL	CUR_INCIDENT_STATUS_DATE	,
NULL	STATUS_AGE_IN_BUSINESS_DAYS	,
NULL	STATUS_AGE_IN_CALENDAR_DAYS	,
NULL	CUR_JEOPARDY_STATUS	,
NULL	JEOPARDY_STATUS_DATE	,
NULL	COMPLETE_DATE	,
NULL	REPORTED_BY	,
NULL	REPORTER_RELATIONSHIP	,
NULL	CASE_ID	,
NULL	REPORTER_FIRST_NAME	,
NULL	REPORTER_LAST_NAME	,
NULL	REPORTER_FULL_NAME	,
NULL	REPORTER_PHONE	,
NULL	CUR_ENROLLMENT_STATUS	,
NULL	PRIORITY	,
NULL	PROGRAM	,
NULL	SUB_PROGRAM	,
NULL	CUR_LAST_UPDATE_DATE	,
NULL	CUR_LAST_UPDATE_BY_NAME	,
NULL	PLAN_ID	,
NULL	PROVIDER_ID	,
NULL	ACTION_TYPE	,
NULL	RESOLUTION_TYPE	,
NULL	NOTIFY_CLIENT_FLAG	,
NULL	PROCESS_CLNT_NOTIFY_START_DT	,
NULL	PROCESS_CLNT_NOTIFY_END_DT	,
NULL	PROCESS_CLNT_NOTIFY_FLAG	,
NULL	ESCALATE_INCIDENT_FLAG	,
NULL	ESCALATE_TO_STATE_DT	,
NULL	CUR_TASK_ID	,
NULL	STATE_RECEIVED_APPEAL_DATE	,
NULL	HEARING_DATE	,
NULL	SELECTION_ID	,
NULL	TIMELINESS_STATUS	,
NULL	EB_FOLLOWUP_NEEDED_FLAG	,
NULL	OTHER_PARTY_NAME	,
NULL	RESEARCH_INCIDENT_ST_DT	,
NULL	RESEARCH_INCIDENT_END_DT	,
NULL	PROCESS_INCIDENT_ST_DT	,
NULL	PROCESS_INCIDENT_END_DT	,
NULL	PROCESS_INCIDENT_FLAG	,
NULL	RETURN_INCIDENT_FLAG	,
NULL	COMPLETE_INCIDENT_ST_DT	,
NULL	COMPLETE_INCIDENT_END_DT	,
NULL	COMPLETE_INCIDENT_FLAG	,
NULL	RETURN_TO_MMS_DT	,
NULL	CREATED_BY_NAME	,
NULL	GENERIC_FIELD_1	,
NULL	GENERIC_FIELD_2	,
NULL	GENERIC_FIELD_3	,
NULL	GENERIC_FIELD_4	,
NULL	GENERIC_FIELD_5	,
NULL	ENROLLEE_RIN	,
NULL	RESEARCH_INCIDENT_FLAG	,
NULL	CANCEL_BY	,
NULL	CANCEL_REASON	,
NULL	CANCEL_METHOD	,
NULL	COUNTY_CODE	,
NULL	COUNTY_NAME	,
NULL	ACTION_COMMENTS	,
NULL	INCIDENT_DESCRIPTION	,
NULL	RESOLUTION_DESCRIPTION	,
NULL	CLIENT_ID	,
NULL	CREATED_BY_ID	,
NULL	CREATED_BY_EMPID	,
NULL	RECIPIENT_NAME	,
NULL	RECIPIENT_ADDRESS	,
NULL	RECIPIENT_PHONE	
FROM d_dates dd
  CROSS JOIN (SELECT apt.value DPIIA_ID, apt.report_label CUR_INCIDENT_ABOUT, aps.value DPIIR_ID, aps.report_label CUR_INCIDENT_REASON
              FROM eb.enum_affected_party_type apt   
                JOIN  eb.enum_affected_party_subtype aps ON apt.value = aps.affected_party_type_cd 
               WHERE apt.effective_end_date is null
               and aps.effective_end_date is null
               AND apt.scope = 'INCIDENT'
               AND aps.scope = 'INCIDENT') apt 
WHERE dd.d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13);

GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO MAXDATSUPPORT_READ_ONLY;
GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO MAXDAT_REPORTS;
  
DROP VIEW F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV;

CREATE OR REPLACE VIEW F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV 
AS
SELECT request_status_code
       ,request_status_description
       ,record_date      
       ,COUNT(DISTINCT urgent_request) urgent_request_count
       ,COUNT(DISTINCT non_urgent_request) non_urgent_request_count
       ,COUNT(DISTINCT incident_header_id) request_count
FROM (
SELECT i.incident_header_id 
       ,h.status_cd request_status_code
       ,TRUNC(h.create_ts) record_date
       ,CASE WHEN i.affected_party_type_cd = 'SATPR' THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  THEN i.incident_header_id ELSE null END non_urgent_request      
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
FROM incident_header i
  JOIN (SELECT *
        FROM(SELECT incident_header_id,status_cd,create_ts
               ,ROW_NUMBER() OVER (PARTITION BY h.incident_header_id,h.status_cd,TRUNC(h.create_ts) ORDER BY h.create_ts DESC,incident_header_stat_hist_id DESC) rrn 
             FROM incident_header_stat_hist h
             --WHERE request_status_code IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING')
         )
         WHERE rrn = 1  ) h  ON i.incident_header_id = h.incident_header_id
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'OUTREACHREQUEST') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=h.status_cd)        
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN('REFERRAL', 'SATPR')
AND i.status_cD IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON','APPROVED_BEACON','DENIED_BEACON')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description      
FROM d_dates
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('REFERRAL', 'SATPR')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate)
)
GROUP BY request_status_code,request_status_description,record_date ;

GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_STATUS_DATE_SV TO MAXDATSUPPORT_READ_ONLY;

DROP VIEW F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV;

CREATE OR REPLACE VIEW F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV 
AS
WITH submitted AS (
SELECT h.incident_header_id
      ,h.create_ts submitted_date
    FROM incident_header_stat_hist h
    WHERE h.status_cd in ('OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON')
)
SELECT distinct i.incident_header_id 
       ,h.status_cd request_status_code
       ,h.create_ts record_date
       ,CASE WHEN i.incident_header_id = submitted.incident_header_id  THEN submitted.submitted_date END submitted_date
       ,CASE WHEN i.affected_party_type_cd = 'SATPR' THEN i.incident_header_id ELSE null END urgent_request
       ,CASE WHEN i.affected_party_type_cd = 'REFERRAL'  THEN i.incident_header_id ELSE null END non_urgent_request      
       ,apt.report_label referral_desc            
       ,s.report_label request_status_description       
FROM incident_header i
  JOIN (SELECT *
        FROM(SELECT incident_header_id,status_cd,create_ts
               ,ROW_NUMBER() OVER (PARTITION BY h.incident_header_id,h.status_cd,TRUNC(h.create_ts) ORDER BY h.create_ts DESC,incident_header_stat_hist_id DESC) rrn 
             FROM incident_header_stat_hist h
             --WHERE request_status_code IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING')
         )
         WHERE rrn = 1  ) h  ON i.incident_header_id = h.incident_header_id
  JOIN (SELECT * FROM eb.enum_affected_party_type
        WHERE effective_end_date IS NULL AND scope = 'OUTREACHREQUEST') apt    ON (apt.value=i.affected_party_type_cd)
  LEFT JOIN eb.enum_incident_header_status s   ON (s.value=h.status_cd)        
  LEFT JOIN submitted ON submitted.incident_header_id = i.incident_header_id
WHERE  i.incident_header_type_cd = 'OUTREACH REQUEST'
AND i.affected_party_type_cd IN('REFERRAL', 'SATPR')
AND i.status_cd IN('OUTREACH_REQUEST_APPROVED','OUTREACH_COMPLETE','OUTREACH_REQUEST_DENIED','OUTREACH_REQUEST_PENDING','SUBMIT_LME_MCO','SUBMIT_BEACON','APPROVED_BEACON','DENIED_BEACON')
UNION ALL
SELECT NULL incident_header_id
      ,s.value request_status_code      
      ,d_date record_date
      ,NULL submitted_date
      ,NULL urgent_request
      ,NULL non_urgent_request
      ,apt.report_label referral_desc
      ,s.report_label request_status_description      
FROM d_dates
  CROSS JOIN eb.enum_affected_party_type apt        
  CROSS JOIN eb.enum_incident_header_status s 
WHERE apt.value in ('REFERRAL', 'SATPR')
AND d_date >= ADD_MONTHS(TRUNC(SYSDATE), -13)
AND d_date <= TRUNC(sysdate)
;

GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_ELIGIBILITY_REQUESTS_BY_SUBMITTED_DATE_SV TO MAXDATSUPPORT_READ_ONLY;