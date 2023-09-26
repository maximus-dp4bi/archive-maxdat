create or replace view emrs_f_homeless_cnt_sv as
select report_date, sum(no_to_yes_count) no_to_yes_count, sum(yes_to_no_count) yes_to_no_count, sum(no_to_no_count) no_to_no_count
from
(
select trunc(create_ts) report_date
, sum(case when context like '%NO%YES' then 1 else 0 end) no_to_yes_count
, sum(case when context like '%YES%NO' then 1 else 0 end) yes_to_no_count
, sum(case when context like '%NO%NO' then 1 else 0 end) no_to_no_count
from eb.event e
 where event_type_cd = 'HOMELESSINDICATOR_UPDATED'
 and (context like '%NO%YES%' or context like '%YES%NO%' or context like '%NO%NO%')
group by trunc(create_ts)
union
select d_date report_date, 0 no_to_yes_count, 0 yes_to_no_count, 0 no_to_no_count
from maxdat_support.d_dates d
where d.d_date >= to_date('1/1/2023','mm/dd/yyyy')
)
group by report_date
;

GRANT SELECT ON MAXDAT_SUPPORT.emrs_f_homeless_cnt_sv TO MAXDAT_REPORTS;


