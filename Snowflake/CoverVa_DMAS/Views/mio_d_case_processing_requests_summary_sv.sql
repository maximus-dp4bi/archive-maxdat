USE SCHEMA PUBLIC;
CREATE OR REPLACE VIEW mio_d_case_processing_requests_summary_sv AS
SELECT 
yyy.Supervisor,
yyy.worker,
yyy.request_type,
yyy.Outstanding,
yyy.Completed,
oldestOutstanding.Oldest_Outstanding
FROM
 (SELECT xxx.Supervisor, 
        xxx.worker, 
        xxx.request_type,
        SUM(xxx.Outstanding) AS Outstanding,
        SUM(xxx.Completed) AS Completed
  FROM(SELECT s.Supervisor,
         CONCAT(e.first_name,' ', e.last_name) AS Worker,
         request_type,
         CASE WHEN status IN ('New', 'Pending') THEN 1 ELSE 0 END AS Outstanding,
         CASE WHEN status IN ('Completed', 'Denied') THEN 1 ELSE 0 END AS Completed
       FROM coverva_mio.cate_unprocessed c 
         JOIN coverva_mio.employees e ON e.id = c.employee_table_id
         LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
       WHERE (status IN ('New', 'Pending')) OR (status IN ('Completed', 'Denied') AND CONVERT_TIMEZONE('UTC', 'America/New_York',c.date_updated) > DATEADD(DAY,-1,current_date()) )
       ) xxx
  GROUP BY xxx.Supervisor, xxx.worker, xxx.request_type) yyy
 LEFT JOIN  -- this is so we can grab the oldest case per supervisor and worker grouping
  (SELECT s.Supervisor,
     CONCAT(e.first_name,' ', e.last_name) AS Worker,
     MIN(CAST(CONVERT_TIMEZONE('UTC', 'America/New_York',c.date_created) AS DATE)) AS Oldest_Outstanding
   FROM coverva_mio.cate_unprocessed c 
    JOIN coverva_mio.employees e ON e.id = c.employee_table_id
    LEFT JOIN mio_d_supervisor_sv s ON e.supervisor = s.id
   WHERE (status IN ('New', 'Pending')) OR (status IN ('Completed', 'Denied') AND CONVERT_TIMEZONE('UTC', 'America/New_York',c.date_updated) > DATEADD(DAY,-1,current_date()) )
   GROUP BY s.Supervisor, CONCAT(e.first_name,' ', e.last_name)
) oldestOutstanding ON oldestOutstanding.Worker = yyy.worker;