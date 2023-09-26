use role SYSADMIN;
use warehouse PUREINSIGHTS_DP4BI_UAT_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

alter table d_pi_projects_hold add
(
    projectchargecode           varchar(100),
    projectchargecodename       varchar(400)
);
