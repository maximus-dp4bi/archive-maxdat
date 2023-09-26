/*RUN AGAINST NICE IEX */

select P.c_lname+', '+P.c_fname as Name,
Convert(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(QS.C_TIMESTAMP, -360), '-10:00') as datetime),101) as Date
,sum(QS.C_ORIGHNDL) as Handled
,sum(QS.C_ORIGCONTTIMESECS) ContTime
,sum(C_ORIGHLDTIMESECS) HldTime
,sum(C_ORIGWORKTIMESECS) WorkTime
from
nice_wfm_customer1.dbo.R_AGTQUEUESTATS QS
inner join nice_wfm_customer1.dbo.R_AGT Ag on QS.C_AGT = Ag.C_OID
inner join nice_wfm_customer1.dbo.R_PERSON P on Ag.C_PERSON = P.C_OID
inner join nice_wfm_customer1.dbo.R_QUEUE Q on QS.C_QUEUE = Q.C_OID
inner join nice_wfm_customer1.dbo.R_ENTITY E on Q.C_OID = E.C_OID and E.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on Q.C_ACD = acd.C_OID and acd.C_Name = 'Cisco Enterprise' ----Update for ACD Name
Where CONVERT(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(QS.C_TIMESTAMP, -360), '-10:00') as date),111) >= '2016/06/25'
and CONVERT(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(QS.C_TIMESTAMP, -360), '-10:00') as date),111) <= '2016/06/29'
and Q.C_QTAG in('P5091','P5092','P5093','P5094','P5095')  ---Update the Queue Tags
GROUP by P.c_lname+', '+P.c_fname, 
Convert (char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(QS.C_TIMESTAMP, -360), '-10:00') as datetime),101)
order by 1,2


/*Run Against Avaya*/

select
aas.AgentSurname||', '||aas.AgentGivenName as Agt
,aas.Application
,to_char(aas.Timestamp,'mm/dd/yyyy') as Dt
,sum(aas.CallsAnswered) Answered 
,Sum(aas.TalkTime) Talk
--,Sum(aas.HoldTime) Hold
,sum(aas.PostCallProcessingTime) Wrap
from
dbo.iAgentByApplicationStat aas
where
aas.Application in('CES_EN_ESCALATION_s','CES_SP_ESCALATION_s','CSR_ENG_s','CSR_SPN_s','Gen_ENG_CES_s','Gen_SP_CES_s','HC_EN_CES_s'
,'HC_EN_CON_s','HC_OB_EN_CES_s','HC_OB_SP_CES_s','HC_SPN_CES_s','HC_SP_CON_s','ICP_EN_CES_s','ICP_EN_CON_s'
,'ICP?_OB_EN_CES_s','ICP_OB_SP_CES_s','ICP_SP_CES_s','ICP_SP_CON_s','ILEEV_ENG_Escalation_s','ILEEV_SPN_ESCALATION_s'
,'MAI_EN_CON_s','MAI_EN_s','MAI_OB_EN_s','MAI_OB_SP_s','MAI_SP_CON_s','MAI_SP_s','MMC_EN_CON_s','MMC_EN_sk'
,'MMC_OB_EN_s','MMC_OB_SP_s','MMC_SP_CON_s','MMC_SP_s','Sen_CSR_ENG_s','Sen_CSR_SPN_s','VMCALLBACK_ENG_s'
,'VMCALLBACK_EN_CES_s','VMCALLBACK_SPN_CES_s','VMCALLBACK_SPN_s','VMC_EN_CES_s','VMC_EN_CON_s','VMC_OB_EN_CES_s'
,'VMC_OB_SP_CES_s','VMC_SP_CES_s','VMC_SP_CON_s')  --- Update Application Names as needed
and 
aas.Timestamp >= '2016-04-22 00:00:00'
and aas.Timestamp <= '2016-05-07 00:00:00'
group by aas.AgentSurname||', '||aas.AgentGivenName,to_char(aas.Timestamp,'mm/dd/yyyy')
,aas.Application
order by 1,3,2;



/*Run Against CISCO*/

SELECT
  P.LastName+', '+P.FirstName as Agent
,CONVERT(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(ASGIS.DateTime, -360), '-04:00') as datetime),101) as Date  
, sum(CallsHandled) as Handled
, sum(TalkInTime) + sum(HoldTime) as ContTime
, sum(HoldTime) as HoldTime
, Sum(WorkNotReadyTime + WorkReadyTime) as WorkTime
FROM 
      maxco_awdb.dbo.Agent_Skill_Group_Interval ASGIS
JOIN  maxco_awdb.dbo.Agent AGT on ASGIS.SkillTargetID = AGT.SkillTargetID
JOIN  maxco_awdb.dbo.Person P on AGT.PersonID = P.PersonID
WHERE
SkillGroupSkillTargetID != 5000
AND ASGIS.PrecisionQueueID in(5091,5092,5093,5094,5095)
AND Convert(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(ASGIS.DateTime, -360), '-04:00') as datetime),111) >= '2016/06/25'
AND Convert(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(ASGIS.DateTime, -360), '-04:00') as datetime),111) <= '2016/06/29'
Group by P.LastName+', '+P.FirstName,CONVERT(char,CAST(SWITCHOFFSET(TODATETIMEOFFSET(ASGIS.DateTime, -360), '-04:00') as datetime),101)
order by 1,2