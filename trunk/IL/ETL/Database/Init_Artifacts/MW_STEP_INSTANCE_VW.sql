CREATE OR REPLACE VIEW MW_STEP_INSTANCE_VW AS
SELECT si.ROWID                              stage_rowid
, SI.STEP_INSTANCE_ID                   TASK_ID
, SI.hist_status                        TASK_STATUS
, SD.NAME                               TASK_TYPE
, SI.CREATE_TS                          CREATE_DATE
, decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL)  COMPLETE_DATE
, DECODE(SI.ESCALATED_IND, 1, 'Y', 'N') ESCALATED_FLAG
, SI.STEP_DUE_TS
, DECODE(SI.FORWARDED_IND, 1, 'Y', 'N') FORWARDED_FLAG
, G1.GROUP_NAME                         GROUP_NAME
, G2.GROUP_NAME                         GROUP_PARENT_NAME
, TRIM(S1.LAST_NAME) || DECODE(S1.LAST_NAME, NULL, NULL, ',') || TRIM(S1.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S1.MIDDLE_NAME, 1, 1), ' ')) GROUP_SUPERVISOR_NAME
, G3.GROUP_NAME                 TEAM_NAME
, G4.GROUP_NAME                 TEAM_PARENT_NAME
, TRIM(S2.LAST_NAME) || DECODE(S2.LAST_NAME, NULL, NULL, ',') || TRIM(S2.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S2.MIDDLE_NAME, 1, 1), ' ')) TEAM_SUPERVISOR_NAME
, SI.REF_ID             SOURCE_REFERENCE_ID
, decode(upper(SI.REF_TYPE) , 'APP_HEADER'         ,'Application ID'
                            , 'APPLICATION_ID'     ,'Application ID'
                            , 'DOCUMENT_ID'        ,'Document ID'
                            , 'DOCUMENT'           ,'Document ID'
                            , 'DOCUMENT_SET_ID'    ,'Document Set ID'
                            , 'DOCUMENT_SET'       ,'Document Set ID'
                            , 'IMAGING'            ,'Image ID'
                            , 'CASES'              ,'Case ID'
                            , 'CASE_ID'            ,'Case ID'
                            , 'CLIENT'             ,'Client ID'
                            , 'CLNT_CLIENT_ID'     ,'Client ID'
                            , 'CALL_RECORD'        ,'Call ID'
                            , 'CALL_RECORD_ID'     ,'Call ID'
                            , 'INCIDENT_HEADER'    ,'Incident ID'
                            , 'INCIDENT_HEADER_ID' ,'Incident ID'
                            ,                        NULL)  SOURCE_REFERENCE_TYPE
, TRIM(S3.LAST_NAME) || DECODE(S3.LAST_NAME, NULL, NULL, ',') || TRIM(S3.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S3.MIDDLE_NAME, 1, 1), ' ')) CREATED_BY_NAME
, TRIM(S4.LAST_NAME) || DECODE(S4.LAST_NAME, NULL, NULL, ',') || TRIM(S4.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S4.MIDDLE_NAME, 1, 1), ' ')) ESCALATED_TO_NAME
, TRIM(S5.LAST_NAME) || DECODE(S5.LAST_NAME, NULL, NULL, ',') || TRIM(S5.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S5.MIDDLE_NAME, 1, 1), ' ')) FORWARDED_BY_NAME
, TRIM(S6.LAST_NAME) || DECODE(S6.LAST_NAME, NULL, NULL, ',') || TRIM(S6.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S6.MIDDLE_NAME, 1, 1), ' ')) OWNER_NAME
, SI.SUSPENDED_TS
, TRUNC(NVL(SI.COMPLETED_TS, SYSDATE)) - TRUNC(SI.CREATE_TS) AGE_IN_CALENDAR_DAYS
, bus_days_between(SI.CREATE_TS, NVL(SI.COMPLETED_TS, SYSDATE))  AGE_IN_BUSINESS_DAYS
, SI.HIST_CREATE_TS                STATUS_DATE
, DECODE(SI.hist_status, 'COMPLETED', 0, bus_days_between(SI.HIST_CREATE_TS, NVL(SI.COMPLETED_TS, SYSDATE))) STATUS_AGE_IN_BUS_DAYS
, DECODE(SI.hist_status, 'COMPLETED', 0,TRUNC(NVL(SI.COMPLETED_TS, SYSDATE)) - TRUNC(SI.HIST_CREATE_TS))     STATUS_AGE_IN_CAL_DAYS
, SI.HIST_CREATE_TS                LAST_UPDATE_DATE
, SI.HIST_CREATE_BY                LAST_UPDATED_BY
, sla_days.VALUE                   SLA_DAYS
, sla_type.VALUE                   SLA_DAYS_TYPE
, sla_target_days.VALUE            SLA_TARGET_DAYS
, sla_Jeopardy_days.VALUE          SLA_JEOPARDY_DAYS
, CASE
            WHEN sla_Jeopardy_days.VALUE is null then 'N'
            WHEN sla_type.VALUE = 'B' AND  bus_days_between(SI.CREATE_TS, NVL(SI.COMPLETED_TS, SYSDATE)) > sla_Jeopardy_days.VALUE THEN 'Y'
            WHEN sla_type.VALUE = 'C' AND  TRUNC(NVL(SI.COMPLETED_TS, SYSDATE)) - TRUNC(SI.CREATE_TS) >  sla_Jeopardy_days.VALUE THEN 'Y'
            ELSE 'N'
  END     JEOPARDY_FLAG
