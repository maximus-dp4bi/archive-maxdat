use database MARS_DP4BI_DEV;
create schema COVERVA_MIO;

use schema COVERVA_MIO;

create or replace stage COVERVA_MIO_DEV_S3_SSDB
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.coverva.mio/dev'
  credentials=(aws_key_id='AKIAT6QV4CSZNXA6JR42' aws_secret_key='O01oCuQ+AfXLgTglWhbkUanqZ/gG2cwGxPl6LqwJ');