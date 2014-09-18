

delete from f_metric
where d_reporting_period_id in (
  select d_reporting_period_id
  from d_reporting_period
  where end_date > to_date('01-DEC-2013 00:00:00', 'DD-MON-YYYY HH24:MI:SS')
);
