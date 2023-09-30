CREATE OR REPLACE VIEW MAXDAT_SUPPORT.D_PL_CURRENT_SV
AS
SELECT    
    LR.LMREQ_ID AS PL_BI_ID ,
    LR.CREATE_TS AS CREATE_DATE ,
    LR.REQUESTED_ON AS REQUEST_DATE,
    LR.CASE_ID AS CASE_ID ,    
    LR.SENT_ON AS SENT_DATE ,
    LR.STATUS_CD,
    -- added by James Frick to include last updated date
    LR.UPDATE_TS,
    ST.DESCRIPTION AS LETTER_STATUS ,
    LR.LANGUAGE_CD ,
    LN.DESCRIPTION AS LANGUAGE ,
    LD.DESCRIPTION AS LETTER_TYPE ,       
    nr.RETURN_REASON_CD,
    --(SELECT report_label FROM enum_county ec WHERE ec.value = LH.RESIDENCE_COUNTY) AS COUNTY_CODE ,
    LH.RESIDENCE_COUNTY AS COUNTY_CODE,
    LH.RESIDENCE_ZIP_CODE AS ZIP_CODE ,    
    LH.ADDRESS_LINE_1||CASE WHEN LH.ADDRESS_LINE_2 IS NULL THEN NULL ELSE ' '||LH.ADDRESS_LINE_2 END||' '||LH.CITY||' '||LH.STATE AS ADDRESS,
    --LH.CITY        
  --LL.REFERENCE_ID AS APPLICATION_ID,
    NC.RECIPIENT_TYPE AS RECIPIENT_TYPE,
    CASE WHEN COALESCE(NC.RECIPIENT_TYPE,'CLIENT') IN('CLIENT','NONE') THEN LH.ADDRESS_LINE_1||CASE WHEN LH.ADDRESS_LINE_2 IS NULL THEN NULL ELSE ' '||LH.ADDRESS_LINE_2 END||' '||LH.CITY||' '||LH.STATE ELSE recipient_address END RECIPIENT_ADDRESS,
    CASE WHEN COALESCE(NC.RECIPIENT_TYPE,'CLIENT') IN('CLIENT','NONE') THEN LH.RESIDENCE_COUNTY ELSE cag.county_cd END AS RECIPIENT_COUNTY_CODE,
    CASE WHEN COALESCE(NC.RECIPIENT_TYPE,'CLIENT') IN('CLIENT','NONE') THEN LH.RESIDENCE_ZIP_CODE ELSE cag.zipcode END AS RECIPIENT_ZIP_CODE,
    cag.email AS RECIPIENT_EMAIL,
    cag.fax_number AS RECIPIENT_FAX_NUMBER,
    CASE WHEN ld.scope IS NULL THEN CASE WHEN sf_stat.lmreq_id IS NOT NULL THEN 'Y' ELSE 'N' END  ELSE sf_stat.ieb_created_flag END AS CREATE_LETTER_FLAG,
    LR.CREATED_BY AS CREATED_BY, 
    nr.channel_cd AS DISTRIBUTION_METHOD,
    COALESCE(sf_stat.outcome_flag,'NA') DOCUMENT_OUTCOME_FLAG,
    sf_stat.fax_sent_flag AS FAX_SENT_FLAG,
    sf_stat.letter_delivery_flag AS LETTER_DELIVERY_FLAG,
    sf_stat.letter_dms_flag AS LETTER_DMS_FLAG,
    sf_stat.message_sent_flag AS MESSAGE_SENT_FLAG,
    sf_stat.pdf_mailed_flag AS PDF_MAILED_FLAG,
    NULL AS PDF_SENT_FLAG,
    CASE WHEN c_stat.status_cd IN('COMPLETED','FAX_FAIL') THEN 'Y' ELSE 'N' END AS STATUS_COMPLETE_FLAG,
    CASE WHEN ld.scope IS NULL THEN CASE WHEN lr.sent_on IS NOT NULL THEN 'Y' ELSE 'N' END ELSE NULL END AS FILE_DELIVERY_FLAG,
    LR.LMDEF_ID,    
    sf_stat.available_print_flag AS AVAILABLE_PRINT_FLAG,
    CASE WHEN nr.return_reason_cd IN('02','03','04','05','07') THEN 'Y' ELSE ' N' END AS BAD_ADDRESS_INDICATOR,
    c_stat.complete_date AS COMPLETE_DATE,
    CASE WHEN LD.SCOPE IS NULL THEN 'CHC' ELSE 'IEB' END LETTER_SCOPE,  
    LR.PRINTED_ON AS PRINT_DATE ,
    LR.MAILED_DATE AS MAILED_DATE, 
    --LR.RETURN_DATE AS RETURN_DATE ,    
    --Next two lines about Aging were added by JAmes Frick to calculate aging at Letter Request LEvel
    CASE WHEN LR.SENT_ON IS NOT NULL THEN ((SELECT
              CASE
                WHEN (COUNT(*)-1) < 0
                THEN 0
                ELSE (COUNT(*))
              END
            FROM MAXDAT_SUPPORT.D_DATES D1
            WHERE D1.business_day_flag = 'Y' AND D1.d_date BETWEEN LR.REQUESTED_ON AND LR.SENT_ON) ) ELSE 0 end AS AGE_IN_BUS_DAYS_CUMULATIVE, 
    CASE WHEN LR.SENT_ON IS NOT NULL THEN TRUNC(LR.SENT_ON) - TRUNC(LR.REQUESTED_ON)
    ELSE 0 end AS AGE_IN_CAL_DAYS_CUMULATIVE     
  FROM LETTER_REQUEST LR
  --LEFT OUTER JOIN letter_request_link ll ON lr.lmreq_id = ll.lmreq_id AND ll.reference_type = 'APP_HEADER'
  LEFT OUTER JOIN letter_out_header lh ON LR.LMREQ_ID = LH.LETTER_REQ_ID  
  LEFT OUTER JOIN (SELECT *
                   FROM(SELECT ca.case_id, ca.agency_id
                               ,ag.street_address_1||CASE WHEN ag.street_address_2 IS NULL THEN NULL ELSE ' '||ag.street_address_2 END||' '||ag.city recipient_address
                               ,ag.state_cd, ag.zipcode, ag.county_cd
                               ,ag.phone_number, ag.fax_number, ag.email
                               ,ROW_NUMBER() OVER (PARTITION BY ca.case_id ORDER BY ca.end_date) crn
                        FROM case_agency ca
                        JOIN agency ag ON ca.agency_id = ag.agency_id
                        WHERE ca.end_date IS NULL
                        AND ag.end_date IS NULL  ) 
                   WHERE crn = 1) cag ON lr.case_id = cag.case_id
  LEFT OUTER JOIN (SELECT *
                   FROM (SELECT ref_type1_value letter_req_id,return_reason_cd,channel_cd,
                                ROW_NUMBER() OVER(PARTITION BY ref_type1_value ORDER BY notification_request_id DESC) nrn
                         FROM notification_request
                         WHERE ref_type1 = 'LETTER_REQUEST')
                   WHERE  nrn = 1 ) nr ON lr.lmreq_id = nr.letter_req_id 
