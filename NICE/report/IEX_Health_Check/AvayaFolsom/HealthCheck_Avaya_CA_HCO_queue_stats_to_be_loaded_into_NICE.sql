/* Get Avaya CA Health Care Options queue stats. */
/* Avaya Folsom PRD DB URL: jdbc:Cache://10.2.6.1:1972/CCMS_STAT */


/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select '       ' + char(39) + Q.C_QTAG + char(39) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Folsom-Avaya Blue'  
where 
  e.C_ID >= 25000 and e.C_ID <= 25058
  and e.C_DTIME is null
  and q.C_QTAG not in (
    'ExLn_CB_agt_ara_s',
    'ExLn_CB_agt_arm_s',
    'ExLn_CB_agt_cam_s',
    'ExLn_CB_agt_can_s',
    'ExLn_CB_agt_eng_s',
    'ExLn_CB_agt_esp_s',
    'ExLn_CB_agt_far_s',
    'ExLn_CB_agt_hmo_s',
    'ExLn_CB_agt_kor_s',
    'ExLn_CB_agt_man_s',
    'ExLn_CB_agt_rus_s',
    'ExLn_CB_agt_tag_s',
    'ExLn_CB_agt_vie_s',
    'SCSC_CB_agt_ara_s',
    'SCSC_CB_agt_arm_s',
    'SCSC_CB_agt_cam_s',
    'SCSC_CB_agt_can_s',
    'SCSC_CB_agt_far_s',
    'SCSC_CB_agt_hmo_s',
    'SCSC_CB_agt_kor_s',
    'SCSC_CB_agt_man_s',
    'SCSC_CB_agt_rus_s',
    'SCSC_CB_agt_tag_s',
    'SCSC_CB_agt_vie_s'
  )
order by 1;
*/

select 
  to_char(App.Dt, 'mm/dd/yyyy') as Date,
  App.Application as QueueName,
  case 
    when App.Application in 
      ('ExLn_CB_agt_ara_s','ExLn_CB_agt_arm_s','ExLn_CB_agt_cam_s','ExLn_CB_agt_can_s','ExLn_CB_agt_eng_s','ExLn_CB_agt_far_s',
	   'ExLn_CB_agt_hmo_s','ExLn_CB_agt_kor_s','ExLn_CB_agt_man_s','ExLn_CB_agt_rus_s','ExLn_CB_agt_esp_s','ExLn_CB_agt_tag_s','ExLn_CB_agt_vie_s',
	   'HCO_CB_agt_eng_s','HCO_CB_agt_esp_s','SCSC_CB_agt_ara_s','SCSC_CB_agt_arm_s','SCSC_CB_agt_cam_s','SCSC_CB_agt_can_s','SCSC_CB_agt_eng_s',
	   'SCSC_CB_agt_far_s','SCSC_CB_agt_hmo_s','SCSC_CB_agt_kor_s','SCSC_CB_agt_man_s','SCSC_CB_agt_rus_s','SCSC_CB_agt_esp_s','SCSC_CB_agt_tag_s',
	   'SCSC_CB_agt_vie_s') then 
	  sum(App.CallsOffered) 
    else coalesce((sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)),0) + 
	   coalesce(
	     case 
		   when sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) < 0 then 
			 0 
		   else 
		     sum(Ag.CallsAnswered) - (sum(Ag.CallsAnswered) - sum(App.CallsAnsweredAftThreshold)) 
		   end
	     ,0) + sum(App.CallsAbandoned) 
    end as Received,
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
       'ExLn_ara_s',
       'ExLn_arm_s',
       'ExLn_cam_s',
       'ExLn_can_s',
       'ExLn_eng_s',
       'ExLn_esp_s',
       'ExLn_far_s',
       'ExLn_hmo_s',
       'ExLn_kor_s',
       'ExLn_man_s',
       'ExLn_rus_s',
       'ExLn_tag_s',
       'ExLn_vie_s',
       'F_ops_s',
       'HCO_CB_agt_eng_s',
       'HCO_CB_agt_esp_s',
       'HCO_eng_s',
       'HCO_esp_s',
       'SCSC_CB_agt_eng_s',
       'SCSC_CB_agt_esp_s',
       'SCSC_ara_s',
       'SCSC_arm_s',
       'SCSC_cam_s',
       'SCSC_can_s',
       'SCSC_eng_s',
       'SCSC_esp_s',
       'SCSC_far_s',
       'SCSC_hmo_s',
       'SCSC_kor_s',
       'SCSC_man_s',
       'SCSC_rus_s',
       'SCSC_tag_s',
       'SCSC_vie_s'
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
       'ExLn_ara_s',
       'ExLn_arm_s',
       'ExLn_cam_s',
       'ExLn_can_s',
       'ExLn_eng_s',
       'ExLn_esp_s',
       'ExLn_far_s',
       'ExLn_hmo_s',
       'ExLn_kor_s',
       'ExLn_man_s',
       'ExLn_rus_s',
       'ExLn_tag_s',
       'ExLn_vie_s',
       'F_ops_s',
       'HCO_CB_agt_eng_s',
       'HCO_CB_agt_esp_s',
       'HCO_eng_s',
       'HCO_esp_s',
       'SCSC_CB_agt_eng_s',
       'SCSC_CB_agt_esp_s',
       'SCSC_ara_s',
       'SCSC_arm_s',
       'SCSC_cam_s',
       'SCSC_can_s',
       'SCSC_eng_s',
       'SCSC_esp_s',
       'SCSC_far_s',
       'SCSC_hmo_s',
       'SCSC_kor_s',
       'SCSC_man_s',
       'SCSC_rus_s',
       'SCSC_tag_s',
       'SCSC_vie_s'
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
order by 1,2