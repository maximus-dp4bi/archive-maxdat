CREATE OR REPLACE FORCE VIEW MAXDAT_SUPPORT.F_PL_BY_DATE_SV
AS
  SELECT create_date
         ,complete_date
         ,sent_on
         ,letter_type
         ,status_cd
         ,distribution_method
         ,outcome
         ,letter_scope
         ,age_in_business_days
         ,age_in_calendar_days     
         ,0 ltr_count_processed_timely
         ,0 ltr_count_processed_untimely
         ,COUNT(pl_bi_id) letter_count
  FROM(       
  SELECT   
    --F_PL_BY_DATE_SV  
    lr.create_ts create_date,
    c_stat.complete_date,    
    LR.SENT_ON ,
    LD.DESCRIPTION AS LETTER_TYPE ,
    LR.STATUS_CD ,     
    nr.channel_cd AS DISTRIBUTION_METHOD,
    sf_stat.outcome_flag outcome,
    CASE WHEN LD.SCOPE IS NULL THEN 'CHC' ELSE 'IEB' END LETTER_SCOPE,
    --LR.MAILED_DATE ,    
    (SELECT CASE WHEN (COUNT(*)-1) < 0  THEN 0 ELSE COUNT(*)-1  END
          FROM D_DATES
          WHERE business_day_flag = 'Y'
          AND d_date BETWEEN TRUNC(lr.create_ts) AND TRUNC(COALESCE(c_stat.complete_date,SYSDATE))) AS AGE_IN_BUSINESS_DAYS ,
      TRUNC(COALESCE(c_stat.complete_date,SYSDATE))- TRUNC(LR.CREATE_TS) AS AGE_IN_CALENDAR_DAYS       
      ,LR.LMREQ_ID AS PL_BI_ID       
  FROM LETTER_REQUEST LR  
 -- LEFT JOIN eb.letter_req_status_history H     ON (LR.LMREQ_ID = H.LMREQ_ID AND H.STATUS_CD = 'REQ')
  LEFT OUTER JOIN LETTER_DEFINITION LD            ON LR.LMDEF_ID = LD.LMDEF_ID
  LEFT OUTER JOIN (SELECT *
                   FROM (SELECT h.lmreq_id,
                                h.status_cd,
                                h.create_ts complete_date,
                                ROW_NUMBER() OVER(PARTITION BY h.lmreq_id ORDER BY h.create_ts DESC) crn
                         FROM letter_req_status_history h                            
                         WHERE status_cd IN('COMPLETED'))
                   WHERE  crn = 1 ) c_stat ON lr.lmreq_id = c_stat.lmreq_id
   LEFT OUTER JOIN (SELECT *
                   FROM (SELECT ref_type1_value letter_req_id,return_reason_cd,channel_cd,
                                ROW_NUMBER() OVER(PARTITION BY ref_type1_value ORDER BY notification_request_id DESC) nrn
                         FROM notification_request
                         WHERE ref_type1 = 'LETTER_REQUEST')
                   WHERE  nrn = 1 ) nr ON lr.lmreq_id = nr.letter_req_id 
  LEFT OUTER JOIN (SELECT *
                   FROM (SELECT h.lmreq_id,
                                h.status_cd,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('FAX_SUCCESS','FAX_FAIL')) THEN 'Y' ELSE 'N' END fax_sent_flag,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('FAX_SENT')) THEN 'Y' ELSE 'N' END message_sent_flag,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('DMS_SUCCESS')) THEN 'Y' ELSE 'N' END letter_dms_flag,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('EMAIL_SUCCESS')) THEN 'Y' ELSE 'N' END pdf_mailed_flag,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('PRINT_SUCCESS')) THEN 'Y' ELSE 'N' END available_print_flag,
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('MAILMERGE_SUCCESS')) THEN 'Y' ELSE 'N' END ieb_created_flag,                                
                            --    CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('REQUEST_VALID')) THEN 'Y' ELSE 'N' END letter_delivery_flag,                                
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('PRINT_SUCCESS','EMAIL_SUCCESS','FAX_SUCCESS','DMS_SUCCESS')) THEN 'S' 
                                     WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('PRINT_FAIL','EMAIL_FAIL','FAX_FAIL','DMS_FAILED')) THEN 'F' 
                                  ELSE NULL END outcome_flag,                                
                                ROW_NUMBER() OVER(PARTITION BY h.lmreq_id ORDER BY h.create_ts DESC) crn
                         FROM letter_req_status_history h                            
                         WHERE status_cd IN('REQ') )                         
                   WHERE  crn = 1 ) sf_stat ON lr.lmreq_id = sf_stat.lmreq_id                   
  WHERE (LR.CREATE_TS >= ADD_MONTHS(TRUNC(sysdate,'mm'),-3) OR LR.STATUS_CD NOT IN('MAIL','COMBND','OBE','REJ','VOID','ERR','COMPLETED'))
  ) ltr
  GROUP BY create_date
         ,complete_date
         ,sent_on
         ,letter_type
         ,status_cd
         ,distribution_method
         ,outcome
         ,letter_scope
         ,age_in_business_days
         ,age_in_calendar_days;
  
  GRANT SELECT ON MAXDAT_SUPPORT.F_PL_BY_DATE_SV TO MAXDAT_REPORTS;
  GRANT SELECT ON MAXDAT_SUPPORT.F_PL_BY_DATE_SV TO MAXDAT_SUPPORT_READ_ONLY;