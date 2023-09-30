CREATE OR REPLACE VIEW d_notification_request_sv
AS
SELECT dd.d_date sent_date
  ,es.lmreq_id
  ,es.letter_type
  ,es.notification_type
  ,es.notification_request_id
  ,es.channel_cd
  ,es.read_date
  ,es.clicked_date
  ,es.days_between_read_sent
 -- ,es.days_unopened
  ,es.client_id
  ,COALESCE(es.plan_id_ext,'0') plan_id_ext
  ,COALESCE(es.plan_service_type_cd,'UD') plan_service_type_cd
  ,COALESCE(es.provider_org_type,'PCMP') provider_org_type
  ,CASE WHEN days_between_read_sent BETWEEN 0 AND 5 THEN notification_request_id ELSE NULL END read_sent_between1and5
  ,CASE WHEN days_between_read_sent BETWEEN 6 AND 10 THEN notification_request_id ELSE NULL END read_sent_between6and10
  ,CASE WHEN days_between_read_sent BETWEEN 11 AND 30 THEN notification_request_id ELSE NULL END read_sent_between11and30
  ,CASE WHEN days_between_read_sent BETWEEN 31 AND 181 THEN notification_request_id ELSE NULL END read_sent_greater30
  ,COALESCE(es.plan_id,0) plan_id
  ,sms_fail_date
  ,email_fail_date  
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
,nr.ref_type1_value
,COALESCE(pl.plan_id_ext,slct.plan_id_ext) plan_id_ext
,COALESCE(con.plan_service_type_cd,slct.plan_service_type_cd) plan_service_type_cd
,COALESCE(prov.provider_org_type,slct.provider_org_type) provider_org_type
,COALESCE(pl.plan_id,slct.plan_id) plan_id
,TRUNC(nhfs.sms_fail_date) sms_fail_date
,TRUNC(nhf.email_fail_date) email_fail_date
FROM eb.letter_request lr 
  JOIN eb.letter_definition ld ON lr.lmdef_id = ld.lmdef_id
  LEFT JOIN eb.letter_request_link lrl on lrl.lmreq_id = lr.lmreq_id
  LEFT JOIN eb.notification_request nr ON lr.lmreq_id = nr.lmreq_id 
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts sent_date,
                                ROW_NUMBER() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('ACCEPTED','DELIVERED','SENT'))
                   WHERE  crn = 1 ) nh ON nr.notification_request_id = nh.notification_request_id
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts email_fail_date,
                                ROW_NUMBER() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('EMAIL_FAIL','EMAIL_FAILED_IN_TRANSIT','FAILED','ERR'))
                   WHERE  crn = 1 ) nhf ON nr.notification_request_id = nhf.notification_request_id  
                   
 LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts sms_fail_date,
                                ROW_NUMBER() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('SMS_FAIL','SMS_FAILED_IN_TRANSIT','FAILED','ERR'))
                   WHERE  crn = 1 ) nhfs ON nr.notification_request_id = nhfs.notification_request_id                     
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts read_date,
                                ROW_NUMBER() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('READ'))
                   WHERE  crn = 1 ) nhr ON nr.notification_request_id = nhr.notification_request_id  AND nhr.read_date >= nh.sent_date                  
  LEFT JOIN (SELECT *
                   FROM (SELECT h.notification_request_id,
                                h.status_cd,
                                h.create_ts clicked_date,
                                ROW_NUMBER() OVER(PARTITION BY h.notification_request_id ORDER BY h.create_ts DESC) crn
                         FROM eb.nreq_status_history h                            
                         WHERE status_cd IN('CLICKED'))
                   WHERE  crn = 1 ) nhc ON nr.notification_request_id = nhc.notification_request_id    
  LEFT JOIN eb.client_letter_data cld on (cld.client_letter_data_id = lrl.additional_reference_id and lrl.additional_reference_type = 'CLIENT_LETTER_DATA')
  LEFT JOIN eb.plans pl on pl.plan_id_ext = CASE WHEN cld.medical_provider = '23876239' THEN '99999905' when cld.medical_provider ='7020368' THEN '99999901' ELSE cld.medical_provider END
  LEFT JOIN eb.contract con on con.plan_id = pl.plan_id 
  LEFT JOIN MAXDAT_SUPPORT.EMRS_D_COEB_PROVIDER_SV PROV ON (CON.PLAN_sERVICE_TYPE_CD = 'ACC' AND prov.plan_id_ext = pl.plan_id_ext and ((cld.medical_provider = prov.plan_id_ext and prov.provider_org_type = 'MCO') or (prov.pcmp_svc_name = cld.pcmp_mco_name and prov.svc_phn_nbr = cld.pcmp_phone_number)))
  LEFT JOIN (SELECT * FROM (
                SELECT con.plan_service_type_cd, pl.plan_id_ext,slct.client_id,pl.plan_id
                      , CASE WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IN ('7020368','07020368','23876239') THEN 'MCO' 
                             WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT NOT IN ('7020368','07020368','23876239') THEN 'PCMP' 
                             WHEN CON.PLAN_SERVICE_TYPE_CD = 'ACC' AND PROVIDER_ID_EXT IS NULL THEN 'PCMP' 
                         ELSE NULL END PROVIDER_ORG_TYPE
                      ,ROW_NUMBER() OVER(PARTITION BY slct.client_id ORDER BY slct.start_nd DESC) rown
                FROM eb.selection_segment slct
                  LEFT JOIN eb.plans pl ON pl.plan_id = slct.plan_id
                  LEFT JOIN eb.CONTRACT CON ON CON.PLAN_ID = SLCT.PLAN_ID
                WHERE 1=1
                AND con.end_date IS NULL
                AND slct.start_nd < slct.end_nd
                AND slct.program_type_cd = 'MEDICAID'
                AND slct.plan_type_cd = 'MEDICAL'
                AND slct.status_cd = 'OPEN' )
            WHERE rown = 1) slct ON slct.client_id = lrl.client_id
WHERE lr.is_digital_ind = 1 ) es ON es.sent_date = dd.d_date
UNION
SELECT dd.d_date sent_date
  ,null lmreq_id
  ,null letter_type
  ,nt.notification_type
  ,null notification_request_id
  ,nc.value channel_cd  
  ,null read_date
  ,null clicked_date
  ,null days_between_read_sent
 -- ,es.days_unopened
  ,null client_id
  ,p.plan_id_ext
  ,s.plan_service_type_cd
  ,pr.provider_org_type
  ,NULL read_sent_between1and5
  ,NULL read_sent_between6and10
  ,NULL read_sent_between11and30
  ,NULL read_sent_greater30
  ,p.plan_id
  ,null sms_failed_date
  ,null email_failed_date
FROM maxdat_support.d_dates dd
CROSS JOIN eb.enum_notification_channel nc
CROSS JOIN (SELECT 'Welcome' notification_type FROM dual
            UNION ALL
            SELECT 'Letter Notification' notification_type FROM dual) nt
CROSS JOIN (maxdat_support.emrs_d_plan_sv p
 left join maxdat_support.emrs_d_plan_service_type_sv s ON p.plan_service_type_cd = s.plan_service_type_cd
 left join maxdat_support.emrs_d_coeb_prov_org_sv pr ON p.plan_id_ext = pr.plan_id_ext )
 WHERE p.plan_id > 1
 AND value IN('EMAIL','SMS')
 ;


GRANT SELECT ON maxdat_support.D_NOTIFICATION_REQUEST_SV TO MAXDAT_REPORTS;
GRANT SELECT ON maxdat_support.D_NOTIFICATION_REQUEST_SV TO MAXDATSUPPORT_READ_ONLY;