use database MARS_DP4BI_PROD;
create schema COVERVA_DMAS;

use schema COVERVA_DMAS;

create or replace stage COVERVA_DMAS_PRD_S3_SSDB
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.coverva.prd'
  credentials=(aws_key_id='AKIAT6QV4CSZF2IBCQ7Z' aws_secret_key='mK8PbqRAPm9zy5wA589J0jxxpisRwHdwK4V8Eegp');

grant all PRIVILEGES on stage COVERVA_DMAS_PRD_S3_SSDB to MARS_DP4BI_PROD_ADMIN;