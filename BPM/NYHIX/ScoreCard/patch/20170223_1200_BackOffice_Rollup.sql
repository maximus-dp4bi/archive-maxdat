declare  c int;
begin
   select count(*) into c from user_tables where table_name ='SC_SUMMARY_BO_ROLLUP';
   if c = 1 then
      execute immediate 'drop table SC_SUMMARY_BO_ROLLUP cascade constraints';
   end if;
end;
/

create table DP_SCORECARD.SC_SUMMARY_BO_ROLLUP
(
  supervisor_staff_id           NUMBER,
  department                    VARCHAR2(50),
  building                      VARCHAR2(100),
  dates_month_num               VARCHAR2(6),
  dates_year                    VARCHAR2(41),
  event_name_sort               NUMBER,
  event_name                    VARCHAR2(300),
  event_subname_sort            NUMBER,
  event_subname                 VARCHAR2(300),
  metric                        NUMBER
);

CREATE INDEX SC_SUMMARY_BO_ROLLUP_NDX
    ON DP_SCORECARD.SC_SUMMARY_BO_ROLLUP (supervisor_staff_id)
    TABLESPACE MAXDAT_INDX;

commit;

grant select on DP_SCORECARD.SC_SUMMARY_BO_ROLLUP to MAXDAT_READ_ONLY;
grant select on DP_SCORECARD.SC_SUMMARY_BO_ROLLUP to MAXDAT;
--select * from DP_SCORECARD.SC_SUMMARY_BO_ROLLUP 


CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office_Rollup

AS

BEGIN
delete dp_scorecard.SC_SUMMARY_BO_ROLLUP where 1=1;
commit;


---MONTHLY
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
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and a11.event_id not in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and  a11.event_id in (1410,1413,1411,1412,1456)
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

--MONTLHY
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
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
group by
  a24.supervisor_staff_id,
  a24.department,
  a24.building,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
);
commit;


---MONTHLY
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
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and a11.event_id not in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) a24
join dp_scorecard.scorecard_hierarchy_sv a25 on a25.staff_staff_id=a24.STAFF_ID
order by--group by
a25.supervisor_staff_id,
a25.department,
a25.building,
a24.dates_month_num,
a24.dates_year,
a24.scorecard_group
);
commit;



--MONTHLY
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
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and a11.event_id not in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START)
and  a11.event_id in (1410,1413,1411,1412,1456)
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
       end as scorecard_group
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START)
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
--where tl.STAFF_ID in (select distinct staff_staff_id from dp_scorecard.scorecard_hierarchy_sv)
);

commit;

--MONTHLY
--Rollup Overall Numerator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building,  dates_month_num, dates_year, 3, 'Overall Numerator',  1, NULL, numerator
from
(
select supervisor_staff_id, department, building, dates_month_num, dates_year,
sum(subtotal) as numerator
--sum(total_act_time_metric) as denominator
--sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
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
--where supervisor_staff_id=1296
group by supervisor_staff_id, department, building, dates_month_num, dates_year
);
commit;


