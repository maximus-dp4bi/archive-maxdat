declare  c int;
begin
   select count(*) into c from user_tables where table_name ='NYHBE_ETL_APPEALS_SCHEDULER';
   if c = 1 then
      execute immediate 'drop table NYHBE_ETL_APPEALS_SCHEDULER cascade constraints';
   end if;
end;
/

create table NYHBE_ETL_APPEALS_SCHEDULER 
(
NEPAS_ID                        NUMBER NOT NULL
,INCIDENT_APPOINTMENT_LINK_ID   NUMBER(18,0) NOT NULL
,INCIDENT_HEADER_ID             NUMBER(18,0)
,CREATED_BY                     VARCHAR2(80)
,CREATE_DT                      DATE
,ITEM_STATUS_CD                 VARCHAR2(32)
,CATEGORY_CD                    VARCHAR2(32)
,PRIORITY_CD                    VARCHAR2(32)
,START_DT                       DATE
,END_DT                         DATE
,UPDATE_DT                      DATE
,STG_EXTRACT_DATE          		DATE DEFAULT SYSDATE NOT NULL
,STG_LAST_UPDATE_DATE      		DATE DEFAULT SYSDATE NOT NULL
)
    TABLESPACE MAXDAT_DATA;
    
GRANT SELECT ON NYHBE_ETL_APPEALS_SCHEDULER TO MAXDAT_READ_ONLY;
GRANT SELECT ON NYHBE_ETL_APPEALS_SCHEDULER TO DP_SCORECARD; 

create unique index NYHBE_ETL_APLS_nepas_id_ndx on NYHBE_ETL_APPEALS_SCHEDULER (NEPAS_ID) TABLESPACE MAXDAT_INDX;
create index NYHBE_ETL_APLS_ial_id_ndx on NYHBE_ETL_APPEALS_SCHEDULER (INCIDENT_APPOINTMENT_LINK_ID) TABLESPACE MAXDAT_INDX;
create index NYHBE_ETL_APLS_ih_id_ndx on NYHBE_ETL_APPEALS_SCHEDULER (INCIDENT_HEADER_ID) TABLESPACE MAXDAT_INDX;
create index NYHBE_ETL_APLS_stat_cd_ndx on NYHBE_ETL_APPEALS_SCHEDULER (ITEM_STATUS_CD) TABLESPACE MAXDAT_INDX;
create index NYHBE_ETL_APLS_cat_cd_ndx on NYHBE_ETL_APPEALS_SCHEDULER (CATEGORY_CD) TABLESPACE MAXDAT_INDX;
create index NYHBE_ETL_APLS_pri_cd_ndx on NYHBE_ETL_APPEALS_SCHEDULER (PRIORITY_CD) TABLESPACE MAXDAT_INDX;

create OR REPLACE VIEW D_APPEALS_SCHEDULER_SV    
(
NEPAS_ID                       
,INCIDENT_APPOINTMENT_LINK_ID   
,INCIDENT_HEADER_ID             
,CREATED_BY                     
,CREATE_DT                      
,ITEM_STATUS_CD                 
,CATEGORY_CD                    
,PRIORITY_CD                    
,START_DT                       
,END_DT                         
,UPDATE_DT                      
)  AS
SELECT 
NEPAS_ID                       
,INCIDENT_APPOINTMENT_LINK_ID   
,INCIDENT_HEADER_ID             
,CREATED_BY                     
,CREATE_DT                      
,ITEM_STATUS_CD                 
,CATEGORY_CD                    
,PRIORITY_CD                    
,START_DT                       
,END_DT                         
,UPDATE_DT  
FROM NYHBE_ETL_APPEALS_SCHEDULER
WITH READ ONLY;

GRANT SELECT ON D_APPEALS_SCHEDULER_SV TO MAXDAT_READ_ONLY;
GRANT SELECT ON D_APPEALS_SCHEDULER_SV TO DP_SCORECARD;  

declare  c int;
begin
   select count(*) into c from user_objects where object_type = 'SEQUENCE' and object_name ='SEQ_NEPAS_ID';
   if c = 1 then
      execute immediate 'DROP SEQUENCE SEQ_NEPAS_ID';
   end if;
end;
/

CREATE SEQUENCE SEQ_NEPAS_ID -- FOR NYHBE_ETL_APPEALS_SCHEDULER
    START WITH 10
    INCREMENT BY 1
    NOMINVALUE
    NOMAXVALUE
    NOCYCLE
    NOORDER
    CACHE 20;

CREATE OR REPLACE trigger TRG_R_NYHBE_ETL_APPEALS_SCHED 
before insert or update on NYHBE_ETL_APPEALS_SCHEDULER 
for each row 
begin 
if inserting then
    if :new.NEPAS_ID is null then
      :new.NEPAS_ID := SEQ_NEPAS_ID.nextval;
    end if;
    if :new.STG_EXTRACT_DATE is null then
      :new.STG_EXTRACT_DATE  := sysdate;
    end if;
  end if;
  :new.STG_LAST_UPDATE_DATE := sysdate;
end;
/


	