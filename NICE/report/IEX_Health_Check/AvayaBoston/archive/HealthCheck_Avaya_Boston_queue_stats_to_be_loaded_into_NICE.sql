/* Get yesterday's Avaya - Boston queue stats. */
/* Avaya Boston PRD DB URL: jdbc:Cache://10.15.133.15:1972/ccms_stat */

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
'CAC_Attck_s',
'External_MHPB_s',
'HC_1095B_Spanish_s',
'HC_1095B_s',
'HC_1099_Spanish_s',
'HC_1099_s',
'Hlth_Safety_Net_s',
'Hlth_Safety_Spanish_s',
'Internal_Enrollment_Only_s',
'Internal_HIX_CustSrv_s',
'Internal_MHPB_s',
'Internal_Transport_s',
'LTC_Tran_Phy_Claim_s',
'MEC_AddNewborn_s',
'MEC_Application_s',
'MEC_Cust_Svc_s',
'MEC_Mbr_Eligibility_s',
'MEC_Notice_s',
'MH_HIX_CustSrv_s',
'MH_HIX_NOWRONGDOOR_s',
'MH_Mbr_Application',
'MH_Mbr_Card_Replace',
'MH_Mbr_CustSvc',
'MH_Mbr_Eligibilty_s',
'MH_Mbr_Enrollment',
'MH_Mbr_MAP',
'MH_Mbr_Medicare_D_s',
'MH_Mbr_Special2_s',
'MH_Mbr_Transport',
'MH_Prov_Claims',
'MH_Prov_CustSvc',
'MH_Prov_DME_CS_s',
'MH_Prov_Hipaa',
'MH_Prov_InPat_OutPat_s',
'MH_Prov_PEC_s',
'MH_Prov_PIN',
'MH_Prov_POSC',
'MH_Prov_Transport',
'Mbr_Reque_s',
'One_Care_Mbr_Svcs',
'One_Care_Span',
'Prem_Billing_s',
'RiteWay_Special_s',
'SS_APPLICATION_s',
'SS_ELIGIBILITY_s',
'SS_Prem_Bill_s',
'SS_Transport_s',
'Senior_Care',
'SpanAdv',
'Span_Prem_Billing_s',
'Span_Reque_s',
'Span_Transport_s')
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
sk.Name in('CAC_Attck_s',
'External_MHPB_s',
'HC_1095B_Spanish_s',
'HC_1095B_s',
'HC_1099_Spanish_s',
'HC_1099_s',
'Hlth_Safety_Net_s',
'Hlth_Safety_Spanish_s',
'Internal_Enrollment_Only_s',
'Internal_HIX_CustSrv_s',
'Internal_MHPB_s',
'Internal_Transport_s',
'LTC_Tran_Phy_Claim_s',
'MEC_AddNewborn_s',
'MEC_Application_s',
'MEC_Cust_Svc_s',
'MEC_Mbr_Eligibility_s',
'MEC_Notice_s',
'MH_HIX_CustSrv_s',
'MH_HIX_NOWRONGDOOR_s',
'MH_Mbr_Application',
'MH_Mbr_Card_Replace',
'MH_Mbr_CustSvc',
'MH_Mbr_Eligibilty_s',
'MH_Mbr_Enrollment',
'MH_Mbr_MAP',
'MH_Mbr_Medicare_D_s',
'MH_Mbr_Special2_s',
'MH_Mbr_Transport',
'MH_Prov_Claims',
'MH_Prov_CustSvc',
'MH_Prov_DME_CS_s',
'MH_Prov_Hipaa',
'MH_Prov_InPat_OutPat_s',
'MH_Prov_PEC_s',
'MH_Prov_PIN',
'MH_Prov_POSC',
'MH_Prov_Transport',
'Mbr_Reque_s',
'One_Care_Mbr_Svcs',
'One_Care_Span',
'Prem_Billing_s',
'RiteWay_Special_s',
'SS_APPLICATION_s',
'SS_ELIGIBILITY_s',
'SS_Prem_Bill_s',
'SS_Transport_s',
'Senior_Care',
'SpanAdv',
'Span_Prem_Billing_s',
'Span_Reque_s',
'Span_Transport_s')
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

