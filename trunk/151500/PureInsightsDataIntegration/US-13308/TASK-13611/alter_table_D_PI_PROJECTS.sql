use role SYSADMIN;
use warehouse PUREINSIGHTS_DP4BI_PRD_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

alter table d_pi_projects add
(
    projectchargecode           varchar(100),
    projectchargecodename       varchar(400)
);
