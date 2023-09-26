/* Get yesterday's Avaya - Folsom queue stats. */
/* Avaya Folsom PRD DB URL: jdbc:Cache://10.2.6.1:1972/CCMS_STAT */

Select to_char(App.Dt, 'mm/dd/yyyy') as Date
,App.Application as QueueName
,CASE WHEN App.Application in ('ExLn_CB_agt_ara_s','ExLn_CB_agt_arm_s','ExLn_CB_agt_cam_s','ExLn_CB_agt_can_s','ExLn_CB_agt_eng_s','ExLn_CB_agt_far_s'
	,'ExLn_CB_agt_hmo_s','ExLn_CB_agt_kor_s','ExLn_CB_agt_man_s','ExLn_CB_agt_rus_s','ExLn_CB_agt_esp_s','ExLn_CB_agt_tag_s','ExLn_CB_agt_vie_s'
	,'HCO_CB_agt_eng_s','HCO_CB_agt_esp_s','SCSC_CB_agt_ara_s','SCSC_CB_agt_arm_s','SCSC_CB_agt_cam_s','SCSC_CB_agt_can_s','SCSC_CB_agt_eng_s'
	,'SCSC_CB_agt_far_s','SCSC_CB_agt_hmo_s','SCSC_CB_agt_kor_s','SCSC_CB_agt_man_s','SCSC_CB_agt_rus_s','SCSC_CB_agt_esp_s','SCSC_CB_agt_tag_s'
	,'SCSC_CB_agt_vie_s') THEN sum(App.CallsOffered) ELSE Coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + Coalesce(CASE WHEN 
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
ss.Timestamp as Dt
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
sk.Name in('AIM_Armenian_S','AIM_Cambodian_S','AIM_Cantonese_S','AIM_English_S','AIM_Farsi_S','AIM_Hmong_S','AIM_Korean_S','AIM_Laotian_S'
,'AIM_Russian_S','AIM_Spanish_S','AIM_Tran_Armenian_S','AIM_Tran_Cambodian_S','AIM_Tran_Cantonese_S','AIM_Tran_English_S','AIM_Tran_Farsi_S'
,'AIM_Tran_Hmong_S','AIM_Tran_Korean_S','AIM_Tran_Laotian_S','AIM_Tran_Russian_S','AIM_Tran_Spanish_S','AIM_Tran_Vietnamese_S','AIM_Vietnamese_S'
,'Diversion_S','ExLn_Esp_s','ExLn_ara_s','ExLn_arm_s'
,'ExLn_cam_s','ExLn_can_s','ExLn_eng_s','ExLn_far_s','ExLn_hmo_s','ExLn_kor_s','ExLn_man_s','ExLn_rus_s','ExLn_tag_s','ExLn_vie_s','F_ops_s','HCO_CB_agt_eng_s'
,'HCO_CB_agt_esp_s','HCO_eng_s','HCO_esp_s','HFP_Armenian_S','HFP_Armenian_ovfl_S','HFP_Cambodian_S','HFP_Cambodian_ovfl_S','HFP_Cantonese_S'
,'HFP_Cantonese_ovfl_S','HFP_English_S','HFP_English_ovfl_S','HFP_Farsi_S','HFP_Farsi_ovfl_S','HFP_Hmong_S','HFP_Hmong_ovfl_S','HFP_Korean_S','HFP_Korean_ovfl_S'
,'HFP_Laotian_S','HFP_Laotian_ovfl_S','HFP_Russian_S','HFP_Russian_ovfl_S','HFP_SPE_Fail_Armenian_S','HFP_SPE_Fail_Cambodian_S','HFP_SPE_Fail_Cantonese_S'
,'HFP_SPE_Fail_English_S','HFP_SPE_Fail_Farsi_S','HFP_SPE_Fail_Hmong_S','HFP_SPE_Fail_Korean_S','HFP_SPE_Fail_Laotian_S','HFP_SPE_Fail_Russian_S'
,'HFP_SPE_Fail_Spanish_S','HFP_SPE_Fail_Vietnamese_S','HFP_Spanish_S','HFP_Spanish_ovfl_S','HFP_Tran_Armenian_S','HFP_Tran_Cambodian_S','HFP_Tran_Cantonese_S'
,'HFP_Tran_English_S','HFP_Tran_Farsi_S','HFP_Tran_Hmong_S','HFP_Tran_Korean_S','HFP_Tran_Laotian_S','HFP_Tran_Russian_S','HFP_Tran_Spanish_S'
,'HFP_Tran_Vietnamese_S','HFP_Vietnamese_S','HFP_Vietnamese_ovfl_S','HI_ovfl_s','IBR_Eng_s','IBR_Escalate_eng_s','IBR_Escalate_spn_s','IBR_Spn_s','IMR_Eng_s'
,'IMR_Escalate_eng_s','IMR_Escalate_spn_s','IMR_Spn_s','MH_HC_1095B_Spanish_s','MH_HC_1095B_s','MH_HC_1099_Spanish_s','MH_HC_1099_s','MH_HIX_App_EN_s'
,'MH_HIX_App_SP_s','MH_HIX_Applications_Spanish_s','MH_HIX_NOWRONGDOOR_s','MH_MEC_AddNewborn_s','MH_MEC_Application_s','MH_MEC_Cust_Svc_s'
,'MH_MEC_Mbr_Eligibility_s','MH_MEC_Notice_s','MH_Mbr_Application_s','MH_Mbr_Card_Replace_s','MH_Mbr_CustSvc_s','MH_Mbr_Eligibility_s','MH_Mbr_Enrollment_s'
,'MH_Mbr_MAP_s','MH_Mbr_Transport_s','MH_SS_Application_s','MH_SS_Eligibility_s','MH_SS_Transport_s','MH_Span_Adv_s','MH_Takeback_Xfer_Eng_s'
,'MH_Takeback_Xfer_Spn_s','SCSC_CB_agt_eng_s','SCSC_CB_agt_esp_s','SCSC_Rus_s'
,'SCSC_ara_s','SCSC_arm_s','SCSC_cam_s','SCSC_can_s','SCSC_eng_s','SCSC_esp_s','SCSC_far_s','SCSC_hmo_s','SCSC_kor_s','SCSC_man_s','SCSC_tag_s','SCSC_vie_s'
,'SPE_Armenian_S','SPE_Assist_Armenian_S','SPE_Assist_Cambodian_S','SPE_Assist_Cantonese_S','SPE_Assist_English_S','SPE_Assist_Farsi_S','SPE_Assist_Hmong_S'
,'SPE_Assist_Korean_S','SPE_Assist_Laotian_S','SPE_Assist_Russian_S','SPE_Assist_Spanish_S','SPE_Assist_Vietnamese_S','SPE_Cambodian_S','SPE_Cantonese_S'
,'SPE_English_S','SPE_Farsi_S','SPE_Hmong_S','SPE_Korean_S','SPE_Laotian_S','SPE_Russian_S','SPE_Spanish_S','SPE_Tran_Armenian_S','SPE_Tran_Cambodian_S'
,'SPE_Tran_Cantonese_S','SPE_Tran_English_S','SPE_Tran_Farsi_S','SPE_Tran_Hmong_S','SPE_Tran_Korean_S','SPE_Tran_Laotian_S','SPE_Tran_Russian_S'
,'SPE_Tran_Spanish_S','SPE_Tran_Vietnamese_S','SPE_Vietnamese_S','TN_ENG_s','TN_OTHLANG_s','TN_SPAN_s','Tech_Support_S')
and ss.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
and ss.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) App
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
ss.Timestamp as Dt
,sk.Name as Application
,ss.AgentLogin
,ss.CallsAnswered
,ss.TalkTime
from
dbo.iAgentByApplicationStat ss
inner join dbo.Application sk on ss.ApplicationID = sk.ApplicationID
where
sk.Name in('AIM_Armenian_S','AIM_Cambodian_S','AIM_Cantonese_S','AIM_English_S','AIM_Farsi_S','AIM_Hmong_S','AIM_Korean_S','AIM_Laotian_S'
,'AIM_Russian_S','AIM_Spanish_S','AIM_Tran_Armenian_S','AIM_Tran_Cambodian_S','AIM_Tran_Cantonese_S','AIM_Tran_English_S','AIM_Tran_Farsi_S'
,'AIM_Tran_Hmong_S','AIM_Tran_Korean_S','AIM_Tran_Laotian_S','AIM_Tran_Russian_S','AIM_Tran_Spanish_S','AIM_Tran_Vietnamese_S','AIM_Vietnamese_S'
,'Diversion_S','ExLn_Esp_s','ExLn_ara_s','ExLn_arm_s'
,'ExLn_cam_s','ExLn_can_s','ExLn_eng_s','ExLn_far_s','ExLn_hmo_s','ExLn_kor_s','ExLn_man_s','ExLn_rus_s','ExLn_tag_s','ExLn_vie_s','F_ops_s','HCO_CB_agt_eng_s'
,'HCO_CB_agt_esp_s','HCO_eng_s','HCO_esp_s','HFP_Armenian_S','HFP_Armenian_ovfl_S','HFP_Cambodian_S','HFP_Cambodian_ovfl_S','HFP_Cantonese_S'
,'HFP_Cantonese_ovfl_S','HFP_English_S','HFP_English_ovfl_S','HFP_Farsi_S','HFP_Farsi_ovfl_S','HFP_Hmong_S','HFP_Hmong_ovfl_S','HFP_Korean_S','HFP_Korean_ovfl_S'
,'HFP_Laotian_S','HFP_Laotian_ovfl_S','HFP_Russian_S','HFP_Russian_ovfl_S','HFP_SPE_Fail_Armenian_S','HFP_SPE_Fail_Cambodian_S','HFP_SPE_Fail_Cantonese_S'
,'HFP_SPE_Fail_English_S','HFP_SPE_Fail_Farsi_S','HFP_SPE_Fail_Hmong_S','HFP_SPE_Fail_Korean_S','HFP_SPE_Fail_Laotian_S','HFP_SPE_Fail_Russian_S'
,'HFP_SPE_Fail_Spanish_S','HFP_SPE_Fail_Vietnamese_S','HFP_Spanish_S','HFP_Spanish_ovfl_S','HFP_Tran_Armenian_S','HFP_Tran_Cambodian_S','HFP_Tran_Cantonese_S'
,'HFP_Tran_English_S','HFP_Tran_Farsi_S','HFP_Tran_Hmong_S','HFP_Tran_Korean_S','HFP_Tran_Laotian_S','HFP_Tran_Russian_S','HFP_Tran_Spanish_S'
,'HFP_Tran_Vietnamese_S','HFP_Vietnamese_S','HFP_Vietnamese_ovfl_S','HI_ovfl_s','IBR_Eng_s','IBR_Escalate_eng_s','IBR_Escalate_spn_s','IBR_Spn_s','IMR_Eng_s'
,'IMR_Escalate_eng_s','IMR_Escalate_spn_s','IMR_Spn_s','MH_HC_1095B_Spanish_s','MH_HC_1095B_s','MH_HC_1099_Spanish_s','MH_HC_1099_s','MH_HIX_App_EN_s'
,'MH_HIX_App_SP_s','MH_HIX_Applications_Spanish_s','MH_HIX_NOWRONGDOOR_s','MH_MEC_AddNewborn_s','MH_MEC_Application_s','MH_MEC_Cust_Svc_s'
,'MH_MEC_Mbr_Eligibility_s','MH_MEC_Notice_s','MH_Mbr_Application_s','MH_Mbr_Card_Replace_s','MH_Mbr_CustSvc_s','MH_Mbr_Eligibility_s','MH_Mbr_Enrollment_s'
,'MH_Mbr_MAP_s','MH_Mbr_Transport_s','MH_SS_Application_s','MH_SS_Eligibility_s','MH_SS_Transport_s','MH_Span_Adv_s','MH_Takeback_Xfer_Eng_s'
,'MH_Takeback_Xfer_Spn_s','SCSC_CB_agt_eng_s','SCSC_CB_agt_esp_s','SCSC_Rus_s'
,'SCSC_ara_s','SCSC_arm_s','SCSC_cam_s','SCSC_can_s','SCSC_eng_s','SCSC_esp_s','SCSC_far_s','SCSC_hmo_s','SCSC_kor_s','SCSC_man_s','SCSC_tag_s','SCSC_vie_s'
,'SPE_Armenian_S','SPE_Assist_Armenian_S','SPE_Assist_Cambodian_S','SPE_Assist_Cantonese_S','SPE_Assist_English_S','SPE_Assist_Farsi_S','SPE_Assist_Hmong_S'
,'SPE_Assist_Korean_S','SPE_Assist_Laotian_S','SPE_Assist_Russian_S','SPE_Assist_Spanish_S','SPE_Assist_Vietnamese_S','SPE_Cambodian_S','SPE_Cantonese_S'
,'SPE_English_S','SPE_Farsi_S','SPE_Hmong_S','SPE_Korean_S','SPE_Laotian_S','SPE_Russian_S','SPE_Spanish_S','SPE_Tran_Armenian_S','SPE_Tran_Cambodian_S'
,'SPE_Tran_Cantonese_S','SPE_Tran_English_S','SPE_Tran_Farsi_S','SPE_Tran_Hmong_S','SPE_Tran_Korean_S','SPE_Tran_Laotian_S','SPE_Tran_Russian_S'
,'SPE_Tran_Spanish_S','SPE_Tran_Vietnamese_S','SPE_Vietnamese_S','TN_ENG_s','TN_OTHLANG_s','TN_SPAN_s','Tech_Support_S')
and ss.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
and ss.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) t1
	inner join
(select aps.Timestamp as Dt
,aps.AgentLogin
,aps.CDNCallsTransferredToDN
,aps.TalkTime
from
dbo.iAgentPerformanceStat aps  
where
  aps.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
  and aps.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) t2
	on t1.Dt = t2.Dt and t1.AgentLogin = t2.AgentLogin
group by t1.Dt
,t1.Application
,t1.AgentLogin
,t1.CallsAnswered)
group by Dt, Application) Ag
	on Ag.Dt = App.Dt and Ag.Application = App.Application
group by to_char(App.Dt, 'mm/dd/yyyy'), App.Application
order by 1,2