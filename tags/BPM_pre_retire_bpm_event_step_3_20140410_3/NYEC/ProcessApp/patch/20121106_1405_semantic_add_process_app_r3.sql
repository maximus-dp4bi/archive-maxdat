-- NYEC Process App changes.

insert into D_NYEC_PA_COUNTY (DNPACOU_ID ,"County") values (SEQ_DNPACOU_ID.nextval,null);
commit;

alter table F_NYEC_PA_BY_DATE modify "Receipt Date" date null;


-- NYEC Process App release 3 changes.

alter table D_NYEC_PA_CURRENT add "Cur CIN" varchar2(30); 
alter table D_NYEC_PA_CURRENT add "CIN Date" date;
alter table D_NYEC_PA_CURRENT add "Provider Name" varchar2(80);
alter table D_NYEC_PA_CURRENT add "Cur FPBP Sub-type" varchar2(30); 
alter table D_NYEC_PA_CURRENT add "Reverse Clearance Indictr" varchar2(50);
alter table D_NYEC_PA_CURRENT add "Reverse Clearance Indictr Date" date;
alter table D_NYEC_PA_CURRENT add "Reverse Clearance Outcome" varchar2(22);
alter table D_NYEC_PA_CURRENT add "Upstate/Downstate Indictr" varchar2(20);
alter table D_NYEC_PA_CURRENT add "Invoiceable Date" date;
alter table D_NYEC_PA_CURRENT add "Cur HEART Incomplete App Ind" varchar2(1);
alter table D_NYEC_PA_CURRENT add "Days To Timeout" number;


----- D_NYEC_PA_CIN    DNPAC_ID  
create sequence SEQ_DNPACIN_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_CIN
  (
   DNPACIN_ID number not null, 
   "CIN" varchar2(30) 
  ) 
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_CIN add constraint DNPACIN_PK primary key (DNPACIN_ID);
alter index DNPACIN_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPACIN_UIX1 on D_NYEC_PA_CIN ("CIN") online tablespace MAXDAT_INDX parallel compute statistics;

alter table F_NYEC_PA_BY_DATE add DNPACIN_ID number;
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPACIN_FK foreign key (DNPACIN_ID) references D_NYEC_PA_CIN(DNPACIN_ID);

create or replace view D_NYEC_PA_CIN_SV as
select * from D_NYEC_PA_CIN
with read only;

insert into D_NYEC_PA_CIN (DNPACIN_ID,"CIN") values (SEQ_DNPACIN_ID.nextval,null);
commit;

----- D_NYEC_PA_FPBP_SUBTYPE    DNPAFPBPST_ID  
create sequence SEQ_DNPAFPBPST_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_FPBP_SUBTYPE
  (
   DNPAFPBPST_ID number not null, 
   "FPBP Sub-type" varchar2(30) 
  )
tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_FPBP_SUBTYPE add constraint DNPAFPBPST_PK primary key (DNPAFPBPST_ID);
alter index DNPAFPBPST_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAFPBPST_UIX1 on D_NYEC_PA_FPBP_SUBTYPE ("FPBP Sub-type") online tablespace MAXDAT_INDX parallel compute statistics;    

alter table F_NYEC_PA_BY_DATE add DNPAFPBPST_ID number;
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAFPBPST_FK foreign key (DNPAFPBPST_ID) references D_NYEC_PA_FPBP_SUBTYPE(DNPAFPBPST_ID);

create or replace view D_NYEC_PA_FPBP_SUBTYPE_SV as
select * from D_NYEC_PA_FPBP_SUBTYPE
with read only;

insert into D_NYEC_PA_FPBP_SUBTYPE (DNPAFPBPST_ID,"FPBP Sub-type") values (SEQ_DNPAFPBPST_ID.nextval,null);
commit;


----- D_NYEC_PA_HEART_INC_APP_IND    DNPAHIAI_ID  
create sequence SEQ_DNPAHIAI_ID
minvalue 1
maxvalue 999999999999999999999999999
start with 265
increment by 1
cache 20;

create table D_NYEC_PA_HEART_INC_APP_IND
  (
   DNPAHIAI_ID number not null, 
   "HEART Incomplete App Ind" varchar2(1) 
  ) tablespace MAXDAT_DATA parallel;

alter table D_NYEC_PA_HEART_INC_APP_IND add constraint DNPAHIAI_PK primary key (DNPAHIAI_ID);
alter index DNPAHIAI_PK rebuild tablespace MAXDAT_INDX parallel;

create unique index DNPAHIAI_UIX1 on D_NYEC_PA_HEART_INC_APP_IND ("HEART Incomplete App Ind") online tablespace MAXDAT_INDX parallel compute statistics;    

alter table F_NYEC_PA_BY_DATE add DNPAHIAI_ID number; 
alter table F_NYEC_PA_BY_DATE add constraint FNPABD_DNPAHIAI_FK foreign key (DNPAHIAI_ID) references D_NYEC_PA_HEART_INC_APP_IND(DNPAHIAI_ID);

create or replace view D_NYEC_PA_HEART_INC_APP_IND_SV as
select * from D_NYEC_PA_HEART_INC_APP_IND
with read only;

insert into D_NYEC_PA_HEART_INC_APP_IND (DNPAHIAI_ID,"HEART Incomplete App Ind") values (SEQ_DNPAHIAI_ID.nextval,null);
commit;

alter table F_NYEC_PA_BY_DATE add "Invoiceable Date" date;
create index FNPABD_IX2 on F_NYEC_PA_BY_DATE ("Invoiceable Date") online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_NYEC_PA_BY_DATE_SV as
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  case 
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE >= fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpabd.BUCKET_END_DATE
union all
select
  FNPABD_ID,
  bdd.D_DATE D_DATE,
  NYEC_PA_BI_ID,
  DNPAAS_ID,
  DNPACOU_ID,
  DNPAHS_ID,
  "Receipt Date",
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;