--MONTHLY
--Rollup Overall Denominator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
select supervisor_staff_id, department, building,  dates_month_num, dates_year, 3, 'Overall Denominator',  1, NULL, denominator
from
(
select supervisor_staff_id, department, building, dates_month_num, dates_year,
--sum(subtotal) as numerator
sum(total_act_time_metric) as denominator
--sum(subtotal) / sum(total_act_time_metric) as daily_production_metric
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





--MONTHLY Rollup Adherence Numerator
insert into dp_scorecard.SC_SUMMARY_BO_ROLLUP
  (supervisor_staff_id, department, building, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
select distinct supervisor_staff_id, department, building,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO_ROLLUP
  --where supervisor_staff_id=1296
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
--(sum(p.PRODUCTIVITIY)/sum(s.TOTAL_MIN_SCHED)) as monthly_adherence_metric
sum(p.PRODUCTIVITIY) as numerator
--sum(s.TOTAL_MIN_SCHED) as denominator
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

--MONTHLY Rollup Adherence Denominator
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
--(sum(p.PRODUCTIVITIY)/sum(s.TOTAL_MIN_SCHED)) as monthly_adherence_metric
--sum(p.PRODUCTIVITIY) as numerator
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

GRANT EXECUTE ON INSERT_BACK_OFFICE_ROLLUP TO maxdat;
GRANT EXECUTE ON INSERT_BACK_OFFICE_ROLLUP TO maxdat_read_only;

create or replace view dp_scorecard.scorecard_prod_bo_rollup_sv as
with total_logged as
(
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as total_logged, 0 AS activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Logged'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, metric as activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Activity Time'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, 0 AS activity_time, metric as staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Staff Count'
),
targets as
(
select scorecard_group, target, ops_group, start_date, end_date from
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
select DISTINCT
       a10.supervisor_staff_id, 
       a10.department, 
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       sum(a10.total_logged) as total_logged,
       sum(a10.activity_time) as activity_time,
       sum(a10.staff_count) as staff_count,
       (to_char(trunc((sum(a10.activity_time) * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((sum(a10.activity_time) * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((sum(a10.activity_time) * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as ops_group
  from total_logged a10
  GROUP BY        a10.supervisor_staff_id, 
       a10.department, 
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort,
       a10.event_name;

GRANT select on DP_SCORECARD.scorecard_prod_bo_rollup_sv to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.scorecard_prod_bo_rollup_sv to MAXDAT; 

commit;

create or replace view dp_scorecard.scorecard_prod_dp_bo_rollup_sv as
with overall as
(
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, 
'Overall >= 100%' as event_name, event_name_sort, metric as overall_numerator, 0 as overall_denominator from dp_scorecard.sc_summary_bo_rollup
where event_name='Overall Numerator'
union
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, 
'Overall >= 100%' as event_name, event_name_sort, 0 as overall_numerator, metric as overall_denominator from dp_scorecard.sc_summary_bo_rollup
where event_name='Overall Denominator'
union
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, 
'Monthly Adherence' as event_name, event_name_sort, metric as overall_numerator, 0 as overall_denominator from dp_scorecard.sc_summary_bo_rollup
where event_name='Monthly Adherence Numerator'
union
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, 
'Monthly Adherence' as event_name, event_name_sort, 0 as overall_numerator, metric as overall_denominator from dp_scorecard.sc_summary_bo_rollup
where event_name='Monthly Adherence Denominator'
)
select supervisor_staff_id, department, building, month_id, month_name, 
event_name, event_name_sort,sum(overall_numerator) as overall_numerator, sum(overall_denominator) as overall_denominator 
from overall
group by supervisor_staff_id, department, building, month_id, month_name, 
event_name, event_name_sort;

GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_rollup_sv to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_rollup_sv to MAXDAT; 

commit;


---
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_QUALITY_BO_RU_SV AS
with just_months as
(
      SELECT
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'MM/DD/YYYY') as dates,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month') as dates_month,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'YYYYMM') as dates_month_num,
      to_char(add_months (TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM'), 1*Level -1), 'Month YYYY') as dates_year,
      0 as avg_qc_score,
      0  as qcs_performed,
      0 as qcs_remaining,
      0 as sum_qc_score,
      0 as count_qc_score
    FROM Dual
    CONNECT BY Level <= MONTHS_BETWEEN(trunc(SYSDATE), TRUNC (ADD_MONTHS (SYSDATE, -11), 'MM')) + 1
),
quality_by_month as
(
SELECT distinct h.supervisor_staff_id,
       h.department,
       h.building,
       dates_month_num,
       dates_year,
       avg(avg_qc_score) over (partition by h.supervisor_staff_id, h.department, h.building, dates_month_num) as avg_qc_score,
       sum(qcs_performed) over (partition by h.supervisor_staff_id, h.department, h.building, dates_month_num) as qcs_performed,
       sum(qcs_remaining) over (partition by h.supervisor_staff_id, h.department, h.building, dates_month_num) as qcs_remaining,
       sum(sum_qc_score) over (partition by h.supervisor_staff_id, h.department, h.building, dates_month_num) as sum_qc_score,
       sum(count_qc_score) over (partition by h.supervisor_staff_id, h.department, h.building, dates_month_num) as count_qc_score
  from
  (
  SELECT distinct staff_staff_id,
       staff_staff_name,
       staff_natid,
       to_char(TRUNC(EVAL_DATE), 'YYYYMM') as dates_month_num,
       to_char(TRUNC(EVAL_DATE), 'Month YYYY') as dates_year,
       avg(SCORE_TOTAL) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as avg_qc_score,
       sum(SCORE_TOTAL) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as sum_qc_score,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as count_qc_score,
       count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) as qcs_performed,
       case
         when count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM')) >= 10 then 0
           else 10 - count(*) over (partition by staff_staff_id ,to_char(TRUNC(EVAL_DATE), 'YYYYMM'))
       end as qcs_remaining
  from dp_scorecard.SCORECARD_QUALITY_SV
  ) q
  join dp_scorecard.scorecard_hierarchy_sv h on q.staff_staff_id=h.staff_staff_id
),
combined as
(
  select r.supervisor_staff_id,
         r.department,
         r.building,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed,
         r.qcs_remaining,
         r.sum_qc_score,
         r.count_qc_score
         from quality_by_month r
  union
  select r.supervisor_staff_id,
         r.department,
         r.building,
         jm.dates_month_num,
         jm.dates_year,
         jm.avg_qc_score,
         jm.qcs_performed,
         jm.qcs_remaining,
         jm.sum_qc_score,
         jm.count_qc_score
       from quality_by_month r, just_months jm
),
ranked as
(
select   supervisor_staff_id,
         department,
         building,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         qcs_remaining,
         sum_qc_score,
         count_qc_score,
         rank() over(partition by supervisor_staff_id, department, building, dates_month_num order by qcs_performed desc) as rnk
         from combined order by supervisor_staff_id, department, building, dates_month_num
),
all_columns as
(
SELECT
H.supervisor_staff_id,
H.department,
H.building,
F.SCORECARD_SCORE_TYPE,
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END AS EVAL_MONTH,
COUNT(DISTINCT A.EVALUATION_REFERENCE) AUDITS,
COUNT(DISTINCT A1.EVALUATION_REFERENCE) AUDITS_SUP_EVALED,
ROUND(AVG(A1.SCORE_TOTAL),2) QC_SCORE,
ROUND(AVG(S.SCORE_TOTAL),2) SUP_SCORE,
(ROUND(AVG(S.SCORE_TOTAL),2) - ROUND(AVG(A1.SCORE_TOTAL),2)) DEVIATION_SCORE,
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES DISPUTES,
ROUND(((COUNT(DISTINCT A.EVALUATION_REFERENCE)- X.QC_DISPUTES)/(COUNT(DISTINCT A.EVALUATION_REFERENCE))),2) NON_DISPUTE_SCORE
FROM DP_SCORECARD.ENGAGE_ACTUALS_SV A
JOIN DP_SCORECARD.ENGAGE_FORM_TYPE F ON A.EVALUATION_FORM = F.EVALUATION_FORM
JOIN DP_SCORECARD.SCORECARD_HIERARCHY_SV H ON A.EVALUATOR_ID = H.STAFF_NATID
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SUP S ON A.EVALUATION_REFERENCE = S.QC_EVALUATION_ID
LEFT JOIN DP_SCORECARD.ENGAGE_ACTUALS_SV A1 ON A1.EVALUATION_REFERENCE = S.QC_EVALUATION_ID
LEFT JOIN (
  SELECT TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM') QC_MONTH,
  AGENT_ID,
  COUNT(EVALUATION_REFERENCE) QC_EVALS,
  ROUND(AVG(SCORE_TOTAL),2) QC_EVALS_SCORE
  FROM DP_SCORECARD.ENGAGE_ACTUALS_QC_EVAL
  GROUP BY TO_CHAR(EVALUATION_DATE_TIME,'YYYYMM'), AGENT_ID) E
      ON (A.EVALUATOR_ID = E.AGENT_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = E.QC_MONTH) --CHANGEXX
LEFT JOIN (
  SELECT TO_CHAR(PT_ENTRY_DATE,'YYYYMM') ENTRY_DATE,
  H.STAFF_NATID,
  COUNT(PT_ID) QC_DISPUTES
  FROM DP_SCORECARD.SC_PERFORMANCE_TRACKER T
  LEFT JOIN DP_SCORECARD.SCORECARD_HIERARCHY_SV H ON T.STAFF_ID = H.STAFF_STAFF_ID
  LEFT JOIN DP_SCORECARD.SC_DISCUSSION_LKUP L ON L.DL_ID = T.DL_ID
  WHERE L.DISCUSSION_TOPIC = 'QC Dispute'
  GROUP BY TO_CHAR(PT_ENTRY_DATE,'YYYYMM'), H.STAFF_NATID) X
      ON (X.STAFF_NATID = A.EVALUATOR_ID AND CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END = x.ENTRY_DATE)  --CHANGE XX
WHERE F.SCORECARD_SCORE_TYPE = 'QC'
GROUP BY
H.supervisor_staff_id,
H.department,
H.building,
F.SCORECARD_SCORE_TYPE,
CASE WHEN A.CALL_DATE IS NULL THEN TO_CHAR(A.EVALUATION_DATE_TIME,'YYYYMM') ELSE TO_CHAR(A.CALL_DATE,'YYYYMM') END,
E.QC_EVALS,
E.QC_EVALS_SCORE,
X.QC_DISPUTES
),
all_columns2 as
(
SELECT
supervisor_staff_id,
department,
building,
SCORECARD_SCORE_TYPE,
EVAL_MONTH as dates_month_num ,
AUDITS,
AUDITS_SUP_EVALED,
QC_SCORE,
SUP_SCORE,
DEVIATION_SCORE,
QC_EVALS,
QC_EVALS_SCORE,
DISPUTES,
NON_DISPUTE_SCORE
FROM all_columns
),
rank_filter as
(
select   supervisor_staff_id,
         department,
         building,
         dates_month_num,
         dates_year,
         avg_qc_score,
         qcs_performed,
         qcs_remaining,
         sum_qc_score,
         count_qc_score
         from ranked where rnk=1
)
select   r.supervisor_staff_id,
         r.department,
         r.building,
         r.dates_month_num,
         r.dates_year,
         r.avg_qc_score,
         r.qcs_performed,
         r.qcs_remaining,
         r.sum_qc_score,
         r.count_qc_score,
         ac.AUDITS,
         ac.AUDITS_SUP_EVALED,
         ac.QC_SCORE,
         ac.SUP_SCORE,
         ac.DEVIATION_SCORE,
         ac.QC_EVALS,
         ac.QC_EVALS_SCORE,
         ac.DISPUTES,
         ac.NON_DISPUTE_SCORE
         from rank_filter r
         left outer join all_columns2 ac on r.supervisor_staff_id=ac.supervisor_staff_id 
         and r.department=ac.department
         and r.building=ac.building
         and r.dates_month_num=ac.dates_month_num;

GRANT select on DP_SCORECARD.SCORECARD_QUALITY_BO_RU_SV to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.SCORECARD_QUALITY_BO_RU_SV to MAXDAT; 

		 
CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_BO_ATND_QC_ROLLUP_SV AS
WITH attendance as
(
select distinct a.SUPERVISOR_STAFF_ID,
                h.department,
                h.building,
                DATES_MONTH,
                DATES_MONTH_NUM,
                DATES_YEAR,
                SUM(BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, h.department, h.building, dates_month_num) as BALANCE,
                SUM(TOTAL_BALANCE) over(partition by a.SUPERVISOR_STAFF_ID, h.department, h.building, dates_month_num) as TOTAL_BALANCE,
                --SC_ATTENDANCE_ID,
                COUNT(h.staff_staff_id) over(partition by a.SUPERVISOR_STAFF_ID, h.department, h.building, dates_month_num) as STAFF_COUNT
from dp_scorecard.scorecard_attendance_mthly_sv a
join dp_scorecard.scorecard_hierarchy_sv h on a.STAFF_STAFF_ID=h.staff_staff_id
where a.DATES_MONTH_NUM >= to_char(h.hire_date,'YYYYMM')
AND (a.DATES_MONTH_NUM <= to_char(h.termination_date,'YYYYMM')
OR H.TERMINATION_DATE IS NULL)
ORDER BY a.SUPERVISOR_STAFF_ID,
                h.department,
                h.building, DATES_MONTH_NUM
),
QC_metrics AS
(
select distinct supervisor_staff_id,
                department,
                building,
                dates_month_num,
                dates_year,
                avg_qc_score,
                qcs_performed,
                qcs_remaining,
                sum_qc_score,
                count_qc_score
    from dp_scorecard.SCORECARD_QUALITY_BO_RU_SV
)
 SELECT
   distinct a.supervisor_staff_id,
   a.department,
   a.building,
   a.dates_month,
   a.dates_month_num,
   a.dates_year,
   qc.qcs_performed,
   qc.avg_qc_score,
   a.balance,
   a.total_balance,
   a.staff_count,
   qc.qcs_remaining,
   qc.sum_qc_score,
   qc.count_qc_score
 FROM attendance a 
 left outer join QC_metrics qc on a.supervisor_staff_id = qc.supervisor_staff_id 
 and a.department=qc.department
 and a.building=qc.building
 and a.dates_month_num=qc.dates_month_num;
 
GRANT select on DP_SCORECARD.SCORECARD_BO_ATND_QC_ROLLUP_SV to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.SCORECARD_BO_ATND_QC_ROLLUP_SV to MAXDAT; 

commit; 


/*
select * from dp_scorecard.scorecard_prod_dp_bo_rollup_sv
where supervisor_staff_id=1296
order by supervisor_staff_id, department, building, month_id, month_name, 
event_name


begin
  DP_SCORECARD.Insert_Back_Office_Rollup;
end;
*/
/*

select distinct supervisor_staff_id from dp_scorecard.scorecard_hierarchy_sv where manager_staff_id=1409

select *
  from DP_SCORECARD.scorecard_prod_bo_rollup_sv
 where supervisor_staff_id in
       (select distinct supervisor_staff_id
          from dp_scorecard.scorecard_hierarchy_sv
         where manager_staff_id = 1409)
         and event_name in ('ARU Wrap Up >= 100%','Awaiting Written Withdrawal >= 100%')
         order by event_name, month_id



with total_logged as
(
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, metric as total_logged, 0 AS activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Logged'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, metric as activity_time, 0 AS staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Total Activity Time'
UNION
select supervisor_staff_id, department, building, dates_month_num as month_id, dates_year as month_name, event_name, event_name_sort, 0 as total_logged, 0 AS activity_time, metric as staff_count from dp_scorecard.sc_summary_bo_rollup
where event_subname='Staff Count'
),
targets as
(
select scorecard_group, target, ops_group, start_date, end_date from
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
select DISTINCT
       a10.supervisor_staff_id, 
       a10.department, 
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort as event_sort_id,
       a10.event_name || ' >= 100%' as event_name,
       sum(a10.total_logged) as total_logged,
       sum(a10.activity_time) as activity_time,
       sum(a10.staff_count) as staff_count,
       (to_char(trunc((sum(a10.activity_time) * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((sum(a10.activity_time) * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((sum(a10.activity_time) * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.month_id >= to_char(targets.start_date,'YYYYMM') AND (targets.end_date IS NULL OR a10.month_id <= to_char(targets.end_date,'YYYYMM')) ) as ops_group
  from total_logged a10
  GROUP BY        a10.supervisor_staff_id, 
       a10.department, 
       a10.building,
       a10.month_id,
       a10.month_name,
       a10.event_name_sort,
       a10.event_name;





*/
