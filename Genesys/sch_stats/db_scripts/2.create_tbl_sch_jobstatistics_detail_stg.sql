--use database PUREINSIGHTS_DEV;
--use database PUREINSIGHTS_UAT;
--use database PUREINSIGHTS_PRD;
use schema SCH_STATS;

create table SCH_JOBSTATISTICS_DETAIL_STG(
JOBID string not null
,JOBNAME string
,RUNCOUNT string not null
,DTL_MSGID string not null
,DTL_TIME string
,DTL_MSG string
,DTL_STATUS string
,DTL_USER string
,load_status string default 'notstarted'
,constraint SCH_JOBSTATS_DTL_PK primary key (JOBID,RUNCOUNT,DTL_MSGID) enforced
);

