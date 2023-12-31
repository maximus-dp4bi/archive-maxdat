-- DecisionPoint - NICE WFM
-- Agent Contact
-- Build MicroStrategy cube from NICE WFM view via UTC_DATETIME.
-- Trim MicroStrategy cube via ACD_DATE.

use nice_wfm_integration
go

create view AGENT_CONTACT_SV as
select 
  a.C_ID as AGENT_WFM_ID,
  asys.C_AGTLOGON as AGENT_LOGON_ID,
  acd.C_NAME as ACD_NAME,
  cast(asys.C_TIMESTAMP as datetime) as UTC_DATETIME,
  cast(switchoffset(asys.C_TIMESTAMP,tz.C_TZOFFSET) as date) as ACD_DATE,
  cast(switchoffset(asys.C_TIMESTAMP,tz.C_TZOFFSET) as datetime) as ACD_DATETIME,
  acd.C_TZ as ACD_TIME_ZONE_NAME,
  asys.C_REVINTCONT as AGENT_TO_AGENT_CONTACT,
  asys.C_REVINTCONTTIMESECS as AGENT_TO_AGENT_HANDLE_TIME_SEC,
  asys.C_REVLOGINTIMESECS as AGENT_LOGIN_TIME_SEC,
  asys.C_REVNOTREADYTIMESECS as AGENT_NOT_READY_TIME_SEC,
  asys.C_REVOUTCONT as AGENT_OUTBOUND_CONTACT,
  asys.C_REVOUTCONTTIMESECS as AGENT_OUTBOUND_HANDLE_TIME_SEC,
  asys.C_REVREADYTIMESECS as AGENT_READY_TIME_SEC
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_AGTSYSSTATS asys on a.C_OID = asys.C_AGT
inner join nice_wfm_customer1.dbo.R_ACD acd on asys.C_ACD = acd.C_OID 
inner join nice_wfm_customer1.dbo.R_TZINFO tz on acd.C_TZ = tz.C_TZ and asys.C_TIMESTAMP >= tz.C_BEGIN and asys.C_TIMESTAMP <= tz.C_END;