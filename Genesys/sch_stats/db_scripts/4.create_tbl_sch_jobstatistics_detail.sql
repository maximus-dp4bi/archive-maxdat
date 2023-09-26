--use database PUREINSIGHTS_DEV;
--use database PUREINSIGHTS_UAT;
--use database PUREINSIGHTS_PRD;
use schema SCH_STATS;

create table SCH_JOBSTATISTICS_DETAIL(
JOBID string not null
,JOBNAME string
,RUNCOUNT string not null
,DTL_MSGID string not null
,DTL_TIME string
,DTL_MSG string
,DTL_STATUS string
,DTL_USER string
,constraint SCH_JOBSTATS_DTL_PK primary key (JOBID,RUNCOUNT,DTL_MSGID) enforced
,constraint SCH_JOBSTATS_DTL_FK foreign key (JOBID,RUNCOUNT) references SCH_JOBSTATISTICS_SUMMARY (JOBID,RUNCOUNT) enforced
);


