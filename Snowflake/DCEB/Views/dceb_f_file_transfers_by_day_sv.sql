CREATE OR REPLACE VIEW dceb.dceb_f_file_transfers_by_day_sv 
AS
SELECT d.d_day_name
      ,DATE_TRUNC('SECOND', si.log_created_on) AS file_sent_dt
      ,COUNT(DISTINCT si.profile_id) AS cnt_members
FROM marsdb.marsdb_etl_selection_init_vw si
LEFT JOIN marsdb.marsdb_project_vw p on (si.project_id = p.project_id)
LEFT JOIN public.d_dates d ON (DATE_TRUNC('DAY',si.log_created_on) = d.d_date AND si.project_id = d.project_id)
WHERE p.project_name = 'DC-EB'
GROUP BY DATE_TRUNC('SECOND', si.log_created_on), d.d_day_name;