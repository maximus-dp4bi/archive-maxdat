use role PI_Data_Ingest_PRD_Alert_User;
use warehouse PUREINSIGHTS_DP4BI_PRD_WH;
use database PUREINSIGHTS_PRD;
use schema PUBLIC;

alter table d_pi_projects_history add
(
    projectchargecode           varchar(100),
    projectchargecodename       varchar(400)
);
