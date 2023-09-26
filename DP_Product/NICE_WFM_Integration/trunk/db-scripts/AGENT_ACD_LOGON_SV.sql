-- DecisionPoint - NICE WFM
-- Agent ACD Logon

use nice_wfm_integration
go

create view AGENT_ACD_LOGON_SV as 
select
  a.C_ID as AGENT_WFM_ID,
  aa.C_AGTLOGON as AGENT_LOGON_ID,
  aa.C_LOGINTYPE as LOGIN_TYPE,
  acd.C_NAME as ACD_NAME,
  aa.C_PRI as ACD_PRIORITY,
  cast(aaa.C_SDATE as date) as ACD_ASSIGN_START_DATE,
  cast(aaa.C_EDATE as date) as ACD_ASSIGN_END_DATE
from nice_wfm_customer1.dbo.R_AGT a
inner join nice_wfm_customer1.dbo.R_AGTACDASSGN aaa on a.C_OID = aaa.C_AGT and a.C_ACT = 'A'
inner join nice_wfm_customer1.dbo.R_ASSIGNEDACDS aa on aaa.C_OID = aa.C_AGTACDASSGN
inner join nice_wfm_customer1.dbo.R_ACD acd on aa.C_ACD = acd.C_OID;


