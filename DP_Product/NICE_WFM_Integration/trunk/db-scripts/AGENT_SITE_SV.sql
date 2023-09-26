-- DecisionPoint - NICE WFM
-- Agent Site History

use nice_wfm_integration
go

create view AGENT_SITE_SV as 
select
  a.C_ID as AGENT_WFM_ID,
  adv.C_ALPHAVAL as AGENT_SITE_NAME,
  cast(ad.C_SDATE as date) as START_DATE,
  cast(ad.C_EDATE as date) as END_DATE
from nice_wfm_customer1.dbo.R_AGTDATADEF addef
inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR = 'Site' and addef.C_OID = adv.C_AGTDATADEF
inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A';