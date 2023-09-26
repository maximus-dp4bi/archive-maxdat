-- DecisionPoint - NICE WFM
-- MAXDAT-6154 - Enable Traceability of CSR Agent Activity
-- Agent Activity
-- Build MicroStrategy cube from NICE WFM view via START_UTC_DATETIME.
-- Trim MicroStrategy cube via START_MU_DATE.

use nice_wfm_integration
go

drop view AGENT_ACTIVITY_SV;