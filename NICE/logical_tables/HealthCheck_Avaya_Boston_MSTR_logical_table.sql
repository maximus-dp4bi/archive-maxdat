select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, Site_Name, Contact_Center,
  App.Application as Queue_Name,
  /* case 
    when App.Application in 
      ('add_list_of_workload_queues_here') then 
	  sum(App.CallsOffered) 
    else */ coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + 
	   coalesce(
	     case 
		   when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
			 0 
		   else 
		     sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
		   end
	     ,0) + sum(App.CallsAbandoned) 
    /* end */ as Received,
  coalesce(sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold),0) as Handled_Before_Threshold,
  coalesce(
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
    ,0) as Handled_After_Threshold,
  coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) + 
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
	,0) as Handled,
  sum(App.CallsAbandoned) - sum(App.CallsAbandonedAftThreshold)  as Abandoned_Before_Threshold,
  sum(App.CallsAbandonedAftThreshold) as Abandoned_After_Threshold,
  sum(App.CallsAbandoned) as Abandoned
from
  (select
     ss.Timestamp as Dt, 'Boston' as Site_Name, 'MA MH' as Contact_Center,
     sk.Name as Application,
     ss.CallsOffered,
     ss.CallsAnswered,
     ss.CallsAnsweredAftThreshold,
     ss.CallsAbandoned,
     ss.CallsAbandonedAftThreshold
   from dbo.iApplicationStat ss
   inner join dbo.Application sk on ss.ApplicationID = sk.ApplicationID
   where
     sk.Name in (
       'CAC_Attck_s',
	   'Community_Partners_s',
       'DeptCorr_Special_s',
       'External_MHPB_s',
	   'External_MHPB_Spa_s',
	   'HC_1095B_s',
	   'HC_1095B_Spanish_s',
       'HC_1099_s',
       'Hlth_Safety_Net_s',
       'Hlth_Safety_Spanish_s',
       'Internal_Enrollment_Only_s',
       'Internal_HIX_CustSrv_s',
       'Internal_MHPB_s',
       'Internal_Transport_s',
       'Language_Line_s',
       'LTC_Tran_Phy_Claim_s',
       'MEC_AddNewborn_s',
       'MEC_Application_s',
       'MEC_Cust_Svc_s',
       'MEC_Mbr_Eligibility_s',
	   'MH_Mbr_Elig_Spa_sk',
       'MEC_Walk_In_s',
	   'MH_CMSP_s',
	   'MH_CMSP_Spn_s',
       'MH_HIX_CustSrv_s',
       'MH_HIX_NOWRONGDOOR_s',
       'MH_Mbr_App_Status_Spa_s',
       'MH_Mbr_Application',
	   'MH_Mbr_App_Status_Spa_sk',
       'MH_Mbr_Card_Replace',
       'MH_Mbr_CustSvc',
       'MH_Mbr_Elig_Spa_s',
       'MH_Mbr_Eligibilty_s',
       'MH_Mbr_Enroll_Spa_s',
       'MH_Mbr_Enrollment',
	   'MH_Mbr_Enroll_Spa_sk',
	   'MH_Mbr_FairHearingAppSupp_s',
	   'MH_Mbr_FairHrngAppSupp_SPN_s',
       'MH_Mbr_MAP',
       'MH_Mbr_Medicare_D_s',
	   'MH_Mbr_Other_Language_s',
       'MH_Mbr_Special2_s',
       'MH_Mbr_Transport',
	   'MH_Mbr_Transport_Spa_s', 
       'MH_Prov_Claims',
       'MH_Prov_CustSvc',
       'MH_Prov_DME_CS_s',
       'MH_Prov_Hipaa',
       'MH_Prov_InPat_OutPat_s',
       'MH_Prov_PEC_s',
       'MH_Prov_PIN',
       'MH_Prov_POSC',
       'MH_Prov_Transport',
	   'Mbr_Reque_Elig_s',
       'Mbr_Reque_s',
	   'MH_White_Glove_s',
	   'NH_En_s', 
	   'NH_SP_s', 
	   'One_Care_Mbr_Svcs',
       'One_Care_Span',
       'Prem_Billing_s',
       'Priority_Phone_App_s',							  
       'SS_Prem_Bill_s',
       'SS_Transport_s',
       'Senior_Care',
       'SpanAdv',
	   'Span_Elig_s',
       'Span_Prem_Billing_s',
       'Span_Reque_s',
       'Span_Transport_s'

       )
     and ss.Timestamp between dateadd('dd',datediff('dd',5,CURRENT_DATE),0) and dateadd('dd',datediff('dd',0,CURRENT_DATE),0)
) App
   left outer join
     (select
        Dt,
        Application,
        sum(CallsAnswered) + sum(CDNCalls) as CallsAnswered
	  from
        (select
           t1.Dt,
           t1.Application,
           t1.AgentLogin,
           t1.CallsAnswered as CallsAnswered,
           round(sum(t2.CDNCallsTransferredToDN) * 
		     case 
			   when sum(t2.TalkTime) = 0 then 
			     0 
			   else 
			     sum(t1.TalkTime) / sum(t2.TalkTime) 
			   end
			 ,0) as CDNCalls
	     from
           (select
              ss.Timestamp as Dt,
              sk.Name as Application,
              ss.AgentLogin,
              ss.CallsAnswered,
              ss.TalkTime
            from dbo.iAgentByApplicationStat ss
            inner join dbo.Application sk on ss.ApplicationID = sk.ApplicationID
            where
              sk.Name in (
       'CAC_Attck_s',
	   'Community_Partners_s',
       'DeptCorr_Special_s',
       'External_MHPB_s',
	   'External_MHPB_Spa_s',
	   'HC_1095B_s',
	   'HC_1095B_Spanish_s',
       'HC_1099_s',
       'Hlth_Safety_Net_s',
       'Hlth_Safety_Spanish_s',
       'Internal_Enrollment_Only_s',
       'Internal_HIX_CustSrv_s',
       'Internal_MHPB_s',
       'Internal_Transport_s',
       'Language_Line_s',
       'LTC_Tran_Phy_Claim_s',
       'MEC_AddNewborn_s',
       'MEC_Application_s',
       'MEC_Cust_Svc_s',
       'MEC_Mbr_Eligibility_s',
	   'MH_Mbr_Elig_Spa_sk',
       'MEC_Walk_In_s',
	   'MH_CMSP_s',
	   'MH_CMSP_Spn_s',
       'MH_HIX_CustSrv_s',
       'MH_HIX_NOWRONGDOOR_s',
       'MH_Mbr_App_Status_Spa_s',
       'MH_Mbr_Application',
	   'MH_Mbr_App_Status_Spa_sk',
       'MH_Mbr_Card_Replace',
       'MH_Mbr_CustSvc',
       'MH_Mbr_Elig_Spa_s',
       'MH_Mbr_Eligibilty_s',
       'MH_Mbr_Enroll_Spa_s',
       'MH_Mbr_Enrollment',
	   'MH_Mbr_Enroll_Spa_sk',
	   'MH_Mbr_FairHearingAppSupp_s',
	   'MH_Mbr_FairHrngAppSupp_SPN_s',
       'MH_Mbr_MAP',
       'MH_Mbr_Medicare_D_s',
	   'MH_Mbr_Other_Language_s',
       'MH_Mbr_Special2_s',
       'MH_Mbr_Transport',
	   'MH_Mbr_Transport_Spa_s', 
       'MH_Prov_Claims',
       'MH_Prov_CustSvc',
       'MH_Prov_DME_CS_s',
       'MH_Prov_Hipaa',
       'MH_Prov_InPat_OutPat_s',
       'MH_Prov_PEC_s',
       'MH_Prov_PIN',
       'MH_Prov_POSC',
       'MH_Prov_Transport',
	   'Mbr_Reque_Elig_s',
       'Mbr_Reque_s',
	   'MH_White_Glove_s',
	   'NH_En_s', 
	   'NH_SP_s', 
	   'One_Care_Mbr_Svcs',
       'One_Care_Span',
       'Prem_Billing_s',
       'Priority_Phone_App_s',							  
       'SS_Prem_Bill_s',
       'SS_Transport_s',
       'Senior_Care',
       'SpanAdv',
	   'Span_Elig_s',
       'Span_Prem_Billing_s',
       'Span_Reque_s',
       'Span_Transport_s'

              )
     and ss.Timestamp between dateadd('dd',datediff('dd',5,CURRENT_DATE),0) and dateadd('dd',datediff('dd',0,CURRENT_DATE),0)
		) t1
	  inner join
        (select 
		   aps.Timestamp as Dt,
           aps.AgentLogin,
           aps.CDNCallsTransferredToDN,
           aps.TalkTime
         from dbo.iAgentPerformanceStat aps  
         where
      aps.Timestamp between dateadd('dd',datediff('dd',5,CURRENT_DATE),0) and dateadd('dd',datediff('dd',0,CURRENT_DATE),0)

    ) t2 on t1.Dt = t2.Dt and t1.AgentLogin = t2.AgentLogin
    group by 
      t1.Dt,
      t1.Application,
      t1.AgentLogin,
      t1.CallsAnswered)
  group by Dt, Application) Ag on Ag.Dt = App.Dt and Ag.Application = App.Application
group by to_char(App.Dt, 'mm/dd/yyyy'),Site_Name,Contact_Center, App.Application

UNION
select 
  to_char('12/31/2999', 'mm/dd/yyyy') as DDate, 'Unknown' as Site_Name, 'Unknown' as Contact_Center,
  'Unknown' as Queue_Name,
  Sum(0) as Received,
  Sum(0) as Handled_Before_Threshold,
  Sum(0) as Handled_After_Threshold,
  Sum(0) as Handled,
Sum(0) as Abandoned_Before_Threshold,
Sum(0) as Abandoned_After_Threshold,
Sum(0) as Abandoned