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
--dmh 4/2013, TRIM(S1.LAST_NAME) || DECODE(S1.LAST_NAME, NULL, NULL, ',') || TRIM(S1.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S1.MIDDLE_NAME, 1, 1), ' ')) GROUP_SUPERVISOR_NAME
--,s1.Display_Name  GROUP_SUPERVISOR_NAME
,CASE WHEN S1s.LAST_NAME||', '||S1s.FIRST_NAME != ', ' THEN S1s.LAST_NAME||', '||S1s.FIRST_NAME
      WHEN S1e.LAST_NAME||', '||S1e.FIRST_NAME != ', ' THEN S1e.LAST_NAME||', '||S1e.FIRST_NAME
       ELSE 'UNKNOWN' END  GROUP_SUPERVISOR_NAME
, G3.GROUP_NAME                 TEAM_NAME
, G4.GROUP_NAME                 TEAM_PARENT_NAME
--dmh 4/2013, TRIM(S2.LAST_NAME) || DECODE(S2.LAST_NAME, NULL, NULL, ',') || TRIM(S2.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S2.MIDDLE_NAME, 1, 1), ' ')) TEAM_SUPERVISOR_NAME
--dmh 9/2013,s1.Display_Name TEAM_SUPERVISOR_NAME
--,s2.Display_Name TEAM_SUPERVISOR_NAME
,CASE WHEN S2s.LAST_NAME||', '||S2s.FIRST_NAME != ', ' THEN S2s.LAST_NAME||', '||S2s.FIRST_NAME
      WHEN S2e.LAST_NAME||', '||S2e.FIRST_NAME != ', ' THEN S2e.LAST_NAME||', '||S2e.FIRST_NAME
       ELSE 'UNKNOWN' END  TEAM_SUPERVISOR_NAME
, SI.REF_ID             SOURCE_REFERENCE_ID
-- 9/24/13 B.Thai Add SI.REF_TYPE to default to source, and APP_DOC_TRACKER_ID value for NYHIX-1572.
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
                            , 'APP_DOC_TRACKER_ID' ,'App Doc Tracker ID'
                            ,                        SI.REF_TYPE)  SOURCE_REFERENCE_TYPE
--dmh 4/2013, TRIM(S3.LAST_NAME) || DECODE(S3.LAST_NAME, NULL, NULL, ',') || TRIM(S3.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S3.MIDDLE_NAME, 1, 1), ' ')) CREATED_BY_NAME
--,s3.Display_Name CREATED_BY_NAME
,CASE WHEN S3s.LAST_NAME||', '||S3s.FIRST_NAME != ', ' THEN S3s.LAST_NAME||', '||S3s.FIRST_NAME
      WHEN S3e.LAST_NAME||', '||S3e.FIRST_NAME != ', ' THEN S3e.LAST_NAME||', '||S3e.FIRST_NAME
       ELSE 'UNKNOWN' END  CREATED_BY_NAME
--dmh 4/2013, TRIM(S4.LAST_NAME) || DECODE(S4.LAST_NAME, NULL, NULL, ',') || TRIM(S4.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S4.MIDDLE_NAME, 1, 1), ' ')) ESCALATED_TO_NAME
--,s4.Display_Name ESCALATED_TO_NAME
,CASE WHEN S4s.LAST_NAME||', '||S4s.FIRST_NAME != ', ' THEN S4s.LAST_NAME||', '||S4s.FIRST_NAME
      WHEN S4e.LAST_NAME||', '||S4e.FIRST_NAME != ', ' THEN S4e.LAST_NAME||', '||S4e.FIRST_NAME
       ELSE 'UNKNOWN' END  ESCALATED_TO_NAME
--dmh 4/2013, TRIM(S5.LAST_NAME) || DECODE(S5.LAST_NAME, NULL, NULL, ',') || TRIM(S5.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S5.MIDDLE_NAME, 1, 1), ' ')) FORWARDED_BY_NAME
--,s5.Display_Name FORWARDED_BY_NAME
,CASE WHEN S5s.LAST_NAME||', '||S5s.FIRST_NAME != ', ' THEN S5s.LAST_NAME||', '||S5s.FIRST_NAME
      WHEN S5e.LAST_NAME||', '||S5e.FIRST_NAME != ', ' THEN S5e.LAST_NAME||', '||S5e.FIRST_NAME
       ELSE 'UNKNOWN' END  FORWARDED_BY_NAME