, CASE
            WHEN  decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL) IS NULL then 'Not Complete'  -- COMPLETE_FLAG is 'N'
            WHEN sla_days.VALUE is null then 'Not Required'
            WHEN sla_type.VALUE = 'B' AND  bus_days_between(SI.CREATE_TS, NVL(SI.COMPLETED_TS, SYSDATE)) >  sla_days.VALUE then 'Untimely'
            WHEN sla_type.VALUE = 'C' AND  TRUNC(NVL(SI.COMPLETED_TS, SYSDATE)) - TRUNC(SI.CREATE_TS) >  sla_days.VALUE then 'Untimely'
            else 'Timely'
  END    TIMELINESS_STATUS
, 'N'                              ASF_CANCEL_WORK
, 'N'                              ASF_COMPLETE_WORK
,  TO_DATE(NULL)                   CANCEL_WORK_DATE
, 'N'                              CANCEL_WORK_FLAG
, CASE
      WHEN  decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL) IS NULL THEN 'N'
      ELSE 'Y'
  END   COMPLETE_FLAG
,  TRIM(S7.LAST_NAME) || DECODE(S7.LAST_NAME, NULL, NULL, ',') || TRIM(S7.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S7.MIDDLE_NAME, 1, 1), ' '))                LAST_UPDATE_BY_NAME
,  si.stage_create_ts          STG_EXTRACT_DATE
,  SYSDATE                STAGE_DONE_DATE
,  unit_of_work_list.out_var          UNIT_OF_WORK
,  SI.Step_instance_history_id
,SI.MW_PROCESSED,
 SI.STAGE_CREATE_TS
FROM STEP_INSTANCE_stg SI,
     STEP_DEFINITION_STG SD,
     GROUPS_STG G1,
     GROUPS_STG G2,
     GROUPS_STG G3,
     GROUPS_STG G4,
     STAFF_lkup S1,
     STAFF_lkup S2,
     STAFF_lkup S3,
     STAFF_lkup S4,
     STAFF_lkup S5,
     STAFF_lkup S6,
     STAFF_lkup S7,
     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
        FROM  corp_etl_list_lkup
        WHERE NAME = 'ManageWork_SLA_Days'
        AND   SYSDATE BETWEEN start_date AND end_date
        AND   ref_type = 'STEP_DEFINITION_ID') sla_days,
     (SELECT  ref_id, decode(out_var,'N',to_char(NULL),out_var) AS VALUE
        FROM  corp_etl_list_lkup
        WHERE NAME = 'ManageWork_SLA_Days_Type'
        AND   SYSDATE BETWEEN start_date AND end_date
        AND   ref_type = 'STEP_DEFINITION_ID' ) sla_type,
     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
        FROM  corp_etl_list_lkup
        WHERE NAME = 'ManageWork_SLA_Jeopardy_Days'
        AND   SYSDATE BETWEEN start_date AND end_date
        AND   ref_type = 'STEP_DEFINITION_ID') sla_Jeopardy_days,
     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
        FROM  corp_etl_list_lkup
        WHERE NAME = 'ManageWork_SLA_Target_Days'
        AND   SYSDATE BETWEEN start_date AND end_date
        AND   ref_type = 'STEP_DEFINITION_ID') sla_target_days,
   (SELECT out_var, value FROM corp_etl_list_lkup WHERE NAME = 'ManageWork_UnitOfWork' AND SYSDATE BETWEEN START_date AND END_DATE) unit_of_work_list
where SI.MW_PROCESSED = 'N'
  AND sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
  AND SD.STEP_DEFINITION_ID  = SI.STEP_DEFINITION_ID
  AND G1.GROUP_ID (+) = SI.GROUP_ID
  AND G2.GROUP_ID (+) = G1.PARENT_GROUP_ID
  AND G3.GROUP_ID (+) = SI.TEAM_ID
  AND G4.GROUP_ID (+) = G3.PARENT_GROUP_ID
  AND S1.STAFF_ID (+) = TO_CHAR(G1.SUPERVISOR_STAFF_ID)
  AND S2.STAFF_ID (+) = TO_CHAR(G3.SUPERVISOR_STAFF_ID)
  AND S3.STAFF_ID (+) = TO_CHAR(SI.CREATED_BY)
  AND S4.STAFF_ID (+) = TO_CHAR(SI.ESCALATE_TO)
  AND S5.STAFF_ID (+) = TO_CHAR(SI.FORWARDED_BY)
  AND S6.STAFF_ID (+) = TO_CHAR(SI.OWNER)
  AND S7.STAFF_ID (+) = TO_CHAR(SI.HIST_CREATE_BY)
  and unit_of_work_list.value (+) = sd.NAME
  AND sla_days.ref_id (+) =  si.step_definition_id
  AND sla_Type.ref_id (+) =  si.step_definition_id
  AND sla_Jeopardy_days.ref_id (+) =  si.step_definition_id
  AND sla_target_days.ref_id (+) =  si.step_definition_id;
