CREATE OR REPLACE VIEW DP_SCORECARD.SCORECARD_HIERARCHY_SV
AS
select 999 as admin_id, --created an admin level in the hierarchy so that user id 999 in MicroStrategy can see all managers
       h.sr_director_name,
       h.sr_director_staff_id,
       h.sr_director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_director_staff_id = s.Staff_id) sr_director_termination_date,
       h.director_name,
       h.director_staff_id,
       h.director_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.director_staff_id = s.Staff_id) director_termination_date,
       h.sr_manager_name,
       h.sr_manager_staff_id,
       h.sr_manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.sr_manager_staff_id = s.Staff_id) sr_manager_termination_date,
       h.manager_name,
       h.manager_staff_id,
       h.manager_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.manager_staff_id = s.Staff_id) manager_termination_date,
       h.supervisor_name,
       h.supervisor_staff_id,
       h.supervisor_natid,
       (select termination_date from MAXDAT.PP_WFM_STAFF_SV S where h.supervisor_staff_id = s.Staff_id) supervisor_termination_date,
       h.staff_staff_id,
       h.staff_staff_name,
       h.staff_natid,
       h.hire_date,
       h.position,
       h.office,
       h.termination_date,
       (select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where 
        (trunc(std.effective_date) <= trunc(sysdate) 
        and coalesce(std.end_date,to_date('07/07/7777','mm/dd/yyyy')) > trunc(sysdate)
        AND h.TERMINATION_DATE IS null) 
        and std.staff_id=h.staff_staff_id
        UNION
        select distinct d.name from dp_scorecard.pp_wfm_staff_to_department std
        join dp_scorecard.pp_wfm_department d on std.department_id=d.department_id
        where 
            (h.termination_date IS NOT NULL
           AND trunc(std.effective_date) <= trunc(h.termination_date)
           AND std.end_date >= trunc(h.termination_date)
           AND std.DELETE_FLAG = 'N')
        and std.staff_id=h.staff_staff_id
        ) as department ,
       (select DISTINCT building from dp_scorecard.scorecard_office_building_lkup obl where obl.office=h.office) as building
  from dp_scorecard.scorecard_hierarchy h
/*  union
  select null as admin_id,
       null as sr_director_name,
       null as sr_director_staff_id,
       null as sr_director_natid,
       null as  sr_director_termination_date,
       null as director_name,
       null as director_staff_id,
       null as director_natid,
       null as director_termination_date,
       null as sr_manager_name,
       null as sr_manager_staff_id,
       null as sr_manager_natid,
       null as sr_manager_termination_date,
      null as manager_name,
       null as manager_staff_id,
       null as manager_natid,
       null as manager_termination_date,
       null as supervisor_name,
       null as supervisor_staff_id,
       null as supervisor_natid,
       null as supervisor_termination_date,
         null as staff_staff_id,
       null as staff_staff_name,
       null as staff_natid,
       null as hire_date,
       null as position,
       null as office,
       null as termination_date,
       null as department,
       null as building
  from dual*/;

GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT;
GRANT SELECT ON DP_SCORECARD.SCORECARD_HIERARCHY_SV TO MAXDAT_READ_ONLY;



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
where /*not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and */trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
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
where /*not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and */trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START)
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
where /*not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and */trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START) 
group by
  a11.STAFF_ID,
  trunc(a11.TASK_END),
  a12.scorecard_group
);

commit;

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
where /*not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and */trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START) 
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
where /*not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and */trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START) 
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
where trunc(a11.TASK_END) >= TRUNC(SYSDATE - 366) and trunc(a11.TASK_END)=trunc(a11.TASK_START) 
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.task_start) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and  trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
--and staff_id=1440 ---remove this
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
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
where not exists (select 1 from sc_exclusion_yes_sv b where a11.staff_id = b.staff_id and trunc(a11.TASK_END) = trunc(b.exclusion_date))
        and trunc(a11.TASK_END) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM') and trunc(a11.TASK_END)=trunc(a11.TASK_START) /*and a11.EXCLUSION_FLAG='N'*/
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
 WHERE not exists (select 1 from sc_exclusion_yes_sv b where A.staff_id = b.staff_id and trunc(A.TASK_START) = trunc(b.exclusion_date)) --Add for exclusion

GROUP BY STAFF_ID, TRUNC(TASK_START)
),
SCHEDULED as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T --DP_SCORECARD.PP_WFM_TASK_BO T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE and trunc(T.TASK_START) >= TRUNC(SYSDATE - 31)
   AND not exists (select 1 from sc_exclusion_yes_sv b where T.STAFF_ID = b.staff_id and trunc(T.TASK_START) = trunc(b.exclusion_date)) --Add for exclusion

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
 SELECT STAFF_ID,
       TRUNC(TASK_START) as TASK_START,
       SUM(HANDLE_TIME) as DAILY_PRODUCTIVITIY
  FROM MAXDAT.PP_WFM_ACTUALS_SV A
--added in this join and removed some filters that were no longer necessary--
  JOIN (
  SELECT DISTINCT EVENT_ID, NAME, EE_ADHERENCE
  FROM MAXDAT.PP_BO_EVENT_TARGET_LKUP
  WHERE EE_ADHERENCE = 'Y') X ON A.EVENT_ID = X.EVENT_ID
