create or replace Procedure              Insert_Back_Office

AS

BEGIN
delete dp_scorecard.sc_production_bo where 1=1;
delete dp_scorecard.SC_SUMMARY_BO where 1=1;
commit;

--Total Logged
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Logged', nvl(TOTAL_LOGGED,0)
From
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group,a11.event_id
union
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
 sum(work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
);
commit;

--Total Activity Time in Hrs
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 2, 'Total Activity Time', HANDLE_TIME_IN_HOURS
From
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
)
--where staff_id=6962;
commit;

--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.STAFF_ID, tl.end_date, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS ,tgt.target, (tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS / tgt.target) as metric
from (
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group,a11.event_id
union
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
 sum(work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
) tl
join
(
select
  a11.STAFF_ID,
  trunc(a11.TASK_END) as end_date,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, 0), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.end_date=ht.end_date and tl.scorecard_group=ht.scorecard_group
join
(
   select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);
commit;

--Daily PRODUCTION
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates, 3, 'Daily Production',  1, NULL, daily_production_metric
from
(
select staff_id, dates, sum(subtotal) as numerator, sum(total_act_time_metric) as denominator,
sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates, event_name, metric as task_prod_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Task Production') tp
  join (select staff_id, dates, event_name, metric as total_act_time_metric
          from dp_scorecard.sc_production_bo
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates = tat.dates
   and tp.event_name = tat.event_name
)
group by staff_id, dates
);

commit;



---MONTHLY
--Total Logged
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Logged', nvl(TOTAL_LOGGED,0)
From
(
 select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
 union
  select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum(a11.work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
/*select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group*/
);
commit;

--MONTLHY
--Total Activity Time in Hrs
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Activity Time', HANDLE_TIME_IN_HOURS
From
(
select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
);
commit;

--MONTHLY
--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.STAFF_ID, tl.dates_month_num, tl.dates_year, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS ,tgt.target, (tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS / tgt.target) as metric
from
(
 select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and a11.event_id not in (1410,1413,1411,1412,1172,1456)
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
 union
  select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum(a11.work_subactivity) as total_logged
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
and  a11.event_id in (1410,1413,1411,1412,1172,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
/*select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  count(a11.RT_ACTUALS_ID)  as TOTAL_LOGGED
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group*/
) tl
join
(
select
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from  maxdat.PP_WFM_ACTUALS_SV  a11
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  a11.TASK_END is not null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.dates_month_num=ht.dates_month_num and tl.scorecard_group=ht.scorecard_group
join
(
   select scorecard_group, target from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);
commit;

--MONTHLY
--Daily PRODUCTION
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select staff_id,  dates_month_num, dates_year, 3, 'Overall',  1, NULL, daily_production_metric
from
(
select staff_id,  dates_month_num, dates_year, sum(subtotal) as numerator, sum(total_act_time_metric) as denominator,
sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
from
(
select tp.staff_id,
       tp.dates_month_num,
       tp.dates_year,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select staff_id, dates_month_num, dates_year, event_name, metric as task_prod_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Task Production') tp
  join (select staff_id, dates_month_num, dates_year, event_name, metric as total_act_time_metric
          from dp_scorecard.SC_SUMMARY_BO
         where event_subname = 'Total Activity Time') tat
    on tp.staff_id = tat.staff_id
   and tp.dates_month_num = tat.dates_month_num
   and tp.event_name = tat.event_name
)
group by staff_id, dates_month_num, dates_year
);
commit;
END;
/