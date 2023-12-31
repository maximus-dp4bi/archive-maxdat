CREATE OR REPLACE FORCE VIEW MAXDAT_LOOKUP.D_PL_CURRENT_SV
AS
  SELECT
    --D_PL_CURRENT_SV
    CASE
      WHEN SI.TASK_ID IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS CREATE_ROUTE_WORK_FLAG ,
    CASE
      WHEN LR.MAILED_DATE IS NOT NULL OR ER.DESCRIPTION IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS CONFIRMATION_FLAG ,
    LR.LMREQ_ID AS PL_BI_ID ,
    LR.CREATE_TS AS CREATE_DATE ,
    LR.CREATED_BY AS CREATED_BY --just get directly from letter request
    ,
    LR.REQUESTED_ON AS REQUEST_DATE ,
    CASE
      WHEN LR.MAILED_DATE IS NOT NULL
      THEN 'Complete'
      WHEN LR.SENT_ON IS NULL AND LR.ERROR_CODES IS NOT NULL
      THEN 'Complete'
      WHEN ER.DESCRIPTION IS NOT NULL
      THEN 'Complete'
      WHEN LR.STATUS_CD IN ('CANC','VOID','OBE','COMBND')
      THEN 'Complete'
      ELSE 'Active'
    END AS INSTANCE_STATUS ,
    LD.DESCRIPTION AS LETTER_TYPE ,
    PR.REPORT_LABEL AS PROGRAM ,
    LR.CASE_ID AS CASE_ID ,
    (SELECT report_label FROM enum_county ec WHERE ec.value = LH.RESIDENCE_COUNTY
    ) AS COUNTY_CODE ,
    LH.RESIDENCE_ZIP_CODE AS ZIP_CODE ,
    LN.DESCRIPTION AS LANGUAGE ,
    CASE
      WHEN LR.REQUEST_TYPE = 'R'
      THEN 'Y'
      ELSE 'N'
    END AS REPRINT ,
    CASE
      WHEN LR.DRIVER_TYPE = 'CASE'
      THEN 'CASE'
      WHEN LR.DRIVER_TYPE = 'CLNT'
      THEN 'CLNT'
      ELSE NULL
    END AS REQUEST_DRIVER_TYPE ,
    LD.DRIVER_TABLE_NAME AS REQUEST_DRIVER_TABLE ,
    ST.DESCRIPTION AS LETTER_STATUS ,
    COALESCE(LR.UPDATE_TS,LR.CREATE_TS) LETTER_STATUS_DATE ,
    LR.SENT_ON AS SENT_DATE ,
    LR.PRINTED_ON AS PRINT_DATE ,
    LR.MAILED_DATE AS MAILED_DATE ,
    LR.RETURN_DATE AS RETURN_DATE ,
    RR.DESCRIPTION AS RETURN_REASON ,
    ER.DESCRIPTION AS ERROR_CODES ,
    LR.ERROR_CODES AS REQUEST_ERROR_REASON ,
    SUBSTR(jrd.FILENAME,instr(jrd.FILENAME,'/',-1) + 1) AS TRANSMITTED_FILE_NAME ,
    jrd.CREATE_TS AS TRANSMITTED_FILE_DATE ,
    SUBSTR(jrd2.FILENAME,instr(jrd2.FILENAME,'/',-1) + 1) AS LETTER_RESPONSE_FILE_NAME ,
    jrd2.CREATE_TS AS LETTER_RESPONSE_FILE_DATE ,
    LR.UPDATE_TS AS LAST_UPDATE_DATE ,
    LR.UPDATED_BY AS LAST_UPDATED_BY_NAME ,
    'N' AS NEWBORN_FLAG ,
    SI.TASK_ID ,
    CASE
      WHEN lr.status_cd IN ('CANC','VOID','OBE','COMBND')
      THEN COALESCE(LRSH.CANCEL_DATE, LR.UPDATE_TS)
      ELSE NULL
    END AS CANCEL_DATE ,
    CASE
      WHEN lr.status_cd IN ('CANC','VOID','OBE','COMBND')
      THEN COALESCE(LRSH.CANCEL_BY, LR.UPDATED_BY)
      ELSE NULL
    END AS CANCEL_BY ,
    CASE
      WHEN LR.MAILED_DATE IS NOT NULL
      THEN lr.MAILED_DATE
      WHEN LR.SENT_ON IS NULL AND LR.ERROR_CODES IS NOT NULL
      THEN LRSH.ERR_DATE
      WHEN ER.DESCRIPTION IS NOT NULL AND SI.TASK_ID IS NULL
      THEN jrd2.CREATE_TS
      WHEN ER.DESCRIPTION IS NOT NULL AND SI.TASK_ID IS NOT NULL
      THEN SI.TASK_DATE
      WHEN LR.status_cd IN ('CANC','VOID','OBE','COMBND')
      THEN COALESCE(LRSH.CANCEL_DATE, LR.UPDATE_TS)
      ELSE NULL
    END AS COMPLETE_DATE ,
    LR.CREATE_TS AS PROCESS_LTR_REQUEST_START_DATE ,
    CASE
      WHEN LR.SENT_ON IS NOT NULL
      THEN LR.SENT_ON
      WHEN LR.SENT_ON IS NULL AND LR.ERROR_CODES IS NOT NULL
      THEN lrsh.ERR_DATE
      ELSE NULL
    END AS PROCESS_LTR_REQUEST_END_DATE ,
    CASE
      WHEN LR.SENT_ON IS NOT NULL
      THEN LR.SENT_ON
      ELSE NULL
    END AS SEND_TO_MAIL_HOUSE_START_DATE ,
    CASE
      WHEN jrd.CREATE_TS IS NOT NULL
      THEN jrd.CREATE_TS
      ELSE NULL
    END AS SEND_TO_MAIL_HOUSE_END_DATE ,
    CASE
      WHEN jrd.CREATE_TS IS NOT NULL
      THEN jrd.CREATE_TS
      ELSE NULL
    END AS RECEIVE_CONFIRM_START_DATE ,
    CASE
      WHEN LR.MAILED_DATE IS NOT NULL OR ER.DESCRIPTION IS NOT NULL
      THEN jrd2.CREATE_TS
      ELSE NULL
    END AS RECEIVE_CONFIRM_END_DATE ,
    CASE
      WHEN LR.SENT_ON IS NULL AND LR.ERROR_CODES IS NOT NULL AND SI.TASK_ID IS NOT NULL
      THEN LRSH.ERR_DATE
      WHEN ER.DESCRIPTION IS NOT NULL AND SI.TASK_ID IS NOT NULL
      THEN jrd2.CREATE_TS
      ELSE NULL
    END AS CREATE_ROUTE_WORK_START_DATE ,
    CASE
      WHEN SI.TASK_ID IS NOT NULL
      THEN SI.TASK_DATE
      ELSE NULL
    END AS CREATE_ROUTE_WORK_END_DATE ,
    'TIMELINESS_STATUS' AS TIMELINESS_STATUS ,
    'N' AS JEOPARDY_STATUS ,
    'SLA_CATEGORY' AS SLA_CATEGORY ,
    0 AS SLA_DAYS ,
    'B' AS SLA_DAYS_TYPE ,
    TO_DATE('01-Jan-1985', 'dd-mon-yyyy') AS SLA_JEOPARDY_DATE ,
    0 AS SLA_JEOPARDY_DAYS ,
    0 AS SLA_TARGET_DAYS ,
    CASE
      WHEN LR.SENT_ON IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS VALIDATION_FLAG ,
    CASE
      WHEN LR.MAILED_DATE IS NOT NULL
      THEN 'M'
      WHEN ER.DESCRIPTION IS NOT NULL
      THEN 'R'
      ELSE NULL
    END AS OUTCOME_FLAG ,
    CASE
      WHEN LR.SENT_ON IS NULL AND LR.ERROR_CODES IS NOT NULL AND SI.TASK_ID IS NOT NULL
      THEN 'Y'
      WHEN ER.DESCRIPTION IS NOT NULL AND SI.TASK_ID IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS WORK_REQUIRED_FLAG ,
    CASE
      WHEN LR.SENT_ON IS NOT NULL OR LR.ERROR_CODES IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS PROCESS_LETTERS_FLAG ,
    CASE
      WHEN jrd.CREATE_TS IS NOT NULL
      THEN 'Y'
      ELSE 'N'
    END AS TRANSMIT_FLAG ,
    'N' AS PROCESS_LETTER_FLAG ,
    CASE
      WHEN lr.STATUS_CD = 'ERR'
      THEN lrsh.ERR_DATE
      ELSE NULL
    END AS err_date ,
    CASE
      WHEN lr.STATUS_CD IN ('CANC','VOID','OBE','COMBND')
      THEN lrsh.LRSHISTORY_ID
      ELSE NULL
    END AS cancel_history_id
    -- For cube join.
    ,
    lr.LMDEF_ID ,
    lr.status_cd ,
    lr.LANGUAGE_CD ,
    lr.REJECT_REASON_CD ,
    lr.RETURN_REASON_CD ,
    lr.PROGRAM_TYPE_CD
  FROM eb.LETTER_REQUEST LR
  LEFT OUTER JOIN eb.letter_out_header lh ON LR.LMREQ_ID = LH.LETTER_REQ_ID
  LEFT JOIN
    (SELECT CASE_ID , STEP_DEFINITION_ID , CREATE_TS AS TASK_DATE , task_id FROM
      (SELECT CASE_ID , STEP_DEFINITION_ID , CREATE_TS , STEP_INSTANCE_ID AS task_id ,RANK() OVER(PARTITION BY CASE_ID ORDER BY STEP_INSTANCE_ID DESC) AS RNK FROM EB.STEP_INSTANCE WHERE STEP_DEFINITION_ID IN (26,22,27)
      ) WHERE RNK = 1
    ) SI ON (SI.CASE_ID = LR.CASE_ID)
  LEFT JOIN
    (SELECT LMREQ_ID, LRSHISTORY_ID, CASE WHEN STATUS_CD = 'ERR' THEN CREATE_TS ELSE NULL END AS ERR_DATE, CASE WHEN STATUS_CD IN ('CANC','VOID','OBE','COMBND') THEN CREATE_TS ELSE NULL END AS CANCEL_DATE, CASE WHEN STATUS_CD IN ('CANC','VOID','OBE','COMBND') THEN CREATED_BY ELSE NULL END AS CANCEL_BY FROM
      (SELECT LRSHISTORY_ID, LMREQ_ID, STATUS_CD, CREATED_BY, CREATE_TS, RANK() OVER(PARTITION BY LMREQ_ID ORDER BY LRSHISTORY_ID DESC) AS RNK FROM EB.LETTER_REQ_STATUS_HISTORY WHERE STATUS_CD IN ('CANC','VOID','OBE','COMBND', 'ERR')
      ) WHERE RNK = 1
    ) LRSH ON (LRSH.LMREQ_ID = LR.LMREQ_ID)
  LEFT JOIN (
    (SELECT LODC.LETTER_REQ_ID, MAX(LODC.JOB_ID)AS JOB_ID FROM EB.LETTER_OUT_DATA_CONTENT LODC GROUP BY LODC.LETTER_REQ_ID
    ) LOCD2
  JOIN EB.JOB_RUN_DATA JRD ON (JRD.JOB_RUN_DATA_ID = LOCD2.JOB_ID) ) ON LOCD2.LETTER_REQ_ID = LR.LMREQ_ID
  LEFT JOIN (
    (SELECT ELM.LMREQ_ID, MAX(ELM.JOB_ID)AS JOB_ID FROM EB.ETL_L_MAILHOUSE ELM GROUP BY ELM.LMREQ_ID
    ) ELM2
  JOIN EB.JOB_RUN_DATA JRD2                          ON (JRD2.JOB_RUN_DATA_ID = ELM2.JOB_ID) ) ON ELM2.LMREQ_ID = LR.LMREQ_ID
  LEFT OUTER JOIN eb.LETTER_DEFINITION LD            ON LR.LMDEF_ID = LD.LMDEF_ID
  LEFT OUTER JOIN eb.ENUM_LM_STATUS ST               ON LR.STATUS_CD = ST.VALUE
  LEFT OUTER JOIN eb.ENUM_LANGUAGE LN                ON LR.LANGUAGE_CD = LN.VALUE
  LEFT OUTER JOIN eb.ENUM_MAILHOUSE_ERROR_REASONS ER ON LR.REJECT_REASON_CD = ER.VALUE
  LEFT OUTER JOIN eb.ENUM_RETURN_REASON RR           ON LR.RETURN_REASON_CD = RR.VALUE
  LEFT OUTER JOIN eb.ENUM_PROGRAM_TYPE PR            ON LR.PROGRAM_TYPE_CD = PR.VALUE
    --D_PL_CURRENT_SV
  WHERE (LR.CREATE_TS >= (ADD_MONTHS(TRUNC(sysdate,'mm'),-2)) OR ST.DESCRIPTION NOT IN('Mailed','Combined similar Requests','Rejected','Voided','Errored')) ;
  
  GRANT SELECT ON MAXDAT_LOOKUP.D_PL_CURRENT_SV TO EB_MAXDAT_REPORTS;