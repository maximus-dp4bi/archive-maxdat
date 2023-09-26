update ineo_queue_daily_summary_history
set date = cast('01/20/2023' as date)
where filename in('INEOQueueDailySummary01202023_20230126180030');

update ineo_queue_daily_summary_history
set date = cast('01/23/2023' as date)
where filename in('INEOQueueDailySummary01232023_20230126180026');

update ineo_queue_daily_summary_history
set date = cast('02/16/2023' as date)
where filename in('INEOQueueDailySummary02162023_20230217100434');