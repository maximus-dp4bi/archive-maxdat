select
p.projectid
,p.projectname
,ph.project_time_zone
,ph.project_hours_start_time
,ph.project_hours_end_time
,qia.max_project_interval_start
,convert_timezone('UTC',ph.project_time_zone,sysdate()) current_project_time
,datediff(hour,qia.max_project_interval_start,convert_timezone('UTC',ph.project_time_zone,sysdate())) delay_hrs
from "PUBLIC"."D_PI_PROJECTS" p
left join "PUBLIC"."CFG_PI_PROJECT_HOURS" ph on (p.projectid=ph.project_id)
left join (select PROJECTID,max(PROJECTINTERVALSTART) max_project_interval_start
    from "PUBLIC"."F_PI_QUEUE_INTERVAL_AGGREGATES_VW"
    group by PROJECTID)qia on (p.projectid=qia.projectid)
where p.active='TRUE'
and dayofweek(convert_timezone('UTC',ph.project_time_zone,sysdate()))+1 between ph.project_hours_start_day and ph.project_hours_end_day
and to_time(convert_timezone('UTC',project_time_zone,sysdate())) between timeadd(min,30,to_time(project_hours_start_time)) and timeadd(min,30,to_time(project_hours_end_time))
and datediff(hour,qia.max_project_interval_start,convert_timezone('UTC',ph.project_time_zone,sysdate())) > 1