-- DecisionPoint - NICE WFM
-- Contact Type Forecast
-- Build MicroStrategy cube from NICE WFM view via UTC_DATETIME.
-- Trim MicroStrategy cube via Contact Date.

use nice_wfm_integration
go

create view CONTACT_TYPE_FORECAST_SV as 
select
  eeg.C_NAME ENTERPRISE_GROUP_NAME,
  ect.C_NAME CONTACT_TYPE_NAME,
  cast(f.C_GENTIME as datetime) FORECAST_GEN_UTC_DATETIME,
  cast(p.C_FCSTPRD as datetime) as UTC_DATETTIME,
  cast(switchoffset(p.C_FCSTPRD,tz.C_TZOFFSET) as date) as CONTACT_TYPE_DATE,
  cast(switchoffset(p.C_FCSTPRD,tz.C_TZOFFSET) as datetime) as CONTACT_TYPE_DATETIME,
  ect.C_TZ as CONTACT_TYPE_TIME_ZONE_NAME,
  cast(((substring(p.C_REVAHT,1,4) * 86400) + (substring(p.C_REVAHT,6,2) * 3600) + (substring(p.C_REVAHT,9,2) * 60) + substring(p.C_REVAHT,12,2)) as float) + (cast(substring(p.C_REVAHT,15,3) as float)/1000.0) as FORECAST_AVG_HANDLE_TIME_SEC,
  p.C_REVAVAIL as FORECAST_STAFF_AVAILABILITY,
  p.C_REVCONT as FORECAST_CONTACTS,
  p.C_REVCONTHNDL as FORECAST_CONTACTS_TO_BE_HANDLED,
  p.C_REVSLREQ as FORECAST_STAFF_NEED_SL_GOAL,
  p.C_REVEFFSL as FORECAST_ADJ_FACTOR_SL_GOAL,
  p.C_REVSLREQ as FORECAST_STAFF_NEED_ASA_GOAL,
  p.C_REVEFFASA as FORECAST_ADJ_FACTOR_ASA_GOAL,
  p.C_REVMAXOCCREQ as FORECAST_STAFF_NEED_MAX_OCC,
  p.C_REVSLGOAL as SERVICE_LEVEL_PERCENTAGE,
  cast(((substring(p.C_REVSLTIME,1,4) * 86400) + (substring(p.C_REVSLTIME,6,2) * 3600) + (substring(p.C_REVSLTIME,9,2) * 60) + substring(p.C_REVSLTIME,12,2)) as integer) as SERVICE_LEVEL_SEC
from nice_wfm_customer1.dbo.R_ENTITY eeg
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on eeg.C_OID = heg.C_PARENT and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY ect on heg.C_CHILD = ect.C_OID and ect.C_TYPE in ('T') and ect.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_TZINFO tz on ect.C_TZ = tz.C_TZ 
inner join nice_wfm_customer1.dbo.R_PLAN p on ect.C_OID = p.C_CT and p.C_FCSTPRD >= tz.C_BEGIN and p.C_FCSTPRD <= tz.C_END
inner join nice_wfm_customer1.dbo.R_FCST f on p.C_FCST = f.C_OID;