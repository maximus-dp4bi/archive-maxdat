select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Chicago' as Site_Name, 'CES' as Contact_Center,
  App.Application as Queue_Name,
  coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + 
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
       'CES_EN_ESCALATION_s',
       'CES_SP_ESCALATION_s',
       'Gen_ENG_CES_s',
       'Gen_SP_CES_s',
       'HC_EN_CES_s',
       'HC_OB_EN_CES_s',
       'HC_OB_SP_CES_s',
       'HC_SPN_CES_s',
       'HC_SP_CON_s',
       'ICP_EN_CES_s',
       'ICP_EN_CON_s',
       'ICP_OB_EN_CES_s',
       'ICP_OB_SP_CES_s',
       'ICP_SP_CES_s',
       'ICP_SP_CON_s',
       'MAI_EN_CON_s',
       'MAI_EN_s',
       'MAI_OB_EN_s',
       'MAI_OB_SP_s',
       'MAI_SP_CON_s',
       'MAI_SP_s',
       'MMC_EN_CON_s',
       'MMC_EN_sk',
       'MMC_OB_EN_s',
       'MMC_OB_SP_s',
       'MMC_SP_CON_s',
       'MMC_SP_s',
       'MMCP_EN_CES_s',
       'MMCP_SP_CES_s',
       'MMCP_OB_EN_CES_s',
       'MMCP_OB_SP_CES_s',
       'MMCP_EN_CON_s',
       'MMCP_SP_CON_s',
       'LMMCP_EN_CES_s',
       'LMMCP_SP_CES_s',
       'LMMCP_OB_EN_CES_s',
       'LMMCP_OB_SP_CES_s',
       'LMMCP_EN_CON_s',
       'LMMCP_SP_CON_s',
       'LMAI_EN_CES_s',
       'LMAI_SP_CES_s',
       'LMAI_OB_EN_CES_s',
       'LMAI_OB_SP_CES_s',
       'LMAI_EN_CON_s',
       'LMAI_SP_CON_s',
       'VMCALLBACK_EN_CES_s',
       'VMCALLBACK_SPN_CES_s',
       'VMC_EN_CES_s',
       'VMC_EN_CON_s',
       'VMC_OB_EN_CES_s',
       'VMC_OB_SP_CES_s',
       'VMC_SP_CES_s',
       'VMC_SP_CON_s'
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
       'CES_EN_ESCALATION_s',
       'CES_SP_ESCALATION_s',
       'Gen_ENG_CES_s',
       'Gen_SP_CES_s',
       'HC_EN_CES_s',
       'HC_OB_EN_CES_s',
       'HC_OB_SP_CES_s',
       'HC_SPN_CES_s',
       'HC_SP_CON_s',
       'ICP_EN_CES_s',
       'ICP_EN_CON_s',
       'ICP_OB_EN_CES_s',
       'ICP_OB_SP_CES_s',
       'ICP_SP_CES_s',
       'ICP_SP_CON_s',
       'MAI_EN_CON_s',
       'MAI_EN_s',
       'MAI_OB_EN_s',
       'MAI_OB_SP_s',
       'MAI_SP_CON_s',
       'MAI_SP_s',
       'MMC_EN_CON_s',
       'MMC_EN_sk',
       'MMC_OB_EN_s',
       'MMC_OB_SP_s',
       'MMC_SP_CON_s',
       'MMC_SP_s',
       'MMCP_EN_CES_s',
       'MMCP_SP_CES_s',
       'MMCP_OB_EN_CES_s',
       'MMCP_OB_SP_CES_s',
       'MMCP_EN_CON_s',
       'MMCP_SP_CON_s',
       'LMMCP_EN_CES_s',
       'LMMCP_SP_CES_s',
       'LMMCP_OB_EN_CES_s',
       'LMMCP_OB_SP_CES_s',
       'LMMCP_EN_CON_s',
       'LMMCP_SP_CON_s',
       'LMAI_EN_CES_s',
       'LMAI_SP_CES_s',
       'LMAI_OB_EN_CES_s',
       'LMAI_OB_SP_CES_s',
       'LMAI_EN_CON_s',
       'LMAI_SP_CON_s',
       'VMCALLBACK_EN_CES_s',
       'VMCALLBACK_SPN_CES_s',
       'VMC_EN_CES_s',
       'VMC_EN_CON_s',
       'VMC_OB_EN_CES_s',
       'VMC_OB_SP_CES_s',
       'VMC_SP_CES_s',
       'VMC_SP_CON_s'
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
group by 
  to_char(App.Dt,'mm/dd/yyyy'), 'Chicago', 'CES',
  App.Application
union
select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Chicago' as Site_Name, 'EEV' as Contact_Center,
  App.Application as Queue_Name,
coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + 
	   coalesce(
	     case 
		   when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
			 0 
		   else 
		     sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
		   end
	     ,0) + sum(App.CallsAbandoned) 
    /* end */ as Received,
  coalesce(sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold),0) as HandledBefThresh,
  coalesce(
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
    ,0) as HandAftThresh,
  coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) + 
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
	,0) as Handled,
  sum(App.CallsAbandoned) - sum(App.CallsAbandonedAftThreshold)  as AbanBefThresh,
  sum(App.CallsAbandonedAftThreshold) as AbanAftThresh,
  sum(App.CallsAbandoned) as Aband
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
       'CSR_ENG_s',
       'CSR_SPN_s',
       'Sen_CSR_ENG_s',
       'Sen_CSR_SPN_s',
       'VMCALLBACK_ENG_s',
       'VMCALLBACK_SPN_s'
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
       'CSR_ENG_s',
       'CSR_SPN_s',
       'Sen_CSR_ENG_s',
       'Sen_CSR_SPN_s',
       'VMCALLBACK_ENG_s',
       'VMCALLBACK_SPN_s'
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
group by 
  to_char(App.Dt,'mm/dd/yyyy'), 'Chicago', 'EEV',
  App.Application
union
select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Chicago' as Site_Name, 'MI MSS' as Contact_Center,
  App.Application as Queue_Name,
coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + 
	   coalesce(
	     case 
		   when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
			 0 
		   else 
		     sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
		   end
	     ,0) + sum(App.CallsAbandoned) 
    /* end */ as Received,
  coalesce(sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold),0) as HandledBefThresh,
  coalesce(
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
    ,0) as HandAftThresh,
  coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) + 
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
	,0) as Handled,
  sum(App.CallsAbandoned) - sum(App.CallsAbandonedAftThreshold)  as AbanBefThresh,
  sum(App.CallsAbandonedAftThreshold) as AbanAftThresh,
  sum(App.CallsAbandoned) as Aband
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
       'MI_MSS_EN_s'
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
       'MI_MSS_EN_s'
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
group by 
  to_char(App.Dt,'mm/dd/yyyy'), 'Chicago', 'MI MSS',
  App.Application
union
select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Chicago' as Site_Name, 'PA IEB' as Contact_Center,
  App.Application as QueueName,
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
  coalesce(sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold),0) as HandledBefThresh,
  coalesce(
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
    ,0) as HandAftThresh,
  coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) + 
    case 
	  when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
	    0 
	  else 
	    sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
	  end
	,0) as Handled,
  sum(App.CallsAbandoned) - sum(App.CallsAbandonedAftThreshold)  as AbanBefThresh,
  sum(App.CallsAbandonedAftThreshold) as AbanAftThresh,
  sum(App.CallsAbandoned) as Aband
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
       'CHC_ENG_s',
	   'CHC_SPN_s',
       'CHC_Provider_s',
       'CHC_OD_ENG_s',
       'CHC_OD_SPN_s',
	   'IEB_enroll_Eng_s',
       'IEB_enroll_Spn_s',
       'IEB_Ref_OD_EN_s',
       'IEB_REf_OD_SPN_s',
       'PAIEB_Reminder_EN_s',
       'PAIEB_Reminder_SPN_s',
       'IEB_Sch_EN_s',
       'IEB_Sch_SPN_s',
       'PAIEB_Agency_s',
       'PAIEB_Referrals_EN_s',
       'PAIEB_Referrals_SPN_s',
	   'PAIEB_Scheduler_EN_s',
	   'PAIEB_Scheduler_SPN_s'
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
       'CHC_ENG_s',
	   'CHC_SPN_s',
       'CHC_Provider_s',
       'CHC_OD_ENG_s',
       'CHC_OD_SPN_s',
	   'IEB_enroll_Eng_s',
       'IEB_enroll_Spn_s',
       'IEB_Ref_OD_EN_s',
       'IEB_REf_OD_SPN_s',
       'PAIEB_Reminder_EN_s',
       'PAIEB_Reminder_SPN_s',
       'IEB_Sch_EN_s',
       'IEB_Sch_SPN_s',
       'PAIEB_Agency_s',
       'PAIEB_Referrals_EN_s',
       'PAIEB_Referrals_SPN_s',
	   'PAIEB_Scheduler_EN_s',
	   'PAIEB_Scheduler_SPN_s'
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
  to_char(App.Dt,'mm/dd/yyyy'), 'Chicago', 'PA IEB',
  App.Application
UNION
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
				'VHC_Tier_1_CHI_s',
				'VHC_Tier_2_CHI_s',
				'VHC_XFER_Tier_1_CHI_s',
				'VHC_XFER_Tier_2_CHI_s'
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
				'VHC_Tier_1_CHI_s',
				'VHC_Tier_2_CHI_s',
				'VHC_XFER_Tier_1_CHI_s',
				'VHC_XFER_Tier_2_CHI_s'
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