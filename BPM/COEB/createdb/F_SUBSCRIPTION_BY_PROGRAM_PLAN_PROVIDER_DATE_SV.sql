CREATE OR REPLACE VIEW F_SUBSCRIPTION_BY_PROGRAM_PLAN_PROVIDER_DATE_SV 
AS
SELECT event_date,COALESCE(plan_service_type_cd,'UD') plan_service_type_cd,COALESCE(plan_id,0) plan_id,COALESCE(plan_id_ext,'0') plan_id_ext,provider_org_type
,SUM(email_only) email_only_changed_count
,SUM(sms_only) sms_only_changed_count
,SUM(email_and_sms) email_and_sms_changed_count
,SUM(es_none) emailandsms_none_changed_count
,SUM(sms_none) sms_none_changed_count
,SUM(email_none) email_none_changed_count
,SUM(no_subscription) no_channel_count
,SUM(none_email_only_call + none_sms_only_call + none_smsandemail_call) none_electronic_changed_count
,SUM(call_count) none_electronic_total_count
,ROUND(SUM(none_email_only_call + none_sms_only_call + none_smsandemail_call)/CASE WHEN SUM(COALESCE(call_count,0)) = 0 THEN 1 ELSE SUM(call_count) END ,2)*100 none_electronic_sla
FROM (
  SELECT *
FROM (
SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
       --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM(SELECT cs.case_id,TRUNC(COALESCE(opt_out_date_sms,opt_in_date_email,opt_in_date_sm)) event_date
               ,CASE WHEN COALESCE(opt_out_date_sms,opt_in_date_email,opt_in_date_sm) IS NOT NULL THEN 1 ELSE 0 END email_only
               ,CASE WHEN opt_in_date_email IS NOT NULL THEN 1 ELSE 0 END  none_email_only
               ,CASE WHEN opt_in_date_email IS NOT NULL AND call_record_id IS NOT NULL THEN 1 ELSE 0 END none_email_only_call
               ,0 sms_only
               ,0 none_sms_only       
               ,0 none_sms_only_call
               ,0 email_and_sms
               ,0 none_smsandemail
               ,0 none_smsandemail_call
               ,0 es_none
               ,0 sms_none
               ,0 email_none
               ,0 no_subscription      
               ,0 call_count
            FROM &schema_name..cases cs
              LEFT JOIN(SELECT *
                   FROM (SELECT TRUNC(create_ts) opt_in_date_email, call_record_id,event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                         FROM &schema_name..event e
                         WHERE event_type_cd = 'OPT_IN_EMAIL'
                         AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                          -- none to email only
                         AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) )
                         AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_SMS') AND TRUNC(eprev.create_ts) <= TRUNC(e.create_ts)) )
                   WHERE iern = 1) ei ON cs.case_id = ei.case_id  
              LEFT JOIN(SELECT *
                     FROM (SELECT TRUNC(create_ts) opt_in_date_sm, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                         FROM &schema_name..event e
                         WHERE event_type_cd = 'OPT_IN_EMAIL'
                         AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                          -- sms to email only
                         AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd = 'OPT_IN_SMS' AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)) 
                         AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_SMS') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ) )                     
                   WHERE iern = 1) se ON cs.case_id = se.case_id    
             LEFT JOIN(SELECT *
                   FROM (SELECT TRUNC(create_ts) opt_out_date_sms, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                         FROM &schema_name..event e
                         WHERE event_type_cd = 'OPT_OUT_SMS' --sms and email to email only
                         AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                         AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd = 'OPT_IN_SMS' AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts))
                         AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)))
                   WHERE iern = 1) os ON cs.case_id = os.case_id      
            WHERE  COALESCE(opt_out_date_sms,opt_in_date_email,opt_in_date_sm) IS NOT NULL ) cs
  LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
          )  slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))     
)
WHERE rown = 1   
UNION ALL
SELECT *
FROM (
SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
        --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM(SELECT cs.case_id,TRUNC(COALESCE(opt_out_date_email,opt_in_date_sms,opt_in_date_sm)) event_date
       ,0 email_only
       ,0 none_email_only
       ,0 none_email_only_call
       ,CASE WHEN COALESCE(opt_out_date_email,opt_in_date_sms,opt_in_date_sm) IS NOT NULL THEN 1 ELSE 0 END sms_only
       ,CASE WHEN opt_in_date_sms IS NOT NULL THEN 1 ELSE 0 END none_sms_only
       ,CASE WHEN opt_in_date_sms IS NOT NULL AND call_record_id IS NOT NULL THEN 1 ELSE 0 END none_sms_only_call
       ,0 email_and_sms
       ,0 none_smsandemail
       ,0 none_smsandemail_call
       ,0 es_none
       ,0 sms_none
       ,0 email_none
       ,0 no_subscription
    --   ,COALESCE(cs.plan_service_type_cd,'UD') plan_service_type_cd,COALESCE(cs.plan_id,0) plan_id,COALESCE(cs.plan_id_ext,'0') plan_id_ext,cs.provider_org_type
       ,0 call_count
    FROM &schema_name..cases cs
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_in_date_sms, call_record_id,event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'OPT_IN_SMS'
                  -- none to sms only
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                 AND  EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) )
                 AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL') AND TRUNC(eprev.create_ts) <= TRUNC(e.create_ts))  )
           WHERE iern = 1) ei ON cs.case_id = ei.case_id
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_in_date_sm, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'OPT_IN_SMS'                 
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                  -- email to sms only
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd = 'OPT_IN_EMAIL' AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)) 
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_EMAIL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ))                    
           WHERE iern = 1) se ON cs.case_id = se.case_id
   LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_out_date_email, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'OPT_OUT_EMAIL' --sms and email to sms only
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd = 'OPT_IN_SMS' AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts))
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)))
           WHERE iern = 1) os ON cs.case_id = os.case_id     
    WHERE  COALESCE(opt_out_date_email,opt_in_date_sms,opt_in_date_sm) IS NOT NULL
 ) cs
 LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
           ) slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))    
)
WHERE rown = 1 
UNION ALL
SELECT *
FROM (
SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
       --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM(SELECT cs.case_id, TRUNC(COALESCE(opt_in_date,opt_in_date_sms,opt_in_date_email)) event_date
      ,0 email_only
      ,0 none_email_only
      ,0 none_email_only_call
      ,0 sms_only
      ,0 none_sms_only
      ,0 none_sms_only_call  
      ,CASE WHEN COALESCE(opt_in_date,opt_in_date_sms,opt_in_date_email) IS NOT NULL THEN 1 ELSE 0 END email_and_sms
      ,CASE WHEN opt_in_date IS NOT NULL THEN 1 ELSE 0 END none_smsandemail
      ,CASE WHEN opt_in_date IS NOT NULL AND call_record_id IS NOT NULL THEN 1 ELSE 0 END none_smsandemail_call
      ,0 es_none
      ,0 sms_none
      ,0 email_none
      ,0 no_subscription  
      ,0 call_count        
    FROM &schema_name..cases cs
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_in_date, call_record_id,event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd IN('OPT_IN_SMS','OPT_IN_EMAIL')
                  -- none to sms and email
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) )
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_SMS','OPT_IN_EMAIL') AND eprev.event_id != e.event_id AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts)  )
                 )
           WHERE iern = 1) es ON cs.case_id = es.case_id
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_in_date_email, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'OPT_IN_EMAIL' --sms to email and sms 
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_SMS') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)  )
                 AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_SMS') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ) )
           WHERE iern = 1) ie ON cs.case_id = ie.case_id           
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_in_date_sms, event_type_cd,case_id, ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'OPT_IN_SMS' --email to email and sms
                 AND TRUNC(e.create_ts) > = ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)  )
                 AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_EMAIL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ) )
           WHERE iern = 1) s ON cs.case_id = s.case_id 
    WHERE  COALESCE(opt_in_date,opt_in_date_sms,opt_in_date_email) IS NOT NULL
           ) cs
LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
          ) slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))            
)
WHERE rown = 1 
UNION ALL
SELECT *
FROM (
SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
     --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM( SELECT cs.case_id,TRUNC(opt_out_date) event_date
        ,0 email_only
        ,0 none_email_only
        ,0 none_email_only_call
        ,0 sms_only
        ,0 none_sms_only
        ,0 none_sms_only_call  
        ,0 email_and_sms
        ,0 none_smsandemail
        ,0 none_smsandemail_call
        ,CASE WHEN opt_out_date IS NOT NULL AND optin_email = 'Y' AND optin_sms = 'Y' AND optout_email = 'Y' AND optout_sms = 'Y' THEN 1 ELSE 0 END es_none
        ,CASE WHEN opt_out_date IS NOT NULL AND optin_email = 'N' AND optin_sms = 'Y'  THEN 1 ELSE 0 END sms_none
        ,CASE WHEN opt_out_date IS NOT NULL AND optin_email = 'Y' AND optin_sms = 'N'  THEN 1 ELSE 0 END email_none
        ,0 no_subscription 
        ,0 call_count
    FROM &schema_name..cases cs
    LEFT JOIN(SELECT *
           FROM (SELECT TRUNC(create_ts) opt_out_date, event_type_cd,case_id
           ,CASE WHEN EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)) THEN 'Y' ELSE 'N' END optin_email
           ,CASE WHEN EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_IN_SMS') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts)) THEN 'Y' ELSE 'N' END optin_sms
           ,CASE WHEN EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_SMS') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ) THEN 'Y' ELSE 'N' END optout_sms
           ,CASE WHEN EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('OPT_OUT_EMAIL') AND TRUNC(eprev.create_ts) = TRUNC(e.create_ts) ) THEN 'Y' ELSE 'N' END optout_email
           ,ROW_NUMBER() OVER(PARTITION BY case_id, TRUNC(create_ts,'mm') ORDER BY event_id) iern
                 FROM &schema_name..event e
                 WHERE event_type_cd = 'CASE_PREFERRED_TO_POSTAL'
                 AND TRUNC(e.create_ts) >= ADD_MONTHS(TRUNC(sysdate, 'mm'), -6)
                  -- sms only to none                 
                 AND EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = e.case_id AND eprev.event_type_cd IN('CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts) < TRUNC(e.create_ts) )             
                 )
           WHERE iern = 1) es ON cs.case_id = es.case_id 
    WHERE opt_out_date IS NOT NULL  ) cs
  LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
           ) slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))  
)
WHERE rown = 1
UNION ALL
SELECT *
FROM (
SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
       --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM(SELECT cs.case_id,d_month_start event_date
        ,0 email_only
        ,0 none_email_only
        ,0 none_email_only_call
        ,0 sms_only
        ,0 none_sms_only
        ,0 none_sms_only_call  
        ,0 email_and_sms
        ,0 none_smsandemail
        ,0 none_smsandemail_call
        ,0 es_none
        ,0 sms_none
        ,0 email_none
        ,1 no_subscription  
        ,0 call_count
    FROM 
      d_months dd
        CROSS JOIN &schema_name..cases cs         
    WHERE dd.d_month_start >= ADD_MONTHS(TRUNC(sysdate,'mm'),-6)   
    AND dd.d_month_start <= TRUNC(sysdate,'mm')
    -- AND (pref_contact_method_cd = 'POSTAL' OR (EXISTS (SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = cs.case_id AND eprev.event_type_cd = 'CASE_PREFERRED_TO_POSTAL' AND TRUNC(eprev.create_ts,'mm') <= d_month_start)) )
    AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = cs.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL','OPT_IN_SMS','CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts,'mm') <= d_month_start)
  ) cs
  LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
           ) slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))
  ) 
  WHERE rown = 1
