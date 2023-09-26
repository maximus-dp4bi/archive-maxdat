-- DecisionPoint - NICE WFM
-- MAXDAT-6154 - Enable Traceability of CSR Agent Activity
-- Agent Activity
-- Build MicroStrategy cube from NICE WFM view via START_UTC_DATETIME.
-- Trim MicroStrategy cube via AA Start MU Date.

use nice_wfm_integration
go

create view AGENT_ACTIVITY_SV as
select 
  a.C_ID as AGENT_WFM_ID,
  aa.C_AGTLOGON as AGENT_LOGON_ID,
  acd.C_NAME as ACD_NAME,
  emu.C_NAME as MANAGEMENT_UNIT_NAME,
  cast(ald.C_STIME as datetime) as START_UTC_DATETIME,
  cast(ald.C_ETIME as datetime) as END_UTC_DATETIME,
  datediff(second,ald.C_STIME,ald.C_ETIME) as ACTIVITY_DURATION_SEC,
  cast(switchoffset(ald.C_STIME,tzs.C_TZOFFSET) as date) as START_MU_DATE,
  cast(switchoffset(ald.C_STIME,tzs.C_TZOFFSET) as datetime) as START_MU_DATETIME,
  cast(switchoffset(ald.C_ETIME,tze.C_TZOFFSET) as datetime) as END_MU_DATETIME,
  emu.c_TZ as MANAGEMENT_UNIT_TIME_ZONE_NAME,
  e.C_NAME as ACTIVITY_NAME,
  case
    when e.C_OVERTIME = 'F' then 'N'
    when e.C_OVERTIME = 'T' then 'Y'
	else e.C_OVERTIME
	end as IS_OVERTIME_ACTIVITY,
  case
    when e.C_PAID = 'F' then 'N'
    when e.C_PAID = 'T' then 'Y'
	else e.C_PAID
	end as IS_PAID_ACTIVITY
from  nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_AGTACDASSGN aaa on a.C_OID = aaa.C_AGT and a.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ASSIGNEDACDS aa on aaa.C_OID = aa.C_AGTACDASSGN
inner join nice_wfm_customer1.dbo.R_ACD acd on aa.C_ACD = acd.C_OID
inner join nice_wfm_customer1.dbo.R_AGTACDLOGON aal on a.C_OID = aal.C_AGT and aa.C_AGTLOGON = aal.C_AGTLOGON and acd.C_OID = aal.C_ACD
inner join nice_wfm_customer1.dbo.R_ACTIVITYLOGDTL ald on aal.C_OID = ald.C_AGTACDLOGON
inner join nice_wfm_customer1.dbo.R_EXCP e on ald.C_EXCP = e.C_OID
inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and mr.C_ACT = 'A' 
  and cast(ald.C_STIME as date) >= cast(mr.C_SDATE as date) and cast(ald.C_STIME as date) <= coalesce(mr.C_EDATE,cast(mr.C_EDATE as date),dateadd(day,1,sysutcdatetime()))
inner join nice_wfm_customer1.dbo.R_ENTITY emu on mr.C_MU = emu.C_OID and emu.C_TYPE = 'M' and emu.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_TZINFO tzs on emu.C_TZ = tzs.C_TZ and cast(ald.C_STIME as datetime) >= tzs.C_BEGIN and cast(ald.C_STIME as datetime) <= tzs.C_END
inner join nice_wfm_customer1.dbo.R_TZINFO tze on emu.C_TZ = tze.C_TZ and cast(ald.C_ETIME as datetime) >= tze.C_BEGIN and cast(ald.C_ETIME as datetime) <= tze.C_END;
