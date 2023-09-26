select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Burlington' as Site_Name, 'VT VHC' as Contact_Center,
  App.Application as Queue_Name,
  /* case 
    when App.Application in (
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
     ss.Timestamp as Dt,
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
				'VT_BUS_s',
				'VT_GMC_OTH_s',
				'VT_VHC_ASSISTER_s',
				'VT_VHC_CARRIER_s',
				'VT_VHC_GMC_Phase1_s',
				'VT_VHC_GMC_Phase2_s',
				'VT_VHC_OTH_s',
				'VT_VHC_PAYMENT_s',
				'VT_VHC_SMALLBIZ_s',
				'VT_XFER_GMC_PMTS_s',
				'VT_XFER_GMC_RSRCH_s',
				'VT_XFER_VHC_PMTS_s',
				'XFER_CHI_TO_BTV_s',
				'VT_XFER_BUS_s',
				'VT_XFER_VHC_RSRCH_s',
				'VT_SPECIAL_INITIATIVE_s'
              )
     and ss.Timestamp >= dateadd('dd',datediff('dd',5,CURRENT_DATE),0)
     and ss.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)) App
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
				'VT_BUS_s',
				'VT_GMC_OTH_s',
				'VT_VHC_ASSISTER_s',
				'VT_VHC_CARRIER_s',
				'VT_VHC_GMC_Phase1_s',
				'VT_VHC_GMC_Phase2_s',
				'VT_VHC_OTH_s',
				'VT_VHC_PAYMENT_s',
				'VT_VHC_SMALLBIZ_s',
				'VT_XFER_GMC_PMTS_s',
				'VT_XFER_GMC_RSRCH_s',
				'VT_XFER_VHC_PMTS_s',
				'XFER_CHI_TO_BTV_s',
				'VT_XFER_BUS_s',
				'VT_XFER_VHC_RSRCH_s',
				'VT_SPECIAL_INITIATIVE_s'
				)
            and ss.Timestamp >= dateadd('dd',datediff('dd',5,CURRENT_DATE),0)
            and ss.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)
		) t1
	  inner join
        (select 
		   aps.Timestamp as Dt,
           aps.AgentLogin,
           aps.CDNCallsTransferredToDN,
           aps.TalkTime
         from dbo.iAgentPerformanceStat aps  
         where
           aps.Timestamp >= dateadd('dd',datediff('dd',5,CURRENT_DATE),0)
           and aps.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)
    ) t2 on t1.Dt = t2.Dt and t1.AgentLogin = t2.AgentLogin
    group by 
      t1.Dt,
      t1.Application,
      t1.AgentLogin,
      t1.CallsAnswered)
  group by Dt, Application) Ag on Ag.Dt = App.Dt and Ag.Application = App.Application
group by 
  to_char(App.Dt,'mm/dd/yyyy'), 'Burlington', 'VT VHC',
  App.Application

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