WHERE not exists (select 1 from sc_exclusion_yes_sv b where A.staff_id = b.staff_id and trunc(A.TASK_START) = trunc(b.exclusion_date)) --Add for exclusion
AND TRUNC(TASK_START) = TRUNC(TASK_END) and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
GROUP BY STAFF_ID, TRUNC(TASK_START)

),
SCHEDULED_DAILY as
(
SELECT T.STAFF_ID,
       TRUNC(T.TASK_START) as TASK_START,
       SUM(T.DURATION) as DAILY_TOTAL_MIN_SCHED
  FROM DP_SCORECARD.PP_WFM_TASK_BO_SV T --DP_SCORECARD.PP_WFM_TASK_BO T
 WHERE T.EVENT_ID NOT IN ('4', '5')
   AND TRUNC(T.TASK_START) <= SYSDATE and TRUNC(TASK_START) >= TRUNC(ADD_MONTHS(SYSDATE, -11), 'MM')
   AND not exists (select 1 from sc_exclusion_yes_sv b where T.staff_id = b.staff_id and trunc(T.TASK_START) = trunc(b.exclusion_date)) --Add for exclusion
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


END Insert_Back_Office;
/

grant execute on dp_scorecard.Insert_Back_Office to MAXDAT_READ_ONLY;
grant execute on dp_scorecard.Insert_Back_Office to MAXDAT;

------

create or replace view dp_scorecard.scorecard_prod_dp_bo_all_sv as
select dates,
       staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = staff_id) as staff_natid,
       event_name,
       event_name_sort as event_sort_id,
       metric as productivity
  from dp_scorecard.sc_production_bo
 where event_name = 'Daily Production' 
UNION
select da.dates,
       da.staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = da.staff_id) as staff_natid,
       da.event_name,
       da.event_name_sort as event_sort_id,
       da.metric as productivity
  from dp_scorecard.sc_production_bo da
  join (select dates, staff_id
          from dp_scorecard.sc_production_bo
         where event_name = 'Daily Production') dp
    on da.dates = dp.dates
   and da.staff_id = dp.staff_id
 where da.event_name = 'Daily Adherence';

GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_all_sv to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_all_sv to MAXDAT;
 -----

create or replace view dp_scorecard.scorecard_prod_dp_bo_sv as
select dates,
       staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = staff_id) as staff_natid,
       event_name,
       event_name_sort as event_sort_id,
       metric as productivity
  from dp_scorecard.sc_production_bo
 where event_name = 'Daily Production' 
 and trunc(dates) >= trunc(sysdate - 31) 
UNION
select da.dates,
       da.staff_id,
       (select distinct staff_natid
          from dp_scorecard.scorecard_hierarchy_sv
         where staff_staff_id = da.staff_id) as staff_natid,
       da.event_name,
       da.event_name_sort as event_sort_id,
       da.metric as productivity
  from dp_scorecard.sc_production_bo da
  join (select dates, staff_id
          from dp_scorecard.sc_production_bo
         where event_name = 'Daily Production'
         and trunc(dates) >= trunc(sysdate - 31)) dp
    on da.dates = dp.dates
   and da.staff_id = dp.staff_id
 where da.event_name = 'Daily Adherence';

GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_sv to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.scorecard_prod_dp_bo_sv to MAXDAT;
---
 
create or replace view dp_scorecard.scorecard_prod_bo_all_sv as
with total_logged as
(
select staff_id, dates, event_name_sort, event_name, metric as total_logged from dp_scorecard.sc_production_bo
where event_subname='Total Logged'
),
activity_time as
(
select staff_id, dates, event_name_sort, event_name, metric as activity_time from dp_scorecard.sc_production_bo
where event_subname='Total Activity Time'
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
select a10.staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.dates,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.dates = a11.dates
   and a10.event_name = a11.event_name;
   
GRANT select on DP_SCORECARD.scorecard_prod_bo_all_sv to MAXDAT_READ_ONLY;
GRANT select on DP_SCORECARD.scorecard_prod_bo_all_sv to MAXDAT;
----
create or replace view dp_scorecard.scorecard_prod_bo_sv as
with total_logged as
(
select staff_id, dates, event_name_sort, event_name, metric as total_logged from dp_scorecard.sc_production_bo
where event_subname='Total Logged' and trunc(dates) >= trunc(sysdate - 31)
),
activity_time as
(
select staff_id, dates, event_name_sort, event_name, metric as activity_time from dp_scorecard.sc_production_bo
where event_subname='Total Activity Time' and trunc(dates) >= trunc(sysdate - 31)
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
select a10.staff_id,
       (select distinct staff_natid from dp_scorecard.scorecard_hierarchy_sv where staff_staff_id=a10.staff_id) as staff_natid,
       a10.dates,
       a10.event_name_sort as event_sort_id,
       a10.event_name,
       a10.total_logged,
       a11.activity_time,
       (to_char(trunc((a11.activity_time * 3600) / 3600), 'FM999999990') || ':' || to_char(trunc(mod((a11.activity_time * 3600), 3600) / 60), 'FM00') || ':' || to_char(mod((a11.activity_time * 3600), 60), 'FM00')) as activity_time_in_hhmmss,
       (select DISTINCT target from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as target,
       (select DISTINCT ops_group from targets where scorecard_group = a10.event_name AND  a10.dates >= targets.start_date AND (targets.end_date IS NULL OR a10.dates <= targets.end_date) ) as ops_group
  from total_logged a10
  left outer join activity_time a11
    on a10.staff_id = a11.staff_id
   and a10.dates = a11.dates
   and a10.event_name = a11.event_name;
   
 
GRANT select on DP_SCORECARD.scorecard_prod_bo_all_sv to MAXDAT_READ_ONLY; 
GRANT select on DP_SCORECARD.scorecard_prod_bo_all_sv to MAXDAT;  

commit;