UNION ALL  
SELECT *
 FROM (
 SELECT cs.*
         ,slct.provider_org_type
         ,slct.plan_id_ext
         ,slct.plan_id
         ,slct.plan_service_type_cd
       --  ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct.selection_segment_id ) rown
        ,ROW_NUMBER() OVER(PARTITION BY cs.case_id,cs.event_date ORDER BY slct_close_ind,selection_segment_id ) rown
    FROM(SELECT DISTINCT cl.case_id,TRUNC(cr.create_ts) event_date
          ,0 email_only
          ,0 none_email_only
          ,0 none_email_only_call
          ,0 sms_only
          ,0 none_sms_only
          ,0 none_sms_only_call  
          ,0 email_and_sms
          ,0 none_smsandemail
          ,0 none_smsandemail_call
          ,0 es_none
          ,0 sms_none
          ,0 email_none
          ,0 no_subscription 
          ,1 call_count
    FROM &schema_name..CALL_RECORD cr
        JOIN &schema_name..call_record_link cl ON cl.call_record_id = cr.call_record_id                                      
    WHERE TRUNC(cr.create_ts) >= ADD_MONTHS(TRUNC(sysdate,'mm'),-6) 
    AND NOT EXISTS(SELECT 1 FROM &schema_name..event eprev WHERE eprev.case_id = cl.case_id AND eprev.event_type_cd IN('OPT_IN_EMAIL','OPT_IN_SMS','CASE_PREFERRED_TO_DIGITAL') AND TRUNC(eprev.create_ts) <= TRUNC(cr.create_ts)) 
    AND NOT EXISTS(SELECT 1 
                    FROM &schema_name..EVENT e 
                      JOIN &schema_name..cases cs ON e.case_id = cs.case_id                              
                      JOIN &schema_name..ENUM_MANUAL_CALL_ACTION ma ON (e.context = ma.value) 
                      JOIN &schema_name..ENUM_MAN_CALL_ACT_CATEGORIES mct ON mct.value = ma.categories
                    WHERE ma.categories IN('OUT_OF_SCOPE') 
                    AND e.call_record_id = cr.call_record_id
                    AND TRUNC(e.create_ts) = TRUNC(cr.create_ts))  )cs
LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,slct.start_date, slct.selection_segment_id
              , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                     WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                  ELSE NULL END PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date    
             ,CASE WHEN slct.status_cd = 'OPEN' THEN 0 ELSE 1  END slct_close_ind
          FROM &schema_name..selection_segment slct                      
            JOIN &schema_name..case_client cc ON slct.client_id = cc.cscl_clnt_client_id --AND cc.cscl_status_end_date IS NULL               
            LEFT JOIN &schema_name..plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN &schema_name..CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
          ) slct ON slct.case_id = cs.case_id AND cs.event_date BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy'))                   )
WHERE rown = 1
)
GROUP BY event_date
  ,provider_org_type
  ,plan_id_ext
  ,plan_id
  ,plan_service_type_cd;
  
GRANT SELECT ON maxdat_support.F_SUBSCRIPTION_BY_PROGRAM_PLAN_PROVIDER_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.F_SUBSCRIPTION_BY_PROGRAM_PLAN_PROVIDER_DATE_SV TO MAXDATSUPPORT_READ_ONLY;
