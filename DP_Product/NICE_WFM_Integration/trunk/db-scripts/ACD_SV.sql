-- DecisionPoint - NICE WFM
-- ACD (Automated Call Distribution)

use nice_wfm_integration
go

create view ACD_SV as
select 
  C_NAME as ACD_NAME,
  C_TZ as ACD_TIME_ZONE_NAME
from nice_wfm_customer1.dbo.R_ACD;