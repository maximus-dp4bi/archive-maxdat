-- DecisionPoint - NICE WFM
-- Agent Schedule and Scheduled Absenteeism
-- (case statement when order is based on value occurrance frequency in PRD db - highest first)
-- Build MicroStrategy cube from NICE WFM view via MANAGEMENT_UNIT_DATE.
-- Trim MicroStrategy cube via Management Unit Date.

use nice_wfm_integration
go

create view AGENT_SCHEDULE_SV as
select 
  a.C_ID as AGENT_WFM_ID,
  emu.C_NAME as MANAGEMENT_UNIT_NAME,
  'Y' as IS_CURRENT_SCHEDULE,
  cast(asa.C_STIME as datetime) as SCHEDULE_START_UTC_DATETIME,
  cast(asa.C_ETIME as datetime) as SCHEDULE_END_UTC_DATETIME,
  cast(asa.C_DATE as date) as MANAGEMENT_UNIT_DATE,
  cast(switchoffset(asa.C_STIME,tzss.C_TZOFFSET) as datetime) as SCHEDULE_START_MU_DATETIME,
  cast(switchoffset(asa.C_ETIME,tzse.C_TZOFFSET) as datetime) as SCHEDULE_END_MU_DATETIME,
  emu.c_TZ as MANAGEMENT_UNIT_TIME_ZONE_NAME,
  cast(asda.C_STIME as datetime) as ABSENTEEISM_START_UTC_DATETIME,
  cast(asda.C_ETIME as datetime) as ABSENTEEISM_END_UTC_DATETIME,
  cast(switchoffset(asda.C_STIME,tzas.C_TZOFFSET) as datetime) as ABSENTEEISM_START_MU_DATETIME,
  cast(switchoffset(asda.C_ETIME,tzae.C_TZOFFSET) as datetime) as ABSENTEEISM_END_MU_DATETIME,
  e.c_name as ABSENTEEISM_TYPE,
  row_number() over (partition by a.C_ID,asa.C_DATE,e.c_name,asa.C_CTIME order by asda.C_STIME asc) as AGENT_DATE_ACTIVITY_RANK,
  case
    when e.c_paid = 'T' then 'Y'
    when e.c_paid = 'F' then 'N'
	else e.c_paid
	end as IS_PAID_ACTIVITY,
  case
    when asa.C_PROCDESCR = 's' then 'Schedule Management view'
	when asa.C_PROCDESCR = 'T' then 'Schedule generator'
	when asa.C_PROCDESCR = 'w' then 'Schedule change requested from WebStation'
	when asa.C_PROCDESCR = 'i' then 'Individual schedules view'
	when asa.C_PROCDESCR = 'g' then 'Forecast generator'
	when asa.C_PROCDESCR = 'F' then 'Apply future activities'
	when asa.C_PROCDESCR = 'C' then 'Copy MU schedules'
	when asa.C_PROCDESCR = 'M' then 'Meeting scheduler'
	when asa.C_PROCDESCR = 'o' then 'Schedule break optimizer'
	when asa.C_PROCDESCR = 'A' then 'Create active schedules'
	when asa.C_PROCDESCR = 't' then 'Trade schedules view'
	when asa.C_PROCDESCR = 'W' then 'Trade schedules from WebStation'
	when asa.C_PROCDESCR = 'c' then 'Trade agent schedules'
	when asa.C_PROCDESCR = 'V' then 'WebServices'
    else asa.C_PROCDESCR
    end as PROCESS_USED_TO_GENERATE,
  dt.C_NAME as DAILY_SCHEDULE_RULE_NAME,
  cast(asa.C_CTIME as datetime) as CREATED_UTC_DATETIME,
  cast(asa.C_MOD as datetime) as LAST_MODIFIED_UTC_DATETIME,
  cast(switchoffset(asa.C_CTIME,tzsc.C_TZOFFSET) as datetime) as CREATED_MU_DATETIME,
  cast(switchoffset(asa.C_MOD,tzsm.C_TZOFFSET) as datetime) as LAST_MODIFIED_MU_DATETIME
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_AGTSCHEDACT asa on a.C_OID = asa.C_AGT and a.C_ACT = 'A'
left outer join nice_wfm_customer1.dbo.R_DAILYTMPLT dt on dt.C_OID = asa.C_TMPLT
inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and mr.C_ACT = 'A' and asa.C_DATE >= mr.C_SDATE and asa.C_DATE <= coalesce(mr.C_EDATE,mr.C_EDATE,convert(nvarchar(10),dateadd(day,1,getdate()),23))
left outer join nice_wfm_customer1.dbo.R_AGTSCHEDDTLACT asda on asa.C_OID = asda.C_AGTSCHED
left outer join nice_wfm_customer1.dbo.R_EXCP e on asda.C_EXCP = e.C_OID
inner join nice_wfm_customer1.dbo.R_ENTITY emu on mr.C_MU = emu.C_OID and emu.C_TYPE = 'M' and emu.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_TZINFO tzss on emu.C_TZ = tzss.C_TZ and asa.C_STIME >= tzss.C_BEGIN and asa.C_STIME <= tzss.C_END
inner join nice_wfm_customer1.dbo.R_TZINFO tzse on emu.C_TZ = tzse.C_TZ and asa.C_ETIME >= tzse.C_BEGIN and asa.C_ETIME <= tzse.C_END
left outer join nice_wfm_customer1.dbo.R_TZINFO tzsc on emu.C_TZ = tzsc.C_TZ and asa.C_CTIME >= tzsc.C_BEGIN and asa.C_CTIME <= tzsc.C_END
left outer join nice_wfm_customer1.dbo.R_TZINFO tzsm on emu.C_TZ = tzsm.C_TZ and asa.C_MOD >= tzsm.C_BEGIN and asa.C_MOD <= tzsm.C_END
left outer join nice_wfm_customer1.dbo.R_TZINFO tzas on emu.C_TZ = tzas.C_TZ and asda.C_STIME >= tzas.C_BEGIN and asda.C_STIME <= tzas.C_END
left outer join nice_wfm_customer1.dbo.R_TZINFO tzae on emu.C_TZ = tzae.C_TZ and asda.C_ETIME >= tzae.C_BEGIN and asda.C_ETIME <= tzae.C_END;
