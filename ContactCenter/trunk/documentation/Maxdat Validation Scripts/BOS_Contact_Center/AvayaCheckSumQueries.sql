--CC_S_ACD_INTERVAL
select a."Timestamp", a.CallsAnswered as CallsAnsweredByQueue, b.CallsAnswered as CallsAnsweredByAgent
from (
	select "Timestamp", sum(CallsAnswered) CallsAnswered
	from dApplicationStat das
	where "Timestamp" >= {ts '2014-07-28 00:00:00'}
	and "Timestamp" < {ts '2014-07-29 00:00:00'}
	and ApplicationID in (10006,10016,10018,10019,10020,10021,10024,10025,10026,10032,10033,10036,10038,10039,10046,10047,10049,10051,10053,10055,10066,10075,10076,10077,10078,10080,10081,10082,10083,10084,10085,10087,10089,10090,10092,10093,10094)
	group by "Timestamp"
) a inner join (
select "Timestamp", sum(CallsAnswered) CallsAnswered
from dAgentbySkillsetStat das
where "Timestamp" >= {ts '2014-07-28 00:00:00'}
and "Timestamp" < {ts '2014-07-29 00:00:00'}
and SkillsetID in (10002,10003,10008,10009,10010,10015,10016,10017,10018,10019,10020,10022,10023,10024,10026,10027,10028,10029,10031,10033,10034,10036,10038,10039,10040,10042,10047,10048,10050,10052,10053,10055,10057,10067,10073,10074,10077,10079,10080,10081)
group by "Timestamp"
) b on a."Timestamp" = b."Timestamp"
order by "Timestamp" desc;

--CC_S_ACD_AGENT_ACTIVITY
select dabss."Timestamp", SUM(dabss.CallsAnswered) as totCalls
from dbo.dAgentBySkillsetStat dabss
inner join dbo.dAgentPerformanceStat daps on ((dabss.AgentLogin = daps.AgentLogin) AND (dabss."Timestamp" = daps."Timestamp"))
where dabss.SkillsetID in (10002,10003,10008,10009,10010,10015,10016,10017,10018,10019,10020,10022,10023,10024,10026,10027,10028,10029,10031,10033,10034,10036,10038,10039,10040,10042,10047,10048,10050,10052,10053,10055,10057,10067,10073,10074,10077,10079,10080,10081)
	and dabss."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-07-28 00:00:00'}), 0)
	and dabss."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-07-29 00:00:00'}), 0)
	and daps."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-07-28 00:00:00'}), 0)
	and daps."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-07-29 00:00:00'}), 0)
	--Filtering out 'leading-zero' agents logged in CC_L_ERROR
	and dabss.AgentLogin NOT IN ('0964','0885','0760','0637','0577','0566','0486','0460','0404','0393','0212')
GROUP BY dabss."Timestamp";



select "Timestamp", sum(LoggedInTime) 
from dAgentPerformanceStat das
where "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
and UserID in (
	select distinct ssa.UserID 
	from dAgentBySkillsetStat ssa
	where Skillset in (
		'VMCALLBACK_ENG_sk'
		,'VMCALLBACK_SPN_sk'
		,'CSR_ENG_sk'
		,'CSR_SPN_sk'
		,'Sen_CSR_ENG_sk'
		,'Sen_CSR_SPN_sk'
		,'VMCALLBACK_EN_sk'
		,'VMCALLBACK_SP_sk'
		,'GEN_ENG_sk'
		,'GEN_SPN_SK'
		,'HC_EN_sk'
		,'HC_SP_sk'
		,'HC_OB_EN_sk'
		,'HC_OB_SP_sk'
		,'ICP_EN_sk'
		,'ICP_SP_sk'
		,'ICP_OB_EN_sk'
		,'ICP_OB_SP_sk'
		,'MAI_EN_sk'
		,'MAI_SP_sk'
		,'MAI_OB_EN_sk'
		,'MAI_OB_SP_sk'
		,'VMC_EN_sk'
		,'VMC_SP_sk'
		,'VMC_OB_EN_sk'
		,'VMC_OB_SP_sk'
	)
)
group by "Timestamp"
order by "Timestamp" desc;


select distinct UserID 
from dAgentBySkillsetStat
where Skillset in (
		'VMCALLBACK_ENG_sk'
		,'VMCALLBACK_SPN_sk'
		,'CSR_ENG_sk'
		,'CSR_SPN_sk'
		,'Sen_CSR_ENG_sk'
		,'Sen_CSR_SPN_sk'
		,'VMCALLBACK_EN_sk'
		,'VMCALLBACK_SP_sk'
		,'GEN_ENG_sk'
		,'GEN_SPN_SK'
		,'HC_EN_sk'
		,'HC_SP_sk'
		,'HC_OB_EN_sk'
		,'HC_OB_SP_sk'
		,'ICP_EN_sk'
		,'ICP_SP_sk'
		,'ICP_OB_EN_sk'
		,'ICP_OB_SP_sk'
		,'MAI_EN_sk'
		,'MAI_SP_sk'
		,'MAI_OB_EN_sk'
		,'MAI_OB_SP_sk'
		,'VMC_EN_sk'
		,'VMC_SP_sk'
		,'VMC_OB_EN_sk'
		,'VMC_OB_SP_sk'
)
and "Timestamp" >= {ts '2014-03-01 00:00:00'}
and "Timestamp" < {ts '2014-03-04 00:00:00'}
;