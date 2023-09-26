CREATE OR REPLACE VIEW OHIO_PROVIDER_DP4BI_DEV_DB.PUBLIC.PM_F_APPLICATIONS_BY_DAY_SV 
AS
SELECT  d_date,
        SUM(creation_count)                         AS  creation_count,
        SUM(inventory_count)                        AS  inventory_count,
        SUM(completion_count)                       AS  completion_count,
        SUM(cancellation_count)                     AS  cancellation_count,
        SUM(completion_count) +
        SUM(cancellation_count)                     AS  termination_count
FROM    (
            SELECT dd.d_date,pcbd.*,
              CASE WHEN     d_date = CAST(pcbd.process_start_dt AS DATE)                                        THEN 1 ELSE 0 END AS    creation_count,  
              CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE)                                        THEN 0 ELSE 1 END AS    inventory_count,
              CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE)                                        
                        AND pcbd.cancel_notice_dt IS NULL                                                       THEN 1 ELSE 0 END AS    completion_count,
              CASE WHEN     d_date = CAST(pcbd.process_end_dt   AS DATE)                                            
                        AND pcbd.cancel_notice_dt IS NOT NULL                                                   THEN 1 ELSE 0 END AS    cancellation_count
            FROM (
                    SELECT  r.reg_id, 
                            wp.process_id,
                            wc.start_date_time                                      AS  process_start_dt, 
                            COALESCE(cn.cancel_notice_dt, wc.end_date_time)         AS  process_end_dt, 
                            cn.cancel_notice_dt,
                            RANK() OVER(PARTITION BY r.reg_id ORDER BY wc.process_id DESC, cn.cancel_notice_dt) prnk
                      FROM  ohpnm_dp4bi_dev.registration        r 
                      JOIN  ohpnm_dp4bi_dev.wf_parameter        wp  ON wp.parameter_value = r.reg_id AND parameter_name = 'REGISTRATION_ID' 
                      JOIN  ohpnm_dp4bi_dev.wf_process          wc  ON wc.process_id = wp.process_id 
                      LEFT JOIN
                      (
                        SELECT cec.reg_id,cec.communication_event_id, cec.communication_event_date_time cancel_notice_dt  
                          FROM ohpnm_dp4bi_dev.communication_event cec  
                          LEFT JOIN ohpnm_dp4bi_dev.email e  ON e.communication_event_id = cec.communication_event_id
                          LEFT JOIN ohpnm_dp4bi_dev.mail m  ON m.communication_event_id = cec.communication_event_id                   
                        WHERE COALESCE(e.template_name,m.template_name) = 'ProviderApplication10DayNotice.txt'                  
                      ) cn
                      ON r.reg_id = cn.reg_id AND cn.cancel_notice_dt > wc.start_date_time
                ) pcbd
            JOIN d_dates dd ON dd.d_date >= CAST(pcbd.process_start_dt AS DATE) AND 
                 dd.d_date <= CAST(COALESCE(pcbd.process_end_dt, CONVERT_TIMEZONE('America/Los_Angeles','America/New_York',current_timestamp())) AS DATE)
         WHERE prnk = 1
      ) t
GROUP BY d_date;
