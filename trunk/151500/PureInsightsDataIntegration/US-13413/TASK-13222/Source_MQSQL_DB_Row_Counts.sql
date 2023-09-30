
select
	(select count(*) from PureCloud.transcription_program_configuration) as tpc_cnt,   -- 2
	(select count(*) from PureCloud.transcription_program_queue_mapping) as tpqm_cnt,  -- 12
    (select count(*) from PureCloud.transcription_program_topic_mapping) as tptm_cnt,  -- 66
    (select count(*) from PureCloud.transcription_sentiment) as ts_cnt,  -- 11091
    (select count(*) from PureCloud.transcription_topics) as tt_cnt,  -- 82780
    (select count(*) from PureCloud.transcription_topic_configuration) as ttc_cnt,  -- 43
    (select count(*) from PureCloud.transcription_topic_phrases) as ttp_cnt;  -- 3580
    
select description,id,name,published,modifieddate,modifiedby from PureClound.transcription_program_configuration;    
select programid,queueid from PureClound.transcription_program_queue_mapping order by programid,queueid;
select programid,topicid from PureClound.transcription_program_topic_mapping order by programid,topicid;
select conversationid,participantname,phrase,queuename,sentiment,sentimentstarttime from PureClound.transcription_sentiment order by conversationid,participantname,phrase,queuename,sentiment,sentimentstarttime;
select confidence,conversationid,participantname,queuename,topicid,topicname,topicphrase,topicstarttime,transcriptphrase,userid from PureClound.transcription_topics order by confidence,conversationid,participantname,queuename,topicid,topicname,topicphrase,topicstarttime,transcriptphrase,userid;
select description,dialect,id,modifiedby,modifieddate,name,participants,published,publishedby,publisheddate,strictness from PureCloud.transcription_topic_configuration order by description,dialect,id,modifiedby,modifieddate,name,participants,published,publishedby,publisheddate,strictness;
select sentiment,strictness,text,topicid from PureCloud.transcription_topic_phrases order by sentiment,strictness,text,topicid;


    

