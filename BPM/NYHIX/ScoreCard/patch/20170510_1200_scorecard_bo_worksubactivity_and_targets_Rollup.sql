CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office_Rollup

AS

BEGIN
--20170515 - NYHIX-30763, NYHIX-28053 - Made code change to handle decommissioning of events in pp_bo_event_target_lkup  
  
delete dp_scorecard.SC_SUMMARY_BO_ROLLUP where 1=1;
commit;


---Rollup MONTHLY
--Total Logged
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Logged', nvl(TOTAL_LOGGED,0)
From
(
select
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group,
sum(a24.TOTAL_LOGGED) as TOTAL_LOGGED
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id) 
--and a11.event_id not in (1410,1413,1411,1412,1456)
and a12.worksubactivity_flag='N'
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id) 
--and  a11.event_id in (1410,1413,1411,1412,1456)
and a12.worksubactivity_flag='Y'
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) a24
join dp_scorecard.scorecard_hierarchy_sv a25 on a25.staff_staff_id=a24.STAFF_ID
group by
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group
);
commit;

--Rollup MONTLHY
--Total Activity Time in Hrs
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Total Activity Time', HANDLE_TIME_IN_HOURS
From
(
select
  --a11.STAFF_ID,
  a24.supervisor_staff_id,
  a24.department,
  a24.building,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from dp_scorecard.scorecard_hierarchy_sv a24
  join maxdat.PP_WFM_ACTUALS_SV  a11 on a11.staff_id=a24.staff_staff_id
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id)  
group by
  a24.supervisor_staff_id,
  a24.department,
  a24.building,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
);
commit;


---Rollup MONTHLY
--Staff Count
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 1, 'Staff Count', nvl(STAFF_COUNT,0)
From
(
select distinct
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group,
COUNT(distinct a24.STAFF_ID) over(partition by a25.supervisor_staff_id, a25.department, a25.building, a24.dates_month_num, a24.dates_year, a24.scorecard_group) as STAFF_COUNT
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id)  
and a12.worksubactivity_flag='N'
--and a11.event_id not in (1410,1413,1411,1412,1456)
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id)  
and a12.worksubactivity_flag='Y'
--and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) a24
join dp_scorecard.scorecard_hierarchy_sv a25 on a25.staff_staff_id=a24.STAFF_ID
);
commit;



--Rollup MONTHLY
--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
with targets as
(
     select scorecard_group, target, ops_group, start_date, nvl(end_date, to_date('07/07/77','mm/dd/yy')) as end_date from
    (select distinct
           case
             when upper(scorecard_group) like 'OTHER%' then
              'All Other Tasks'
             else
              scorecard_group
           end as scorecard_group,
           target,
           ops_group,
           start_date,
           end_date
      from maxdat.PP_BO_EVENT_TARGET_LKUP
     where SCORECARD_FLAG = 'Y')
)
select supervisor_staff_id, department, building, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.supervisor_staff_id, tl.department, tl.building, tl.dates_month_num, tl.dates_year, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS,
tgt.target,
((tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS) / tgt.target) as metric
from
(
select
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group,
sum(a24.TOTAL_LOGGED) as TOTAL_LOGGED
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id)  
and a12.worksubactivity_flag='N'
--and a11.event_id not in (1410,1413,1411,1412,1456)
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
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id)  
and a12.worksubactivity_flag='Y'
--and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) a24
join dp_scorecard.scorecard_hierarchy_sv a25 on a25.staff_staff_id=a24.STAFF_ID
group by
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group
) tl
join
(
select
  a24.supervisor_staff_id,
  a24.department,
  a24.building,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM') as dates_month_num,
  to_char(TRUNC(a11.TASK_END), 'Month YYYY') as dates_year,
  a12.scorecard_group,
  sum((a11.HANDLE_TIME / 60.0))  as HANDLE_TIME_IN_HOURS
from dp_scorecard.scorecard_hierarchy_sv a24
  join maxdat.PP_WFM_ACTUALS_SV  a11 on a11.staff_id=a24.staff_staff_id
  join  (select event_id,
       case
         when upper(scorecard_group) like 'OTHER%' then
          'All Other Tasks'
         else
          scorecard_group
       end as scorecard_group,
       start_date,
       coalesce(end_date, trunc(sysdate+1)) as end_date,
       worksubactivity_flag
  from maxdat.PP_BO_EVENT_TARGET_LKUP/*_SV*/
 where SCORECARD_FLAG = 'Y' /*and (end_date is null or trunc(sysdate) <= trunc(end_date))*/)  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and (trunc(a11.TASK_START) >= trunc(a12.start_date) and trunc(a11.TASK_START) <= trunc(a12.end_date) and a11.event_id=a12.event_id) 
group by
  a24.supervisor_staff_id,
  a24.department,
  a24.building,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) ht on tl.supervisor_staff_id=ht.supervisor_staff_id and tl.department=ht.department and tl.building=ht.building and tl.dates_month_num=ht.dates_month_num and tl.scorecard_group=ht.scorecard_group
