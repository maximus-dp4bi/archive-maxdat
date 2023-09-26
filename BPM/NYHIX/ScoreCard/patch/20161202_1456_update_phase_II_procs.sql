CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Attendance
   ( in_staff_id in number
   , in_absence_type_id in number
   , in_datetime in date
   , in_NATIONAL_ID in NUMBER )

AS

   v_incentive_flag varchar2(1);
   v_username varchar2(100);

   cursor c1 is
   select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id;

BEGIN
           
   open c1;
   fetch c1 into v_incentive_flag;

   if c1%notfound then
      v_incentive_flag := NULL;
   end if;

   if  in_staff_id is null or in_absence_type_id is null or in_datetime is null or in_NATIONAL_ID is null then
     /*do nothing*/
      null;
   else
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      --insert into pp_bo_scorecard. added where clause to prevent user from adding dates before staff's hire date or future dates
      insert into dp_scorecard.sc_attendance
        (sc_attendance_id, staff_id, entry_date, sc_all_id, absence_type, point_value, create_by, create_datetime, incentive_flag, last_updated_by, LAST_UPDATED_DATETIME)
        (select SEQ_SCAS_ID.nextval,
                in_staff_id,
                trunc(in_datetime),
                in_absence_type_id,
                (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
                v_username,
                sysdate,
                v_incentive_flag,
                v_username,
                sysdate
          from dual
          where (trunc(in_datetime) >= (select dates from DP_SCORECARD.SCORECARD_ATTENDANCE_SCORE_SV where staff_staff_id=in_staff_id and sc_attendance_id=0)
          and trunc(in_datetime) <= trunc(sysdate)));

       commit;

       --call procedure to recalculate running totals for this staff id
       DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
       --call procedure to populate monthly score table
       DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id);

   end if;

   close c1;

END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_ATTENDANCE TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_ATTENDANCE TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Back_Office

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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
and a11.event_id not in (1410,1413,1411,1412,1456) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
---and staff_id=1440 ---remove this
and  a11.event_id in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
);

commit;

/*  ---This code does not use historical targets
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
and a11.event_id not in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
and  a11.event_id in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
      from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);*/


--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
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
select staff_id, end_date, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select distinct tl.STAFF_ID, tl.end_date, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS,
tgt.target,
((tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS) / tgt.target) as metric
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
and a11.event_id not in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
and  a11.event_id in (1410,1413,1411,1412,1456)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(SYSDATE - 31) and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.end_date=ht.end_date and tl.scorecard_group=ht.scorecard_group
join targets tgt on tgt.scorecard_group=ht.scorecard_group and tl.end_date between tgt.start_date AND tgt.end_date
where tl.STAFF_ID in (select distinct staff_staff_id from dp_scorecard.scorecard_hierarchy_sv)
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
);
commit;

/*  ---This code does not use historical targets
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
      from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
     where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))
)   tgt on tgt.scorecard_group=ht.scorecard_group
);*/

--MONTHLY
--Task Prodution : ([Total Logged] / ([Total Activity Time in Hrs] / [Max (QC Target)]))
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
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
select staff_id, dates_month_num, dates_year, case when scorecard_group = 'All Other Tasks' then 2 else 1 end, scorecard_group, 3, 'Task Production', metric
from
(
select tl.STAFF_ID, tl.dates_month_num, tl.dates_year, tl.scorecard_group, tl.TOTAL_LOGGED, ht.HANDLE_TIME_IN_HOURS,
tgt.target,
((tl.TOTAL_LOGGED / ht.HANDLE_TIME_IN_HOURS) / tgt.target) as metric
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
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
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
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
and  a11.event_id in (1410,1413,1411,1412,1456)
and LENGTH(TRIM(TRANSLATE(work_subactivity, ' +-.0123456789', ' '))) is null
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
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
  from maxdat.PP_BO_EVENT_TARGET_LKUP_SV
 where SCORECARD_FLAG = 'Y' and (end_date is null or trunc(sysdate) <= trunc(end_date)))  a12
    on   (a11.EVENT_ID = a12.EVENT_ID)
