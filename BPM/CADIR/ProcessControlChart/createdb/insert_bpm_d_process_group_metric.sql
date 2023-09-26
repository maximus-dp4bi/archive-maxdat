INSERT INTO bpm_d_process_group_metric
(d_metric_definition_id,d_process_group_detail_id, lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt, record_end_dt)
SELECT d_metric_definition_id, d_process_group_detail_id,90,'Y','CONTROL CHART',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'TASK_COMPLETED_TIMELY'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE'
;

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'AVG_AGE_UNCLAIMED'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def,bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MAX_AGE_UNCLAIMED'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def,bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MEDIAN_AGE_UNCLAIMED'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def,bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'AVG_CYCLE_TIME_CALDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MAX_CYCLE_TIME_CALDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MEDIAN_CYCLE_TIME_CALDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def,bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'AVG_CYCLE_TIME_BUSDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MAX_CYCLE_TIME_BUSDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

INSERT INTO bpm_d_process_group_metric (d_metric_definition_id,d_process_group_detail_id,lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt,record_end_dt)
SELECT d_metric_definition_id,d_process_group_detail_id,90,'Y','CONTROL CHART',TRUNC(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def,bpm_d_process_group_detail dtl,bpm_d_process_definition pd, bpm_d_process_group pg
WHERE dtl.d_process_group_id = pg.d_process_group_id
and dtl.d_process_definition_id = pd.d_process_definition_id
and def.name = 'MEDIAN_CYCLE_TIME_BUSDAYS'
and pd.process_name = 'MANAGE_WORK'
and pg.group_name = 'TASK_TYPE';

commit;