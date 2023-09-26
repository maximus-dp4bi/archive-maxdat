-- DecisionPoint - NICE WFM
-- Generate list of all 60 minutes of an hour - values 0 to 59.
-- Build MicroStrategy cube from NICE WFM view.

use nice_wfm_integration
go

create view D_MINUTE_SV as
with 
  n1(number) as
    (select 1 union all 
     select 1 union all
     select 1 union all 
     select 1 union all
     select 1 union all 
     select 1 union all
     select 1 union all 
     select 1 union all
     select 1 union all 
     select 1),
  n2(number) as
     (select 1 from n1 a, n1 b) /* for <= 100 rows */
select top(60) row_number() over (order by (select null)) - 1 as D_MINUTE from n2;