where  trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) and a11.EXCLUSION_FLAG='N'
--and staff_id=1440 ---remove this
group by
  a11.STAFF_ID,
  to_char(TRUNC(a11.TASK_END), 'YYYYMM'),
  to_char(TRUNC(a11.TASK_END), 'Month YYYY'),
  a12.scorecard_group
) ht on tl.STAFF_ID=ht.STAFF_ID and tl.dates_month_num=ht.dates_month_num and tl.scorecard_group=ht.scorecard_group
join targets tgt on tgt.scorecard_group=ht.scorecard_group
and tl.dates_month_num between to_char(TRUNC(tgt.start_date), 'YYYYMM') AND to_char(TRUNC(tgt.end_date), 'YYYYMM')
where tl.STAFF_ID in (select distinct staff_staff_id from dp_scorecard.scorecard_hierarchy_sv)
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

/*OLD CODE NOT WORKING
--Daily Adherence (PRODUCTION)
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
With PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
  JOIN MAXDAT.PP_BO_EVENT_TARGET_LKUP_SV T
    ON A.EVENT_ID = T.EVENT_ID
 WHERE T.EE_ADHERENCE = 'Y'
   AND TRUNC(TASK_START) = TRUNC(TASK_END) and trunc(TASK_END) >= TRUNC(SYSDATE - 31)
   AND T.SCORECARD_GROUP NOT IN ('NON-PRODUCTIVE')
 GROUP BY STAFF_ID, TRUNC(TASK_START)
),
SCHEDULED as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE
 GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED as
(
select p.staff_id, p.TASK_START as dates, (p.PRODUCTIVITIY/s.TOTAL_MIN_SCHED) as daily_adherence_metric, p.PRODUCTIVITIY, s.TOTAL_MIN_SCHED
from PRODUCTIVITIY p
join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
)
select staff_id, dates, 3, 'Daily Adherence',  1, NULL, daily_adherence_metric from COMBINED;*/


--Daily Adherence (PRODUCTION)
insert into dp_scorecard.sc_production_bo
  (staff_id, dates, event_name_sort, event_name, event_subname_sort, event_subname, metric)
With PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
--added in this join and removed some filters that were no longer necessary--
  JOIN (
  SELECT DISTINCT EVENT_ID, NAME, EE_ADHERENCE
  FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
  WHERE EE_ADHERENCE = 'Y') X ON A.EVENT_ID = X.EVENT_ID
   AND TRUNC(TASK_START) = TRUNC(TASK_END) and trunc(TASK_END) >= TRUNC(SYSDATE - 31)
GROUP BY STAFF_ID, TRUNC(TASK_START)
),
SCHEDULED as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE and trunc(T.TASK_START) >= TRUNC(SYSDATE - 31)
 GROUP BY T.STAFF_ID, TRUNC(T.TASK_START)
),
COMBINED as
(
select p.staff_id, p.TASK_START as dates, (p.PRODUCTIVITIY/s.TOTAL_MIN_SCHED) as daily_adherence_metric, p.PRODUCTIVITIY, s.TOTAL_MIN_SCHED
from PRODUCTIVITIY p
left outer join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.TASK_START=s.TASK_START
 WHERE PRODUCTIVITIY IS NOT NULL AND PRODUCTIVITIY > 0
 AND TOTAL_MIN_SCHED IS NOT NULL AND TOTAL_MIN_SCHED > 0
)
select staff_id, dates, 3, 'Daily Adherence',  1, NULL, daily_adherence_metric from COMBINED;


commit;

