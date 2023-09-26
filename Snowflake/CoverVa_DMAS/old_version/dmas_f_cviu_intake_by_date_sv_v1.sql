CREATE OR REPLACE VIEW dmas_f_cviu_intake_by_date_sv
AS
SELECT  d_year,d_quarter,d_month_year,d_date,
 intake_record_count count_intake_records, 
 doc_intake_record_count count_doc_intake_records,
 scb_intake_record_count count_scb_intake_records,
 intake_process_count count_intake_process,
 doc_intake_process_count count_doc_intake_process,
 scb_intake_process_count count_scb_intake_process
 FROM (SELECT d_year,
        d_month,
        TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
        d_date, 
        CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter
       FROM d_dates
       WHERE project_id = 117
       AND d_date >= CAST('01/01/2021' AS DATE) 
       AND d_date <= LAST_DAY(current_date(),'week')  ) dd
  JOIN coverva_dmas.cviu_intake_history ih ON dd.d_date = ih.dr_file_date
UNION ALL
SELECT d_year,d_quarter,d_month_year,d_date,
 COUNT(offender_id) count_intake_records,
 SUM(CASE WHEN offender_location_type = 'DOC' THEN 1 ELSE 0 END) count_doc_intake_records,
 SUM(CASE WHEN offender_location_type = 'SCB' THEN 1 ELSE 0 END) count_scb_intake_records,
 SUM(CASE WHEN medicaid_number IS NOT NULL THEN 1 ELSE 0 END) count_intake_process,
 SUM(CASE WHEN  offender_location_type = 'DOC' AND medicaid_number IS NOT NULL  THEN 1 ELSE 0 END) count_doc_intake_process,
 SUM(CASE WHEN  offender_location_type = 'SCB' AND medicaid_number IS NOT NULL  THEN 1 ELSE 0 END) count_scb_intake_process
FROM (SELECT d_year,
        d_month,
        TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
        d_date, 
        CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter
      FROM d_dates
      WHERE project_id = 117
      AND d_date >= CAST('01/01/2022' AS DATE) 
      AND d_date <= LAST_DAY(current_date(),'week')  ) dd
 JOIN coverva_dmas.dmas_file_log fl ON dd.d_date = CAST(fl.file_date AS DATE) AND fl.filename_prefix = 'CVIU_INTAKE' 
 JOIN coverva_dmas.cviu_intake_data_full_load dr  ON fl.filename = UPPER(dr.filename)
GROUP BY d_year,d_quarter,d_month_year,d_date;