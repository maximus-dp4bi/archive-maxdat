create or replace view OHIO_PROVIDER_DP4BI_PROD_DB.PUBLIC.D_PM_APPLICATION_NOTICE_INSTANCE_SV(
	D_DATE,
	APPLICATION_ID,
	COMMUNICATION_EVENT_ID,
	NOTICE_SUBJECT,
	TEMPLATE_NAME,
	NOTICE_TYPE,
	OPERATIONAL_GROUP,
	PROVIDER_TYPE,
	PROVIDER_TYPE_CODE_MMIS
) as 
SELECT CAST(CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',communication_event_date_time) AS DATE) AS d_date,
       cec.reg_id application_id,
       cec.communication_event_id, 
       COALESCE(e.subject,m.subject) notice_subject,
       REPLACE(COALESCE(e.template_name,m.template_name),'.txt','') AS template_name,
       CASE WHEN e.communication_event_id IS NOT NULL THEN 'Email' 
            WHEN m.communication_event_id IS NOT NULL THEN 'Mail' ELSE NULL END AS notice_type,  
       CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group,
       rpt.provider_type_name AS provider_type,
       rpt.mmis_provider_type_id AS provider_type_code_mmis
FROM ohpnm_dp4bi.registration r 
  JOIN ohpnm_dp4bi.reg_provider rp ON r.reg_id = rp.reg_id
  LEFT JOIN ohpnm_dp4bi.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id
  JOIN ohpnm_dp4bi.communication_event cec ON r.reg_id = cec.reg_id
  LEFT JOIN ohpnm_dp4bi.email e  ON e.communication_event_id = cec.communication_event_id
  LEFT JOIN ohpnm_dp4bi.mail m  ON m.communication_event_id = cec.communication_event_id ;