--dmh 4/2013, TRIM(S6.LAST_NAME) || DECODE(S6.LAST_NAME, NULL, NULL, ',') || TRIM(S6.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S6.MIDDLE_NAME, 1, 1), ' ')) OWNER_NAME
--,s6.Display_Name OWNER_NAME
,CASE WHEN S6s.LAST_NAME||', '||S6s.FIRST_NAME != ', ' THEN S6s.LAST_NAME||', '||S6s.FIRST_NAME
      WHEN S6e.LAST_NAME||', '||S6e.FIRST_NAME != ', ' THEN S6e.LAST_NAME||', '||S6e.FIRST_NAME
       ELSE 'UNKNOWN' END  OWNER_NAME
, SI.SUSPENDED_TS
, 0                                AGE_IN_CALENDAR_DAYS
, 0                                AGE_IN_BUSINESS_DAYS
, SI.HIST_CREATE_TS                STATUS_DATE
, 0                                STATUS_AGE_IN_BUS_DAYS
, 0                                STATUS_AGE_IN_CAL_DAYS
, SI.HIST_CREATE_TS                LAST_UPDATE_DATE
, SI.HIST_CREATE_BY                LAST_UPDATED_BY
, sla_days.VALUE                   SLA_DAYS
, sla_type.VALUE                   SLA_DAYS_TYPE
, sla_target_days.VALUE            SLA_TARGET_DAYS
, sla_Jeopardy_days.VALUE          SLA_JEOPARDY_DAYS
, 'N'                              JEOPARDY_FLAG
, 'Not Complete'                   TIMELINESS_STATUS
, 'N'                              ASF_CANCEL_WORK
, 'N'                              ASF_COMPLETE_WORK
,  TO_DATE(NULL)                   CANCEL_WORK_DATE
, 'N'                              CANCEL_WORK_FLAG
, CASE
      WHEN  decode (SI.hist_status,'COMPLETED', SI.COMPLETED_TS,NULL) IS NULL THEN 'N'
      ELSE 'Y'
  END   COMPLETE_FLAG
--dmh 4/2013,  TRIM(S7.LAST_NAME) || DECODE(S7.LAST_NAME, NULL, NULL, ',') || TRIM(S7.FIRST_NAME) || RTRIM(LPAD(SUBSTR(S7.MIDDLE_NAME, 1, 1), ' '))                LAST_UPDATE_BY_NAME
--,s7.Display_Name  LAST_UPDATE_BY_NAME
,CASE WHEN S7s.LAST_NAME||', '||S7s.FIRST_NAME != ', ' THEN S7s.LAST_NAME||', '||S7s.FIRST_NAME
      WHEN S7e.LAST_NAME||', '||S7e.FIRST_NAME != ', ' THEN S7e.LAST_NAME||', '||S7e.FIRST_NAME
       ELSE 'UNKNOWN' END  LAST_UPDATE_BY_NAME
,  si.stage_create_ts          STG_EXTRACT_DATE
,  SYSDATE                STAGE_DONE_DATE
,  unit_of_work_list.out_var          UNIT_OF_WORK
,  SI.Step_instance_history_id
,  SI.MW_PROCESSED
,  SI.CLIENT_ID
,  SI.CASE_ID
,  SI.STAGE_CREATE_TS
,  SI.priority
,  SI.status_order   -- NYHIX-4273
FROM STEP_INSTANCE_stg SI
     LEFT JOIN STEP_DEFINITION_STG SD ON SD.STEP_DEFINITION_ID  = SI.STEP_DEFINITION_ID
