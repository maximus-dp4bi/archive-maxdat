
CREATE TABLE D_MJ_CURRENT
  (
    MJ_BI_ID					NUMBER,
    JOB_ID   						NUMBER,
    CREATE_DATE 					DATE,
    CREATED_BY 						VARCHAR2(80),
    JOB_NAME   						VARCHAR2(500),
    JOB_DETAIL 						VARCHAR2(500),
    JOB_GROUP  						VARCHAR2(80),
    JOB_TYPE   						VARCHAR2(32),
    JOB_START_DATE 					DATE,
    JOB_END_DATE 					DATE,
    JOB_STATUS 						VARCHAR2(100),
    FILE_NAME  						VARCHAR2(50),
    RECEIPT_DATE 					DATE,
    TRANSMIT_DATE 					DATE,
    FILE_TYPE           			VARCHAR2(50),
    FILE_SOURCE         			VARCHAR2(50),
    FILE_DESTINATION    			VARCHAR2(50),
    HEALTH_PLAN_NAME           		VARCHAR2(50),
    RESPONSE_FILE_REQUIRED   		VARCHAR2(50),
    RECORD_COUNT        			NUMBER,
    RECORD_ERROR_COUNT  			NUMBER,
    RESPONSE_FILE_NAME  			VARCHAR2(50),
    LAST_UPDATE_BY_NAME 			VARCHAR2(50), --HISTORY
    LAST_UPDATE_BY_DATE 			DATE, --HISTORY
    IDENTIFY_JOB_START_DATE 		DATE,
    IDENTIFY_JOB_END_DATE 			DATE,
    PROCESS_JOB_START_DATE 			DATE,
    PROCESS_JOB_END_DATE 			DATE,
    CREATE_REPONSE_FILE_START_DATE 	DATE,
    CREATE_RESPONSE_FILE_END_DATE 	DATE,
    CREATE_OUTBOUND_START_DATE 		DATE,
    CREATE_OUTBOUND_END_DATE 		DATE,
    IDENTIFY_JOB_TYPE_FLAG        	VARCHAR2(1),
    PROCESS_JOB_FLAG          		VARCHAR2(1),
    RESPONSE_FILE_FLAG 				VARCHAR2(1),
    OUTBOUND_FILE_FLAG 				VARCHAR2(1),
    PROCESSED_OK_FLAG         		VARCHAR2(1),
    JOB_TYPE_FLAG             		VARCHAR2(1),
    RESPONSE_FILE_GTW_FLAG      	VARCHAR2(1),
    COMPLETE_DATE 					DATE,
    INSTANCE_STATUS 				VARCHAR2(10),
    CANCEL_DATE 					DATE,
    CANCEL_BY VARCHAR2(80 BYTE),
	CANCEL_REASON 					VARCHAR2(100), --CALCULATED
        CANCEL_METHOD VARCHAR2(40 BYTE),
	FILE_RECEIVED_TIMELY 			VARCHAR2(32), --CALCULATED
	RECORD_COUNT_THRESHOLD_MET 		VARCHAR2(32), --CALCULATED
	RECORD_ERROR_PERCENTAGE 		NUMBER, --CALCULATED
	RECORD_ERROR_THRESHOLD 			VARCHAR2(32), --CALCULATED
	FILE_PROCESSED_TIMELY 			VARCHAR2(32), --CALCULATED
	FILE_PROCESS_TIME 				VARCHAR2(20)) --CALCULATED
tablespace MAXDAT_DATA parallel;
  
create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;

alter table D_MJ_CURRENT add constraint DIMJCUR_PK primary key (MJ_BI_ID);
alter index DIMJCUR_PK rebuild tablespace MAXDAT_INDX parallel;

create or replace view D_MJ_CURRENT_SV as
select * from D_MJ_CURRENT 
with read only;

----- D_MJ_LAST_UPDATE_BY    DIMJLUB_ID  
create sequence SEQ_DIMJLUB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_MJ_LAST_UPDATE_BY
   (
     DIMJLUB_ID number not null, 
     LAST_UPDATE_BY_NAME 			VARCHAR2(50))
tablespace MAXDAT_DATA parallel;

alter table D_MJ_LAST_UPDATE_BY add constraint DIMJLUB_PK primary key (DIMJLUB_ID);
alter index DIMJLUB_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DIMJLUB_UIX1 on D_MJ_LAST_UPDATE_BY (LAST_UPDATE_BY_NAME) tablespace MAXDAT_INDX parallel compute statistics;    

create or replace view D_MJ_LAST_UPDATE_BY_SV as
select * from D_MJ_LAST_UPDATE_BY
with read only;


insert into D_MJ_LAST_UPDATE_BY (DIMJLUB_ID ,LAST_UPDATE_BY_NAME) values (SEQ_DIMJLUB_ID.nextval,null);
commit;

create sequence SEQ_FIMJBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_MJ_BY_DATE
   (
     FIMJBD_ID number not null, 
     D_DATE date not null, 
     BUCKET_START_DATE DATE NOT NULL,
     BUCKET_END_DATE DATE NOT NULL,
     MJ_BI_ID number not null, 
	 DIMJLUB_ID number not null, 
	 LAST_UPDATE_BY_DATE 		DATE,
     INVENTORY_COUNT number, 
     CREATION_COUNT number, 
     COMPLETION_COUNT number)
tablespace MAXDAT_DATA parallel;

alter table F_MJ_BY_DATE add constraint FIMJBD_PK primary key (FIMJBD_ID);

alter table F_MJ_BY_DATE add constraint FIMJBD_DIMJLUB_FK foreign key (DIMJLUB_ID) references D_MJ_LAST_UPDATE_BY(DIMJLUB_ID);
alter table F_MJ_BY_DATE add constraint FIMJBD_DIMJCUR_FK foreign key (MJ_BI_ID) references D_MJ_CURRENT(MJ_BI_ID);


alter index FIMJBD_PK rebuild tablespace MAXDAT_INDX parallel;

CREATE UNIQUE INDEX FNMRBD_UIX1 ON F_MJ_BY_DATE(FIMJBD_ID, D_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
CREATE UNIQUE INDEX FNMRBD_UIX2 ON F_MJ_BY_DATE(FIMJBD_ID, BUCKET_START_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
CREATE UNIQUE INDEX FNMRBD_UIX3 ON F_MJ_BY_DATE(FIMJBD_ID, BUCKET_END_DATE) tablespace MAXDAT_INDX  parallel compute statistics;

create or replace view F_MJ_BY_DATE_SV as
select
  FIMJBD_ID, 
  bdd.D_DATE, 
  MJ_BI_ID, 
  DIMJLUB_ID,
  case 
    when dense_rank() over (partition by MJ_BI_ID order by MJ_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_MJ_BY_DATE fimjrbd
where
  bdd.D_DATE >= fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE < fimjrbd.BUCKET_END_DATE
union all
select
  FIMJBD_ID, 
  bdd.D_DATE,
  MJ_BI_ID, 
  DIMJLUB_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_MJ_BY_DATE fimjrbd
where
  bdd.D_DATE = fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE = fimjrbd.BUCKET_END_DATE
with read only;
   
commit;  





