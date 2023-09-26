select 
  to_char(App.Dt, 'mm/dd/yyyy') as DDate, 'Atlanta' as Site_Name, 'GA GF' as Contact_Center,
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
       'NH_EN_s',
       'NH_SP_s',
       'OB_Enroll_Eng',
       'OB_Enroll_spn',
       'P4HB_SP_s',
       'P4HB_sc'
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
       'NH_EN_s',
       'NH_SP_s',
       'OB_Enroll_Eng',
       'OB_Enroll_spn',
       'P4HB_SP_s',
       'P4HB_sc'       )
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
  to_char(App.Dt,'mm/dd/yyyy'), 'Atlanta', 'GA GF',
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
