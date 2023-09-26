USE DATABASE PUREINSIGHTS_DEV;
USE SCHEMA PUBLIC;

-- ********** NCEB **********

-- Metadata for pureinsights_dev.public.f_pi_transcript_sentiment_interval_aggregates_vw matches PureCloud.transcript_sentiment_interval_aggregates

-- Target

select count(*) from raw.transcript_sentiment_interval_aggregates 
where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'NCEB')
and intervalstart >= '2021-07-12 14:15:00'; -- Returned 779

select count(*) from f_pi_transcript_sentiment_interval_aggregates_vw 
where projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'NCEB')
and intervalstart >= '2021-07-12 14:15:00'; -- Returned 779

select 
	to_char(intervalstart, 'yyyy-mm-dd hh24:mi:ss') AS intervalstart, 
    queuename,
    direction,
    mediatype,
    customersentimentcount,
    customersentimentmin,
    customersentimentmax,
    customersentimentsum,
    customersentimentcountnegative,
    customersentimentcountpositive
from 
    f_pi_transcript_sentiment_interval_aggregates_vw 
where 
    projectid = (select max(projectid) from pureinsights_dev.public.d_pi_projects where projectname = 'NCEB')
and intervalstart >= '2021-07-12 14:15:00' 
order  by 
	intervalStart, queuename, direction, mediatype
limit 160;    


-- Source

select count(*) from PureCloud.transcript_sentiment_interval_aggregates where intervalstart >= '2021-07-12 14:15:00'; -- Returned 779

select 
	intervalstart, 
    queuename,
    direction,
    mediatype,
    customersentimentcount,
    customersentimentmin,
    customersentimentmax,
    customersentimentsum,
    customersentimentcountnegative,
    customersentimentcountpositive
from 
	PureCloud.transcript_sentiment_interval_aggregates 
where 
    intervalstart >= '2021-07-12 14:15:00' 
order  by 
	intervalStart, queuename, direction, mediatype
limit 160;    
