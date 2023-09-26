#######UAT############
use database PUREINSIGHTS_UAT;
use schema SCH_STATS;

create or replace task sch_stats_load_hist_tbl
  warehouse = PUREINSIGHTS_UAT_LOAD_WH
  schedule = 'USING CRON 10 * * * * UTC'
as
  call sch_stats.sp_populate_sch_history_table();

alter task sch_stats_load_hist_tbl resume;