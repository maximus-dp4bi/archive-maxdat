-- DecisionPoint - NICE WFM
-- Agent Management Unit
-- All Agents.

use nice_wfm_integration
go

create view AGENT_MANAGEMENT_UNIT_SV as
select
  a.C_ID as AGENT_WFM_ID,
  emu.C_NAME as MANAGEMENT_UNIT_NAME,
  emu.C_ID as MANAGEMENT_UNIT_ID,
  emu.C_TZ as MANAGEMENT_UNIT_TIME_ZONE_NAME,
  cast(mr.C_SDATE as date) as START_DATE,
  cast(mr.C_EDATE as date) as END_DATE
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_MUROSTER mr on a.C_OID = mr.C_AGT and a.C_ACT = 'A' and mr.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_MU mu on mr.C_MU = mu.C_OID
inner join nice_wfm_customer1.dbo.R_ENTITY emu on mu.C_OID = emu.C_oID and emu.C_TYPE = 'M' and emu.C_ACT = 'A';



