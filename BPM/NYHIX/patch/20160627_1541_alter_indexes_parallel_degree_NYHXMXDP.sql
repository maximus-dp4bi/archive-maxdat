-- MAXDAT-3712 - Sweep through and set all MAXDat schema indexes to be non-parallel to prevent optimizer from using index full-scans. 
-- NYHXMXDP
-- Make some of the indexes parallel.

/*
alter session set current_schema = MAXDAT;

select 'alter index ' || i.INDEX_NAME || ' parallel ' || ltrim(t.DEGREE) || ';'
from ALL_INDEXES i
inner join ALL_TABLES t on i.TABLE_NAME = t.TABLE_NAME
where 
  i.OWNER = 'MAXDAT'
  and t.OWNER = 'MAXDAT'
  and t.DEGREE not like ('%1') 
order by i.INDEX_NAME asc;
*/
alter index BATCH_PK parallel 2;
alter index BUEQ_IX1 parallel 4;
alter index BUEQ_LX1 parallel 4;
alter index BUEQ_LX2 parallel 4;
alter index BUEQ_LX3 parallel 4;
alter index BUEQ_LX5 parallel 4;
alter index BUEQ_PK parallel 4;
alter index DCMPLAC_PK parallel 2;
alter index DCMPLAC_UIX1 parallel 2;
alter index DCMPLCUR_IDX1 parallel 2;
alter index DCMPLCUR_PK parallel 2;
alter index DCMPLIIA_IX1 parallel 2;
alter index DCMPLII_UIX1 parallel 2;
alter index DCMPLIR_IX1 parallel 2;
alter index DCMPLISD_IX1 parallel 2;
alter index DDNBDN_IXL1 parallel 4;
alter index DDNBDN_IXL2 parallel 4;
alter index DDNBDN_UIX1 parallel 4;
alter index DDNBDN_UIX2 parallel 4;
alter index DDNBD_PK parallel 4;
alter index DDNCU_IX1 parallel 4;
alter index DDNCU_IX2 parallel 4;
alter index DDNCU_IX3 parallel 4;
alter index DDNCU_IX4 parallel 4;
alter index DDN_PK parallel 4;
alter index DMFBCUR_PK parallel 4;
alter index DMFBCUR_UIX1 parallel 4;
alter index DMFDBD_IX1 parallel 4;
alter index DMFDBD_IX2 parallel 4;
alter index DMFDBD_IXL2 parallel 4;
alter index DMFDBD_IXL3 parallel 4;
alter index DMFDBD_PK parallel 4;
alter index DMFDBD_UIX1 parallel 4;
alter index DMFDBD_UIX2 parallel 4;
alter index DMFDCU_IX1 parallel 4;
alter index DMFDCU_IX2 parallel 4;
alter index DMFDCU_IX3 parallel 4;
alter index DMFDCU_IX4 parallel 4;
alter index DMFD_PK parallel 4;
alter index DMWBD_ID_PK parallel 4;
alter index DMWBD_IXL2 parallel 4;
alter index DMWBD_IXL3 parallel 4;
alter index DMWBD_UIX2 parallel 4;
alter index DMWCUR_PK parallel 4;
alter index DMWCUR_UIX1 parallel 4;
alter index DMWCUR_V2_CANCELDT_FBIDX parallel 4;
alter index DMWCUR_V2_CANCELLED_STF_ID parallel 4;
alter index DMWCUR_V2_COMPLETEDT_FBIDX parallel 4;
alter index DMWCUR_V2_CREATEDT_FBIDX parallel 4;
alter index DMWCUR_V2_CREATED_STF_ID parallel 4;
alter index DMWCUR_V2_CURR_BUSUNIT_ID parallel 4;
alter index DMWCUR_V2_CURR_TASK_TYPE_ID parallel 4;
alter index DMWCUR_V2_CURR_TEAM_ID parallel 4;
alter index DMWCUR_V2_ESCALATED_STF_ID parallel 4;
alter index DMWCUR_V2_FORWARDED_STF_ID parallel 4;
alter index DMWCUR_V2_INSTANCESTDT_FBIDX parallel 4;
alter index DMWCUR_V2_LAST_UPD_BY_STF_ID parallel 4;
alter index DMWCUR_V2_OWNER_STF_ID parallel 4;
alter index DMWCUR_V2_PK parallel 4;
alter index DMWCUR_V2_UNIQ_TASK_ID parallel 4;
alter index DNMFDCUR_IX1 parallel 4;
alter index DNMFDCUR_IX2 parallel 4;
alter index DNMFDCUR_IX3 parallel 4;
alter index DNMFDCUR_IX4 parallel 4;
alter index DNMFDCUR_IX5 parallel 4;
alter index DNMFDCUR_IX6 parallel 4;
alter index D_BATCHES_DATE_CAP_IDX parallel 2;
alter index FCMPLBD_IX1 parallel 4;
alter index FCMPLBD_IX2 parallel 4;
alter index FCMPLBD_IX3 parallel 4;
alter index FCMPLBD_IXL2 parallel 4;
alter index FCMPLBD_IXL3 parallel 4;
alter index FCMPLBD_IXL4 parallel 4;
alter index FCMPLBD_IXL5 parallel 4;
alter index FCMPLBD_IXL6 parallel 4;
alter index FCMPLBD_PK parallel 4;
alter index FCMPLBD_UIX1 parallel 4;
alter index FCMPLBD_UIX2 parallel 4;
alter index FCMPLCBD_IXL1 parallel 4;
alter index FMFBBH_IXL1 parallel 4;
alter index FMFBBH_IXL2 parallel 4;
alter index FMFBBH_IXL4 parallel 4;
alter index FMFBBH_PK parallel 4;
alter index FMFBBH_UIX1 parallel 4;
alter index FMFBBH_UIX2 parallel 4;
alter index FMWBD_IX1 parallel 4;
alter index FMWBD_IX2 parallel 4;
alter index FMWBD_IXL1 parallel 4;
alter index FMWBD_IXL2 parallel 4;
alter index FMWBD_IXL3 parallel 4;
alter index FMWBD_IXL4 parallel 4;
alter index FMWBD_IXL5 parallel 4;
alter index FMWBD_IXL6 parallel 4;
alter index FMWBD_PK parallel 4;
alter index FMWBD_UIX1 parallel 4;
alter index FMWBD_UIX2 parallel 4;
alter index FNMFDBD_IX1 parallel 4;
alter index FNMFDBD_IX2 parallel 4;
alter index FNMFDBD_IX4 parallel 4;
alter index FNMFDBD_IX5 parallel 4;
alter index FNMFDBD_IXL1 parallel 4;
alter index FNMFDBD_IXL2 parallel 4;
alter index FNMFDBD_IXL3 parallel 4;
alter index FNMFDBD_IXL4 parallel 4;
alter index FNMFDBD_PK parallel 4;
alter index FNMFDBD_UIX1 parallel 4;
alter index FNMFDBD_UIX2 parallel 4;
alter index FPLBD_IX1 parallel 4;
alter index FPLBD_IXL1 parallel 4;
alter index FPLBD_IXL2 parallel 4;
alter index FPLBD_IXL3 parallel 4;
alter index FPLBD_IXL4 parallel 4;
alter index FPLBD_PK parallel 4;
alter index FPLBD_UIX1 parallel 4;
alter index FPLBD_UIX2 parallel 4;
alter index IDX_NOTE_CASE_ID parallel 2;
alter index IDX_NOTE_CASE_ID_CLIENT_ID parallel 2;
alter index IDX_NOTE_CLIENT_ID parallel 2;
alter index IDX_NOTE_REF1 parallel 2;
alter index IDX_NOTE_REF2 parallel 2;
alter index IDX_NOTE_REFID parallel 2;
alter index NYHIX_MFD_PK parallel 4;
alter index PK_NOTE parallel 2;