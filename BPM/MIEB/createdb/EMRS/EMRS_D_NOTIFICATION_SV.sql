CREATE OR REPLACE VIEW EMRS_D_NOTIFICATION_SV
AS
  SELECT e.etl_e_834_staging_id notification_id ,
    r.start_ts send_date ,
    e.member_maint_type_cd maintenance_type_cd ,
    e.etl_e_834_staging_id source_record_id ,
    TO_CHAR(r.job_id) created_by ,
    e.create_ts date_created ,
    e.reason_cd maintenance_reason ,
    s.selection_segment_id ,
    'ETL_E_834_STAGING' source_table_name
  FROM etl_e_834_staging e
  JOIN etl_report r        ON e.job_id = r.job_id
  JOIN selection_segment s ON s.client_id = e.client_id AND s.plan_id = e.health_plan_ref_id
    --benefit_begin_date WAS USED BUT THAT DOESN'T EXIST
  WHERE e.CREATE_TS BETWEEN s.start_date AND to_date(s.end_nd,'YYYYMMDD');
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_NOTIFICATION_SV TO MAXDAT_REPORTS; 