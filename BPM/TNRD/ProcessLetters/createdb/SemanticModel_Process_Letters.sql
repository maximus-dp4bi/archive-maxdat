/*
v1 Creation.
v2 Raj A. 11/3/2015 Changed column size for Letter_Type and SLA_Category to 4000 to match source system column size, Letter_Definition.Description
v3 Raj A. 11/5/2015 (1) Modified Letter_Status to 256 Bytes to match the source system field, ENUM_LM_STATUS.description. 
                    (2) Also, modified the column in the dimension, D_PL_LETTER_STATUS.letter_status
*/
--PROCESS LETTERS
create table D_PL_CURRENT
  (PL_BI_ID                       number,
   letter_request_id              number not null,
	 create_date							      date not null,
	 created_by							        varchar2(50),
	 request_date						        date,
	 instance_status						    varchar2(10) not null,
	 letter_type							      varchar2(4000),
	 program								        varchar2(50),
	 case_id								        number,
	 county_code							      varchar2(64),
	 zip_code							          number,
	 language							          varchar2(32),
	 reprint								        varchar2(1),
	 request_driver_type					  varchar2(10),
	 request_driver_table				    varchar2(32),
	 letter_status				          varchar2(256) not null,
	 letter_status_date					    date not null,
	 sent_date							        date,
	 print_date							        date,
	 mailed_date							      date,
	 return_date							      date,
	 return_reason						      varchar2(100),
	 rejection_reason					      varchar2(100),
	 request_error_reason				    varchar2(4000),
	 transmitted_file_name				  varchar2(100),
	 TRANSMITTED_FILE_DATE				  date,
	 LETTER_RESPONSE_FILE_NAME			varchar2(100),
	 letter_response_file_date			date,
	 last_update_date					      date,
	 last_updated_by_name				    varchar2(50),
	 NEWBORN_FLAG				            varchar2(1) ,
	 task_id                   			number,
	 cancel_date							      date,
	 cancel_by							        varchar2(50),
	 COMPLETE_DATE						      date,
	 PROCESS_LTR_REQUEST_START_DATE	date,
	 PROCESS_LTR_REQUEST_END_DATE		date,
	 SEND_TO_MAIL_HOUSE_START_DATE	date,
	 send_to_mail_house_end_date		date,
	 receive_confirm_start_date		  date,
	 RECEIVE_CONFIRM_END_DATE		    date,
	 CREATE_ROUTE_WORK_START_DATE		date,
	 create_route_work_end_date			date,
	 age_in_business_days           number,
	 age_in_calendar_days           number,
	 timeliness_status					    varchar2(20),
	 jeopardy_status				        varchar2(1),
	 sla_category				            varchar2(4000),
	 sla_days                		    varchar2(20),
	 sla_days_type				          varchar2(1),
	 sla_jeopardy_date					    date,
	 sla_jeopardy_days              number,
	 sla_target_days                number,
	 validation_flag						    varchar2(1),
	 outcome_flag						        varchar2(1),
	 work_required_flag					    varchar2(1),
	 process_letters_flag				    varchar2(1) not null,
	 transmit_flag			  			    varchar2(1) not null,
	 confirmation_flag					    varchar2(1) not null,
	 create_route_work_flag			    varchar2(1) not null,
   material_request_id            number(18,0),
   family_member_count            number(18,0),
   AIAN_MEMBER_COUNT              number(18,0))
tablespace MAXDAT_DATA parallel;

alter table D_PL_CURRENT add constraint DPICUR_PK primary key (PL_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DPLCUR_UIX1 on D_PL_CURRENT (LETTER_REQUEST_ID) online tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_PL_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_PL_CURRENT_SV as
select pl.*,
      (SELECT case_cin FROM app_case_link_stg cls WHERE cls.case_id = pl.case_id
        AND cls.create_ts = (SELECT MAX(cls1.create_ts) FROM app_case_link_stg cls1 WHERE cls.case_id = cls1.case_id)) state_case_id,
      CASE WHEN TO_CHAR(pl.mailed_date + 20,'D') IN ('1','7') OR EXISTS(SELECT 1 FROM holidays h WHERE h.holiday_date = TRUNC(pl.mailed_date+20)) THEN
         get_business_date(TRUNC(pl.mailed_date+20),1) ELSE TRUNC(pl.mailed_date)+20 END after20_caldays,            
      TRUNC(pl.mailed_date)+40 after40_caldays      
from D_PL_CURRENT pl
with read only;

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
   LETTER_STATUS varchar2(256))
tablespace MAXDAT_DATA;

alter table D_PL_LETTER_STATUS add constraint DPLLS_PK primary key (DPLLS_ID) using index tablespace MAXDAT_INDX;

create unique index DPLLS_UIX1 on D_PL_LETTER_STATUS (LETTER_STATUS) tablespace MAXDAT_INDX parallel compute statistics;

grant select on D_PL_LETTER_STATUS to MAXDAT_READ_ONLY;

create or replace view D_PL_LETTER_STATUS_SV as
select * from D_PL_LETTER_STATUS
with read only;

insert into D_PL_LETTER_STATUS (DPLLS_ID ,LETTER_STATUS) values (SEQ_DPLLS_ID.NEXTVAL,null);
commit;

grant select on D_PL_LETTER_STATUS_SV to MAXDAT_READ_ONLY;


create or replace view D_PL_CLIENT_SUB_SV as
select * 
from CORP_ETL_PROC_LETTERS_CHD
with read only;

grant select on D_PL_CLIENT_SUB_SV to MAXDAT_READ_ONLY;


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

grant select on F_PL_BY_DATE_SV to MAXDAT_READ_ONLY;