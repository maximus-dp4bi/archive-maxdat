--use database PUREINSIGHTS_DEV;
--use database PUREINSIGHTS_UAT;
--use database PUREINSIGHTS_PRD;
use schema SCH_STATS;

create table SCH_JOBSTATS_ERROR_LOG(
ERR_DT timestamp
,ERR_MSG string
,ERR_DESC string
);

