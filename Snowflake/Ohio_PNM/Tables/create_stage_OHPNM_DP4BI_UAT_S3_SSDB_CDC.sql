use schema OHPNM_DP4BI;

create or replace stage OHPNM_DP4BI_UAT_S3_SSDB_CDC
  file_format = (type ='json')
  url = 's3://com.maximus.dp4bi.ohio.provider.uat'
  credentials=(aws_key_id='AKIAT6QV4CSZA5AB5GJY' aws_secret_key='osDsyFF8dsTY1Q4u9d/QjjF4a47wVp5JmF/sDong');