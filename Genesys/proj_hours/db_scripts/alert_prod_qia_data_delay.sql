--configure below MStr alert query and schedule it to run 25th min & 55th min every hour
select
p.projectid ProjId
,p.projectname ProjName
,ph.project_time_zone ProjTimezone
,ph.project_hours_start_time ProjStartTime
,ph.project_hours_end_time ProjEndTime
,qia.max_project_interval_start MaxProjQIAStartTime
,convert_timezone('UTC',ph.project_time_zone,sysdate()) CurrentProjLocalTime
,datediff(day,qia.max_project_interval_start,convert_timezone('UTC',ph.project_time_zone,sysdate())) DelayinDays
,round(datediff(min,qia.max_project_interval_start,convert_timezone('UTC',ph.project_time_zone,sysdate()))/60,2) DelayinHours
,count(p.projectid)
from "PUBLIC"."D_PI_PROJECTS" p
left join "PUBLIC"."CFG_PI_PROJECT_HOURS" ph on (p.projectid=ph.project_id)
left join "PUBLIC"."CFG_PI_PROJECT_HOLIDAYS" phl on (p.projectid=ph.project_id)
left join (select PROJECTID,max(PROJECTINTERVALSTART) max_project_interval_start
    from "PUBLIC"."F_PI_QUEUE_INTERVAL_AGGREGATES_VW"
    group by PROJECTID)qia on (p.projectid=qia.projectid)
where p.active='TRUE'
and dayofweek(convert_timezone('UTC',ph.project_time_zone,sysdate()))+1 = ph.PROJECT_HOURS_WEEK_DAY
and (case when to_date(convert_timezone('UTC',ph.project_time_zone,sysdate())) not in (phl.project_holiday_date)
then to_time(convert_timezone('UTC',ph.project_time_zone,sysdate())) else '24:00' end) between timeadd(min,30,to_time(project_hours_start_time)) and timeadd(min,60,to_time(project_hours_end_time))
and dateadd(min,15,qia.max_project_interval_start) <= to_timestamp(to_char(to_date(convert_timezone('UTC',ph.project_time_zone,sysdate()))) || ' ' || ph.project_hours_end_time)
and datediff(min,qia.max_project_interval_start,convert_timezone('UTC',ph.project_time_zone,sysdate())) > 60
group by ProjId, ProjName, ProjTimezone, ProjStartTime, ProjEndTime, MaxProjQIAStartTime, CurrentProjLocalTime ,DelayinDays, DelayinHours