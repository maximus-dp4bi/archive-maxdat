CREATE OR REPLACE VIEW PUBLIC.dmas_application_renewal_inventory_sv
AS
SELECT received_date ,
       tracking_number,
       application_source,
       case_number,
       case_name,
       processing_unit,
       programs,
       worker_id,
       locality,
       processing_status,
       potential_disability,       
       incarcerated,
       potential_pregnancy,
       ROW_NUMBER() OVER (PARTITION BY tracking_number ORDER BY df.file_date DESC,ra.renewal_data_id DESC) record_sequence 
FROM coverva_dmas.renewal_data_full_load ra
 JOIN coverva_dmas.dmas_file_log df ON UPPER(ra.filename) = UPPER(df.filename);