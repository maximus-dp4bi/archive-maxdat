/*
delete from cc_s_acd_agent_activity;
delete from cc_s_acd_interval;
delete from cc_s_call_detail;
DELETE FROM CC_S_AGENT where agent_id>0;
delete from cc_s_contact_queue where contact_queue_id>0;
delete from cc_s_ivr_interval;
delete from cc_s_ivr_self_service_path;
delete from cc_s_ivr_self_service_usage;
delete from cc_d_ivr_self_service_path;
delete from cc_f_actuals_ivr_interval;
delete from cc_f_actuals_queue_interval;
delete from cc_f_agent_activity_by_date;
delete from cc_f_agent_by_date;
delete from cc_f_forecast_interval;
delete from cc_f_ivr_self_service_usage;
commit;
*/


variable :var_date1 VARCHAR;
exec :var_date1 := '01-OCT-2013';

--select count(*) 
delete
from cc_s_acd_agent_activity
where agent_calls_dt >  to_date(:var_date1);

--select count(*)
delete
from cc_s_acd_interval
where interval_date >  to_date(:var_date1);

--select count(*)
delete 
from cc_s_call_detail
where trunc(call_date) >  to_date(:var_date1);

--select count(*)
delete 
from cc_s_ivr_interval
where interval_date >  to_date(:var_date1);

--select count(*)
delete 
from cc_s_ivr_self_service_usage ssu
where interval_id in (
  select interval_id
  from cc_s_interval
  where trunc(interval_start_date) >  to_date(:var_date1)
);

--select count(*) 
delete 
from cc_f_actuals_ivr_interval
where d_date_id in
(
  select d_date_id
  from cc_d_dates
  where d_date >  to_date(:var_date1)
);

--select count(*) 
delete 
from cc_f_actuals_queue_interval
where d_date_id in
(
  select d_date_id
  from cc_d_dates
  where d_date >  to_date(:var_date1)
);

--select count(*) 
delete 
from cc_f_agent_activity_by_date
where d_date_id in
(
  select d_date_id
  from cc_d_dates
  where d_date >  to_date(:var_date1)
);

--select count(*) 
delete 
from cc_f_agent_by_date
where d_date_id in
(
  select d_date_id
  from cc_d_dates
  where d_date >  to_date(:var_date1)
);

--select count(*) 
delete 
from cc_f_ivr_self_service_usage
where d_date_id in
(
  select d_date_id
  from cc_d_dates
  where d_date > to_date(:var_date1)
);

