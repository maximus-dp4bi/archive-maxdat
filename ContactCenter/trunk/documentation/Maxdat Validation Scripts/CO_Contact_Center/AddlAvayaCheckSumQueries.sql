select dabss."Timestamp", COUNT(DISTINCT dabss.AgentLogin) as agentCount, dabss.AgentLogin, SUM(dabss.CallsAnswered) as totCalls, (SUM(daps.LOGGEDINTIME/60)) as loggedInTime
	, SUM((( (dabss.TALKTIME - dabss.HOLDTIME)+dabss.HOLDTIME+daps.NOTREADYTIME+daps.WAITINGTIME+daps.BREAKTIME+dabss.CONSULTTIME+(daps.DNININTCALLSTALKTIME + daps.DNOUTINTCALLSTALKTIME) + (daps.DNINEXTCALLSTALKTIME + daps.DNOUTEXTCALLSTALKTIME) + dabss.RINGTIME + WALKAWAYTIME) /60)) as activityTime
from dbo.dAgentBySkillsetStat dabss
inner join dbo.dAgentPerformanceStat daps on ((dabss.AgentLogin = daps.AgentLogin) AND (dabss."Timestamp" = daps."Timestamp"))
where dabss.SkillsetID in (10002,10003,10004,10020,10021,10022,10023,10025,10038,10039,10040,10041,10042,10043,10044,10046,10047)
	and dabss."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-08-01 00:00:00'}), 0)
	and dabss."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-08-09 00:00:00'}), 0)
	and daps."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-08-01 00:00:00'}), 0)
	and daps."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-08-09 00:00:00'}), 0)
	--Filtering out GHOST agents logged in CC_L_ERROR
	and dabss.AgentLogin NOT IN ('56666','56716','69983','74123')
GROUP BY dabss."Timestamp", dabss.AgentLogin;


SELECT dabssSub."Timestamp", COUNT(DISTINCT dabssSub.AgentLogin) as agentCount, SUM(dabssSub.CallsAnswered) as totCalls, (SUM(dapsSub.LOGGEDINTIME/60)) as loggedInTime
	, SUM((( (dabssSub.TALKTIME - dabssSub.HOLDTIME)+dabssSub.HOLDTIME+dapsSub.NOTREADYTIME+dapsSub.WAITINGTIME+dapsSub.BREAKTIME+dabssSub.CONSULTTIME+(dapsSub.DNININTCALLSTALKTIME + dapsSub.DNOUTINTCALLSTALKTIME) + (dapsSub.DNINEXTCALLSTALKTIME + dapsSub.DNOUTEXTCALLSTALKTIME) + dabssSub.RINGTIME + WALKAWAYTIME) /60)) as activityTime
FROM (
	SELECT 
	dabss."Timestamp"
	,dabss.AgentLogin
	,SUM(dabss.CallsAnswered) as CallsAnswered
	,SUM(dabss.PostCallProcessingTime) as PostCallProcessingTime
	,SUM(dabss.TalkTime) as TalkTime
	,SUM(dabss.HoldTime) as HoldTime
	,SUM(dabss.ConsultTime) as ConsultTime
	,SUM(dabss.DNOutExtTalkTime) as DNOutExtTalkTime
	,SUM(dabss.DNOutIntTalkTime) as DNOutIntTalkTime
	,SUM(dabss.RingTime) as RingTime
	from dbo.dAgentBySkillsetStat dabss
	where dabss."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-08-01 00:00:00'}), 0) 
	and dabss."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-08-09 00:00:00'}), 0)
	and dabss.SkillsetID in (10002,10003,10004,10020,10021,10022,10023,10025,10038,10039,10040,10041,10042,10043,10044,10046,10047)
	group by AgentLogin, "Timestamp"
		) dabssSub
INNER JOIN (
	SELECT
	  daps."Timestamp"
	, daps.AgentLogin
	, SUM(daps.ACDCallsAnswered) as ACDCallsAnswered
	, SUM(daps.BreakTime) as BreakTime
	, SUM(daps.BusyOnDNTime) as BusyOnDNTime
	, SUM(daps.ConsultationTime) as ConsultationTime
	, SUM(daps.DNInExtCalls) as DNInExtCalls
	, SUM(daps.DNInExtCallsTalkTime) as DNInExtCallsTalkTime
	, SUM(daps.DNInIntCalls) as DNInIntCalls
	, SUM(daps.DNInIntCallsTalkTime) as DNInIntCallsTalkTime
	, SUM(daps.DNOutExtCalls) as DNOutExtCalls
	, SUM(daps.DNOutExtCallsTalkTime) as DNOutExtCallsTalkTime
	, SUM(daps.DNOutIntCalls) as DNOutIntCalls
	, SUM(daps.DNOutIntCallsTalkTime) as DNOutIntCallsTalkTime
	, SUM(daps.LoggedInTime) as LoggedInTime
	, SUM(daps.NotReadyTime) as NotReadyTime
	, SUM(daps.ReservedTime) as ReservedTime
	, SUM(daps.WaitingTime) as WaitingTime
	, SUM(daps.WalkawayTime) as WalkawayTime
	from dbo.dAgentPerformanceStat daps
	where daps."Timestamp" >= dateadd(dd, datediff(dd,0, {ts '2014-08-01 00:00:00'}), 0)
	and daps."Timestamp" < dateadd(dd, datediff(dd,0, {ts '2014-08-09 00:00:00'}), 0)
	Group By daps.AgentLogin, daps."Timestamp"
)dapsSub on ((dabssSub.AgentLogin = dapsSub.AgentLogin) AND (dabssSub."Timestamp" = dapsSub."Timestamp"))
WHERE dabssSub.AgentLogin NOT IN ('56666','56716','69983','74123')
GROUP BY dabssSub."Timestamp";