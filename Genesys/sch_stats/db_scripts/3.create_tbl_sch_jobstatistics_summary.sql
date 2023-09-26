--use database PUREINSIGHTS_DEV;
--use database PUREINSIGHTS_UAT;
--use database PUREINSIGHTS_PRD;
use schema SCH_STATS;

create table SCH_JOBSTATISTICS_SUMMARY (
JOBID string not null
,JOBNAME string
,RUNCOUNT string not null
,STARTTIME string
,FINISHTIME string
,"STATUS" string
,IN_RECORDCNT string
,OUT_RECORDCNT string
,ERR_RECORDCNT string
,"USER" string
,ERR_INFO string
,ERR_MSG string
,WARNING string
,constraint SCH_JOBSTATS_SMRY_PK primary key (JOBID,RUNCOUNT) enforced
);
  
