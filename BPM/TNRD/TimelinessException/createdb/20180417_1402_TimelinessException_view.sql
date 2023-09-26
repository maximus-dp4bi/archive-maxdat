
CREATE OR REPLACE VIEW MAXDAT.TS_TIMELINESS_EXCEPTION_SV
AS select te.timeliness_exception_id,
       te.rids_id,
       te.app_id,
       te.exception_type_id,
       etl.exception_type,
       te.exclusion_flag,
       te.hcfa_reactivation_flag,
       te.callback_date,
       te.new_cycle_start_date,
       te.new_cycle_end_date,
       te.ignore_flag,
       te.comments,
       te.create_by,
       te.create_datetime,
       te.last_updated_by,
       te.last_updated_datetime
  from maxdat.ts_timeliness_exception te
  join maxdat.ts_exception_type_lkup etl on te.exception_type_id=etl.exception_type_id;
  
  GRANT SELECT ON TS_TIMELINESS_EXCEPTION_SV TO MAXDAT_READ_ONLY;
