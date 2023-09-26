CREATE OR REPLACE VIEW PUBLIC.dmas_excluded_application_sv
AS
SELECT x.tracking_number
  ,ignore_application_reason
  ,CAST(f.file_date AS DATE) file_date
  ,fp_create_dt file_processed_date
  ,f.filename  
  ,RANK() OVER(PARTITION BY x.tracking_number ORDER BY CAST(f.file_date AS DATE) DESC,dmas_excluded_application_id DESC) record_sequence
  ,CASE WHEN da.tracking_number IS NOT NULL THEN 'Y' ELSE 'N' END in_app_inventory
  ,CASE WHEN da.tracking_number IS NOT NULL THEN da.file_inventory_date ELSE NULL END inventory_file_date
  ,CASE WHEN da.tracking_number IS NOT NULL THEN da.filename ELSE NULL END inventory_filename
FROM coverva_dmas.dmas_excluded_application x
  JOIN coverva_dmas.dmas_file_log f ON x.file_id = f.file_id
  LEFT JOIN (SELECT *
             FROM(SELECT da.tracking_number, file_inventory_date, filename,RANK() OVER(PARTITION BY da.tracking_number ORDER BY file_inventory_date,dmas_application_id) rnk
                  FROM coverva_dmas.dmas_application da
                    JOIN coverva_dmas.dmas_file_log fl ON da.file_id = fl.file_id)
             WHERE rnk = 1) da ON x.tracking_number = da.tracking_number;