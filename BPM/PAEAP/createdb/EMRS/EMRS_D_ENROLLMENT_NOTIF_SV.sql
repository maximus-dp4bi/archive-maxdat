CREATE OR REPLACE VIEW EMRS_D_ENROLLMENT_NOTIF_SV
AS
  SELECT e.etl_e_834_staging_id notification_id ,
    s.selection_segment_id enrollment_group_id
  FROM etl_e_834_staging e
  JOIN etl_report r        ON e.job_id = r.job_id
  JOIN selection_segment s ON s.client_id = e.client_id AND s.plan_id = e.health_plan_ref_id
    --benefit_begin_date WAS USED BUT THAT DOESN'T EXIST
  WHERE e.CREATE_TS BETWEEN s.start_date AND to_date(s.end_nd,'YYYYMMDD');
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ENROLLMENT_NOTIF_SV TO EB_MAXDAT_REPORTS;