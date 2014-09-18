INSERT INTO bpm_d_process_group_metric(d_metric_definition_id,d_process_group_detail_id, lower_specification_limit,calculate_control_chart_ind,trend_indicator_calculation,record_eff_dt, record_end_dt)
SELECT d_metric_definition_id, d_process_group_detail_id,90,'Y','CONTROL CHART',trunc(sysdate),to_date('12/31/2099','mm/dd/yyyy')
FROM bpm_d_metric_definition def, bpm_d_process_group_detail dtl
where def.name = 'TASK_COMPLETED_TIMELY'
and dtl.name in(select task_type from bpm_d_ops_group_task where ops_group = 'Research');

commit;