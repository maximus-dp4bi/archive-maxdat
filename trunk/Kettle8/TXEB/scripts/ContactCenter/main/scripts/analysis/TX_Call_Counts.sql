select 
  c.d_date
  , queue_contacts_offered
  , queue_contacts_handled
  , agent_contacts_handled
  , agent_contacts_handled - queue_contacts_handled diff
  , 100*(agent_contacts_handled - queue_contacts_handled)/agent_contacts_handled percent_diff
from (
  select d_date, sum(contacts_handled) queue_contacts_handled, sum(contacts_offered) queue_contacts_offered
  from cc_f_actuals_queue_interval f
  inner join cc_d_dates d on f.d_date_id = d.d_date_id
  group by d_date
) c left outer join (
  select d_date, sum(handle_calls_count) agent_contacts_handled
  from cc_f_agent_by_date f
  inner join cc_d_dates d on f.d_date_id = d.d_date_id
  group by d_date
) a on c.d_date = a.d_date
order by 
  c.d_date desc
;