--completed flag
  LEFT OUTER JOIN (SELECT *
                   FROM (SELECT h.lmreq_id,
                                h.status_cd,
                                h.create_ts complete_date,
                                ROW_NUMBER() OVER(PARTITION BY h.lmreq_id ORDER BY h.create_ts DESC) crn
                         FROM letter_req_status_history h                            
                         WHERE status_cd IN('COMPLETED','FAX_FAIL'))
                   WHERE  crn = 1 ) c_stat ON lr.lmreq_id = c_stat.lmreq_id
--IEB outcome flag
  LEFT OUTER JOIN (SELECT *
                   FROM (SELECT h.lmreq_id,
                                h.status_cd,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('FAX_SUCCESS','FAX_FAIL')) THEN 'Y' ELSE 'N' END fax_sent_flag,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('FAX_SENT')) THEN 'Y' ELSE 'N' END message_sent_flag,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('DMS_SUCCESS')) THEN 'Y' ELSE 'N' END letter_dms_flag,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('EMAIL_SUCCESS')) THEN 'Y' ELSE 'N' END pdf_mailed_flag,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('PRINT_SUCCESS')) THEN 'Y' ELSE 'N' END available_print_flag,
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('MAILMERGE_SUCCESS')) THEN 'Y' ELSE 'N' END ieb_created_flag,                                
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('REQUEST_VALID')) THEN 'Y' ELSE 'N' END letter_delivery_flag,                                
                                CASE WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('COMPLETED')) THEN 'S' 
                                     WHEN EXISTS(SELECT 1 FROM letter_req_status_history s WHERE s.lmreq_id = h.lmreq_id AND s.status_cd IN ('FAX_FAIL')) THEN 'F' 
                                  ELSE 'NA' END outcome_flag,                                
                                ROW_NUMBER() OVER(PARTITION BY h.lmreq_id ORDER BY h.create_ts DESC) crn
                         FROM letter_req_status_history h                            
                         WHERE status_cd IN('REQ') )                         
                   WHERE  crn = 1 ) sf_stat ON lr.lmreq_id = sf_stat.lmreq_id                   
  LEFT OUTER JOIN LETTER_DEFINITION LD            ON LR.LMDEF_ID = LD.LMDEF_ID
  LEFT OUTER JOIN ENUM_NOTIFICATION_CONFIG NC     ON LD.LMDEF_ID = NC.LMDEF_ID
  LEFT OUTER JOIN ENUM_LM_STATUS ST               ON LR.STATUS_CD = ST.VALUE
  LEFT OUTER JOIN ENUM_LANGUAGE LN                ON LR.LANGUAGE_CD = LN.VALUE
 -- LEFT OUTER JOIN eb.ENUM_MAILHOUSE_ERROR_REASONS ER ON LR.REJECT_REASON_CD = ER.VALUE  
    --D_PL_CURRENT_SV
  WHERE  (LR.CREATE_TS >= (ADD_MONTHS(TRUNC(sysdate,'mm'),-3)) OR LR.STATUS_CD NOT IN('MAIL','COMBND','OBE','REJ','VOID','ERR','COMPLETED'));

GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CURRENT_SV TO MAXDAT_REPORTS;
GRANT SELECT ON MAXDAT_SUPPORT.D_PL_CURRENT_SV TO MAXDAT_SUPPORT_READ_ONLY;