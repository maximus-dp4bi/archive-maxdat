-- Create Semantic Data Model for NYEC Process App Missing Info process.

create table D_NYEC_PAMI_CURRENT
  (NYEC_PAMI_BI_ID number,
	 "MI Item ID" number,
	 "Application ID" number,
	 "MI Item Level" varchar2(20),
	 "MI Item Type" varchar2(20),
	 "MI Item Create Date" date,
	 "MI Item Requested By" varchar2(50),
	 "MI Letter Required Status" varchar2(20),
	 "MI Letter ID" number,
	 "Cur RFE Status" varchar2(35),
	 "RFE Status Date" date,
	 "Cur MI Item Status" varchar2(35),
	 "MI Item Status Date" date,
	 "Cur MI Item Status Performer" varchar2(50),
	 "MI Letter Cycle Start Date" date,
	 "MI Letter Cycle End Date" date,
	 "MI Item Create Task Type" varchar2(35),
	 "Refer to District Checkbx" varchar2(1),
	 "Refer to District Checkbx Date" date,
	 "Undeliverable Checkbox" varchar2(1),
	 "Undeliverable Checkbox Date" date,
	 "MI Validated Date" date,
	 "HEART MI Due Date" date,
         "MAXe MI Due Date" date,
	 "MI Type" varchar2(100),
	 "MI Letter Name" varchar2(56),
	 "MI Satisfied Reason" varchar2(60))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PAMI_CURRENT add constraint DNPAMICUR_PK primary key (NYEC_PAMI_BI_ID) using index tablespace MAXDAT_INDX;

create index DNPAMICUR_IX1 on D_NYEC_PAMI_CURRENT ("Application ID") online tablespace MAXDAT_INDX parallel compute statistics; 

grant select on D_NYEC_PAMI_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PAMI_CURRENT_SV as
select * from D_NYEC_PAMI_CURRENT
with read only;

grant select on D_NYEC_PAMI_CURRENT_SV to MAXDAT_READ_ONLY;


create sequence SEQ_DNPAMIIS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PAMI_ITEM_STATUS 
  (DNPAMIIS_ID number, 
   "MI Item Status" varchar2(35))
tablespace MAXDAT_DATA;

alter table D_NYEC_PAMI_ITEM_STATUS add constraint DNPAMIIS_PK primary key (DNPAMIIS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAMIIS_UIX1 on D_NYEC_PAMI_ITEM_STATUS ("MI Item Status") online tablespace MAXDAT_INDX parallel compute statistics; 

grant select on D_NYEC_PAMI_ITEM_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PAMI_ITEM_STATUS_SV as
select * from D_NYEC_PAMI_ITEM_STATUS
with read only;

grant select on D_NYEC_PAMI_ITEM_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PAMI_ITEM_STATUS (DNPAMIIS_ID,"MI Item Status") values (SEQ_DNPAMIIS_ID.nextval,null);
commit;


create sequence SEQ_DNPAMIISP_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PAMI_ITEM_STATUS_PER
  (DNPAMIISP_ID number, 
   "MI Item Status Performer" varchar2(35))
tablespace MAXDAT_DATA;

alter table D_NYEC_PAMI_ITEM_STATUS_PER add constraint DNPAMIISP_PK primary key (DNPAMIISP_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAMIISP_UIX1 on D_NYEC_PAMI_ITEM_STATUS_PER ("MI Item Status Performer") online tablespace MAXDAT_INDX parallel compute statistics; 

grant select on D_NYEC_PAMI_ITEM_STATUS_PER to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PAMI_ITEM_STATUS_PER_SV as
select * from D_NYEC_PAMI_ITEM_STATUS_PER
with read only;

grant select on D_NYEC_PAMI_ITEM_STATUS_PER_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PAMI_ITEM_STATUS_PER (DNPAMIISP_ID,"MI Item Status Performer") values (SEQ_DNPAMIISP_ID.nextval,null);
commit;


create sequence SEQ_DNPAMIRS_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PAMI_RFE_STATUS
  (DNPAMIRS_ID number, 
   "RFE Status" varchar2(35))
tablespace MAXDAT_DATA;

alter table D_NYEC_PAMI_RFE_STATUS add constraint DNPAMIRS_PK primary key (DNPAMIRS_ID) using index tablespace MAXDAT_INDX;

create unique index DNPAMIRS_UIX1 on D_NYEC_PAMI_RFE_STATUS ("RFE Status") online tablespace MAXDAT_INDX parallel compute statistics; 

grant select on D_NYEC_PAMI_RFE_STATUS to MAXDAT_READ_ONLY;

create or replace view D_NYEC_PAMI_RFE_STATUS_SV as
select * from D_NYEC_PAMI_RFE_STATUS
with read only;

grant select on D_NYEC_PAMI_RFE_STATUS_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_PAMI_RFE_STATUS (DNPAMIRS_ID,"RFE Status") values (SEQ_DNPAMIRS_ID.nextval,null);
commit;


create sequence SEQ_FNPAMIBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_PAMI_BY_DATE 
  (FNPAMIBD_ID number not null,
	 D_DATE date not null,
	 BUCKET_START_DATE date not null, 
	 BUCKET_END_DATE date not null,
	 NYEC_PAMI_BI_ID number not null,
	 DNPAMIIS_ID number,
	 DNPAMIISP_ID number not null,
	 DNPAMIRS_ID number not null,
   CREATION_COUNT number,
	 INVENTORY_COUNT number,
	 COMPLETION_COUNT number,
	 "MI Item Status Date" date,
	 "RFE Status Date" date)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))   
