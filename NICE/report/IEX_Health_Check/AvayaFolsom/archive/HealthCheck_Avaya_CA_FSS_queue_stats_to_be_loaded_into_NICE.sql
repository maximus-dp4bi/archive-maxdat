/* Get Avaya CA Folsom Shared Services queue stats. */
/* Avaya Folsom PRD DB URL: jdbc:Cache://10.2.6.1:1972/CCMS_STAT */

/* Get list of queues from NICE db to add into this query. */
/* NICE PRD DB: 10.150.140.20 */
/*
select '       ' + char(39) + Q.C_QTAG + char(39) + ','
from nice_wfm_customer1.dbo.R_QUEUE q
inner join nice_wfm_customer1.dbo.R_ENTITY e on q.C_OID = e.C_OID and e.C_TYPE = 'Q'
inner join nice_wfm_customer1.dbo.R_ACD acd on q.C_ACD = acd.C_OID and acd.C_Name = 'Folsom-Avaya Blue'  
where 
  cast(e.C_ID as varchar) like '25%%%'
  and e.C_DTIME is null
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
       'Diversion_S',
       'HFP_Armenian_S',
       'HFP_Armenian_ovfl_S',
       'HFP_Cambodian_S',
       'HFP_Cambodian_ovfl_S',
       'HFP_Cantonese_S',
       'HFP_Cantonese_ovfl_S',
       'HFP_English_S',
       'HFP_English_ovfl_S',
       'HFP_Farsi_S',
       'HFP_Farsi_ovfl_S',
       'HFP_Hmong_S',
       'HFP_Hmong_ovfl_S',
       'HFP_Korean_S',
       'HFP_Korean_ovfl_S',
       'HFP_Laotian_S',
       'HFP_Laotian_ovfl_S',
       'HFP_Russian_S',
       'HFP_Russian_ovfl_S',
       'HFP_Spanish_S',
       'HFP_Spanish_ovfl_S',
       'HFP_Tran_Armenian_S',
       'HFP_Tran_Cambodian_S',
       'HFP_Tran_Cantonese_S',
       'HFP_Tran_English_S',
       'HFP_Tran_Farsi_S',
       'HFP_Tran_Hmong_S',
       'HFP_Tran_Korean_S',
       'HFP_Tran_Laotian_S',
       'HFP_Tran_Russian_S',
       'HFP_Tran_Spanish_S',
       'HFP_Tran_Vietnamese_S',
       'HFP_Vietnamese_S',
       'HFP_Vietnamese_ovfl_S',
       'HI_ovfl_s',
       'IBR_Eng_s',
       'IBR_Escalate_eng_s',
       'IBR_Escalate_spn_s',
       'IBR_Spn_s',
       'IMR_Eng_s',
       'IMR_Escalate_eng_s',
       'IMR_Escalate_spn_s',
       'IMR_Spn_s',
       'MH_HC_1095B_Spanish_s',
       'MH_HC_1095B_s',
       'MH_HC_1099_Spanish_s',
       'MH_HC_1099_s',
       'MH_HIX_App_EN_s',
       'MH_HIX_App_SP_s',
       'MH_HIX_Applications_Spanish_s',
       'MH_HIX_NOWRONGDOOR_s',
       'MH_MEC_AddNewborn_s',
       'MH_MEC_Application_s',
       'MH_MEC_Cust_Svc_s',
       'MH_MEC_Mbr_Eligibility_s',
       'MH_MEC_Notice_s',
       'MH_Mbr_Application_s',
       'MH_Mbr_Card_Replace_s',
       'MH_Mbr_CustSvc_s',
       'MH_Mbr_Eligibility_s',
       'MH_Mbr_Enrollment_s',
       'MH_Mbr_MAP_s',
       'MH_Mbr_Transport_s',
	   'MH_Payment_Reform_s',
       'MH_SS_Application_s',
       'MH_SS_Eligibility_s',
       'MH_SS_Transport_s',
       'MH_Span_Adv_s',
       'MH_Takeback_Xfer_Eng_s',
       'MH_Takeback_Xfer_Spn_s',
       'TN_ENG_s',
       'TN_OTHLANG_s',
       'TN_SPAN_s',
       'Tech_Support_S'
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
              'Diversion_S',
       'HFP_Armenian_S',
       'HFP_Armenian_ovfl_S',
       'HFP_Cambodian_S',
       'HFP_Cambodian_ovfl_S',
       'HFP_Cantonese_S',
       'HFP_Cantonese_ovfl_S',
       'HFP_English_S',
       'HFP_English_ovfl_S',
       'HFP_Farsi_S',
       'HFP_Farsi_ovfl_S',
       'HFP_Hmong_S',
       'HFP_Hmong_ovfl_S',
       'HFP_Korean_S',
       'HFP_Korean_ovfl_S',
       'HFP_Laotian_S',
       'HFP_Laotian_ovfl_S',
       'HFP_Russian_S',
       'HFP_Russian_ovfl_S',
       'HFP_Spanish_S',
       'HFP_Spanish_ovfl_S',
       'HFP_Tran_Armenian_S',
       'HFP_Tran_Cambodian_S',
       'HFP_Tran_Cantonese_S',
       'HFP_Tran_English_S',
       'HFP_Tran_Farsi_S',
       'HFP_Tran_Hmong_S',
       'HFP_Tran_Korean_S',
       'HFP_Tran_Laotian_S',
       'HFP_Tran_Russian_S',
       'HFP_Tran_Spanish_S',
       'HFP_Tran_Vietnamese_S',
       'HFP_Vietnamese_S',
       'HFP_Vietnamese_ovfl_S',
       'HI_ovfl_s',
       'IBR_Eng_s',
       'IBR_Escalate_eng_s',
       'IBR_Escalate_spn_s',
       'IBR_Spn_s',
       'IMR_Eng_s',
       'IMR_Escalate_eng_s',
       'IMR_Escalate_spn_s',
       'IMR_Spn_s',
       'MH_HC_1095B_Spanish_s',
       'MH_HC_1095B_s',
       'MH_HC_1099_Spanish_s',
       'MH_HC_1099_s',
       'MH_HIX_App_EN_s',
       'MH_HIX_App_SP_s',
       'MH_HIX_Applications_Spanish_s',
       'MH_HIX_NOWRONGDOOR_s',
       'MH_MEC_AddNewborn_s',
       'MH_MEC_Application_s',
       'MH_MEC_Cust_Svc_s',
       'MH_MEC_Mbr_Eligibility_s',
       'MH_MEC_Notice_s',
       'MH_Mbr_Application_s',
       'MH_Mbr_Card_Replace_s',
       'MH_Mbr_CustSvc_s',
       'MH_Mbr_Eligibility_s',
       'MH_Mbr_Enrollment_s',
       'MH_Mbr_MAP_s',
       'MH_Mbr_Transport_s',
	   'MH_Payment_Reform_s',
       'MH_SS_Application_s',
       'MH_SS_Eligibility_s',
       'MH_SS_Transport_s',
       'MH_Span_Adv_s',
       'MH_Takeback_Xfer_Eng_s',
       'MH_Takeback_Xfer_Spn_s',
       'TN_ENG_s',
       'TN_OTHLANG_s',
       'TN_SPAN_s',
       'Tech_Support_S'
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