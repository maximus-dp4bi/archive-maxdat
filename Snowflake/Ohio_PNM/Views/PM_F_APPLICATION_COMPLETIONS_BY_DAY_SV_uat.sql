CREATE OR REPLACE VIEW PUBLIC.PM_F_APPLICATION_COMPLETIONS_BY_DAY_SV
AS
WITH completions AS
(SELECT pcbd.provider_type,
       pcbd.provider_type_code_mmis,
       pcbd.operational_group,
       DATE_TRUNC('HOUR',process_end_dt) AS process_end_dt,
       SUM(completion_count) AS completion_count,       
       SUM(timely_count) AS timely_count,
       SUM(untimely_count) AS untimely_count,
       SUM(jeopardy_count) AS jeopardy_count,
       ROUND(SUM(application_tat_in_caldays)/SUM(completion_count),0) avg_application_tat_in_caldays
FROM (SELECT  r.reg_id application_id, 
               wc.process_id,               
               COALESCE(rpt.provider_type_name,'Unavailable') AS provider_type,
               rpt.mmis_provider_type_id AS provider_type_code_mmis,
               CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group,
               COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS  process_start_dt, 
               comp.application_process_end_dt AS  process_end_dt,
               DATEDIFF(DAY,CAST(COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS DATE),CAST(comp.application_process_end_dt AS DATE)) application_tat_in_caldays,
               1 completion_count,
               CASE WHEN DATEDIFF(DAY,CAST(COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS DATE),CAST(comp.application_process_end_dt AS DATE)) BETWEEN 0 AND 30 THEN 1 ELSE 0 END AS timely_count,
               CASE WHEN DATEDIFF(DAY,CAST(COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS DATE),CAST(comp.application_process_end_dt AS DATE)) BETWEEN 31 AND 40 THEN 1 ELSE 0 END AS untimely_count,
               CASE WHEN DATEDIFF(DAY,CAST(COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time) AS DATE),CAST(comp.application_process_end_dt AS DATE)) >= 41 THEN 1 ELSE 0 END AS jeopardy_count,
               RANK() OVER(PARTITION BY r.reg_id ORDER BY COALESCE(comp.application_process_end_dt, wc.end_date_time) ) prnk               
       FROM  ohpnm_dp4bi.registration r 
         JOIN ohpnm_dp4bi.reg_provider rp ON r.reg_id = rp.reg_id
         LEFT JOIN ohpnm_dp4bi.provider_type rpt ON rp.provider_type_id = rpt.provider_type_id
         JOIN  (SELECT *
                FROM (SELECT wc.process_id, parameter_value,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.start_date_time) start_date_time,
                             CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',wc.end_date_time) end_date_time,
                             RANK() OVER (PARTITION BY parameter_value ORDER BY wp.process_id DESC) prnk
                       FROM ohpnm_dp4bi.wf_parameter wp
                         JOIN ohpnm_dp4bi.wf_process wc  ON wc.process_id = wp.process_id AND wc.workflow_id = 1
                       WHERE parameter_name = 'REGISTRATION_ID')
                WHERE prnk = 1) wc ON wc.parameter_value = TO_CHAR(r.reg_id)                                                                 
         LEFT JOIN (SELECT *
                    FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_received_notice_sent_dt, 
		                        RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
			              FROM ohpnm_dp4bi.wf_step s  
			                JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
			              WHERE t.name = 'Application Received Notice') tmp
			        WHERE rnk = 1) arn ON arn.process_id = wc.process_id      
        LEFT JOIN(SELECT cec.reg_id,cec.communication_event_id, CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',cec.communication_event_date_time) cancel_notice_dt  
                   FROM ohpnm_dp4bi.communication_event cec  
                      LEFT JOIN ohpnm_dp4bi.email e  ON e.communication_event_id = cec.communication_event_id
                      LEFT JOIN ohpnm_dp4bi.mail m  ON m.communication_event_id = cec.communication_event_id                   
                   WHERE COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt' ) cn ON r.reg_id = cn.reg_id AND cn.cancel_notice_dt > COALESCE(arn.application_received_notice_sent_dt,wc.start_date_time)       
         LEFT JOIN (SELECT *
                    FROM (SELECT s.process_id, s.task_id,s.start_date_time,CONVERT_TIMEZONE('UTC', 'America/Los_Angeles',s.end_date_time) application_process_end_dt, 
		                          RANK() OVER (PARTITION BY s.process_id ORDER BY s.step_id) rnk
		                  FROM ohpnm_dp4bi.wf_step s  
			                JOIN ohpnm_dp4bi.wf_task t ON s.task_id = t.task_id
			              WHERE UPPER(t.name) IN('COMPLETE WORKFLOW','COMPLETEWORKFLOW')) tmp
			        WHERE rnk = 1) comp ON wc.process_id = comp.process_id  
      WHERE cn.cancel_notice_dt IS NULL
      AND application_process_end_dt IS NOT NULL) pcbd
