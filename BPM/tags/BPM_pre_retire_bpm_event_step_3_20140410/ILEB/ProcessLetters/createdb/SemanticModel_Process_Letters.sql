--PROCESS LETTERS
create table D_PL_CURRENT
  (PL_BI_ID                       number,
   LETTER_REQUEST_ID                   number not null,
	 CREATE_DATE							date not null,
	 CREATED_BY							varchar2(50),
	 REQUEST_DATE						date,
	 INSTANCE_STATUS						varchar2(10) not null,
	 LETTER_TYPE							varchar2(100),
	 PROGRAM								varchar2(50),
	 CASE_ID								number,
	 COUNTY_CODE							varchar2(10),
	 ZIP_CODE							number,
	 LANGUAGE							varchar2(32),
	 REPRINT								varchar2(1),
	 REQUEST_DRIVER_TYPE					varchar2(10),
	 REQUEST_DRIVER_TABLE				varchar2(32),
	 LETTER_STATUS				        varchar2(32) not null,
	 LETTER_STATUS_DATE					date not null,
	 SENT_DATE							date,
	 PRINT_DATE							date,
	 MAILED_DATE							date,
	 RETURN_DATE							date,
	 RETURN_REASON						varchar2(100),
	 REJECTION_REASON					varchar2(100),
	 REQUEST_ERROR_REASON				varchar2(100),
	 TRANSMITTED_FILE_NAME				varchar2(100),
	 TRANSMITTED_FILE_DATE				date,
	 LETTER_RESPONSE_FILE_NAME			varchar2(100),
	 LETTER_RESPONSE_FILE_DATE			date,
	 LAST_UPDATE_DATE					date,
	 LAST_UPDATED_BY_NAME				varchar2(50),
	 NEWBORN_FLAG				        varchar2(1) ,
	 TASK_ID                   			number,
	 CANCEL_DATE							date,
	 CANCEL_BY							varchar2(50),
	 COMPLETE_DATE						date,
	 PROCESS_LTR_REQUEST_START_DATE		date,
	 PROCESS_LTR_REQUEST_END_DATE		date,
	 SEND_TO_MAIL_HOUSE_START_DATE		date,
	 SEND_TO_MAIL_HOUSE_END_DATE			date,
	 RECEIVE_CONFIRM_START_DATE		date,
	 RECEIVE_CONFIRM_END_DATE		date,
	 CREATE_ROUTE_WORK_START_DATE		date,
	 CREATE_ROUTE_WORK_END_DATE			date,
	 AGE_IN_BUSINESS_DAYS                number,
	 AGE_IN_CALENDAR_DAYS                number,
	 TIMELINESS_STATUS					varchar2(20),
	 JEOPARDY_STATUS				        varchar2(1),
	 SLA_CATEGORY				        varchar2(32),
	 SLA_DAYS                			varchar2(20),
	 SLA_DAYS_TYPE				        varchar2(1),
	 SLA_JEOPARDY_DATE					date,
	 SLA_JEOPARDY_DAYS                	number,
	 SLA_TARGET_DAYS                		number,
	 VALIDATION_FLAG						varchar2(1),
	 OUTCOME_FLAG						varchar2(1),
	 WORK_REQUIRED_FLAG					varchar2(1),
	 PROCESS_LETTERS_FLAG				varchar2(1) not null,
	 TRANSMIT_FLAG			  			varchar2(1) not null,
	 CONFIRMATION_FLAG					varchar2(1) not null,
	 CREATE_ROUTE_WORK_FLAG				varchar2(1) not null)
tablespace MAXDAT_DATA parallel;

alter table D_PL_CURRENT add constraint DPICUR_PK primary key (PL_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DPLCUR_UIX1 on D_PL_CURRENT (LETTER_REQUEST_ID) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_PL_CURRENT for D_PL_CURRENT;
grant select on D_PL_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_PL_CURRENT_SV as
select * from D_PL_CURRENT
with read only;

create or replace public synonym D_PL_CURRENT_SV for D_PL_CURRENT_SV;
grant select on D_PL_CURRENT_SV to MAXDAT_READ_ONLY;


-----  D_PL_LETTER_STATUS    DPLLS_ID  
create sequence SEQ_DPLLS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_PL_LETTER_STATUS
  (DPLLS_ID number not null, 
   LETTER_STATUS varchar2(50))) 
tablespace MAXDAT_DATA;

alter table D_PL_LETTER_STATUS add constraint DPLLS_PK primary key (DPLLS_ID) using index tablespace MAXDAT_INDX;

create unique index DPLLS_UIX1 on D_PL_LETTER_STATUS (LETTER_STATUS) tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_PI_LETTER_STATUS for D_PI_LETTER_STATUS;
grant select on D_PI_LETTER_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PL_LETTER_STATUS_SV as
select * from D_PL_LETTER_STATUS
with read only;

create or replace public synonym D_PL_LETTER_STATUS_SV for D_PL_LETTER_STATUS_SV;
grant select on D_PL_LETTER_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_PL_LETTER_STATUS (DPLLS_ID ,LETTER_STATUS) values (SEQ_DPLLS_ID.NEXTVAL,null);
commit;


create sequence SEQ_FPLBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_PL_BY_DATE 
  (FPLBD_ID number not null,
	 D_DATE date not null,
	 BUCKET_START_DATE date not null, 
	 BUCKET_END_DATE date not null,
	 PL_BI_ID number not null, 
	 DPLLS_ID  number not null,
   CREATION_COUNT number,
	 INVENTORY_COUNT number,
	 COMPLETION_COUNT number,
	 LETTER_STATUS_DATE date)
partition by range (BUCKET_START_DATE)
interval (NUMTODSINTERVAL(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (TO_DATE('20120101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_PL_BY_DATE add constraint FPLBD_PK primary key (FPLBD_ID) using index tablespace MAXDAT_INDX;

alter table F_PL_BY_DATE add constraint FPLBD_DPLLS_FK foreign key (DPLLS_ID) references D_PL_LETTER_STATUS(DPLLS_ID);
alter table F_PL_BY_DATE add constraint FPLBD_DPLCUR_FK foreign key (PL_BI_ID) references D_PL_CURRENT(PL_BI_ID);

create unique index FPLBD_UIX1 on F_PL_BY_DATE (PL_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FPLBD_UIX2 on F_PL_BY_DATE (PL_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FPLBD_IX1 on F_PL_BY_DATE (LETTER_STATUS_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FPLBD_IXL1 on F_PL_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL2 on F_PL_BY_DATE (PL_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL3 on F_PL_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FPLBD_IXL4 on F_PL_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_PL_BY_DATE for F_PL_BY_DATE;
grant select on F_PL_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_PL_BY_DATE_SV as
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  case 
    when dense_rank() over (partition by PL_BI_ID order by PL_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,	 
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  BPM_D_DATES BDD,
  F_PL_BY_DATE FPLBD
where
  bdd.D_DATE >= fplbd.BUCKET_START_DATE 
  and bdd.D_DATE < fplbd.BUCKET_END_DATE
union all
select
  FPLBD_ID,
  bdd.D_DATE,
  PL_BI_ID, 
  DPLLS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  LETTER_STATUS_DATE
from 
  BPM_D_DATES bdd,
  F_PL_BY_DATE fplbd
where
  bdd.D_DATE = fplbd.BUCKET_START_DATE 
  and bdd.D_DATE = fplbd.BUCKET_END_DATE
with read only;

create or replace public synonym F_PL_BY_DATE_SV for F_PL_BY_DATE_SV;
grant select on F_PL_BY_DATE_SV to MAXDAT_READ_ONLY;

