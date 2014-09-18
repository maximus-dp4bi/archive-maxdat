INSERT INTO corp_etl_control(name,value_type,value,description)  
(select 'CLIENT_INQUIRY_JOB_DATE' name,
'D' value_type,
(select to_char(nvl(max(job_start_date), to_date('2013/02/17 00:00:00','yyyy/mm/dd HH24:MI:SS')))
from corp_etl_job_statistics
where job_status_cd = 'COMPLETED'
and job_name = 'ClientInquiry_Main_RUNALL') value,
'Client Inquiry main job last successful completion date' description
from dual); 

insert into corp_etl_control(name,value_type,value,description)  
values ('CLIENT_INQUIRY_LKBK_DATE','D','2013/02/17 00:00:00','Client Inquiry main job look back date'); 

COMMIT;