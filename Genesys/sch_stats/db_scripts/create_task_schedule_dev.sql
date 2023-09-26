#######DEV############
use database PUREINSIGHTS_DEV;
use schema SCH_STATS;

create or replace task sch_stats_load_hist_tbl
  warehouse = PUREINSIGHTS_DEV_LOAD_WH
  schedule = 'USING CRON 10 * * * * UTC'
as
  call sch_stats.sp_populate_sch_history_table();

alter task sch_stats_load_hist_tbl resume;