WHERE prnk = 1
GROUP BY pcbd.provider_type,
       pcbd.provider_type_code_mmis,
       pcbd.operational_group,
       DATE_TRUNC('HOUR',process_end_dt))       
SELECT CAST(dd.d_date_hour AS date) AS d_date
    ,CASE WHEN DATE_PART(HOUR,dd.d_date_hour) = 0 THEN '12 AM'
            WHEN DATE_PART(HOUR,dd.d_date_hour) = 12 THEN '12 PM'
            WHEN DATE_PART(HOUR,dd.d_date_hour) < 12 THEN CONCAT(TO_CHAR(DATE_PART(HOUR,dd.d_date_hour)),' AM') 
        ELSE CONCAT(TO_CHAR(DATE_PART(HOUR,dd.d_date_hour)-12),' PM') END AS d_date_hour_ampm
    ,DATE_PART(HOUR,dd.d_date_hour) d_date_hour       
   ,DAYNAME(dd.d_date_hour) AS day_of_week
   ,rpt.provider_type
   ,rpt.provider_type_code_mmis
   ,rpt.operational_group
   ,COALESCE(completion_count,0) completion_count
   ,COALESCE(timely_count,0) timely_count
   ,COALESCE(untimely_count,0) untimely_count
   ,COALESCE(jeopardy_count,0) jeopardy_count
   ,COALESCE(avg_application_tat_in_caldays,0) avg_application_tat_in_caldays
FROM (SELECT TO_TIMESTAMP(CONCAT(TO_CHAR(d_date,'mm/dd/yyyy'),' ',LPAD(hh_time,2,'0')) ,'mm/dd/yyyy hh24') d_date_hour
        FROM d_dates dd
        CROSS JOIN(SELECT  seq4() hh_time
                   FROM TABLE(GENERATOR(ROWCOUNT => 24)) v)
       WHERE d_date >= DATEADD(MONTH,-12,DATE_TRUNC('MONTH',current_date()))
       AND d_date <= current_date()) dd
   CROSS JOIN (SELECT DISTINCT rpt.provider_type_name AS provider_type,
                      rpt.mmis_provider_type_id AS provider_type_code_mmis,
                      CASE WHEN rpt.mmis_provider_type_id = '86' THEN 'Ohio Department of Medicaid' ELSE 'Maximus' END AS operational_group
               FROM ohpnm_dp4bi.provider_type rpt
               UNION ALL
               SELECT 'Unavailable' AS provider_type,
                      '0' provider_type_code_mmis,
                      'Maximus' AS operational_group
               FROM dual) rpt 
   LEFT JOIN completions 
    ON dd.d_date_hour = completions.process_end_dt 
      AND completions.provider_type = rpt.provider_type 
      AND completions.provider_type_code_mmis = rpt.provider_type_code_mmis 
      AND completions.operational_group = rpt.operational_group  ;
          