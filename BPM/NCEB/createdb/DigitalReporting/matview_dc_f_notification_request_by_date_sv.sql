DROP MATERIALIZED VIEW DC_F_NOTIFICATION_REQUEST_BY_DATE_SV;
 
CREATE MATERIALIZED VIEW DC_F_NOTIFICATION_REQUEST_BY_DATE_SV
BUILD IMMEDIATE 
REFRESH FORCE
ON DEMAND
AS
SELECT dd.d_date sent_date
  ,es.lmreq_id
  ,es.letter_type
  ,es.notification_type
  ,es.notification_request_id
  ,es.channel_cd channel_code
  ,es.read_date
  ,es.clicked_date
  ,es.days_between_read_sent
 -- ,es.days_unopened
  ,es.client_id
  ,COALESCE(es.plan_id_ext,'0') plan_id_external
  ,es.plan_service_type_cd plan_service_type_code
  ,COALESCE(es.plan_id,0) plan_id
  ,email_fail_date  
  ,sms_fail_date
  ,CASE WHEN days_between_read_sent BETWEEN 0 AND 5 THEN notification_request_id ELSE NULL END read_sent_between1and5
  ,CASE WHEN days_between_read_sent BETWEEN 6 AND 10 THEN notification_request_id ELSE NULL END read_sent_between6and10
  ,CASE WHEN days_between_read_sent BETWEEN 11 AND 30 THEN notification_request_id ELSE NULL END read_sent_between11and30
  ,CASE WHEN days_between_read_sent BETWEEN 31 AND 181 THEN notification_request_id ELSE NULL END read_sent_greater30
  ,es.case_id source_reference_id
  ,es.source_reference_type
  ,current_notification_status
FROM maxdat_support.d_dates dd
LEFT JOIN (
SELECT 
lr.lmreq_id
,ld.name letter_type
,CASE WHEN ld.name = 'WE' Then 'Welcome' ELSE 'Letter Notification' END notification_type
,nr.notification_request_id
,nr.channel_cd  
,TRUNC(nh.sent_date) sent_date
,TRUNC(nhr.read_date) read_date
,TRUNC(nhc.clicked_date) clicked_date
,TRUNC(COALESCE(nhr.read_date,nhc.clicked_date)) - TRUNC(nh.sent_date) days_between_read_sent
--,CASE WHEN nh.sent_date IS NOT NULL AND nhf.fail_date IS NULL AND nhr.read_date IS NULL AND nhc.clicked_date IS NULL THEN TRUNC(sysdate) - TRUNC(nh.sent_date) ELSE 0 END days_unopened
,lrl.client_id
,lr.case_id
,nr.ref_type1_value
,slct.plan_id_ext plan_id_ext
,slct.plan_service_type_cd
--,NULL provider_org_type
,slct.plan_id plan_id
,TRUNC(nhfs.sms_fail_date) sms_fail_date
,TRUNC(nhf.email_fail_date) email_fail_date
,ns.report_label current_notification_status
,ll.out_var source_reference_type
, rank() over(partition by lr.lmreq_id order by lrl.client_id,slct.selection_segment_id) rown
FROM (SELECT lmreq_id,case_id,lmdef_id,requested_on
      FROM eb.letter_request
      WHERE is_digital_ind = 1) lr 
  JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
  CROSS JOIN (SELECT out_var 
              FROM corp_etl_list_lkup ll
              WHERE ll.name = 'EMAIL_SMS_SOURCE_REFERENCE') ll
  LEFT JOIN eb.letter_request_link lrl on lrl.lmreq_id = lr.lmreq_id
  LEFT JOIN eb.notification_request nr ON lr.lmreq_id = nr.lmreq_id 
  LEFT JOIN eb.enum_notification_status ns ON nr.status_cd = ns.value
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts sent_date,
                                rank() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('ACCEPTED','DELIVERED','SENT'))
                   WHERE  crn = 1 ) nh ON nr.notification_request_id = nh.notification_request_id
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts email_fail_date,
                                rank() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('BLOCK BOUNCE','HARD BOUNCE','SOFT BOUNCE','UNKNOWN BOUNCE','TECHNICAL BOUNCE','ERR'))
                   WHERE  crn = 1 ) nhf ON nr.notification_request_id = nhf.notification_request_id  
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts sms_fail_date,
                                rank() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('BLOCK BOUNCE','HARD BOUNCE','SOFT BOUNCE','UNKNOWN BOUNCE','TECHNICAL BOUNCE','ERR'))
                   WHERE  crn = 1 ) nhfs ON nr.notification_request_id = nhfs.notification_request_id                     
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts read_date,
                                rank() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('OPEN'))
                   WHERE  crn = 1 ) nhr ON nr.notification_request_id = nhr.notification_request_id  AND nhr.read_date >= nh.sent_date                  
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts clicked_date,
                                rank() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('CLICK'))
                   WHERE  crn = 1 ) nhc ON nr.notification_request_id = nhc.notification_request_id     
 LEFT JOIN (SELECT COALESCE(con.plan_service_type_cd,'UD') plan_service_type_cd, COALESCE(pl.plan_id_ext,'0')plan_id_ext ,COALESCE(pl.plan_id,0) plan_id,cc.cscl_case_id case_id
              ,GREATEST(slct.end_date,slct.status_date) end_date,LEAST(TRUNC(cc.cscl_status_begin_date,'mm'),slct.start_date) start_date, slct.selection_segment_id
              ,NULL PROVIDER_ORG_TYPE    
             ,cscl_status_begin_date               
          FROM eb.selection_segment slct                      
            JOIN eb.case_client cc ON slct.client_id = cc.cscl_clnt_client_id
            LEFT JOIN eb.plans pl ON pl.plan_id = slct.plan_id
            LEFT JOIN eb.CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID                  
          WHERE 1=1
          AND (cc.cscl_status_End_date IS NULL OR (TRUNC(slct.start_date) BETWEEN TRUNC(cscl_status_begin_date) AND COALESCE(TRUNC(cscl_status_end_date),TO_DATE('12/31/2099','mm/dd/yyyy')))
                    OR TRUNC(slct.start_date) <= TRUNC(cscl_status_begin_date))
          AND con.end_date IS NULL
          AND slct.start_nd < slct.end_nd
          AND slct.program_type_cd = 'MEDICAID'
          AND slct.plan_type_cd = 'MEDICAL'
          --AND slct.status_cd = 'OPEN'
          )  slct ON slct.case_id = lr.case_id AND (TRUNC(lr.requested_on) BETWEEN TRUNC(slct.start_date) AND COALESCE(TRUNC(slct.end_date),TO_DATE('12/31/2099','mm/dd/yyyy')) ) 
  /*LEFT JOIN (
  --SELECT * FROM (
                SELECT con.plan_service_type_cd, pl.plan_id_ext,slct.client_id,pl.plan_id, slct.start_date, slct.end_date
                      --,ROW_NUMBER() OVER(PARTITION BY slct.client_id ORDER BY slct.start_nd DESC,slct.selection_segment_id) rown
                FROM eb.selection_segment slct
                  LEFT JOIN eb.plans pl ON pl.plan_id = slct.plan_id
                  LEFT JOIN eb.CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID
                WHERE 1=1
                AND con.end_date IS NULL
                AND slct.start_nd < slct.end_nd
                AND slct.program_type_cd = 'MEDICAID'
                AND slct.plan_type_cd = 'MEDICAL'
                AND slct.status_cd = 'OPEN' )
            --WHERE rown = 1)
             slct ON slct.client_id = lrl.client_id and lr.requested_on between slct.start_date and slct.end_date*/