tablespace MAXDAT_DATA parallel;

alter table F_NYEC_PAMI_BY_DATE add constraint FNPAMIBD_PK primary key (FNPAMIBD_ID) using index tablespace MAXDAT_INDX;

alter table F_NYEC_PAMI_BY_DATE add constraint FPAMIBD_DPACUR_FK foreign key (NYEC_PAMI_BI_ID)references D_NYEC_PAMI_CURRENT (NYEC_PAMI_BI_ID);
alter table F_NYEC_PAMI_BY_DATE add constraint FPAMIBD_DPAMIISP_FK foreign key (DNPAMIISP_ID) references D_NYEC_PAMI_ITEM_STATUS_PER (DNPAMIISP_ID);
alter table F_NYEC_PAMI_BY_DATE add constraint FPAMIBD_DPAMIIS_FK foreign key (DNPAMIIS_ID) references D_NYEC_PAMI_ITEM_STATUS (DNPAMIIS_ID);
alter table F_NYEC_PAMI_BY_DATE add constraint FPAMIBD_DPAMIRS_FK foreign key (DNPAMIRS_ID) references D_NYEC_PAMI_RFE_STATUS (DNPAMIRS_ID);

create unique index FNPAMIBD_UIX1 on F_NYEC_PAMI_BY_DATE (NYEC_PAMI_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 
create unique index FNPAMIBD_UIX2 on F_NYEC_PAMI_BY_DATE (NYEC_PAMI_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics; 

create index FNPAMIBD_IX1 on F_NYEC_PAMI_BY_DATE ("MI Item Status Date") online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IX2 on F_NYEC_PAMI_BY_DATE ("RFE Status Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FNPAMIBD_IXL1 on F_NYEC_PAMI_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL2 on F_NYEC_PAMI_BY_DATE (NYEC_PAMI_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL3 on F_NYEC_PAMI_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNPAMIBD_IXL4 on F_NYEC_PAMI_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

grant select on F_NYEC_PAMI_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_PAMI_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNPAMIBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from F_NYEC_PAMI_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  F_NYEC_PAMI_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

grant select on F_NYEC_PAMI_BY_DATE_SV to MAXDAT_READ_ONLY;


create or replace view REL_MI_APP_SV
as
select 
  dnpamicur.NYEC_PAMI_BI_ID as nyec_pami_bi_id,
  dnpacur.NYEC_PA_BI_ID as nyec_pa_bi_id
from 
  D_NYEC_PAMI_CURRENT dnpamicur, 
  D_NYEC_PA_CURRENT dnpacur
where dnpamicur."Application ID" = dnpacur."Application ID"
with read only;

grant select on REL_MI_APP_SV to MAXDAT_READ_ONLY;

