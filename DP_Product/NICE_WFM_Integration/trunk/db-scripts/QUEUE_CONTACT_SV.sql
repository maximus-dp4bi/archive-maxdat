-- DecisionPoint - NICE WFM
-- Queue Contact
-- Build MicroStrategy cube from NICE WFM view via UTC_DATETIME.
-- Trim MicroStrategy cube via CONTACT_TYPE_DATE.

use nice_wfm_integration 
go

create view QUEUE_CONTACT_SV as
select
  eeg.C_NAME as ENTERPRISE_GROUP_NAME,
  ect.C_NAME as CONTACT_TYPE_NAME,
  eq.C_NAME as QUEUE_NAME,
  acd.C_NAME as ACD_NAME,
  cast(qs.C_TIMESTAMP as datetime) as UTC_DATETIME,
  cast(switchoffset(qs.C_TIMESTAMP,tz.C_TZOFFSET) as date) as CONTACT_TYPE_DATE,
  cast(switchoffset(qs.C_TIMESTAMP,tz.C_TZOFFSET) as datetime) as CONTACT_TYPE_DATETIME,
  ect.C_TZ as CONTACT_TYPE_TIME_ZONE_NAME,
  cast(((substring(qs.C_REVLOGINTIME,1,4) * 86400) + (substring(qs.C_REVLOGINTIME,6,2) * 3600) + (substring(qs.C_REVLOGINTIME,9,2) * 60) + substring(qs.C_REVLOGINTIME,12,2)) as integer) as LOGIN_TIME_SEC,
  cast(((substring(qs.C_REVNOTREADYTIME,1,4) * 86400) + (substring(qs.C_REVNOTREADYTIME,6,2) * 3600) + (substring(qs.C_REVNOTREADYTIME,9,2) * 60) + substring(qs.C_REVNOTREADYTIME,12,2)) as integer) as NOT_READY_TIME_SEC,
  cast(((substring(qs.C_REVHLDTIME,1,4)  * 86400) + (substring(qs.C_REVHLDTIME,6,2) * 3600) + (substring(qs.C_REVHLDTIME,9,2) * 60) + substring(qs.C_REVHLDTIME,12,2)) as integer) as HOLD_TIME_SEC,
  cast(((substring(qs.C_REVREADYTIME,1,4) * 86400) + (substring(qs.C_REVREADYTIME,6,2) * 3600) + (substring(qs.C_REVREADYTIME,9,2) * 60) + substring(qs.C_REVREADYTIME,12,2)) as integer) as READY_TIME_SEC,
  cast(((substring(qs.C_REVQUEUEDELAY,1,4) * 86400) + (substring(qs.C_REVQUEUEDELAY,6,2) * 3600) + (substring(qs.C_REVQUEUEDELAY,9,2) * 60) + substring(qs.C_REVQUEUEDELAY,12,2)) as integer) as QUEUE_TIME_BEFORE_ANSWER_SEC,
  cast(((substring(qs.C_REVCONTTIME,1,4) * 86400) + (substring(qs.C_REVCONTTIME,6,2) * 3600) + (substring(qs.C_REVCONTTIME,9,2) * 60) + substring(qs.C_REVCONTTIME,12,2)) as integer) as TALK_TIME_SEC,
  cast(((substring(qs.C_REVOUTCONTTIME,1,4) * 86400) + (substring(qs.C_REVOUTCONTTIME,6,2) * 3600) + (substring(qs.C_REVOUTCONTTIME,9,2) * 60) + substring(qs.C_REVOUTCONTTIME,12,2)) as integer) as OUTGOING_MANUAL_DIAL_TIME_SEC,
  cast(((substring(qs.C_REVWORKTIME,1,4) * 86400) + (substring(qs.C_REVWORKTIME,6,2) * 3600) + (substring(qs.C_REVWORKTIME,9,2) * 60) + substring(qs.C_REVWORKTIME,12,2)) as integer) as AFTER_WORK_TIME_SEC,
  qs.C_REVCONTRCVD as CALLS_CREATED,
  qs.C_REVABANDBEFSL as CALLS_ABANDON_BEFORE_THRESHOLD,
  qs.C_REVABANDAFTSL as CALLS_ABANDON_AFTER_THRESHOLD,
  qs.C_REVHNDLBEFSL as CALLS_HANDLED_BEFORE_THRESHOLD,
  qs.C_REVHNDLAFTSL as CALLS_HANDLED_AFTER_THRESHOLD,
  qs.C_REVOUTCONT as OUTGOING_CALLS_ATTEMPTED 
from nice_wfm_customer1.dbo.R_ENTITY eeg
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on eeg.C_OID = heg.C_PARENT and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY ect on heg.C_CHILD = ect.C_OID and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_HIERARCHY hct on ect.C_OID = hct.C_PARENT and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and hct.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY eq on hct.C_CHILD = eq.C_OID and eq.C_TYPE = 'Q' and eq.C_ACT = 'A' and hct.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_QUEUE q on eq.C_OID = q.C_OID
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID
inner join nice_wfm_customer1.dbo.R_QUEUESTATS qs on qs.C_QUEUE = eq.C_OID and qs.C_TIMESTAMP >= hct.C_SDATE and (hct.C_EDATE IS NULL or qs.C_TIMESTAMP <= hct.C_EDATE)
inner join nice_wfm_customer1.dbo.R_TZINFO tz on ect.C_TZ = tz.C_TZ and qs.C_TIMESTAMP >= tz.C_BEGIN and qs.C_TIMESTAMP <= tz.C_END;

