CREATE OR REPLACE VIEW EMRS_D_ALERT_SV
AS
  SELECT alert_id AS alert_id ,
    alert_id AS source_record_id ,
    case_id AS case_id ,
    client_id AS client_id ,
    MESSAGE AS MESSAGE ,
    start_date AS source_alert_start_date ,
    end_date AS source_alert_end_date ,
    void_ind AS void_ind ,
    system_alert_ind AS system_alert_ind ,
    ref_type AS ref_type ,
    ref_id AS ref_id ,
    lock_id AS lock_id ,
    record_count AS record_count ,
    alert_handler AS alert_handler ,
    TRUNC(create_ts) AS record_date ,
    TO_CHAR(create_ts,'HH24MI') AS record_time ,
    created_by AS record_name ,
    TRUNC(update_ts) AS modified_date ,
    updated_by AS modified_name ,
    TO_CHAR(update_ts,'HH24MI') AS modified_time ,
    create_ts AS date_created ,
    update_ts AS date_updated ,
    created_by AS created_by ,
    updated_by AS updated_by
  FROM &schema_name..alert ;
  
  GRANT SELECT ON MAXDAT_SUPPORT.EMRS_D_ALERT_SV TO MAXDAT_REPORTS;