/*OLD CODE - DOES NOT WORK CORRECTLY
--MONTHLY Adherence (SUMMARY)
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
select distinct staff_id,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO
  order by staff_id,
       dates_month_num
),
PRODUCTIVITIY as
(
SELECT STAFF_ID,
       TO_CHAR(TASK_START,'YYYYMM') as dates_month_num,
       SUM(HANDLE_TIME) as PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
  JOIN MAXDAT.PP_BO_EVENT_TARGET_LKUP_SV T
    ON A.EVENT_ID = T.EVENT_ID
 WHERE T.EE_ADHERENCE = 'Y'
   AND TRUNC(TASK_START) = TRUNC(TASK_END)
   AND T.SCORECARD_GROUP NOT IN ('NON-PRODUCTIVE')
 GROUP BY STAFF_ID, TO_CHAR(TASK_START,'YYYYMM')
),
SCHEDULED as
(
SELECT T.STAFF_ID,
       TO_CHAR(T.TASK_START,'YYYYMM') as dates_month_num,
       SUM(T.DURATION) as TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE
 GROUP BY T.STAFF_ID, TO_CHAR(T.TASK_START,'YYYYMM')
),
COMBINED as
(
select p.staff_id, p.dates_month_num, (p.PRODUCTIVITIY/s.TOTAL_MIN_SCHED) as monthly_adherence_metric, p.PRODUCTIVITIY, s.TOTAL_MIN_SCHED
from PRODUCTIVITIY p
join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
)
select am.staff_id, am.dates_month_num, am.dates_year, 3, 'Monthly Adherence',  1, NULL, monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.staff_id=c.staff_id and am.dates_month_num=c.dates_month_num;*/

--MONTHLY Adherence (SUMMARY)
insert into dp_scorecard.SC_SUMMARY_BO
  (staff_id, dates_month_num, dates_year, event_name_sort, event_name, event_subname_sort, event_subname, metric)
WITH ALL_MONTHS as
(
select distinct staff_id,
       dates_month_num,
       dates_year
  from dp_scorecard.SC_SUMMARY_BO
  order by staff_id,
       dates_month_num
),
PRODUCTIVITIY_DAILY as
(
/*SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as DAILY_PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
  JOIN MAXDAT.PP_BO_EVENT_TARGET_LKUP_SV T
    ON A.EVENT_ID = T.EVENT_ID
 WHERE T.EE_ADHERENCE = 'Y'
   AND TRUNC(TASK_START) = TRUNC(TASK_END) and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   AND T.SCORECARD_GROUP NOT IN ('NON-PRODUCTIVE')
 GROUP BY STAFF_ID, TRUNC(TASK_START)*/
 SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as DAILY_PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
--added in this join and removed some filters that were no longer necessary--
  JOIN (
  SELECT DISTINCT EVENT_ID, NAME, EE_ADHERENCE
  FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
  WHERE EE_ADHERENCE = 'Y') X ON A.EVENT_ID = X.EVENT_ID
WHERE TRUNC(TASK_START) = TRUNC(TASK_END) and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
GROUP BY STAFF_ID, TRUNC(TASK_START)

),
SCHEDULED_DAILY as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO T
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
select p.staff_id, p.dates_month_num, (p.PRODUCTIVITIY/s.TOTAL_MIN_SCHED) as monthly_adherence_metric, p.PRODUCTIVITIY, s.TOTAL_MIN_SCHED
from PRODUCTIVITIY p
LEFT OUTER join SCHEDULED s on p.STAFF_ID=s.STAFF_ID and p.dates_month_num=s.dates_month_num
)
select am.staff_id, am.dates_month_num, am.dates_year, 3, 'Monthly Adherence',  1, NULL, monthly_adherence_metric
FROM ALL_MONTHS am
left outer join COMBINED c on am.staff_id=c.staff_id and am.dates_month_num=c.dates_month_num;

commit;


