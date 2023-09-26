use schema OHPNM_DP4BI_DEV;

create or replace stage OHPNM_DP4BI_DEV_S3_SSDB_CDC
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.ohio.provider.dev'
  credentials=(aws_key_id='AKIAT6QV4CSZJE7OYBUM' aws_secret_key='azjNu+dh9rNvEMpWeuXeZPDTuUVGWUICecMAf1IK');