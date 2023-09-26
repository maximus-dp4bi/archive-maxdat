create task task_pop_aggregate_tables warehouse = 'MAXEB_DP4BI_PAIEB_UAT_LOAD_WH' schedule = 'USING CRON 0 1 * * * America/Los_Angeles' as call SP_POPULATE_AGGREGATES_TABLE();
alter task task_pop_aggregate_tables resume;
--changed schedule
alter task task_pop_aggregate_tables suspend;
alter task task_pop_aggregate_tables set schedule ='USING CRON 30 8 * * * America/Los_Angeles';
alter task task_pop_aggregate_tables resume;