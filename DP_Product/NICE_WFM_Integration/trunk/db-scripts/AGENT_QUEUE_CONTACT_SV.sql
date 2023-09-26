-- DecisionPoint - NICE WFM
-- Agent Queue Contact
-- Build MicroStrategy cube from NICE WFM view via UTC_DATETIME.
-- Trim MicroStrategy cube via CONTACT_TYPE_DATE.

use nice_wfm_integration
go

create view AGENT_QUEUE_CONTACT_SV as 
select 
  a.C_ID as AGENT_WFM_ID,
  aqs.C_AGTLOGON as AGENT_LOGON_ID,
  acd.C_Name as ACD_NAME,
  eeg.C_NAME as ENTERPRISE_GROUP_NAME,
  ect.C_NAME as CONTACT_TYPE_NAME,
  eq.C_NAME as QUEUE_NAME,
  cast(qs.C_TIMESTAMP as datetime) as UTC_DATETIME,
  cast(switchoffset(qs.C_TIMESTAMP,tz.C_TZOFFSET) as date) as CONTACT_TYPE_DATE,
  cast(switchoffset(qs.C_TIMESTAMP,tz.C_TZOFFSET) as datetime) as CONTACT_TYPE_DATETIME,
  ect.C_TZ as CONTACT_TYPE_TIME_ZONE_NAME,
  aqs.C_REVHNDL as AGENT_CONTACTS_HANDLED,
  (aqs.C_REVCONTTIMESECS - aqs.C_REVHLDTIMESECS) as AGENT_TALK_TIME_SEC,
  aqs.C_REVHLDTIMESECS as AGENT_HOLD_TIME_SEC,
  aqs.C_REVWORKTIMESECS as AGENT_WRAP_TIME_SEC
from nice_wfm_customer1.dbo.R_ENTITY eeg
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on eeg.C_OID = heg.C_PARENT and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY ect on heg.C_CHILD = ect.C_OID and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_HIERARCHY hct on ect.C_OID = hct.C_PARENT and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and hct.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY eq on hct.C_CHILD = eq.C_OID and eq.C_TYPE = 'Q' and eq.C_ACT = 'A' and hct.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_QUEUESTATS qs on qs.C_QUEUE = eq.C_OID and qs.C_TIMESTAMP >= hct.C_SDATE and (hct.C_EDATE IS NULL or qs.C_TIMESTAMP <= hct.C_EDATE)
inner join nice_wfm_customer1.dbo.R_TZINFO tz on ect.C_TZ = tz.C_TZ and qs.C_TIMESTAMP >= tz.C_BEGIN and qs.C_TIMESTAMP <= tz.C_END
inner join nice_wfm_customer1.dbo.R_AGTQUEUESTATS aqs on aqs.C_QUEUE = qs.C_QUEUE and aqs.C_TIMESTAMP = qs.C_TIMESTAMP
inner join nice_wfm_customer1.dbo.R_AGT a on aqs.C_AGT = a.C_OID and a.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ACD acd on aqs.C_ACD = acd.C_OID;
