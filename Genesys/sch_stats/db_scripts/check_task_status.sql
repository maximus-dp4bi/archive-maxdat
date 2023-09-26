select *
from table(information_schema.task_history(
scheduled_time_range_start=>dateadd('hour',-10,current_timestamp()),
result_limit => 10,
task_name=>'sch_stats_load_hist_tbl'));