select 
	AgentID
	, ContactTypeName
	, ContactSubType
	, SkillsetName
	, ApplicationStartStamp as OriginatedTime
	, ServiceStamp as StartTime
	, FinalDispositionStamp as EndTime 
	, DATEDIFF(ss, ApplicationStartStamp, FinalDispositionStamp)/60 as Duration
	, HandlingTime/60 as HandlingTime
	, HoldTime/60 as HoldTime
	, NumberOfTimesOnHold
	, WaitTime/60 as WaitTime
from eCSRStat
where OriginatedStamp >= {ts '2014-07-21 00:00:00'}
and OriginatedStamp < {ts '2014-07-22 00:00:00'}
and AgentID = 70022
order by OriginatedStamp
;

select distinct ContactTypeName, ContactSubType
from eCSRStat
where OriginatedStamp >= {ts '2014-07-21 00:00:00'}
and OriginatedStamp < {ts '2014-07-22 00:00:00'}
;

select * from ContactType;	
select * from CDN;
select * from eCSRCodeStat;
select * from ActivityCode;
select * from CodeToMessageMap;
/*
CDN = Content Delivery Network

*/
select * 
from iAgentByApplicationStat
where "Timestamp" > {ts '2014-07-25 00:00:00'}
;

