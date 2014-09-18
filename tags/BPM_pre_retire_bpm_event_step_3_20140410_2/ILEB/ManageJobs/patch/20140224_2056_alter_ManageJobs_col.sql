--ETL
ALTER TABLE CORP_ETL_MANAGE_JOBS
  modify  (PLAN_NAME varchar2(64));
       
       
ALTER TABLE CORP_ETL_MANAGE_JOBS_OLTP
   modify  (PLAN_NAME varchar2(64));

ALTER TABLE CORP_ETL_MANAGE_JOBS_WIP_BPM
   modify  (PLAN_NAME varchar2(64));
 

   
--Semantic

ALTER TABLE D_MJ_CURRENT
modify  (HEALTH_PLAN_NAME  varchar2(64));



create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;  


