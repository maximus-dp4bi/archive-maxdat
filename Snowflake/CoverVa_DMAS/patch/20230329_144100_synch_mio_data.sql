delete from intake_case_pool t
where not exists(select 1 from intake_case_pool_sync d where t.id = d.id  );
drop table intake_case_pool_sync;

delete from safe_his t --21
where not exists(select 1 from safe_his_sync d where t.id = d.id);
drop table safe_his_sync;

delete from safe t --3
where not exists(select 1 from safe_sync d where t.employee_id = d.employee_id);
drop table safe_sync;

delete from safe_manual_cases t --13
where not exists(select 1 from safe_manual_cases_sync d where t.id = d.id);
drop table safe_manual_cases_sync;

delete from etl_log t 
where not exists(select 1 from etl_log_sync d where t.id = d.id)
and t.id <= 78725;
drop table etl_log_sync;

delete from archives_rpt_current_worked_cases t --2440
where not exists(select 1 from archives_rpt_current_worked_cases_sync d where t.id = d.id);
drop table archives_rpt_current_worked_cases_sync;

delete from rpt_daily_clock_rollup t --367
where not exists(select 1 from rpt_daily_clock_rollup_sync d where t.emp_id = d.emp_id and t.clock_date = d.clock_date);
drop table rpt_daily_clock_rollup_sync;

delete from rpt_trending_completed_open_cases_by_day t --59
where not exists(select 1 from rpt_trending_completed_open_cases_by_day_sync d where t.id = d.id);
drop table rpt_trending_completed_open_cases_by_day_sync;

delete from clock_punches t --2499
where not exists(select 1 from clock_punches_sync d where t.id = d.id)
and t.id <= 552053;
drop table clock_punches_sync;

delete from intake_case_pool_log t --431
where not exists(select 1 from intake_case_pool_log_sync d where t.id = d.id)
and t.id <= 515301;
drop table intake_case_pool_log_sync;

delete from page_log t
where not exists(select 1 from page_log_sync d where t.id = d.id)
and t.id <= 534809;
drop table page_log_sync;

delete from rpt_daily_dispositions t 
where not exists(select 1 from rpt_daily_dispositions_sync d where t.id = d.id)
and t.id <= 1728376;
drop table rpt_daily_dispositions_sync;

delete from case_pool_log t 
where not exists(select 1 from case_pool_log_sync d where t.id = d.id)
and t.id <= 4777978;
drop table case_pool_log_sync;