
merge into cc_d_agent a
using (
  with hire_dates as (
    select 
      d_agent_id
      , hire_date
      , lead(hire_date, 1) over(order by login_id, record_eff_dt) next_hire_date
    from cc_d_agent
    where login_id 
    in ( 
      select login_id 
      from cc_d_agent 
      where hire_date is null
    )
  ) 
  select * 
  from hire_dates
  where hire_date is null
  and next_hire_date is not null
) t 
on (a.d_agent_id = t.d_agent_id)
when matched then update 
  set a.hire_date = t.next_hire_date
;


INSERT INTO CC_L_PATCH_LOG ( PATCH_VERSION , SCRIPT_SEQUENCE , SCRIPT_NAME)
VALUES ('1.10.0','008','008_UPDATE_CC_D_AGENT_NULL_HIRE_DATES');

COMMIT;