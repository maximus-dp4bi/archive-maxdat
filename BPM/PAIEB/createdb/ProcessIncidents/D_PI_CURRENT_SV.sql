CREATE OR REPLACE VIEW D_PI_CURRENT_SV
AS
SELECT i.incident_header_id PI_BI_ID ,
    i.application_id AS APP_ID,
    COALESCE(i.client_id, 0) AS CLIENT_ID,
    i.tracking_number INCIDENT_TRACKING_NUMBER ,
    i.fair_hearing_tracking_nbr HEARING_TRACKING_NUMBER,
    i.received_ts RECEIPT_DATE ,
    i.create_ts CREATE_DATE ,
    COALESCE(i.responsible_staff_group_id, 0) AS CREATED_BY_GROUP_ID,
    i.origin_id ,
    COALESCE(i.origin_cd, '0') AS CHANNEL_CODE,
    (
    CASE
      WHEN i.create_ts IS NOT NULL
      AND (
        CASE
          WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
          THEN i.status_ts
          ELSE sysdate
        END) IS NOT NULL
      THEN
        (SELECT
          CASE
            WHEN (COUNT(*)-1) < 0
            THEN 0
            ELSE COUNT(*)-1
          END
        FROM MAXDAT_SUPPORT.D_DATES
        WHERE business_day_flag = 'Y'
        AND d_date BETWEEN i.CREATE_TS AND (
          CASE
            WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
            THEN i.status_ts
            ELSE sysdate
          END)
        )
      ELSE 0
    END ) AGE_IN_BUSINESS_DAYS ,
    TRUNC(
    CASE
      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
      THEN i.status_ts
      ELSE sysdate
    END) - TRUNC(i.create_ts) AGE_IN_CALENDAR_DAYS ,
    0 PROCESS_CLIENT_NOTIFICATION_ID ,
    CASE
      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
      THEN 346
      ELSE 345
    END INSTANCE_STATUS_CODE,
    CASE
      WHEN i.status_cd IN (SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CANCELLED_STATUS')
      THEN i.status_ts
      ELSE NULL
    END CANCEL_DATE ,
    i.incident_header_type_cd AS INCIDENT_TYPE_CODE,
    i.affected_party_type_cd AS INCIDENT_ABOUT_CODE,
    COALESCE(i.affected_party_subtype_cd, '0') AS INCIDENT_REASON_CODE,
    COALESCE(i.network_id_ext, '0') AS network_id_ext,     
    COALESCE(i.plan_id_ext, '0') ABOUT_PLAN_CODE ,
    COALESCE(i.status_cd, '0') AS INCIDENT_STATUS_CODE,
    i.status_ts CUR_INCIDENT_STATUS_DATE ,
    (
    CASE
      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
      THEN 0
      ELSE (
        CASE
          WHEN i.create_ts IS NOT NULL
          AND i.status_ts IS NOT NULL
          THEN
            (SELECT
              CASE
                WHEN (COUNT(*)-1) < 0
                THEN 0
                ELSE COUNT(*)-1
              END
            FROM MAXDAT_SUPPORT.D_DATES
            WHERE business_day_flag = 'Y'
            AND d_date BETWEEN TRUNC(i.status_ts) AND TRUNC(sysdate) 
            )
          ELSE 0
        END )
    END) STATUS_AGE_IN_BUSINESS_DAYS ,
    CASE
      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
      THEN 0
      ELSE TRUNC(sysdate) - TRUNC(i.status_ts)
    END STATUS_AGE_IN_CALENDAR_DAYS ,
--    CASE
--      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
--      THEN 347
--      ELSE
--        CASE
--          WHEN TRUNC(sysdate) - TRUNC(i.create_ts) >= 20
--          THEN 345
--          ELSE 346
--        END
--    END JEOPARDY_STATUS_CODE ,
    347 AS JEOPARDY_STATUS_CODE ,
    NULL AS JEOPARDY_STATUS_DATE ,
    CASE
      WHEN i.status_cd IN(SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CLOSED_STATUS')
      THEN i.status_ts
      ELSE NULL
    END COMPLETE_DATE ,
    COALESCE(i.reporter_type_cd, '0') AS REPORTED_BY_CODE,
    COALESCE(i.reporter_relationship, '0') AS REPORTER_RELATIONSHIP_CODE,
    COALESCE(i.case_id, 0) CASE_ID ,
    NULL CUR_ENROLLMENT_STATUS ,
    i.priority_cd AS PRIORITY_CODE,
    'MEDICAID' PROGRAM ,
    app.subprogram_code SUBPROGRAM_CODE ,
    i.update_ts CUR_LAST_UPDATE_DATE ,
    COALESCE(i.updated_by, '0') as updated_by,
    NULL PLAN_CODE ,
    NULL PROVIDER_ID ,
    COALESCE(i.action_taken_cd, '0') ACTION_TYPE_CODE,
    COALESCE(i.RESOLUTION_TYPE_CD, '0') AS RESOLUTION_TYPE_CODE,
    'N' NOTIFY_CLIENT_FLAG ,
    NULL PROCESS_CLNT_NOTIFY_START_DT ,
    NULL PROCESS_CLNT_NOTIFY_END_DT ,
    NULL PROCESS_CLNT_NOTIFY_FLAG ,
    NULL ESCALATE_INCIDENT_FLAG,
    NULL ESCALATE_TO_STATE_DT ,
    si.step_instance_id CUR_TASK_ID ,
    NULL STATE_RECEIVED_APPEAL_DATE ,
    i.hearing_date HEARING_DATE ,
    i.selection_id SELECTION_ID ,
--    CASE
--      WHEN i.status_cd IN('CLOSED')
--      THEN
--        CASE
--          WHEN TRUNC(i.status_ts) - TRUNC(i.create_ts) <= 30
--          THEN 'Processed Timely'
--          ELSE 'Processed Untimely'
--        END
--      WHEN i.status_cd <> 'CLOSED'
--      THEN 'Not Processed'
--      ELSE NULL
--    END TIMELINESS_STATUS ,
    'NA' AS TIMELINESS_STATUS ,
    (
    CASE
      WHEN (i.eb_follow_up_needed_ind IS NULL
      OR i.eb_follow_up_needed_ind=0 )
      THEN 'N'
      WHEN i.eb_follow_up_needed_ind=1
      THEN 'Y'
      ELSE NULL
    END) EB_FOLLOWUP_NEEDED_FLAG ,
    i.other_party_name OTHER_PARTY_NAME,
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
    i.generic_field1 GENERIC_FIELD_1 ,
    i.generic_field2 GENERIC_FIELD_2 ,
    i.generic_field3 GENERIC_FIELD_3 ,
    i.generic_field4 GENERIC_FIELD_4 ,
    i.generic_field5 GENERIC_FIELD_5 ,
--    c.clnt_cin ENROLLEE_RIN ,
    i.reporter_first_name || ' ' ||i.reporter_last_name REPORTER_NAME ,
    i.reporter_phone AS REPORTER_PHONE,
    'N' RESEARCH_INCIDENT_FLAG ,
    CASE
      WHEN i.status_cd IN (SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CANCELLED_STATUS')
      THEN i.updated_by
      ELSE '0'
    END CANCEL_BY_ID,
    CASE
      WHEN i.status_cd IN (SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CANCELLED_STATUS')
      THEN 'Incident Withdrawn'
      ELSE NULL
    END CANCEL_REASON ,
    CASE
      WHEN i.status_cd IN (SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_CANCELLED_STATUS') 
      THEN 'Normal'
      ELSE NULL
    END CANCEL_METHOD ,
    REPLACE(REPLACE(substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,1),1,2000)||substrb(DBMS_LOB.SUBSTR(xmltype.createxml(i.actions_taken).extract('/actions_taken/action_taken/action').getClobVal(),2000,2001),1,2000), '<action>', CHR(13)||CHR(10)), '</action>', '') ACTION_COMMENTS ,
    substrb(dbms_lob.substr(i.description,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.description,2000, 2001),1,2000) INCIDENT_DESCRIPTION ,
    substrb(dbms_lob.substr(i.resolution,2000, 1 ),1,2000)|| substrb(dbms_lob.substr(i.resolution,2000, 2001),1,2000) RESOLUTION_DESCRIPTION ,
    COALESCE(TO_CHAR(i.responsible_staff_id),i.created_by, '0') created_by_id 
    ,CASE WHEN i.status_cd IN (SELECT OUT_VAR FROM  maxdat_support.CORP_ETL_LIST_LKUP WHERE name = 'INCIDENT_ESCALATED_STATUS')
          THEN i.create_ts 
          ELSE NULL
     END AS ESCALATE_DATE,
     TRUNC(twc.create_ts) as THREE_WAY_CALL_DATE,
     twc.THREE_WAY_CALL_RESULT_CD,
     COALESCE(i.OTHER_PARTY_TYPE_CD, '0') AS OTHER_PARTY_TYPE_CD,
     COALESCE(phcl.phon_area_code,phcase.phon_area_code) phone_area_code,
     COALESCE(phcl.phon_phone_number,phcase.phon_phone_number) phone_number,
     COALESCE(phcl.clnt_phone_number,phcase.case_phone_number) phone_number_disp
  FROM incident_header i
  LEFT JOIN incident_three_way_call twc ON (i.incident_header_id = twc.incident_header_id)
  LEFT JOIN 
    (SELECT si.ref_id, MAX(step_instance_id) step_instance_id FROM step_instance si
    JOIN step_definition sd ON (si.step_definition_id = sd.step_definition_id AND sd.step_type_cd IN ('VIRTUAL_HUMAN_TASK','HUMAN_TASK'))
    WHERE si.ref_type='INCIDENT_HEADER'
    AND si.completed_ts IS NULL
    GROUP BY si.ref_id
    ) si ON (si.ref_id=i.incident_header_id)
  LEFT JOIN (SELECT ah.application_id app_id
                    ,i.client_id
                    ,COALESCE(o.program_subtype_cd,'UD') subprogram_code
                    ,TRUNC(he.app_start_date) app_start_dt 
                    ,RANK() OVER(PARTITION BY i.client_id ORDER BY TRUNC(ah.application_id) DESC) as rnk
              FROM app_header ah
              JOIN app_individual i ON (ah.application_id = i.application_id and COALESCE(i.removed_from_app_ind, 0) = 0) 
              LEFT JOIN app_header_ext he ON (ah.application_id = he.application_id)
              LEFT JOIN app_elig_outcome o ON (i.app_individual_id = o.app_individual_id)  
  ) app ON (app.rnk = 1 AND app.client_id = COALESCE(i.client_id, 0) AND TRUNC(i.received_ts) >= TRUNC(app.app_start_dt))
  LEFT JOIN(SELECT *
            FROM(SELECT phon_id,phon_case_id,clnt_client_id,phon_type_cd,phon_area_code,phon_phone_number
                    ,'('||phon_area_code||')'||SUBSTR(phon_phone_number,1,3)||'-'||SUBSTR(phon_phone_number,4,4) case_phone_number
                    ,RANK() OVER(PARTITION BY phon_case_id ORDER BY phon_end_date DESC NULLS FIRST,DECODE(phon_type_cd,'CH',1,'CM',2,'HM',3),phon_id DESC) rn
                 FROM phone_number
                 WHERE phon_case_id IS NOT NULL
                 AND phon_type_cd IN('CH','CM','HM')) 
            WHERE rn =1) phcase ON phcase.phon_case_id = i.case_id
  LEFT JOIN(SELECT *
            FROM(SELECT phon_id,phon_case_id,clnt_client_id,phon_type_cd,phon_area_code,phon_phone_number
                    ,'('||phon_area_code||')'||SUBSTR(phon_phone_number,1,3)||'-'||SUBSTR(phon_phone_number,4,4) clnt_phone_number
                    ,RANK() OVER(PARTITION BY clnt_client_id ORDER BY phon_end_date DESC NULLS FIRST,DECODE(phon_type_cd,'CH',1,'CM',2,'HM',3),phon_id DESC) rn
                 FROM phone_number
                 WHERE clnt_client_id IS NOT NULL
                 AND phon_type_cd IN('CH','CM','HM'))
            WHERE rn =1) phcl ON phcl.clnt_client_id = i.client_id  
--  WHERE i.incident_header_type_cd IN ('COMPLAINT','LIAISON', 'APPEAL')
    --   and (i.received_ts >=(ADD_MONTHS(TRUNC(sysdate,'mm'),-2))
    --      or i.status_cd not IN('REFERRED_TO_STATE','REFERRED_TO_PLAN','CLOSED','WITHDRAWN' ))
    ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_PI_CURRENT_SV TO MAXDAT_REPORTS ;