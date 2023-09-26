alter session set current_schema = folsom_shared_cc;

update cc_f_actuals_queue_interval
set 
calls_abandoned_period_1 = 0
, calls_abandoned_period_2 = 0
, calls_abandoned_period_3 = 0
, calls_abandoned_period_4 = 0
, calls_abandoned_period_5 = 0
, calls_abandoned_period_6 = 0
, calls_abandoned_period_7 = 0
, calls_abandoned_period_8 = 0
, calls_abandoned_period_9 = 0
, calls_abandoned_period_10 = 0
where d_date_id in (select d_date_id from cc_d_dates where d_date < '12-SEP-16');
--1,716,846

update cc_f_acd_queue_interval
set 
calls_abandoned_period_1 = 0
, calls_abandoned_period_2 = 0
, calls_abandoned_period_3 = 0
, calls_abandoned_period_4 = 0
, calls_abandoned_period_5 = 0
, calls_abandoned_period_6 = 0
, calls_abandoned_period_7 = 0
, calls_abandoned_period_8 = 0
, calls_abandoned_period_9 = 0
, calls_abandoned_period_10 = 0
where d_date_id in (select d_date_id from cc_d_dates where d_date < '12-SEP-16');
--1,716,846

commit;