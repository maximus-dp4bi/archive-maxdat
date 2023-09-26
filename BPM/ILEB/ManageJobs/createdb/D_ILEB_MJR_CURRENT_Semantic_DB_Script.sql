--IL EB MANAGE JOBS
CREATE TABLE D_ILEB_MJR_CURRENT
  (
    ILEB_MJR_BI_ID					NUMBER,
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
    REPONSE_FILE_REQUIRED   		VARCHAR2(50),
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
	CANCEL_REASON 					VARCHAR2(100), --CALCULATED
	FILE_RECEIVED_TIMELY 			VARCHAR2(32), --CALCULATED
	RECORD_COUNT_THRESHOLD_MET 		VARCHAR2(32), --CALCULATED
	RECORD_ERROR_PERCENTAGE 		NUMBER, --CALCULATED
	RECORD_ERROR_THRESHOLD 			VARCHAR2(32), --CALCULATED
	FILE_PROCESSED_TIMELY 			VARCHAR2(32), --CALCULATED
	FILE_PROCESS_TIME 				NUMBER--CALCULATED
  )PARALLEL;
  

grant select on D_ILEB_MJR_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_ILEB_MJR_CURRENT_SV as
select * from D_ILEB_MJR_CURRENT 
with read only;

grant select on D_ILEB_MJR_CURRENT_SV to MAXDAT_READ_ONLY;

alter table D_ILEB_MJR_CURRENT add constraint DIMJRCUR_PK primary key (ILEB_MJR_BI_ID);
alter index DIMJRCUR_PK rebuild tablespace MAXDAT_INDX parallel;

create or replace view D_ILEB_MJR_CURRENT_SV as
select * from D_ILEB_MJR_CURRENT 
with read only;


----- D_ILEB_MJR_LAST_UPDATE_BY    DIMJRLUB_ID  
create sequence SEQ_DIMJRLUB_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_ILEB_MJR_LAST_UPDATE_BY
   (
     DIMJRLUB_ID number not null, 
     LAST_UPDATE_BY_NAME 			VARCHAR2(50)
   ) parallel;

alter table D_ILEB_MJR_LAST_UPDATE_BY add constraint DIMJRLUB_PK primary key (DIMJRLUB_ID);
alter index DIMJRLUB_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DIMJRLUB_UIX1 on D_ILEB_MJR_LAST_UPDATE_BY (LAST_UPDATE_BY_NAME) tablespace MAXDAT_INDX parallel compute statistics;    

grant select on D_ILEB_MJR_LAST_UPDATE_BY to MAXDAT_READ_ONLY;

create or replace view D_ILEB_MJR_LAST_UPDATE_BY_SV as
select * from D_ILEB_MJR_LAST_UPDATE_BY
with read only;

grant select on D_ILEB_MJR_LAST_UPDATE_BY_SV to MAXDAT_READ_ONLY;

insert into D_ILEB_MJR_LAST_UPDATE_BY (DIMJRLUB_ID ,LAST_UPDATE_BY_NAME) values (SEQ_DIMJRLUB_ID.nextval,null);
commit;


create sequence SEQ_FIMJRBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_ILEB_MJR_BY_DATE
   (
     FIMJRBD_ID number not null, 
     D_DATE date not null, 
     BUCKET_START_DATE DATE NOT NULL,
     BUCKET_END_DATE DATE NOT NULL,
     ILEB_MJR_BI_ID number not null, 
	 DIMJRLUB_ID number not null, 
	 LAST_UPDATE_BY_DATE 		DATE,
     INVENTORY_COUNT number, 
     CREATION_COUNT number, 
     COMPLETION_COUNT number 
   ) parallel;

alter table F_ILEB_MJR_BY_DATE add constraint FIMJRBD_PK primary key (FIMJRBD_ID);

alter table F_ILEB_MJR_BY_DATE add constraint FIMJRBD_DIMJRLUB_FK foreign key (DIMJRLUB_ID) references D_ILEB_MJR_LAST_UPDATE_BY(DIMJRLUB_ID);
alter table F_ILEB_MJR_BY_DATE add constraint FIMJRBD_DIMJRCUR_FK foreign key (ILEB_MJR_BI_ID) references D_ILEB_MJR_CURRENT(ILEB_MJR_BI_ID);

alter index FIMJRBD_PK rebuild tablespace MAXDAT_INDX parallel;

CREATE UNIQUE INDEX FNMRBD_UIX1 ON F_ILEB_MJR_BY_DATE(FIMJRBD_ID, D_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
CREATE UNIQUE INDEX FNMRBD_UIX2 ON F_ILEB_MJR_BY_DATE(FIMJRBD_ID, BUCKET_START_DATE) tablespace MAXDAT_INDX  parallel compute statistics;
CREATE UNIQUE INDEX FNMRBD_UIX3 ON F_ILEB_MJR_BY_DATE(FIMJRBD_ID, BUCKET_END_DATE) tablespace MAXDAT_INDX  parallel compute statistics;

grant select on F_ILEB_MJR_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_ILEB_MJR_BY_DATE_SV as
select
     FIMJRBD_ID, 
     bdd.D_DATE, 
     BUCKET_START_DATE,
     BUCKET_END_DATE,
     ILEB_MJR_BI_ID, 
	 DIMJRLUB_ID,
	 INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by ILEB_MJR_BI_ID order by ILEB_MJR_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_ILEB_MJR_BY_DATE fimjrbd
where
  bdd.D_DATE >= fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE < fimjrbd.BUCKET_END_DATE
union all
select
     FIMJRBD_ID, 
     bdd.D_DATE, 
     BUCKET_START_DATE,
     BUCKET_END_DATE,
     ILEB_MJR_BI_ID, 
	 DIMJRLUB_ID,
	 INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by ILEB_MJR_BI_ID order by ILEB_MJR_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  COMPLETION_COUNT, 
  LAST_UPDATE_BY_DATE
from 
  BPM_D_DATES bdd,
  F_ILEB_MJR_BY_DATE fimjrbd
where
  bdd.D_DATE = fimjrbd.BUCKET_START_DATE 
  and bdd.D_DATE = fimjrbd.BUCKET_END_DATE
with read only;
   
grant select on F_ILEB_MJR_BY_DATE_SV to MAXDAT_READ_ONLY;
 





