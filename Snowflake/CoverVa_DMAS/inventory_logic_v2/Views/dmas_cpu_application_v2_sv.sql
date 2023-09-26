CREATE OR REPLACE VIEW PUBLIC.DMAS_CPU_APPLICATION_V2_SV
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
  ,CAST(cpu.file_date AS DATE) file_date
  ,cpu.filename
  ,CASE WHEN UPPER(cpu.application_source) = 'RDE' AND cpu.status IS NULL AND cpu.assigned_to IS NULL THEN 'Y' ELSE 'N' END unsubmitted_phone_application
  ,rnk record_sequence
  ,cpu.running_cpu_mws_date
  ,cpu_load_date
  ,cdc_processed_date
  ,cpu.file_date cpu_file_dt
  ,CASE WHEN file_date < cdc_processed_date OR cdc_processed_date IS NULL THEN 'N' ELSE 'Y' END in_daily_inventory 
  ,CASE WHEN cph.tracking_number IS NOT NULL THEN 'Y' 
        WHEN cph.tracking_number IS NULL AND cpu.file_date > cp.load_date THEN 'Y' ELSE 'N' END in_cp
FROM(SELECT cpu.*, lf.file_date, lf.load_date cpu_load_date,RANK() OVER (PARTITION BY cpu.tracking_number ORDER BY CAST(lf.file_date AS DATE) DESC,cpu.cpu_data_id DESC)  rnk
  ,CASE WHEN COALESCE(application_source,'X') = 'RDE' AND (assigned_to IS NOT NULL OR status IS NOT NULL) THEN mrde.app_received_date 
        WHEN COALESCE(application_source,'X') = 'RDE' AND (assigned_to IS NULL AND status IS NULL) THEN NULL
     ELSE cpu.rundate END running_cpu_mws_date
     ,prev_business_date
     FROM coverva_dmas.cpu_data_full_load cpu
      JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = UPPER(lf.filename)
      JOIN (SELECT project_id,d_date,LAG(d_date) OVER(ORDER BY project_id,d_date) prev_business_date
            FROM PUBLIC.D_DATES
            WHERE business_day_flag = 'Y'
            AND project_id = 117) dd ON CAST(lf.load_date AS DATE) = dd.d_date
      LEFT JOIN(SELECT tracking_number, MIN(CAST(lf.file_date AS DATE)) app_received_date
                FROM coverva_dmas.cpu_data_full_load cpu 
                 JOIN coverva_dmas.dmas_file_log lf ON UPPER(cpu.filename) = lf.filename                  
                WHERE  lf.filename_prefix != 'CPUREPORT_TRNS_YESTERDAY' 
                AND application_source = 'RDE' 
                AND (assigned_to IS NOT NULL OR status IS NOT NULL)
               GROUP BY tracking_number) mrde ON mrde.tracking_number = cpu.tracking_number
     WHERE lf.filename_prefix != 'CPUREPORT_TRNS_YESTERDAY'  ) cpu 
   LEFT JOIN(SELECT tracking_number,MIN(l.cdc_processed_date) cdc_processed_date
             FROM coverva_dmas.dmas_application_v2_inventory da 
               JOIN coverva_dmas.dmas_file_log l ON da.file_id = l.file_id
             GROUP BY tracking_number)  da ON cpu.tracking_number = da.tracking_number
   LEFT JOIN coverva_dmas.dmas_application_v2_current dca ON cpu.tracking_number = dca.tracking_number 
   LEFT JOIN coverva_dmas.cp_application_inventory_hist cph ON cpu.tracking_number = cph.tracking_number AND cph.load_date = cpu.prev_business_date
   LEFT JOIN (SELECT tracking_number,MAX(load_date) load_date
              FROM coverva_dmas.cp_application_inventory_hist
              GROUP BY tracking_number) cp ON cpu.tracking_number = cp.tracking_number;