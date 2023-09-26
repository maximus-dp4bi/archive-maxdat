USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_auto_endofshift_sv AS
SELECT ls.Supervisor,
  CONCAT(e.first_name,' ', e.last_name) AS employee,
  CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE) AS create_date
FROM coverva_mio.clock_punches c
  LEFT JOIN coverva_mio.employees e ON c.emp_id = e.id
  LEFT JOIN mio_d_supervisor_sv ls ON e.supervisor = ls.id 
WHERE c.auto_endshift = 1 
GROUP BY ls.Supervisor, CONCAT(e.first_name,' ', e.last_name) , CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.created) AS DATE);
    