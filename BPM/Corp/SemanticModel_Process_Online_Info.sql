--D_ONL_CURRENT dimension table
CREATE TABLE D_ONL_CURRENT
  (
    ONL_BI_ID                    NUMBER ,
    Transaction_ID               NUMBER(18,0) ,
    Transaction_Type             VARCHAR2(50 BYTE) ,
    Create_Date                  DATE ,
    Create_By_Name               VARCHAR2(80 BYTE) ,
    Case_ID                      NUMBER(18,0) ,
    Client_ID                    NUMBER(18,0) ,
    Work_Required_Flag           VARCHAR2(1 BYTE) ,
    CUR_Instance_Status          VARCHAR2(10 BYTE) ,
    Source_Record_Type           VARCHAR2(50 BYTE) ,
    Source_Record_ID             NUMBER(18,0) ,
    Last_Update_Date             DATE ,
    Last_Updated_by_Name         VARCHAR2(80 BYTE) ,
    Language                     VARCHAR2(2 BYTE) ,
    Process_New_Info_Start_Date  DATE ,
    Process_New_Info_End_Date    DATE ,
    Create_Route_Work_Start_Date DATE ,
    Create_Route_Work_End_Date   DATE ,
    Cancel_Reason                VARCHAR2(50 BYTE) ,
    Cancel_Method                VARCHAR2(32 BYTE) ,
    Cancel_By                    VARCHAR2(80 BYTE) ,
    Cancel_Date                  DATE ,
    Complete_Date                DATE ,
    Age_in_Business_Days         NUMBER ,
    Age_in_Calendar_Days         NUMBER ,
    Timeliness_Status            VARCHAR2(20 BYTE) ,
    Jeopardy_Status              VARCHAR2(1 BYTE) ,
    SLA_Days                     NUMBER ,
    SLA_Days_Type                VARCHAR2(1 BYTE) ,
    SLA_Target_Days              NUMBER ,
    Jeopardy_Days                NUMBER ,
    Jeopardy_Days_Type           VARCHAR2(1 BYTE) ,
    Jeopardy_Target_Days         NUMBER ,
    Jeopardy_Date                DATE
  )
  TABLESPACE MAXDAT_DATA parallel;

alter table D_ONL_CURRENT add constraint DONLCUR_PK primary key (ONL_BI_ID);
alter index DONLCUR_PK rebuild tablespace MAXDAT_INDX parallel;
  
create or replace view D_ONL_CURRENT_SV as
select * from D_ONL_CURRENT 
with read only;  

--D_ONL_INSTANCE_STATUS dimension table 
create sequence SEQ_DONLIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_ONL_INSTANCE_STATUS
   (
     DONLIS_ID number not null, 
     Instance_Status 			VARCHAR2(50)
   )  tablespace MAXDAT_DATA parallel;

alter table D_ONL_INSTANCE_STATUS add constraint DONLIS_PK primary key (DONLIS_ID);
alter index DONLIS_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DONLIS_PK_UIX1 on D_ONL_INSTANCE_STATUS(Instance_Status) tablespace MAXDAT_INDX parallel compute statistics;    

create or replace view D_ONL_INSTANCE_STATUS_SV as
select * from D_ONL_INSTANCE_STATUS
with read only;

insert into D_ONL_INSTANCE_STATUS (DONLIS_ID,Instance_Status) values (SEQ_DONLIS_ID.nextval,null);
commit;


--F_ONL_BY_DATE fact table 
create sequence SEQ_FCMORBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_ONL_BY_DATE
   (
     FONLBD_ID number not null, 
     D_DATE date not null,
     BUCKET_START_DATE DATE NOT NULL,
     BUCKET_END_DATE DATE NOT NULL,
     ONL_BI_ID number NOT NULL,
     DONLIS_ID number NOT NULL,
     LAST_UPDATE_BY_DATE DATE,
     CREATION_COUNT number, 
     INVENTORY_COUNT number, 
     COMPLETION_COUNT number
    )
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2013 values less than (to_date('20130101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;


alter table F_ONL_BY_DATE add constraint FONLBD_PK primary key (FONLBD_ID);
alter index FONLBD_PK rebuild tablespace MAXDAT_INDX parallel;

alter table F_ONL_BY_DATE add constraint FONLBD_DONLCUR_FK foreign key (ONL_BI_ID) references D_ONL_CURRENT (ONL_BI_ID);
alter table F_ONL_BY_DATE add constraint FONLBD_DONLIS_FK foreign key (DONLIS_ID) references D_ONL_INSTANCE_STATUS (DONLIS_ID);

create unique index FONLBD_UIX1 on F_ONL_BY_DATE (ONL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FONLBD_UIX2 on F_MW_BY_DATE (ONL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FONLBD_IX1 on F_ONL_BY_DATE (LAST_UPDATE_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL1 on F_ONL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FONLBD_IXL2 on F_ONL_BY_DATE (ONL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;


create or replace view F_ONL_BY_DATE_SV as
select
  FONLBD_ID, 
  bdd.D_DATE, 
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  case 
    when dense_rank() over (partition by ONL_BI_ID order by ONL_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end Creation_Count,
  Inventory_Count,
  Completion_Count
from 
  BPM_D_DATES bdd,
  F_ONL_BY_DATE fonlbd
where
  bdd.D_DATE >= fonlbd.BUCKET_START_DATE 
  and bdd.D_DATE < fonlbd.BUCKET_END_DATE
union all
select
  FONLBD_ID, 
  bdd.D_DATE, 
  ONL_BI_ID, 
  DONLIS_ID,
  LAST_UPDATE_BY_DATE,
  Creation_Count,
  Inventory_Count,
  Completion_Count
 from 
  BPM_D_DATES bdd,
  F_ONL_BY_DATE fonlbd
where
  bdd.D_DATE = fonlbd.BUCKET_START_DATE 
  and bdd.D_DATE = fonlbd.BUCKET_END_DATE
with read only;
   
commit;  