join targets tgt on tgt.scorecard_group=ht.scorecard_group
and tl.dates_month_num between to_char(TRUNC(tgt.start_date), 'YYYYMM') AND to_char(TRUNC(tgt.end_date), 'YYYYMM')
);

commit;

--Rollup MONTHLY
--Rollup Overall Numerator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building,  dates_month_num, dates_year, 3, 'Overall Numerator',  1, NULL, numerator
from
(
select supervisor_staff_id, department, building, dates_month_num, dates_year,
sum(subtotal) as numerator
from
(
select tp.supervisor_staff_id,
       tp.department,
       tp.building,
       tp.dates_month_num,
       tp.dates_year,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select supervisor_staff_id, department, building, dates_month_num, dates_year, event_name, metric as task_prod_metric
          from dp_scorecard.SC_SUMMARY_BO_ROLLUP
         where event_subname = 'Task Production') tp
  join (select supervisor_staff_id, department, building, dates_month_num, dates_year, event_name, metric as total_act_time_metric
          from dp_scorecard.SC_SUMMARY_BO_ROLLUP
         where event_subname = 'Total Activity Time') tat
    on tp.supervisor_staff_id = tat.supervisor_staff_id
   and tp.department = tat.department
   and tp.building = tat.building
   and tp.dates_month_num = tat.dates_month_num
   and tp.event_name = tat.event_name
)
group by supervisor_staff_id, department, building, dates_month_num, dates_year
);
commit;


--Rollup MONTHLY
--Rollup Overall Denominator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building,  dates_month_num, dates_year, 3, 'Overall Denominator',  1, NULL, denominator
from
(
select supervisor_staff_id, department, building, dates_month_num, dates_year,
sum(total_act_time_metric) as denominator
from
(
select tp.supervisor_staff_id,
       tp.department,
       tp.building,
       tp.dates_month_num,
       tp.dates_year,
       tp.event_name,
       tp.task_prod_metric,
       tat.total_act_time_metric,
       (tp.task_prod_metric * tat.total_act_time_metric) as subtotal
  from (select supervisor_staff_id, department, building, dates_month_num, dates_year, event_name, metric as task_prod_metric
          from dp_scorecard.SC_SUMMARY_BO_ROLLUP
         where event_subname = 'Task Production') tp
  join (select supervisor_staff_id, department, building, dates_month_num, dates_year, event_name, metric as total_act_time_metric
          from dp_scorecard.SC_SUMMARY_BO_ROLLUP
         where event_subname = 'Total Activity Time') tat
    on tp.supervisor_staff_id = tat.supervisor_staff_id
   and tp.department = tat.department
   and tp.building = tat.building
   and tp.dates_month_num = tat.dates_month_num
   and tp.event_name = tat.event_name
)
group by supervisor_staff_id, department, building, dates_month_num, dates_year
);
commit;








