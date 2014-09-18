alter table corp_etl_mfb_batch add source_server varchar2(255) null;
alter table corp_etl_mfb_batch_events add source_server varchar2(255) null;
alter table corp_etl_mfb_form add source_server varchar2(255) null;

alter table corp_etl_mfb_batch_wip add source_server varchar2(255) null;
alter table corp_etl_mfb_batch_events_wip add source_server varchar2(255) null;
alter table corp_etl_mfb_form_wip add source_server varchar2(255) null;


alter table D_MFB_CURRENT add SOURCE_SERVER varchar2(255) null;

create or replace public synonym D_MFB_CURRENT for D_MFB_CURRENT;
grant select on D_MFB_CURRENT to MAXDAT_READ_ONLY;

create or replace view D_MFB_CURRENT_SV as
select * from D_MFB_CURRENT
with read only;

create or replace public synonym D_MFB_CURRENT_SV for D_MFB_CURRENT_SV;
grant select on D_MFB_CURRENT_SV to MAXDAT_READ_ONLY;

create or replace view D_MFBBATCH_EVENTS_CURRENT_SV as
select 
  BATCH_MODULE_ID,
  BATCH_GUID,
  MODULE_LAUNCH_ID,
  MODULE_UNIQUE_ID,
  MODULE_NAME,
  MODULE_CLOSE_ID as MODULE_CLOSE_UNIQUE_ID,
  MODULE_CLOSE_NAME,
  BATCH_STATUS,
  MODULE_START_DT,
  MODULE_END_DT,
  USER_NAME as MODULE_LAUNCH_USER_NAME,
  STATION_ID,
  SITE_NAME,
  SITE_ID,
  BATCH_DELETED,
  DOC_PAGES as PAGES_PER_DOCUMENT,
  PAGES_SCANNED,
  PAGES_DELETED,
  DOCS_CREATED as DOCUMENTS_CREATED,
  DOCS_DELETED as DOCUMENTS_DELETED,
  PAGES_REPLACED,
  SOURCE_SERVER
from CORP_ETL_MFB_BATCH_EVENTS
with read only;

create or replace public synonym D_MFBBATCH_EVENTS_CURRENT_SV for D_MFBBATCH_EVENTS_CURRENT_SV;
grant select on D_MFBBATCH_EVENTS_CURRENT_SV to MAXDAT_READ_ONLY;


CREATE OR REPLACE VIEW D_MFBBATCH_EVENTS_CURMOD_SV AS 
SELECT c.CURRENT_BATCH_MODULE_ID, 
  c.BATCH_GUID, 
  e.MODULE_LAUNCH_ID, 
  e.MODULE_UNIQUE_ID, 
  e.MODULE_NAME, 
  e.MODULE_CLOSE_ID AS MODULE_CLOSE_UNIQUE_ID, 
  e.MODULE_CLOSE_NAME, 
  e.BATCH_STATUS, 
  e.MODULE_START_DT, 
  e.MODULE_END_DT, 
  e.USER_NAME AS MODULE_LAUNCH_USER_NAME, 
  e.STATION_ID, 
  e.SITE_NAME, 
  e.SITE_ID, 
  e.BATCH_DELETED, 
  e.DOC_PAGES AS PAGES_PER_DOCUMENT, 
  e.PAGES_SCANNED, 
  e.PAGES_DELETED, 
  e.DOCS_CREATED AS DOCUMENTS_CREATED, 
  e.DOCS_DELETED AS DOCUMENTS_DELETED, 
  e.PAGES_REPLACED ,e.SOURCE_SERVER
FROM CORP_ETL_MFB_BATCH_EVENTS e, D_MFB_CURRENT c 
WHERE e.BATCH_MODULE_ID = c.CURRENT_BATCH_MODULE_ID 
WITH READ ONLY;

create or replace public synonym D_MFBBATCH_EVENTS_CURMOD_SV for D_MFBBATCH_EVENTS_CURMOD_SV;
grant select on D_MFBBATCH_EVENTS_CURMOD_SV to MAXDAT_READ_ONLY;

