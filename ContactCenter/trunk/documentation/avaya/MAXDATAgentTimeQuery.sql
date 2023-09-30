
with t as (       
  select 
    d.d_date
    , ag.login_id
    , handle_calls_count
    , a.login_seconds/60 as log_mins
    , (
        TALK_SECONDS 
        + HOLD_SECONDS
        + NOT_READY_SECONDS 
        + IDLE_SECONDS 
        + BREAK_TIME
        + CONSULTATION_TIME
        + INTERNAL_SECONDS 
        + EXTERNAL_SECONDS 
        + RING_SECONDS 
        -- + WRAP_SECONDS -- WRAP TIME IS NOT INCLUDED IN THE FORMULA PROVIDED BY CHRIS WILMERS
        + WALKAWAY_TIME
      )/60 as act_mins
      , NOT_READY_SECONDS/60 as NOT_READY_MINS
      , INTERNAL_SECONDS/60 as INTERNAL_MINS
      , EXTERNAL_SECONDS/60 as EXTERNAL_MINS 
    -- , round((a.login_seconds/60),2) - round ((INTERNAL_SECONDS + EXTERNAL_SECONDS + HOLD_SECONDS + RING_SECONDS + TALK_SECONDS + WRAP_SECONDS + IDLE_SECONDS + NOT_READY_SECONDS + TALK_RESERVE_SECONDS + PREDICTIVE_TALK_SECONDS + PREVIEW_TALK_SECONDS)/60,2) as diff_in_mins 
  from   cc_f_agent_by_date  a,
         cc_d_dates          d,
         cc_d_agent          ag,
         cc_d_group          gp
  where  a.d_date_id = d.d_date_id
  and    a.d_agent_id = ag.d_agent_id
  and    a.d_group_id = gp.d_group_id
  and    d.d_date = '14-JUL-2014' --between '01-MAR-2014' and '15-MAR-2014'
), t2 as ( 
  select 
    d_date
    , login_id
    , handle_calls_count
    , log_mins
    , act_mins
    , abs(log_mins - act_mins) delta
    , abs(round(100*(log_mins-act_mins)/log_mins, 2)) as prct_var
    , internal_mins
    , external_mins
  from t
)
select -- *
  d_date
  , login_id
  , round(sum(log_mins),2) logged_in_mins
  , round(sum(act_mins),2) activity_mins
  , round(sum(delta),2) delta
  , round(abs(100*(sum(delta))/sum(log_mins)),2) prct_var
  , round(sum(internal_mins),2) internal_mins
  , round(sum(external_mins),2) external_mins
  , case when (round(sum(delta),2) < 2) then 1 else 0 end good
  , case when (round(sum(delta),2) > 2) then 1 else 0 end bad
--  , sum(handle_calls_count)
from t2
-- where d_date = '03-MAR-2014'
group by 
  d_date
   , login_id
having round(abs(100*(sum(delta))/sum(log_mins)),2) > 2
-- having round(sum(delta),2) < 2
order by prct_var desc

;

-- 698