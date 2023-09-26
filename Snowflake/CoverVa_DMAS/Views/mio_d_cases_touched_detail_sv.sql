USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_cases_touched_detail_sv AS
SELECT case_number, 
  task_status AS disposition,
  assigned_to,
  CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date) AS disposition_Date 
FROM coverva_mio.case_pool_log 
GROUP BY case_number, task_status, CONVERT_TIMEZONE('UTC', 'America/New_York',bucket_date),assigned_to;