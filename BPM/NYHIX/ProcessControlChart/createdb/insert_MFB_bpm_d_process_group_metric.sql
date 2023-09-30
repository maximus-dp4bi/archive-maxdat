INSERT INTO bpm_d_process_group_metric(
      d_metric_definition_id
    , d_process_group_detail_id
    , lower_specification_limit
    , calculate_control_chart_ind
    , trend_indicator_calculation
    , record_eff_dt
    , record_end_dt)
  SELECT d_metric_definition_id
      , d_process_group_detail_id
      , 90
      , 'Y'
      , 'CONTROL CHART'
      , Trunc(sysdate)
      , To_Date('12/31/2099','mm/dd/yyyy')
  FROM  bpm_d_metric_definition    DEF
      , bpm_d_process_group_detail DTL
  WHERE DEF.name = 'BATCHES_COMPLETED_TIMELY'
    AND DTL.d_process_definition_id = (SELECT d_process_definition_id from bpm_d_process_definition where process_name = 'MAIL_FAX_BATCH');

COMMIT;