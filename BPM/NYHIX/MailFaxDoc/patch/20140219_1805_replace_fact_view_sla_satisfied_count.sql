--Not an issue if this drop failes
alter table F_NYHIX_MFD_BY_DATE drop (sla_satisfied_count);

--Create indexes on current table
create index DNMFDCUR_IX2 on D_NYHIX_MFD_CURRENT (CANCEL_DT) online tablespace MAXDAT_INDX parallel compute statistics;
create index DNMFDCUR_IX3 on D_NYHIX_MFD_CURRENT (ENVELOPE_STATUS_DT) online tablespace MAXDAT_INDX parallel compute statistics;

--Replace fact view 
create or replace view F_NYHIX_MFD_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  f.FNMFDBD_ID,
  f.BUCKET_START_DATE D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  f.CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    When 
      f.BUCKET_START_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
  from F_NYHIX_MFD_BY_DATE f, D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  0 CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    When 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from 
  F_NYHIX_MFD_BY_DATE f, 
  D_NYHIX_MFD_CURRENT d,
  BPM_D_DATES bdd
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE >= f.BUCKET_START_DATE
  and bdd.D_DATE < f.BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  0 CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    when 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE f,
  D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  f.FNMFDBD_ID,
  bdd.D_DATE,
  f.NYHIX_MFD_BI_ID,
  f.DNMFDDT_ID,
  f.DNMFDDS_ID,
  f.DNMFDES_ID,
  f.DNMFDDST_ID,
  f.DNMFDFT_ID,
  f.DNMFDTS_ID,
  f.DNMFDIS_ID,
  f.INSTANCE_STATUS_DT,
  f.DOCUMENT_STATUS_DT,
  f.ENVELOPE_STATUS_DT,
  f.SCAN_DT,
  f.RELEASE_DT,
  f.JEOPARDY_FLAG,
  f.CREATION_COUNT,
  f.INVENTORY_COUNT,
  f.COMPLETION_COUNT,
  case 
    when 
      bdd.D_DATE = trunc(d.ENVELOPE_STATUS_DT)
      and d.envelope_status = 'COMPLETEDRELEASED'
      and d.cancel_dt is null
      and d.channel != 'WEB'
      then 1 
    else 0 
    end as SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE f,
  D_NYHIX_MFD_CURRENT d
where
  f.NYHIX_MFD_BI_ID = d.NYHIX_MFD_BI_ID
  and bdd.D_DATE >= f.BUCKET_START_DATE
  and bdd.D_DATE = f.BUCKET_END_DATE
  and f.CREATION_COUNT = 0
  and f.COMPLETION_COUNT = 1
with read only; 

create or replace public synonym F_NYHIX_MFD_BY_DATE_SV for F_NYHIX_MFD_BY_DATE_SV;
grant select on F_NYHIX_MFD_BY_DATE_SV to MAXDAT_READ_ONLY;

--Replace current view for Paper_sla_time_status and previous_kofax_dcn additions to table 
create or replace view D_NYHIX_MFD_CURRENT_SV as
select * from D_NYHIX_MFD_CURRENT
with read only;

create or replace public synonym D_NYHIX_MFD_CURRENT_SV for D_NYHIX_MFD_CURRENT_SV;
grant select on D_NYHIX_MFD_CURRENT_SV to MAXDAT_READ_ONLY;