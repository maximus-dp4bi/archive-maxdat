-- DecisionPoint - NICE WFM
-- Agent Language History

use nice_wfm_integration
go

create view AGENT_LANGUAGE_SV as
select
  a.C_ID as AGENT_WFM_ID,
  adv.C_ALPHAVAL as AGENT_LANGUAGE,
  cast(substring(addef.C_DESCR,10,1) as integer) as AGENT_LANGUAGE_ORDER,
  cast(ad.C_SDATE as date) as START_DATE,
  cast(ad.C_EDATE as date) as END_DATE
from nice_wfm_customer1.dbo.R_AGTDATADEF addef
inner join nice_wfm_customer1.dbo.R_AGTDATAVAL adv on addef.C_DESCR in ('Language 1','Language 2') and addef.C_OID = adv.C_AGTDATADEF
inner join nice_wfm_customer1.dbo.R_AGTDATA ad on adv.C_OID = ad.C_AGTDATAVAL
inner join nice_wfm_customer1.dbo.R_AGT a on ad.C_AGT = a.C_OID and a.C_ACT = 'A';