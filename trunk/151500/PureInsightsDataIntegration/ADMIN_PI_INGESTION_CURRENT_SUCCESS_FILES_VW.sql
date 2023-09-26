use role SYSADMIN;
use warehouse PUREINSIGHTS_DEV_LOAD_DAILY_WH;
use database PUREINSIGHTS_DEV;
use schema PUBLIC;

CREATE OR REPLACE VIEW ADMIN_PI_INGESTION_CURRENT_SUCCESS_FILES_VW(
	TS_EST,
	PROJECTID,
	PROJECTNAME,
	OBJECT_CATEGORY,
	OBJECT_NAME,
	STATUS_STRING,
	MSG
) COPY GRANTS as
select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'


UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_temp ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'



 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_101 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
 
 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_1001 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'


 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_1101 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'


 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_1111 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_1201 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_1301 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_2001 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_201 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_221 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_2222 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_301 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_321 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_3333 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_361 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_401 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_421 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_4444 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_501 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_551 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_555 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_5555 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_701 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_741 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_801 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_8888 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_901 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_903 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  

 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_741 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  
 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_601 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'
  
 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_621 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED'  
  
 UNION

select convert_timezone('America/New_York', to_timestamp_ltz(to_varchar(ddl.ts))) ts_EST,
ddl.projectid,
pp.projectname,
ddl.object_category,
ddl.object_name,
ddl.status_string,
ddl.msg
from raw.ingest_pi_data_det_log_6666 ddl
join public.d_pi_projects pp
on ddl.projectid = pp.projectid
where  pp.active = 'TRUE' 
  and to_date(to_varchar(ddl.ts)) = current_date()  
  and ddl.object_category = 'S3 DATA' and ddl.object_name = '_SUCCESS FILE' and ddl.status_string = 'SUCCEEDED';

GRANT SELECT ON ADMIN_PI_INGESTION_CURRENT_SUCCESS_FILES_VW TO PI_DATA_INGEST_DEV_ALERT_USER;
GRANT SELECT ON ADMIN_PI_INGESTION_CURRENT_SUCCESS_FILES_VW TO MARS_DP4BI_DEV_READ;
