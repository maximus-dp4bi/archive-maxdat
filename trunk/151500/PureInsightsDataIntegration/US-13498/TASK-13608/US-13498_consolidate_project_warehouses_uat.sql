use warehouse PUREINSIGHTS_UAT_LOAD_DAILY_WH;
use database PUREINSIGHTS_UAT;
use schema PUBLIC;

create or replace table d_pi_projects_proj_specific_wh as select * from d_pi_projects;

update d_pi_projects set ingest_wh = 'PUREINSIGHTS_UAT_LOAD_DAILY_WH', update_timestamp = current_timestamp();
