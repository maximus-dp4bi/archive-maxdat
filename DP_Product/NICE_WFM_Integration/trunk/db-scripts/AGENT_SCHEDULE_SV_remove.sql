-- DecisionPoint - NICE WFM
-- Agent Schedule and Scheduled Absenteeism
-- Build MicroStrategy cube from NICE WFM view via SCHEDULE_START_UTC_DATETIME.
-- Trim MicroStrategy cube via MANAGEMENT_UNIT_DATE.

use nice_wfm_integration
go

drop view AGENT_SCHEDULE_SV;
