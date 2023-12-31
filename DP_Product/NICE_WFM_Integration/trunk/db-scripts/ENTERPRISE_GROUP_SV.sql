-- DecisionPoint - NICE WFM
-- Enterprise Group

use nice_wfm_integration
go

create view ENTERPRISE_GROUP_SV as
select
  e.C_NAME as ENTERPRISE_GROUP_NAME,
  e.C_TZ as EG_TIME_ZONE_NAME,
  ega.AMP_PROJECT_NAME,
  ega.AMP_PROGRAM_NAME,
  ega.AMP_GEOGRAPHY_NAME,
  ega.NICE_WFM_START_DATE,
  ega.NICE_WFM_END_DATE
from nice_wfm_customer1.dbo.R_ENTITY e
left outer join nice_wfm_integration.dbo.ENTERPRISE_GROUP_AMP ega on e.C_NAME = ega.ENTERPRISE_GROUP_NAME
where 
   C_TYPE = 'E' and
   C_ACT = 'A';
