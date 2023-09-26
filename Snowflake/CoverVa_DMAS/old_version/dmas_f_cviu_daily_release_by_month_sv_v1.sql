CREATE OR REPLACE VIEW dmas_f_cviu_daily_release_by_month_sv
AS
SELECT
dd.d_year,dd.d_quarter,dd.d_month_year,dd.d_yearmonth_num,
 record_count count_records,
 doc_record_count count_doc_records,
 scb_record_count count_scb_records,
 release_process_count count_release_process,
 doc_release_process_count count_doc_release_process,
 scb_release_process_count count_scb_release_process,
 transfer_process_count count_transfer_process,         
 doc_transfer_process_count count_doc_transfer_process, 
 scb_transfer_process_count count_scb_transfer_process, 
 moved_outof_state_count count_moved_outof_state,
 doc_moved_outof_state_count count_doc_moved_outof_state,         
 scb_moved_outof_state_count count_scb_moved_outof_state
FROM (SELECT d_year,
       d_month,
       TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
       d_date,
       d_day_name,   
       CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter,
       TO_NUMBER(CONCAT(d_year,LPAD(d_month_num,2,'0'))) d_yearmonth_num
      FROM d_dates
      WHERE project_id = 117
      AND d_date >= CAST('01/01/2021' AS DATE) 
      AND d_date <= LAST_DAY(current_date(),'week') ) dd
  JOIN coverva_dmas.cviu_daily_release_history drh ON dd.d_date =  drh.dr_file_date
WHERE dr_mtd_ytd_indicator = 'YTD'
UNION ALL 
SELECT d_year,d_quarter,d_month_year,d_yearmonth_num,
 COUNT(offender_id) count_records,
 SUM(CASE WHEN offender_location_type = 'DOC' THEN 1 ELSE 0 END) count_doc_records,
 SUM(CASE WHEN offender_location_type = 'SCB' THEN 1 ELSE 0 END) count_scb_records,
 SUM(CASE WHEN medicaid_category IN('108','109') AND offender_release_person != '12' AND COALESCE(offender_proposed_address_state,'VA') = 'VA' THEN 1 ELSE 0 END) count_release_process,
 SUM(CASE WHEN  offender_location_type = 'DOC' AND medicaid_category IN('108','109') 
         AND offender_release_person != '12' AND COALESCE(offender_proposed_address_state,'VA') = 'VA' THEN 1 ELSE 0 END) count_doc_release_process,
 SUM(CASE WHEN  offender_location_type = 'SCB' AND medicaid_category IN('108','109') 
         AND offender_release_person != '12' AND COALESCE(offender_proposed_address_state,'VA') = 'VA' THEN 1 ELSE 0 END) count_scb_release_process,
 SUM(CASE WHEN medicaid_category IS NOT NULL AND offender_release_person = '12' THEN 1 ELSE 0 END) count_transfer_process,         
 SUM(CASE WHEN offender_location_type = 'DOC' AND medicaid_category IS NOT NULL AND offender_release_person = '12' THEN 1 ELSE 0 END) count_doc_transfer_process, 
 SUM(CASE WHEN offender_location_type = 'SCB' AND medicaid_category IS NOT NULL AND offender_release_person = '12' THEN 1 ELSE 0 END) count_scb_transfer_process, 
 SUM(CASE WHEN medicaid_category IS NOT NULL AND COALESCE(offender_proposed_address_state,'VA') != 'VA' THEN 1 ELSE 0 END) count_moved_outof_state,
 SUM(CASE WHEN offender_location_type = 'DOC' AND medicaid_category IS NOT NULL AND COALESCE(offender_proposed_address_state,'VA') != 'VA' THEN 1 ELSE 0 END) count_doc_moved_outof_state,         
 SUM(CASE WHEN offender_location_type = 'SCB' AND medicaid_category IS NOT NULL AND COALESCE(offender_proposed_address_state,'VA') != 'VA' THEN 1 ELSE 0 END) count_scb_moved_outof_state
FROM (SELECT d_year,
        d_month,
        TRIM(CONCAT(d_month_name,'-',d_year)) d_month_year,
        d_date,
        d_day_name,
        CONCAT('WE - ',LAST_DAY(d_date,'week')) week_ending,
        CONCAT('Quarter',DATE_PART('quarter',d_date),'-',d_year) d_quarter,
        TO_NUMBER(CONCAT(d_year,LPAD(d_month_num,2,'0'))) d_yearmonth_num
      FROM d_dates
      WHERE project_id = 117
      AND d_date >= CAST('01/01/2022' AS DATE) 
      AND d_date <= LAST_DAY(current_date(),'week') ) dd
 JOIN coverva_dmas.dmas_file_log fl ON dd.d_date = CAST(fl.file_date AS DATE) AND fl.filename_prefix = 'CVIU_DAILY_RELEASE' 
 JOIN coverva_dmas.cviu_daily_release_full_load dr  ON fl.filename = UPPER(dr.filename)
GROUP BY d_year,d_quarter,d_month_year,d_yearmonth_num;