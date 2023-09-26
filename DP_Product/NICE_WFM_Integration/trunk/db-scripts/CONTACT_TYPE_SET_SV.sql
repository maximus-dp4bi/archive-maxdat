-- DecisionPoint - NICE WFM
-- All Contact Type Sets

use nice_wfm_integration
go

create view CONTACT_TYPE_SET_SV as
select  
  eeg.C_NAME as ENTERPRISE_GROUP_NAME,
  ects.C_NAME as CONTACT_TYPE_SET_NAME,
  ect.C_NAME as CONTACT_TYPE_NAME,
  ect.C_TZ as CONTACT_TYPE_TIME_ZONE_NAME,
  eq.C_NAME  as QUEUE_NAME
from nice_wfm_customer1.dbo.R_ENTITY eeg
inner join nice_wfm_customer1.dbo.R_HIERARCHY heg on eeg.C_OID = heg.C_PARENT and eeg.C_TYPE = 'E' and eeg.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY ect on heg.C_CHILD = ect.C_OID and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and heg.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITYSETMBR esm on ect.C_OID = esm.C_ENTITY
inner join nice_wfm_customer1.dbo.R_ENTITYSET ects on esm.C_ENTITYSET = ects.C_OID and ects.C_TYPE = 'T'
inner join nice_wfm_customer1.dbo.R_HIERARCHY hct on ect.C_OID = hct.C_PARENT and ect.C_TYPE = 'T' and ect.C_ACT = 'A' and hct.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ENTITY eq on hct.C_CHILD = eq.C_OID and eq.C_TYPE = 'Q' and eq.C_ACT = 'A' and hct.C_ACT = 'A';