END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_BACK_OFFICE TO MAXDAT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_BACK_OFFICE TO MAXDAT_REPORTS;

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Corrective_Action
   ( in_staff_id in number
   , in_corrective_action_id in number
   , in_unsatisfactory_behavior in varchar2
   , in_comments in varchar2
   , in_date in date
   , in_NATIONAL_ID in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_corrective_action_id is null or in_date is null or in_unsatisfactory_behavior is null 
     or in_comments is null or in_NATIONAL_ID is null or trunc(in_date) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
      
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );
   
      insert into dp_scorecard.sc_corrective_action
        (ca_id,
         staff_id,
         ca_entry_date,
         cal_id,
         unsatisfactory_behavior,
         comments,
         create_by,
         create_datetime, 
         last_updated_by, 
         LAST_UPDATED_DATETIME)
      values
        (SEQ_SCCA_ID.Nextval,
         in_staff_id,
         TRUNC(in_date),
         in_corrective_action_id,
         in_unsatisfactory_behavior,
         in_comments,
         v_username,
         SYSDATE,
         v_username,
         sysdate);

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_ATTENDANCE TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_ATTENDANCE TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Goal
   ( in_staff_id in number
   , in_goal_id in number
   , in_goal_description in varchar2
   , in_goal_date in date
   , in_progress_note in varchar2
   , in_date in date
   , in_NATIONAL_ID in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_goal_id is null or in_date is null or in_goal_description is null or in_progress_note is null
     or in_goal_date is null or in_NATIONAL_ID is null or trunc(in_date) > trunc(sysdate) or trunc(in_goal_date) < trunc(sysdate) then
     /*do nothing*/
      null;
   else
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      insert into dp_scorecard.sc_goal
        (goal_id,
         staff_id,
         goal_entry_date,
         gtl_id,
         goal_description,
         goal_date,
         progress_note,
         create_by,
         create_datetime, 
         last_updated_by, 
         LAST_UPDATED_DATETIME)
      values
        (SEQ_SCGOAL_ID.nextval,
         in_staff_id,
         in_date,
         in_goal_id,
         in_goal_description,
         in_goal_date,
         in_progress_note,
         v_username,
         SYSDATE,
         v_username,
         sysdate);

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_GOAL TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_GOAL TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Insert_Performance_Tracker
   ( in_staff_id in number
   , in_dl_id in number
   , in_comments in varchar2
   , in_date in date
   , in_NATIONAL_ID in NUMBER )

AS
   v_username varchar2(100);
BEGIN

   if  in_staff_id is null or in_dl_id is null or in_date is null or in_comments is null or in_NATIONAL_ID is null 
     or trunc(in_date) > trunc(sysdate) then
     /*do nothing*/
      null;
   else
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );

      insert into dp_scorecard.sc_performance_tracker
        (pt_id, staff_id, pt_entry_date, dl_id, comments, create_by, create_datetime, last_updated_by, LAST_UPDATED_DATETIME)
      values
        (SEQ_SCPT_ID.Nextval,
         in_staff_id,
         TRUNC(in_date),
         in_dl_id,
         in_comments,
         v_username,
         SYSDATE,
         v_username,
         SYSDATE);

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.INSERT_PERFORMANCE_TRACKER TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.INSERT_PERFORMANCE_TRACKER TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Attendance
   ( in_staff_id in number
   , in_sc_attendance_id in number
   , in_absence_type_id in number
   , in_NATIONAL_ID in NUMBER)

AS

   v_all_id number;
   v_username varchar2(100);
   cursor c1 is
   select sc_all_id from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where absence_type='Delete';

