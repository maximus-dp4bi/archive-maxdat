SELECT e.etl_e_834_staging_id notification_id       
        ,s.selection_segment_id enrollment_group_id        
FROM etl_e_834_staging e
 INNER JOIN etl_report r
    ON e.job_id = r.job_id
 INNER JOIN selection_segment s
   ON s.client_id = e.client_id
   AND s.plan_id = e.health_plan_ref_id
WHERE e.benefit_begin_date BETWEEN s.start_date AND to_date(s.end_nd,'YYYYMMDD') 