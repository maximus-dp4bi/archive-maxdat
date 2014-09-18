alter table NYHX_ETL_IDR_INCIDENTS      add complete_dt date;
alter table NYHX_ETL_IDR_INCIDENTS_OLTP add complete_dt date;
alter table NYHX_ETL_IDR_INCIDENTS_wip  add complete_dt date;
alter table d_idr_current               add cur_complete_dt date;

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

alter table F_IDR_BY_DATE add COMPLETE_DT  date;

create index FIDRBD_IX3 on F_IDR_BY_DATE (COMPLETE_DT) online tablespace MAXDAT_INDX parallel compute statistics;

create or replace view F_IDR_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
   FIDRBD_ID,	
	 BUCKET_START_DATE  D_DATE,	 
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIR_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from F_IDR_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIR_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT, 
   COMPLETE_DT,    
   0 CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from 
  F_IDR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIR_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   0 CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from 
  F_IDR_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day..
select
   FIDRBD_ID,	
	 bdd.D_DATE D_DATE,
	 IDR_BI_ID,		 
	 DIDRAC_ID,
	 CURRENT_TASK_ID,
	 DIDRES_ID,
	 DIDRIA_ID,
	 DIDRID_ID,
	 DIDRIR_ID,
	 DIDRIS_ID,		 
	 DIDRIN_ID,
	 DIDRLUBN_ID,		 
	 DIDRLUB_ID,
	 DIDRRD_ID,
	 DIDRRT_ID,
	 CLIENT_ID,
	 INCIDENT_STATUS_DT,
	 LAST_UPDATE_BY_DT,
   COMPLETE_DT,     
   CREATION_COUNT,
   INVENTORY_COUNT,
   COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_IDR_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

----------------------------------------------------------------------------------------------------------------------
--Complete Date
insert into BPM_ATTRIBUTE (BA_ID,BAL_ID,BEM_ID,WHEN_POPULATED,EFFECTIVE_DATE,END_DATE,RETAIN_HISTORY_FLAG) 
values (2584,5,21,'BOTH',sysdate,BPM_COMMON.GET_MAX_DATE,'Y');

--Complete Date for NYHIX IDR Incidents process.
insert into BPM_ATTRIBUTE_STAGING_TABLE (BAST_ID,BA_ID,BSL_ID,STAGING_TABLE_COLUMN) values(SEQ_BAST_ID.nextval,2384,21, 'COMPLETE_DT');
commit;

delete corp_etl_list_lkup
where name in ('IDR_OPEN','IDR_CLOSED');
commit;