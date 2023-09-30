CREATE OR REPLACE VIEW D_NOTIFICATIONS_SV
AS
  SELECT DISTINCT nr.notification_request_id,
    nr.ref_type1_value ,
    nr.ref_type4_value ,
    nr.ref_type1 ,
    nr.ref_type4 ,
    CASE
      WHEN nr.ref_type4 = 'APP_HEADER'
      THEN nr.ref_type4_value
      WHEN nr.ref_type1 = 'APP_HEADER'
      THEN nr.ref_type1_value
      ELSE NULL
    END AS APP_ID ,
    CASE WHEN nr.ref_type3 = 'CLIENT'
    THEN nr.ref_type3_value 
    ELSE NULL 
    END AS client_id ,
    nr.ref_type3 AS TYPE ,
    nr.REQUEST_DATE ,
    nr.create_ts NOTIFICATION_CREATE_TS,
    nr.create_ts CALLBACK_CREATE_TS,
    nr.type_CD AS Doc_Type ,
    nr.error_msg ,
    nr.status_cd,
    nr.channel_cd,
    CASE WHEN nr.ref_type2 = 'CASE'
    THEN nr.ref_type2_value
    ELSE NULL
    END AS case_id,
    pwc.response_code AS RESPONSE_CODE ,
    pwc.response_code_text AS RESPONSE_CODE_TEXT
  FROM ats.notification_request nr
  LEFT JOIN ats.notification_request_ext nre ON (nr.notification_request_id = nre.notification_request_id)
  LEFT JOIN ats.pa_ws_callback pwc           ON (nr.notification_request_id = pwc.ieb_correlation_id)
  LEFT JOIN ats.OUTBOUND_1768_DATA_CONTENT o ON (nr.NOTIFICATION_REQUEST_ID = o.NOTIFICATION_REQUEST_ID)
  ORDER BY 
  CASE
      WHEN nr.ref_type4 = 'APP_HEADER'
      THEN nr.ref_type4_value
      WHEN nr.ref_type1 = 'APP_HEADER'
      THEN nr.ref_type1_value
      ELSE NULL
    END NULLS LAST;
  
  GRANT SELECT ON MAXDAT_SUPPORT.D_NOTIFICATIONS_SV TO MAXDAT_REPORTS ;
