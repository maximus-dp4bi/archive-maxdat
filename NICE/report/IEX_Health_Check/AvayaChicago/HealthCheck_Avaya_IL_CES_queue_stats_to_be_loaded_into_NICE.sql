/* Get yesterday's Avaya IL Client Enrollment Services queue stats. */
/* Avaya Chicago PRD DB URL: jdbc:Cache://10.22.130.2:1972/ccms_stat */

/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select '       ' + char(39) + Q.C_QTAG + char(39) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Chicago Avaya'  
where 
  cast(e.C_ID as varchar) like '30%%%'
  and e.C_DTIME is null
  and q.C_QTAG not in (
     'ILEEV_ENG_Escalation_s',
     'ILEEV_SPN_ESCALATION_s'
    )
order by 1;
*/

select 
  to_char(App.Dt, 'mm/dd/yyyy') as Date,
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
     and ss.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
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
            and ss.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
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
           aps.Timestamp >= dateadd('dd',datediff('dd',1,CURRENT_DATE),0)
           and aps.Timestamp < dateadd('dd',datediff('dd',0,CURRENT_DATE),0)
    ) t2 on t1.Dt = t2.Dt and t1.AgentLogin = t2.AgentLogin
    group by 
      t1.Dt,
      t1.Application,
      t1.AgentLogin,
      t1.CallsAnswered)
  group by Dt, Application) Ag on Ag.Dt = App.Dt and Ag.Application = App.Application
group by 
  to_char(App.Dt,'mm/dd/yyyy'), 
  App.Application
order by 1,2;
