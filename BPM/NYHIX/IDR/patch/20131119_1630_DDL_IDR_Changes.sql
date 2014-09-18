CREATE TABLE NYHX_ETL_IDR_INCIDENT_RSN
(NEIIR_ID NUMBER NOT NULL ENABLE,
 INCIDENT_ID NUMBER(18,0) NOT NULL ENABLE,     
 INCIDENT_REASON VARCHAR2(80)) TABLESPACE MAXDAT_DATA PARALLEL;

--CREATE PRIMARY KEY
alter table  NYHX_ETL_IDR_INCIDENT_RSN add primary key (NEIIR_ID) using index tablespace MAXDAT_INDX;    

--GRANTS & PUBLIC SYNONYMNS
create or replace public synonym NYHX_ETL_IDR_INCIDENT_RSN for NYHX_ETL_IDR_INCIDENT_RSN;

Grant select on NYHX_ETL_IDR_INCIDENT_RSN to MAXDAT_READ_ONLY;
  
--indexes
create index IDX_NYHX_ETL_IDR_INCI_RSN on NYHX_ETL_IDR_INCIDENT_RSN (INCIDENT_ID) TABLESPACE MAXDAT_INDX;

-------------------------------------------------------------------------------------------------------
DROP SEQUENCE SEQ_NEIIR_ID;

CREATE SEQUENCE SEQ_NEIIR_ID
  START WITH 1
  MAXVALUE 9999999999999999999999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER;

CREATE OR REPLACE PUBLIC SYNONYM SEQ_NEIIR_ID FOR SEQ_NEIIR_ID;

-------------------------------------------------------------------------------------------------------
--view for current IDR incident reasons
create or replace view D_IDR_CURRENT_REASONS_SV as
select INCIDENT_ID, INCIDENT_REASON
from NYHX_ETL_IDR_INCIDENT_RSN
with read only;

create or replace public synonym D_IDR_CURRENT_REASONS_SV for D_IDR_CURRENT_REASONS_SV;
grant select on D_IDR_CURRENT_REASONS_SV to MAXDAT_READ_ONLY;

alter table nyhx_etl_idr_incidents modify CREATED_BY_NAME VARCHAR2(150);
alter table nyhx_etl_idr_incidents_oltp modify CREATED_BY_NAME VARCHAR2(150);
alter table nyhx_etl_idr_incidents_wip modify CREATED_BY_NAME VARCHAR2(150);

alter table d_idr_current modify CREATED_BY_NAME VARCHAR2(150);
alter table d_idr_current modify ASPB_IDR_REVIEW_DOCS VARCHAR2(150);
alter table d_idr_current modify ASPB_GATHER_MISS_INFO VARCHAR2(150);
alter table d_idr_current modify incident_TYPE VARCHAR2(80);
alter table d_idr_current modify REPORTER_RELATIONSHIP VARCHAR2(64);
alter table d_idr_current modify CUR_RESOLUTION_TYPE VARCHAR2(64);

alter table D_IDR_RESOLUTION_TYPE modify RESOLUTION_TYPE VARCHAR2(64);

alter table nyhx_etl_idr_incidents drop column incident_reason;
alter table nyhx_etl_idr_incidents_oltp drop column incident_reason;
alter table nyhx_etl_idr_incidents_wip drop column incident_reason;
alter table d_idr_current drop column cur_incident_reason;
drop table D_IDR_INCIDENT_REASON;
drop view D_IDR_Incident_Reason_SV;
alter table F_IDR_BY_DATE drop column DIDRIR_ID;

create or replace view D_IDR_CURRENT_SV as
select * from D_IDR_CURRENT
with read only;

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