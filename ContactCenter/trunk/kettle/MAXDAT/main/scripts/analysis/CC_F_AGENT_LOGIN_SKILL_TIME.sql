



select 
/* 
  d_date
  , sum(case when percent_diff > 2 then 1 else 0 end) as exceeds_threshold 
  , sum(case when percent_diff < 2 then 1 else 0 end) within_threshold
  , count(*)
*/
  d_date, login_id, last_name, job_title, group_name, login_seconds, calc_seconds, percent_diff -- count(*) 
from ( 
  select d_date, login_id, last_name, job_title, group_name, login_seconds, calc_seconds, abs((login_seconds-calc_seconds)/login_seconds*100) percent_diff from (
    select 
      d_date
      , login_id
      , login_seconds
      , INTERNAL_SECONDS + EXTERNAL_SECONDS + HOLD_SECONDS + RING_SECONDS + TALK_SECONDS + WRAP_SECONDS + IDLE_SECONDS + NOT_READY_SECONDS + TALK_RESERVE_SECONDS + PREDICTIVE_TALK_SECONDS + PREVIEW_TALK_SECONDS as CALC_SECONDS
      , da.last_name, da.job_title, gr.group_name
    from 
      cc_f_agent_by_date f
      inner join cc_d_agent da on f.d_agent_id = da.d_agent_id
      inner join cc_d_dates dd on f.d_date_id = dd.d_date_id
      inner join cc_d_group gr on f.d_group_id = gr.d_group_id
    where 
      login_seconds > 60
  )
)
where percent_diff > 2
and d_date >= '01-NOV-2013'
--group by d_date
order by d_date;


select * from cc_c_filter
where filter_type = 'ACD_SKILL_GROUP_INC'
and value in
(
5000
,5196
,5204
,15894
,15895
,18092
);
