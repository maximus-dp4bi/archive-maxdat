/* Get Avaya GA Georgia Families Services queue stats. */
/* Avaya Atlanta PRD DB URL: jdbc:Cache://10.200.7.10:1972/CCMS_STAT */

/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select '       ' + char(39) + Q.C_QTAG + char(39) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Atlanta-Avaya'  
where 
  cast(e.C_ID as varchar) like '50%%%'
  and e.C_DTIME is null
order by 1;
*/

select 
  to_char(App.Dt,'mm/dd/yyyy') as Date,
  App.Application as QueueName,
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
       'Enrollment_English_Script',
       'Enrollment_Spanish_Script',
       'LAEBCALLBACK_EN_s',
       'LAEBCALLBACK_SP_s',
       'LAEBOB_EN_s',
       'LAEBOB_SP_s',
       'LAEBSTATE_s',
       'LAEB_EN_s',
       'LAEB_SP_s',
       'LARA_CB_ENG_s',
       'LARA_NEW_ENG_s',
       'LARA_NEW_SPN_s',
       'LARA_OTR_ENG_s',
       'LARA_OTR_SPN_s',
       'LARA_RNL_ENG_s',
       'LARA_RNL_SPN_s',
       'LARA_StatePlans',
       'NH_EN_s',
       'NH_SP_s',
       'OB_Enroll_Eng',
       'OB_Enroll_spn',
       'P4HB_SP_s',
       'P4HB_sc'
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
       'Enrollment_English_Script',
       'Enrollment_Spanish_Script',
       'LAEBCALLBACK_EN_s',
       'LAEBCALLBACK_SP_s',
       'LAEBOB_EN_s',
       'LAEBOB_SP_s',
       'LAEBSTATE_s',
       'LAEB_EN_s',
       'LAEB_SP_s',
       'LARA_CB_ENG_s',
       'LARA_NEW_ENG_s',
       'LARA_NEW_SPN_s',
       'LARA_OTR_ENG_s',
       'LARA_OTR_SPN_s',
       'LARA_RNL_ENG_s',
       'LARA_RNL_SPN_s',
       'LARA_StatePlans',
       'NH_EN_s',
       'NH_SP_s',
       'OB_Enroll_Eng',
       'OB_Enroll_spn',
       'P4HB_SP_s',
       'P4HB_sc'
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
