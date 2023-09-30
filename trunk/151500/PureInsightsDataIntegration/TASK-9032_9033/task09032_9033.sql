-- Target
select agentComments, count(*) from  PUREINSIGHTS_UAT.PUBLIC.D_PI_EVALUATIONS_VW where agentComments is not null and projectid = 701 group by agentcomments order by 2 desc;
select agentComments, count(*) from  PUREINSIGHTS_UAT.PUBLIC.D_PI_EVALUATION_CALIBRATIONS_VW where agentComments is not null and projectid = 701 group by agentcomments order by 2 desc;

-- Source
select agentcomments, count(*) from PureCloud.evaluations group by agentcomments order by 2 desc;
select agentcomments, count(*) from PureCloud.evaluation_calibrations ec join PureCloud.evaluations e on (ec.id = e.calibrationid and ec.conversationid = e.conversationid) group by agentcomments order by 2 desc;