BEGIN

   open c1;
   fetch c1 into v_all_id;

   if c1%notfound then
      v_all_id := NULL;
   end if;

   if  in_sc_attendance_id = 0 then
     /*do nothing*/
      null;
   else
      if (in_absence_type_id is not null) or (in_absence_type_id = v_all_id) then
          
          --get username
          select name into v_username from 
          (
              SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
              UNION
              SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
              UNION  
              SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
              UNION
              SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
              UNION
              SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
              UNION
              SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
          );         
          
          
          update dp_scorecard.sc_attendance
          set sc_all_id = in_absence_type_id,
              absence_type = (select absence_type from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              point_value = (select point_value from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              incentive_flag = (select incentive_flag from DP_SCORECARD.SC_ATTENDANCE_ABSENCE_LKUP where sc_all_id=in_absence_type_id),
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
          where staff_id = in_staff_id and sc_attendance_id = in_sc_attendance_id;
      else
          /*do nothing if a comment is not submitted with an update or user wants to perform a Delete*/
          null;
      end if;

   end if;

   delete from dp_scorecard.sc_attendance where staff_id=in_staff_id and absence_type='Delete' ;

   commit;

   close c1;

   --call procedure to recalculate running totals for this staff id
   DP_SCORECARD.Calc_Attendance_Score(in_staff_id);
   --call procedure to populate monthly score table
   DP_SCORECARD.Update_Sc_Attendance_Mthly(in_staff_id);

END;
/

GRANT EXECUTE ON DP_SCORECARD.UPDATE_ATTENDANCE TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_ATTENDANCE TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Corrective_Action
   ( in_staff_id in number
   , in_ca_id in number
   , in_unsatisfactory_behavior in varchar2
   , in_comments in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_corrective_action where staff_id=in_staff_id and ca_id = in_ca_id;
     commit;
   elsif  length(in_unsatisfactory_behavior) is NULL and length(in_comments) is NULL then
     /*do nothing*/
      null;
   else
       
     --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );             
       
       
       update dp_scorecard.sc_corrective_action
          set unsatisfactory_behavior = case
                                          when (length(in_unsatisfactory_behavior) > 0) then
                                           in_unsatisfactory_behavior
                                          else
                                           unsatisfactory_behavior
                                        end,
              comments = case
                           when (length(in_comments) > 0) then
                            in_comments
                           else
                            comments
                         end,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where ca_id = in_ca_id;

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.UPDATE_CORRECTIVE_ACTION TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_CORRECTIVE_ACTION TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Goal
   ( in_staff_id in number
   , in_goal_id in number
   , in_goal_description in varchar2
   , in_progress_note in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_goal where staff_id=in_staff_id and goal_id = in_goal_id;
     commit;
   elsif  length(in_goal_description) is NULL and length(in_progress_note) is NULL then
     /*do nothing*/
      null;
   else
       
      --get username
      select name into v_username from 
      (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
      );               
       
       update dp_scorecard.sc_goal
          set goal_description = case
                                      when (length(in_goal_description) > 0) then
                                       in_goal_description
                                      else
                                       goal_description
                                    end,
              progress_note = case
                                 when (length(in_progress_note) > 0) then
                                  in_progress_note
                                 else
                                  progress_note
                               end,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where goal_id = in_goal_id;

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.UPDATE_GOAL TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_GOAL TO MAXDAT;

CREATE OR REPLACE Procedure DP_SCORECARD.Update_Performance_Tracker
   ( in_staff_id in number
   , in_pt_id in number
   , in_comments in varchar2
   , in_delete_flag in number
   , in_NATIONAL_ID in NUMBER)

AS
   v_username varchar2(100);
BEGIN

   if in_delete_flag = 1 then
     delete from dp_scorecard.sc_performance_tracker where staff_id=in_staff_id and pt_id = in_pt_id;
     commit;
   elsif  length(in_comments) is NULL then
     /*do nothing*/
      null;
   else
       
        --get username
        select name into v_username from 
        (
        SELECT 'ADMIN' as NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE admin_id=in_NATIONAL_ID
        UNION
        SELECT sr_director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_director_natid=in_NATIONAL_ID
        UNION  
        SELECT director_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE director_natid=in_NATIONAL_ID
        UNION
        SELECT sr_manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE sr_manager_natid=in_NATIONAL_ID
        UNION
        SELECT manager_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE manager_natid=in_NATIONAL_ID
        UNION
        SELECT supervisor_name AS NAME FROM DP_SCORECARD.SCORECARD_HIERARCHY WHERE supervisor_natid=in_NATIONAL_ID
        );        
       
       update dp_scorecard.sc_performance_tracker
          set comments = in_comments,
              last_updated_by = v_username,
              LAST_UPDATED_DATETIME = sysdate
        where pt_id = in_pt_id;

       commit;

   end if;

END;
/

GRANT EXECUTE ON DP_SCORECARD.UPDATE_PERFORMANCE_TRACKER TO MAXDAT_MSTR_TRX_RPT;
GRANT EXECUTE ON DP_SCORECARD.UPDATE_PERFORMANCE_TRACKER TO MAXDAT;

