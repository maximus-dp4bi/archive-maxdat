-- MAXDAT-3713 - Sweep through all MAXDat tables and determine and set which tables that should be parallel. 
-- NYHXMXDP

/*
alter session set current_schema = MAXDAT;

select 'alter table ' || TABLE_NAME || ' noparallel;'
from ALL_TABLES
where 
  OWNER = 'MAXDAT'
  and DEGREE like '%DEFAULT'
order by TABLE_NAME asc;

-- Then edit commands to set parallel degree.
*/
alter table BUEQ_ARCHIVE_TEMP noparallel;
alter table CORP_ETL_MFB_FORM noparallel;
alter table CORP_ETL_MFB_FORM_STG noparallel;