--Rollup MONTHLY 
--Rollup Adherence Numerator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
select distinct supervisor_staff_id, department, building,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO_ROLLUP
  order by supervisor_staff_id, department, building,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
 SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as DAILY_PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
  JOIN
  (
      SELECT DISTINCT EVENT_ID, NAME, EE_ADHERENCE
      FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
      WHERE EE_ADHERENCE = 'Y'
  ) X
  ON A.EVENT_ID = X.EVENT_ID
WHERE TRUNC(TASK_START) = TRUNC(TASK_END) and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
GROUP BY STAFF_ID, TRUNC(TASK_START)

),
SCHEDULED_DAILY as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
from PRODUCTIVITIY_DAILY p
left outer join SCHEDULED_DAILY s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
  FROM COMBINED_DAILY
 WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
 AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
 GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_TOTAL_MIN_SCHED) as TOTAL_MIN_SCHED
  FROM COMBINED_DAILY
 WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
 AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
 GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
select h.supervisor_staff_id, h.department, h.building, p.dates_month_num,
sum(p.PRODUCTIVITIY) as numerator
from
dp_scorecard.scorecard_hierarchy_sv h
JOIN PRODUCTIVITIY p on h.staff_staff_id=p.STAFF_ID
LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
group by h.supervisor_staff_id, h.department, h.building, p.dates_month_num
)
select am.supervisor_staff_id, am.department, am.building, am.dates_month_num, am.dates_year, 3, 'Monthly Adherence Numerator',  1, NULL, numerator --monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.supervisor_staff_id=c.supervisor_staff_id
and am.department=c.department
and am.building=c.building
and am.dates_month_num=c.dates_month_num;


commit;

--Rollup MONTHLY 
--Rollup Adherence Denominator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
select distinct supervisor_staff_id, department, building,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO_ROLLUP
  order by supervisor_staff_id, department, building,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
 SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as DAILY_PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
  JOIN
  (
      SELECT DISTINCT EVENT_ID, NAME, EE_ADHERENCE
      FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
      WHERE EE_ADHERENCE = 'Y'
  ) X
  ON A.EVENT_ID = X.EVENT_ID
WHERE TRUNC(TASK_START) = TRUNC(TASK_END) and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
GROUP BY STAFF_ID, TRUNC(TASK_START)

),
SCHEDULED_DAILY as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
 GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED_DAILY as
(
select p.staff_id, p.TASK_START, p.DAILY_PRODUCTIVITIY, s.DAILY_TOTAL_MIN_SCHED
from PRODUCTIVITIY_DAILY p
left outer join SCHEDULED_DAILY s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_PRODUCTIVITIY) as PRODUCTIVITIY
  FROM COMBINED_DAILY
 WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
 AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
 GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(DAILY_TOTAL_MIN_SCHED) as TOTAL_MIN_SCHED
  FROM COMBINED_DAILY
 WHERE DAILY_PRODUCTIVITIY IS NOT NULL AND DAILY_PRODUCTIVITIY > 0
 AND DAILY_TOTAL_MIN_SCHED IS NOT NULL AND DAILY_TOTAL_MIN_SCHED > 0
 GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
COMBINED as
(
select h.supervisor_staff_id, h.department, h.building, p.dates_month_num,
sum(s.TOTAL_MIN_SCHED) as denominator
from
dp_scorecard.scorecard_hierarchy_sv h
JOIN PRODUCTIVITIY p on h.staff_staff_id=p.STAFF_ID
LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
group by h.supervisor_staff_id, h.department, h.building, p.dates_month_num
)
select am.supervisor_staff_id, am.department, am.building, am.dates_month_num, am.dates_year, 3, 'Monthly Adherence Denominator',  1, NULL, denominator --monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.supervisor_staff_id=c.supervisor_staff_id
and am.department=c.department
and am.building=c.building
and am.dates_month_num=c.dates_month_num;

commit;


END;

/
