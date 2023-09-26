CREATE OR REPLACE VIEW PUBLIC.DMAS_CPU_APPLICATION_SV
AS
SELECT cpu.tracking_number
  ,cpu.app_received_date
  ,cpu.preg_switch
  ,cpu.disab_switch
  ,cpu.doc_app_switch
  ,cpu.application_source
  ,cpu.cname
  ,cpu.processing_unit
  ,cpu.assigned_to
  ,cpu.locality
  ,cpu.status
  ,cpu.rundate
  ,cpu.trnferdate
  ,cpu.file_date
  ,cpu.filename
  ,CASE WHEN UPPER(cpu.application_source) = 'RDE' AND cpu.status IS NULL AND cpu.assigned_to IS NULL THEN 'Y' ELSE 'N' END unsubmitted_phone_application
  ,rnk record_sequence
  ,cpu.running_cpu_mws_date
  ,CASE WHEN da.in_cp_indicator = 'Y' AND ( cdc_processed_dt IS NOT NULL AND file_date > MIN(cdc_processed_dt) OVER(PARTITION BY cpu.tracking_number ORDER BY cdc_processed_dt)  ) THEN 'Y' ELSE 'N' END in_r15_report
  ,CASE WHEN da.tracking_number IS NOT NULL AND ( cdc_processed_dt IS NOT NULL AND  file_date > MIN(cdc_processed_dt) OVER(PARTITION BY cpu.tracking_number ORDER BY cdc_processed_dt)  ) THEN 'Y' ELSE 'N' END in_daily_inventory
  ,intake_date cp_intake_date
  ,file_inventory_date app_file_inventory_date
  ,cdc_processed_dt
FROM(SELECT cpu.*, lf.file_date, RANK() OVER (PARTITION BY cpu.tracking_number ORDER BY CAST(lf.file_date AS DATE) DESC,cpu.cpu_data_id DESC)  rnk
  ,CASE WHEN COALESCE(application_source,'X') = 'RDE' AND (assigned_to IS NOT NULL OR status IS NOT NULL) THEN mrde.app_received_date 
        WHEN COALESCE(application_source,'X') = 'RDE' AND (assigned_to IS NULL AND status IS NULL) THEN NULL
     ELSE cpu.rundate END running_cpu_mws_date
     FROM coverva_dmas.cpu_data_full_load cpu
      JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = UPPER(lf.filename)
      LEFT JOIN(SELECT tracking_number, MIN(CAST(lf.file_date AS DATE)) app_received_date --OVER(PARTITION BY tracking_number ORDER BY CAST(lf.file_date AS DATE), cpu_data_id) app_received_date                
                FROM coverva_dmas.cpu_data_full_load cpu 
                 JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename 
                WHERE  lf.filename_prefix != 'CPUREPORT_TRNS_YESTERDAY' 
                AND application_source = 'RDE' 
                AND (assigned_to IS NOT NULL OR status IS NOT NULL)
               GROUP BY tracking_number) mrde ON mrde.tracking_number = cpu.tracking_number
     WHERE lf.filename_prefix != 'CPUREPORT_TRNS_YESTERDAY'  ) cpu  
  LEFT JOIN coverva_dmas.dmas_application_current da ON cpu.tracking_number = da.tracking_number 
  LEFT JOIN (SELECT CAST(cdc_processed_date AS DATE) cdc_processed_date,MAX(cdc_processed_date) cdc_processed_dt
             FROM coverva_dmas.dmas_file_log
            GROUP BY CAST(cdc_processed_date AS DATE) ) cdc ON CAST(cpu.file_date AS DATE) = cdc.cdc_processed_date;