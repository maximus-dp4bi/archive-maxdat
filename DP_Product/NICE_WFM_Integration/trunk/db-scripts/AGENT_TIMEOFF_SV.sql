-- DecisionPoint NICE WFM
-- Agent Timeoff

-- Note that the source timeoff start and end dates and times are in local MU time, but source request time is in UTC time.

use nice_wfm_integration
go

create view AGENT_TIMEOFF_SV as 
select 
  a.C_ID as AGENT_WFM_ID,
  fa.C_TYPE as TIMEOFF_TYPE,
  e.C_NAME as TIMEOFF_TYPE_DETAIL,
  e.C_PAID as TIMEOFF_PAY_TYPE,
  cast(switchoffset(todatetimeoffset(cast(ap.C_SDATE as datetime) + cast(coalesce(ap.C_STIME,'00:00:00') as datetime),tzs.C_TZOFFSET),'-00:00') as datetime) as START_UTC_DATETIME,
  cast(switchoffset(todatetimeoffset(cast(ap.C_EDATE as datetime) + cast(coalesce(ap.C_ETIME,'23:59:59.998') as datetime),tze.C_TZOFFSET),'-00:00') as datetime) as END_UTC_DATETIME,
  cast(ap.C_SDATE as datetime) + cast(coalesce(ap.C_STIME,'00:00:00') as datetime) as START_MU_DATETIME,
  cast(ap.C_EDATE as datetime) + cast(coalesce(ap.C_ETIME,'23:59:59.998') as datetime) as END_MU_DATETIME,
  emu.c_TZ as MANAGEMENT_UNIT_TIME_ZONE_NAME,
  cast(t.C_RQSTTIME as datetime) as TIME_OF_REQUEST_UTC_DATETIME,
  cast(switchoffset(t.C_RQSTTIME,tzr.C_TZOFFSET) as datetime) as TIME_OF_REQUEST_MU_DATETIME
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_AGTTIMEOFFFUTACTIVITY atfa on a.C_OID = atfa.C_AGT and a.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_FUTACTIVITY fa on atfa.C_OID = fa.C_OID and fa.C_KIND = 'T'
inner join nice_wfm_customer1.dbo.R_APPOINTMENT ap on fa.C_APPOINTMENT = ap.C_OID
inner join nice_wfm_customer1.dbo.R_PERSON p on a.C_PERSON = p.C_OID
inner join nice_wfm_customer1.dbo.R_USER u on p.C_OID = u.C_PERSON and u.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_TIMEOFFPLAN t on u.C_OID = t.C_RQSTBY
inner join nice_wfm_customer1.dbo.R_EXCP e on e.C_OID = fa.C_EXCP
inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and mr.C_ACT = 'A' and ap.C_SDATE >= mr.C_SDATE and ap.C_SDATE <= coalesce(mr.C_EDATE,cast(mr.C_EDATE as date),dateadd(day,1,sysutcdatetime()))
inner join nice_wfm_customer1.dbo.R_ENTITY emu on mr.C_MU = emu.C_OID and emu.C_TYPE = 'M' and emu.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_TZINFO tzs on emu.C_TZ = tzs.C_TZ and (cast(ap.C_SDATE as datetime) + cast(coalesce(ap.C_STIME,'00:00:00') as datetime)) >= tzs.C_BEGIN and cast(ap.C_SDATE as datetime) + cast(coalesce(ap.C_STIME,'00:00:00') as datetime) <= tzs.C_END
inner join nice_wfm_customer1.dbo.R_TZINFO tze on emu.C_TZ = tze.C_TZ and (cast(ap.C_EDATE as datetime) + cast(coalesce(ap.C_ETIME,'23:59:59.998') as datetime)) >= tze.C_BEGIN and cast(ap.C_EDATE as datetime) + cast(coalesce(ap.C_ETIME,'23:59:59.998') as datetime) <= tze.C_END
inner join nice_wfm_customer1.dbo.R_TZINFO tzr on emu.C_TZ = tzr.C_TZ and cast(t.C_RQSTTIME as datetime) >= tzr.C_BEGIN and cast(t.C_RQSTTIME as datetime) <= tzr.C_END;
