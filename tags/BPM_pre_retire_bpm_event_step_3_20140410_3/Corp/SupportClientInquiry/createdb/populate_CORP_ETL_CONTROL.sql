-- 4/8 Global controls
INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_CONTACT_DAYS','N','30','Client Inquiry''s Number of business days to look for call records.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_DEPLOY_DATE','D',TO_CHAR(SYSDATE,'DD- MON-YYYY'),'Client Inquiry''s production deployment date. Used in Rules Validation scripts.');

INSERT INTO corp_etl_control(name,value_type,value,description)
VALUES('CLIENT_INQUIRY_LAST_CALL_ID','N','0','Client Inquiry''s last processed call record ID.');

INSERT INTO corp_etl_control(name,value_type,value,description)  
(select 'CLIENT_INQUIRY_JOB_DATE' name,
'D' value_type,
(select to_char(nvl(max(job_start_date), to_date('2013/02/17 00:00:00','yyyy/mm/dd HH24:MI:SS')))
from corp_etl_job_statistics
where job_status_cd = 'COMPLETED'
and job_name = 'ClientInquiry_Main_RUNALL') value,
'Client Inquiry main job last successful completion date' description
from dual); -- 2013/02/17 is the first call record in call_record ILEBPRD

insert into corp_etl_control(name,value_type,value,description)  
values ('CLIENT_INQUIRY_LKBK_DATE','D','2013/02/17 00:00:00','Client Inquiry main job look back date'); -- date to which the main job should look back

COMMIT;

--
