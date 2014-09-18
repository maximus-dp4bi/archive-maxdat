create table D_NYEC_IR_CURRENT
  (NYEC_IR_BI_ID                   number not null,
   "APP_ID"                        number not null,
   "Age in Business Days"          number not null,
   "Age in Calendar Days"          number not null,
   "Instance Complete Date"        date,
   "Instance Status"               varchar2(20) not null,
   "Renewal File Received Date"    date,
   "Shell App Create Date"         date,
   "Shell App Create Source"       varchar2(80),
   "Renewal_Receipt Date"          date,
   "Authorization Change Date" 	   date,
   "Authorization End Date"        date,
   "Cancel Date"                   date,
   "Close Date"                    date,
   "Cur Clockdown Indicator"   	   varchar2(1) not null,
   "State Case Identifier"    	   varchar2(20),
   "Notice 1 Type"                 varchar2(20),
   "Notice 1 Due Date"             date,
   "Notice 1 Create Date"          date,
   "Notice 1 Complete Date"        date,
   "Notice 1 Source ID"            number,
   "Notice 2 Type"                 varchar2(20),
   "Notice 2 Due Date"             date,
   "Notice 2 Create Date"          date,
   "Notice 2 Complete Date"        date,
   "Notice 2 Source ID"            number,
   "Notice 3 Type"                 varchar2(20),
   "Notice 3 Due Date"             date,
   "Notice 3 Create Date"          date,
   "Notice 3 Complete Date"        date,
   "Notice 3 Source ID"            number,
   "File Process Successful Flag"  varchar2(1),
   "Process Exception Result Flag" varchar2(1)
  )
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_IR_CURRENT add constraint DNIRCUR_PK primary key (NYEC_IR_BI_ID) using index tablespace MAXDAT_INDX;

create unique index DNIRCUR_UIX1 on D_NYEC_IR_CURRENT ("APP_ID") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym D_NYEC_IR_CURRENT for D_NYEC_IR_CURRENT;
grant select on D_NYEC_IR_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_NYEC_IR_CURRENT_SV as
select * from D_NYEC_IR_CURRENT
with read only;

create or replace public synonym D_NYEC_IR_CURRENT_SV for D_NYEC_IR_CURRENT_SV;
grant select on D_NYEC_IR_CURRENT_SV to MAXDAT_READ_ONLY;


----- D_NYEC_IR_CLOCKDOWN_INDCTR   DNIRCI_ID
create sequence SEQ_DNIRCI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_IR_CLOCKDOWN_IND
  (DNIRCI_ID             number not null,
   "Clockdown Indicator" varchar2(1) not null)
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_IR_CLOCKDOWN_IND add constraint DNIRCI_PK primary key (DNIRCI_ID) using index tablespace MAXDAT_INDX;

create or replace public synonym D_NYEC_IR_CLOCKDOWN_IND for D_NYEC_IR_CLOCKDOWN_IND;
grant select on D_NYEC_IR_CLOCKDOWN_IND to MAXDAT_READ_ONLY;

create or replace view D_NYEC_IR_CLOCKDOWN_IND_SV as
select * from D_NYEC_IR_CLOCKDOWN_IND
with read only;

create or replace public synonym D_NYEC_IR_CLOCKDOWN_IND_SV for D_NYEC_IR_CLOCKDOWN_IND_SV;
grant select on D_NYEC_IR_CLOCKDOWN_IND_SV to MAXDAT_READ_ONLY;

insert into D_NYEC_IR_CLOCKDOWN_IND (DNIRCI_ID,"Clockdown Indicator") values (SEQ_DNIRCI_ID.nextval,'Y');
insert into D_NYEC_IR_CLOCKDOWN_IND (DNIRCI_ID,"Clockdown Indicator") values (SEQ_DNIRCI_ID.nextval,'N');
commit;


create sequence SEQ_FNIRBD_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table F_NYEC_IR_BY_DATE
  (FNIRBD_ID                number not null,
   D_DATE                   date not null,
   BUCKET_START_DATE        date not null,
   BUCKET_END_DATE          date not null,
   NYEC_IR_BI_ID            number not null,
   DNIRCI_ID                number not null,
   "Authorization End Date" date,
   CREATION_COUNT           number,
   INVENTORY_COUNT          number,
   COMPLETION_COUNT         number)
partition by range (BUCKET_START_DATE)
interval (numtodsinterval(1,'day'))
(partition PT_BUCKET_START_DATE_LT_2012 values less than (to_date('20120101','YYYYMMDD')))
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_IR_BY_DATE add constraint FNIRBD_PK primary key (FNIRBD_ID) using index tablespace MAXDAT_INDX;

alter table F_NYEC_IR_BY_DATE add constraint FNIRBD_DNIRCI_FK foreign key (DNIRCI_ID) references D_NYEC_IR_CLOCKDOWN_IND(DNIRCI_ID);
alter table F_NYEC_IR_BY_DATE add constraint FNIRBD_DNIRCUR_FK foreign key (NYEC_IR_BI_ID) references D_NYEC_IR_CURRENT(NYEC_IR_BI_ID);

create unique index FNIRBD_UIX1 on F_NYEC_IR_BY_DATE (NYEC_IR_BI_ID,D_DATE) online tablespace MAXDAT_INDX parallel compute statistics;
create unique index FNIRBD_UIX2 on F_NYEC_IR_BY_DATE (NYEC_IF_BI_ID,BUCKET_START_DATE) online tablespace MAXDAT_INDX parallel compute statistics;

create index FNIRBD_IX1 on F_NYEC_IR_BY_DATE ("Authorization End Date") online tablespace MAXDAT_INDX parallel compute statistics;

create index FNIRBD_IXL1 on F_NYEC_IR_BY_DATE (BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNIRBD_IXL2 on F_NYEC_IR_BY_DATE (NYEC_IR_BI_ID) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNIRBD_IXL3 on F_NYEC_IR_BY_DATE (BUCKET_START_DATE,BUCKET_END_DATE) local online tablespace MAXDAT_INDX parallel compute statistics;
create index FNIRBD_IXL4 on F_NYEC_IR_BY_DATE (CREATION_COUNT) local online tablespace MAXDAT_INDX parallel compute statistics;

create or replace public synonym F_NYEC_IR_BY_DATE for F_NYEC_IR_BY_DATE;
grant select on F_NYEC_IR_BY_DATE to MAXDAT_READ_ONLY;

create or replace view F_NYEC_IR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNIRBD_ID,
  BUCKET_START_DATE D_DATE,
  NYEC_IR_BI_ID,
  DNIRCI_ID,
  "Authorization End Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from F_NYEC_IR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNIRBD_ID,
  bdd.D_DATE,
  NYEC_IR_BI_ID,
  DNIRCI_ID,
  "Authorization End Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  F_NYEC_IR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNIRBD_ID,
  bdd.D_DATE,
  NYEC_IR_BI_ID,
  DNIRCI_ID,
  "Authorization End Date",
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_IR_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNIRBD_ID,
  bdd.D_DATE,
  NYEC_IR_BI_ID,
  DNIRCI_ID,
  "Authorization End Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_IR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_NYEC_IR_BY_DATE_SV for F_NYEC_IR_BY_DATE_SV;
grant select on F_NYEC_IR_BY_DATE_SV to MAXDAT_READ_ONLY;
