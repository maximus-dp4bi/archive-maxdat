use database MARS_DP4BI_UAT;
create schema COVERVA_DMAS;

use schema COVERVA_DMAS;

create or replace stage COVERVA_DMAS_UAT_S3_SSDB
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.coverva.uat'
  credentials=(aws_key_id='AKIAT6QV4CSZGXK3N2BD' aws_secret_key='BH6PpFjsSjhHGJIGX9HP2/MeNSV7Y13aM+sBSW7k');