/* Get yesterday's Avaya - Chicago queue stats. */
/* Avaya Chicago PRD DB URL: jdbc:Cache://10.22.130.2:1972/ccms_stat */

Select to_char(App.Dt, 'mm/dd/yyyy') as Date
,App.Application as QueueName
,CASE WHEN App.Application in ('Workload_Queues') THEN sum(App.CallsOffered) ELSE Coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + Coalesce(CASE WHEN 
	sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 THEN 0 ELSE sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) 
	- sum(App.CallsAnsweredAftThreshold)) END,0) + sum(App.CallsAbandoned) END as Received
,Coalesce(sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold),0) as HandledBefThresh
,Coalesce(CASE WHEN sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 THEN 0 else 
	sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) end,0) as HandAftThresh
,Coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) + CASE WHEN sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 THEN 0 ELSE 
	sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) END,0) as Handled
,sum(App.CallsAbandoned) - sum(App.CallsAbandonedAftThreshold)  as AbanBefThresh
,sum(App.CallsAbandonedAftThreshold) as AbanAftThresh
,sum(App.CallsAbandoned) as Aband
	from
(select
dateadd('hh',-2,ss.Timestamp) as Dt
,sk.Name as Application
,ss.CallsOffered
,ss.CallsAnswered
,ss.CallsAnsweredAftThreshold
,ss.CallsAbandoned
,ss.CallsAbandonedAftThreshold
from
dbo.iApplicationStat ss
inner join dbo.Application sk on ss.ApplicationID = sk.ApplicationID
where
sk.Name in(
'CES_EN_ESCALATION_s',
'CES_SP_ESCALATION_s',
'CSR_ENG_s',
'CSR_SPN_s',
'Gen_ENG_CES_s',
'Gen_SP_CES_s',
'HC_EN_CES_s',
'HC_EN_CON_s',
'HC_OB_EN_CES_s',
'HC_OB_SP_CES_s',
'HC_SPN_CES_s',
'HC_SP_CON_s',
'ICP_EN_CES_s',
'ICP_EN_CON_s',
'ICP_OB_EN_CES_s',
'ICP_OB_SP_CES_S',
'ICP_SP_CES_s',
'ICP_SP_CON_s',
'MAI_EN_CON_s',
'MAI_EN_s',
'MAI_OB_EN_s',
'MAI_OB_SP_s',
'MAI_SP_CON_s',
'MAI_SP_s',
'MMC_EN_CON_s',
'MMC_EN_s',
'MMC_EN_sk',
'MMC_OB_EN_s',
'MMC_OB_SP_s',
'MMC_SP_CON_s',
'MMC_SP_s',
'Sen_CSR_ENG_s',
'Sen_CSR_SPN_s',
'VMCALLBACK_ENG_s',
'VMCALLBACK_EN_CES_s',
'VMCALLBACK_SPN_s',
'VMCALLBACK_SP_CES_s',
'VMCALLBACK_SPN_CES_s',
'VMC_EN_CES_s',
'VMC_EN_CON_s',
'VMC_OB_EN_CES_s',
'VMC_OB_SP_CES_s',
'VMC_SP_CES_s',
'VMC_SP_CON_s')
and dateadd('hh',-2,ss.Timestamp) >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
and dateadd('hh',-2,ss.Timestamp) < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) App
	left outer join
(Select
Dt
,Application
,sum(CallsAnswered) + sum(CDNCalls) as CallsAnswered
	from
(Select
t1.Dt
,t1.Application
,t1.AgentLogin
,t1.CallsAnswered as CallsAnswered
,Round(sum(t2.CDNCallsTransferredToDN)* CASE WHEN Sum(t2.TalkTime) = 0 then 0 else sum(t1.TalkTime)/Sum(t2.TalkTime) end,0) as CDNCalls
	from
(select
dateadd('hh',-2,ss.Timestamp) as Dt
,sk.Name as Application
,ss.AgentLogin
,ss.CallsAnswered
,ss.TalkTime
from
dbo.iAgentByApplicationStat ss
inner join dbo.Application sk on ss.ApplicationID = sk.ApplicationID
where
sk.Name in('CES_EN_ESCALATION_s',
'CES_SP_ESCALATION_s',
'CSR_ENG_s',
'CSR_SPN_s',
'Gen_ENG_CES_s',
'Gen_SP_CES_s',
'HC_EN_CES_s',
'HC_EN_CON_s',
'HC_OB_EN_CES_s',
'HC_OB_SP_CES_s',
'HC_SPN_CES_s',
'HC_SP_CON_s',
'ICP_EN_CES_s',
'ICP_EN_CON_s',
'ICP_OB_EN_CES_s',
'ICP_OB_SP_CES_S',
'ICP_SP_CES_s',
'ICP_SP_CON_s',
'MAI_EN_CON_s',
'MAI_EN_s',
'MAI_OB_EN_s',
'MAI_OB_SP_s',
'MAI_SP_CON_s',
'MAI_SP_s',
'MMC_EN_CON_s',
'MMC_EN_s',
'MMC_EN_sk',
'MMC_OB_EN_s',
'MMC_OB_SP_s',
'MMC_SP_CON_s',
'MMC_EN_sk',
'MMC_SP_s',
'Sen_CSR_ENG_s',
'Sen_CSR_SPN_s',
'VMCALLBACK_ENG_s',
'VMCALLBACK_EN_CES_s',
'VMCALLBACK_SPN_s',
'VMCALLBACK_SP_CES_s',
'VMCALLBACK_SPN_CES_s',
'VMC_EN_CES_s',
'VMC_EN_CON_s',
'VMC_OB_EN_CES_s',
'VMC_OB_SP_CES_s',
'VMC_SP_CES_s',
'VMC_SP_CON_s')
and dateadd('hh',-2,ss.Timestamp) >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
and dateadd('hh',-2,ss.Timestamp) < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) t1
	inner join
(select dateadd('hh',-2,aps.Timestamp) as Dt
,aps.AgentLogin
,aps.CDNCallsTransferredToDN
,aps.TalkTime
from
dbo.iAgentPerformanceStat aps  
where
dateadd('hh',-2,aps.Timestamp) >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
and dateadd('hh',-2,aps.Timestamp) < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) t2
	on t1.Dt = t2.Dt and t1.AgentLogin = t2.AgentLogin
group by t1.Dt
,t1.Application
,t1.AgentLogin
,t1.CallsAnswered)
group by Dt, Application) Ag
	on Ag.Dt = App.Dt and Ag.Application = App.Application
group by to_char(App.Dt, 'mm/dd/yyyy'), App.Application
order by 1,2;
