use database PUREINSIGHTS_UAT;
use schema PUBLIC;

select
	(select count(*) from F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW where projectName = 'COVERVA') as tpc_cnt,   -- 2
	(select count(*) from F_PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_VW  where projectName = 'COVERVA') as tpqm_cnt,  -- 12
    (select count(*) from F_PI_TRANSCRIPTION_PROGRAM_TOPIC_MAPPING_VW  where projectName = 'COVERVA') as tptm_cnt,  -- 66
    (select count(*) from F_PI_TRANSCRIPTION_SENTIMENT_VW  where projectName = 'COVERVA') as ts_cnt,  -- 11091
    (select count(*) from F_PI_TRANSCRIPTION_TOPICS_VW  where projectName = 'COVERVA') as tt_cnt,  -- 82780
    (select count(*) from F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW where projectName = 'COVERVA') as ttc_cnt,  -- 43
    (select count(*) from F_PI_TRANSCRIPTION_TOPIC_PHRASES_VW where projectName = 'COVERVA') as ttp_cnt  -- 3580;



select description,id,name,published,modifieddate,modifiedby from F_PI_TRANSCRIPTION_PROGRAM_CONFIGURATION_VW where projectName = 'COVERVA';
select programid,queueid from F_PI_TRANSCRIPTION_PROGRAM_QUEUE_MAPPING_VW  where projectName = 'COVERVA' order by programid,queueid;
select programid,topicid from F_PI_TRANSCRIPTION_PROGRAM_TOPIC_MAPPING_VW where projectName = 'COVERVA' order by programid,topicid;
select conversationid,participantname,phrase,queuename,sentiment,sentimentstarttime from F_PI_TRANSCRIPTION_SENTIMENT_VW  where projectName = 'COVERVA' order by conversationid,participantname,phrase,queuename,sentiment,sentimentstarttime;
select confidence,conversationid,participantname,queuename,topicid,topicname,topicphrase,topicstarttime,transcriptphrase,userid from F_PI_TRANSCRIPTION_TOPICS_VW  where projectName = 'COVERVA' order by confidence,conversationid,participantname,queuename,topicid,topicname,topicphrase,topicstarttime,transcriptphrase,userid;
select description,dialect,id,modifiedby,modifieddate,name,participants,published,publishedby,publisheddate,strictness from F_PI_TRANSCRIPTION_TOPIC_CONFIGURATION_VW where projectName = 'COVERVA' order by description,dialect,id,modifiedby,modifieddate,name,participants,published,publishedby,publisheddate,strictness;
select sentiment,strictness,text,topicid from F_PI_TRANSCRIPTION_TOPIC_PHRASES_VW where projectName = 'COVERVA' order by sentiment,strictness,text,topicid;