--WHERE lr.is_digital_ind = 1
) es ON es.sent_date = dd.d_date OR (es.sent_date is null and es.email_fail_date = dd.d_date) OR (es.sent_date is null and es.sms_fail_date = dd.d_date)
where es.rown = 1
UNION
SELECT dd.d_date sent_date
  ,null lmreq_id
  ,null letter_type
  ,nt.notification_type
  ,null notification_request_id
  ,nc.value channel_code  
  ,dd.d_date read_date
  ,dd.d_date clicked_date
  ,null days_between_read_sent
 -- ,es.days_unopened
  ,null client_id
  ,p.plan_id_ext plan_id_external
  ,con.plan_service_type_cd plan_service_type_code
  ,p.plan_id
  ,dd.d_date sms_failed_date
  ,dd.d_date email_failed_date
  ,NULL read_sent_between1and5
  ,NULL read_sent_between6and10
  ,NULL read_sent_between11and30
  ,NULL read_sent_greater30
  ,NULL source_reference_id
  ,NULL source_reference_type
  ,NULL current_notification_status
FROM maxdat_support.d_dates dd
CROSS JOIN eb.enum_notification_channel nc
CROSS JOIN (SELECT 'Welcome' notification_type FROM dual
            UNION ALL
            SELECT 'Letter Notification' notification_type FROM dual) nt
CROSS JOIN (eb.plans p
              LEFT JOIN eb.contract con ON con.plan_id = p.plan_id) 
 WHERE d_date >= TO_DATE('02/01/2020','mm/dd/yyyy')
 AND d_date <= TRUNC(sysdate)
 AND p.plan_id > 1
 AND value IN('EMAIL','SMS')
 ;
 
--ALTER MATERIALIZED VIEW DC_F_NOTIFICATION_REQUEST_BY_DATE_SV  REFRESH FAST;   
GRANT SELECT ON maxdat_support.DC_F_NOTIFICATION_REQUEST_BY_DATE_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.DC_F_NOTIFICATION_REQUEST_BY_DATE_SV TO MAXDATSUPPORT_READ_ONLY;

CREATE OR REPLACE PROCEDURE refresh_digital_reporting_views
AS
BEGIN
  dbms_mview.refresh('DC_F_NOTIFICATION_REQUEST_BY_DATE_SV','?');
  dbms_mview.refresh('DC_F_SUBSCRIPTION_BY_PLAN_PROVIDER_DATE_SV','?');
END;
/
commit;
