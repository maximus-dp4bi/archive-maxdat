CREATE OR REPLACE VIEW PUBLIC.PM_F_PROVIDER_CREDENTIAL_BY_STATUS_BY_DAY_SV
AS
SELECT d_date,
  credentialing_status,
  SUM(creation_count) creation_count,
  SUM(inventory_count) inventory_count,
  SUM(completion_count) completion_count,
  0 cancellation_count,
  SUM(termination_count) termination_count
FROM(SELECT dd.d_date,pcbd.*,
			CASE WHEN CAST(pcbd.start_date_time AS DATE)= dd.d_date THEN 1 ELSE 0 END creation_count,  
			CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 0 ELSE 1 END AS inventory_count,
			CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 1 ELSE 0 END AS completion_count,
			CASE WHEN d_date = CAST(pcbd.end_date_time AS DATE) THEN 1 ELSE 0 END AS termination_count  
FROM (SELECT rc.reg_id,c.credentialing_id,acs.credentialing_status_name credentialing_status,convert_timezone('UTC', 'America/Los_Angeles',aac.start_date_time) start_date_time,
		convert_timezone('UTC', 'America/Los_Angeles',COALESCE(aac.end_date_time,LEAD(aac.start_date_time) OVER(PARTITION BY c.credentialing_id ORDER BY aac.a_credentialing_id))) end_date_time
	  FROM ohpnm_dp4bi.reg_credentialing rc 
		JOIN ohpnm_dp4bi.credentialing c ON rc.credentialing_id = c.credentialing_id
		LEFT JOIN ohpnm_dp4bi.a_credentialing aac ON c.credentialing_id = aac.credentialing_id
		LEFT JOIN ohpnm_dp4bi.credentialing_status acs ON acs.credentialing_status_id = aac.credentialing_status_id ) pcbd
JOIN d_dates dd ON dd.d_date >= CAST(pcbd.start_date_time AS DATE) AND dd.d_date <= CAST(COALESCE(pcbd.end_date_time,CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)
) t
GROUP BY d_date,credentialing_status
;