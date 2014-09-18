--ETL
ALTER TABLE CORP_ETL_MANAGE_JOBS
  modify  (LAST_UPDATE_BY_NAME varchar2(102));
       
       
ALTER TABLE CORP_ETL_MANAGE_JOBS_OLTP
   modify  (LAST_UPDATE_BY_NAME varchar2(102));

ALTER TABLE CORP_ETL_MANAGE_JOBS_WIP_BPM
   modify  (LAST_UPDATE_BY_NAME varchar2(102));
   

ALTER TABLE CORP_ETL_MANAGE_JOBS
  modify  (CREATED_BY varchar2(102));
       
       
ALTER TABLE CORP_ETL_MANAGE_JOBS_OLTP
   modify  (CREATED_BY varchar2(102));

ALTER TABLE CORP_ETL_MANAGE_JOBS_WIP_BPM
   modify  (CREATED_BY varchar2(102));
 
   
--Semantic
ALTER TABLE D_MJ_CURRENT
modify  (LAST_UPDATE_BY_NAME varchar2(102));

ALTER TABLE D_MJ_CURRENT
modify  (CREATED_BY varchar2(102));

ALTER TABLE D_MJ_LAST_UPDATE_BY
modify  (LAST_UPDATE_BY_NAME varchar2(102));


create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;  


create or replace view D_MJ_LAST_UPDATE_BY_SV as
select * from D_MJ_LAST_UPDATE_BY
with read only;