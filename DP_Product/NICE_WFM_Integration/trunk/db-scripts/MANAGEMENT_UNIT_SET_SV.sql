-- DecisionPoint - NICE WFM
-- All Management Unit Sets

use nice_wfm_integration
go

create view MANAGEMENT_UNIT_SET_SV as
select  
  eeg.C_NAME as ENTERPRISE_GROUP_NAME,
  emus.C_NAME as MANAGEMENT_UNIT_SET_NAME,
  emu.C_NAME as MANAGEMENT_UNIT_NAME,
  emu.C_ID as MANAGEMENT_UNIT_ID,
  emu.C_TZ as MANAGEMENT_UNIT_TIME_ZONE_NAME
from nice_wfm_customer1.dbo.R_ENTITY eeg
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on eeg.C_OID = heg.C_PARENT and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY emu on heg.C_CHILD = emu.C_OID and emu.C_TYPE = 'M' and emu.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITYSETMBR esm on emu.C_OID = esm.C_ENTITY
inner join nice_wfm_customer1.dbo.R_ENTITYSET emus on esm.C_ENTITYSET = emus.C_OID and emus.C_TYPE = 'M';

