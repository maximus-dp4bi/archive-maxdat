
select max("Timestamp")
from iApplicationStat
where "Timestamp" > {ts '2014-05-20 00:00:00'};

select max("Timestamp")
from iAgentByApplicationStat
where "Timestamp" > {ts '2014-05-20 00:00:00'};


select AgentLogin,CallsAnswered,LoggedInTime,ActivityTime,ABS(ROUND(100*(LoggedinTime-ActivityTime)/LoggedInTime,2)) prct_var
from  (
	select 
		AgentLogin 
		, CallsAnswered
		,LoggedInTime/60 LoggedInTime
		,(TalkTime
			+ NotReadyTime
			+ WaitingTime
			+ BreakTime
			+ ConsultationTime
			+ (DNOutIntCallsTalkTime + DNInIntCallsTalkTime)
			+ (DNOutExtCallsTalkTime + DNInExtCallsTalkTime)
			+ RingTime
			+ WalkawayTime)/60 ActivityTime
		,TalkTime/60 TalkTime
		,NotReadyTime/60 NotReadyTime
		,WaitingTime/60 WaitingTime
		,BreakTime/60 BreakTime
		,ConsultationTime/60 ConsultationTime
		,(DNOutIntCallsTalkTime + DNInIntCallsTalkTime)/60 InternalTalkTime
		,(DNOutExtCallsTalkTime + DNInExtCallsTalkTime)/60 ExternalTalkTime
		,RingTime/60 RingTime
		,WalkawayTime/60 WalkawayTime
	from dAgentPerformanceStat daps
	where "Timestamp" = {ts '2014-03-03 00:00:00'}
	and exists (
		select AgentLogin
		from dAgentBySkillsetStat dass
		where daps."Timestamp" = dass."Timestamp"
		and daps.AgentLogin = dass.AgentLogin
		and SkillsetID in (10053,10054,10047,10049,10050,10048,10043,10045,10046,10044,10080,10082,10083,10081,10051,10052,10039,10041,10042,10040,10001,10002,10003,10004,10035,10036)
	)
)
--where AgentLogin = 69868
order by ABS(ROUND(100*(LoggedinTime-ActivityTime)/LoggedInTime,2)) desc,AgentLogin;

select "Timestamp", sum(CallsAnswered) CallsAnswered
from  (
	select 
		"Timestamp"
		, AgentLogin 
		, CallsAnswered
		,LoggedInTime/60 LoggedInTime
		,(TalkTime
			+ NotReadyTime
			+ WaitingTime
			+ BreakTime
			+ ConsultationTime
			+ (DNOutIntCallsTalkTime + DNInIntCallsTalkTime)
			+ (DNOutExtCallsTalkTime + DNInExtCallsTalkTime)
			+ RingTime
			+ WalkawayTime)/60 ActivityTime
		,TalkTime/60 TalkTime
		,NotReadyTime/60 NotReadyTime
		,WaitingTime/60 WaitingTime
		,BreakTime/60 BreakTime
		,ConsultationTime/60 ConsultationTime
		,(DNOutIntCallsTalkTime + DNInIntCallsTalkTime)/60 InternalTalkTime
		,(DNOutExtCallsTalkTime + DNInExtCallsTalkTime)/60 ExternalTalkTime
		,RingTime/60 RingTime
		,WalkawayTime/60 WalkawayTime
	from dAgentPerformanceStat daps
	where "Timestamp" = {ts '2014-03-03 00:00:00'} --between {ts '2014-03-03 00:00:00'} and {ts '2014-03-03 00:00:00'}
	and exists (
		select AgentLogin
		from dAgentBySkillsetStat dass
		where daps."Timestamp" = dass."Timestamp"
		and daps.AgentLogin = dass.AgentLogin
		and SkillsetID in (10053,10054,10047,10049,10050,10048,10043,10045,10046,10044,10080,10082,10083,10081,10051,10052,10039,10041,10042,10040,10001,10002,10003,10004,10035,10036)
	)
)
group by "Timestamp"
;

select distinct AgentLogin,SkillsetID
from dAgentBySkillsetStat
where "Timestamp" = {ts '2014-05-01 00:00:00'}
and AgentLogin = 54747;
