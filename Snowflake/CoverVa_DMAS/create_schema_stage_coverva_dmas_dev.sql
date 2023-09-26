use database MARS_DP4BI_DEV;
create schema COVERVA_DMAS;

use schema COVERVA_DMAS;

create or replace stage COVERVA_DMAS_DEV_S3_SSDB
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.coverva.dev'
  credentials=(aws_key_id='AKIAT6QV4CSZP3WWFCUI' aws_secret_key='qt/Ki4Dbc1XcTw9rCJMdPlu5zu/bxm6QTiPVgs67');