--                                     AND sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK')
     LEFT OUTER JOIN GROUPS_STG G1 ON G1.GROUP_ID = SI.GROUP_ID
     LEFT OUTER JOIN GROUPS_STG G2 ON G2.GROUP_ID = G1.PARENT_GROUP_ID
     LEFT OUTER JOIN GROUPS_STG G3 ON G3.GROUP_ID = SI.TEAM_ID
     LEFT OUTER JOIN GROUPS_STG G4 ON G4.GROUP_ID = G3.PARENT_GROUP_ID
     LEFT JOIN STAFF_stg S1s ON cast(S1s.STAFF_ID as Char(8)) = cast(G1.SUPERVISOR_STAFF_ID as Char(8))
     LEFT JOIN STAFF_stg S2s ON cast(S2s.STAFF_ID as Char(8)) = cast(G3.SUPERVISOR_STAFF_ID as Char(8))
     LEFT JOIN STAFF_stg S3s ON cast(S3s.STAFF_ID as Char(8)) = cast(SI.CREATED_BY as Char(8))
     LEFT JOIN STAFF_stg S4s ON cast(S4s.STAFF_ID as Char(8)) = cast(SI.ESCALATE_TO as Char(8))
     LEFT JOIN STAFF_stg S5s ON cast(S5s.STAFF_ID as Char(8)) = cast(SI.FORWARDED_BY as Char(8))
     LEFT JOIN STAFF_stg S6s ON cast(S6s.STAFF_ID as Char(8)) = cast(SI.OWNER as Char(8))
     LEFT JOIN STAFF_stg S7s ON cast(S7s.STAFF_ID as Char(8)) = cast(SI.HIST_CREATE_BY as Char(8))
     LEFT JOIN STAFF_stg S1e ON S1e.ext_staff_number = TO_CHAR(G1.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_stg S2e ON S2e.ext_staff_number = TO_CHAR(G3.SUPERVISOR_STAFF_ID)
     LEFT JOIN STAFF_stg S3e ON S3e.ext_staff_number = TO_CHAR(SI.CREATED_BY)
     LEFT JOIN STAFF_stg S4e ON S4e.ext_staff_number = TO_CHAR(SI.ESCALATE_TO)
     LEFT JOIN STAFF_stg S5e ON S5e.ext_staff_number = TO_CHAR(SI.FORWARDED_BY)
     LEFT JOIN STAFF_stg S6e ON S6e.ext_staff_number = TO_CHAR(SI.OWNER)
     LEFT JOIN STAFF_stg S7e ON S7e.ext_staff_number = TO_CHAR(SI.HIST_CREATE_BY)
     LEFT OUTER JOIN
                     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
                        FROM  corp_etl_list_lkup
                        WHERE NAME = 'ManageWork_SLA_Days'
                        AND   SYSDATE BETWEEN start_date AND end_date
                        AND   ref_type = 'STEP_DEFINITION_ID') sla_days
     ON sla_days.ref_id =  si.step_definition_id
     LEFT OUTER JOIN
                      (SELECT  ref_id, decode(out_var,'N',to_char(NULL),out_var) AS VALUE
                         FROM  corp_etl_list_lkup
                         WHERE NAME = 'ManageWork_SLA_Days_Type'
                         AND   SYSDATE BETWEEN start_date AND end_date
                         AND   ref_type = 'STEP_DEFINITION_ID' ) sla_type
     ON sla_Type.ref_id  =  si.step_definition_id
     LEFT OUTER JOIN
                     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
                        FROM  corp_etl_list_lkup
                        WHERE NAME = 'ManageWork_SLA_Jeopardy_Days'
                        AND   SYSDATE BETWEEN start_date AND end_date
                        AND   ref_type = 'STEP_DEFINITION_ID') sla_Jeopardy_days
     ON sla_Jeopardy_days.ref_id =  si.step_definition_id
     LEFT OUTER JOIN
                     (SELECT  ref_id, decode(out_var,'0',to_number(NULL),to_number(out_var)) AS VALUE
                        FROM  corp_etl_list_lkup
                        WHERE NAME = 'ManageWork_SLA_Target_Days'
                        AND   SYSDATE BETWEEN start_date AND end_date
                        AND   ref_type = 'STEP_DEFINITION_ID') sla_target_days
   ON sla_target_days.ref_id =  si.step_definition_id
   LEFT OUTER JOIN
                   (SELECT out_var, value FROM corp_etl_list_lkup WHERE NAME = 'ManageWork_UnitOfWork' AND SYSDATE BETWEEN START_date AND END_DATE) unit_of_work_list
   ON unit_of_work_list.value = sd.NAME
where SI.MW_PROCESSED = 'N'
   AND sd.step_type_cd IN ('HUMAN_TASK','VIRTUAL_HUMAN_TASK');

Grant select on MW_STEP_INSTANCE_VW to MAXDAT_READ_ONLY;