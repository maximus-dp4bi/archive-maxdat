--Add SLA_SATISFIED_COUNT to fact table
alter table f_nyhix_mfd_by_date add (SLA_SATISFIED_COUNT number(1) default 0 not null);

--Replace current view
create or replace view D_NYHIX_MFD_CURRENT_SV as
select * from D_NYHIX_MFD_CURRENT
with read only;


create or replace public synonym D_NYHIX_MFD_CURRENT_SV for D_NYHIX_MFD_CURRENT_SV;
grant select on D_NYHIX_MFD_CURRENT_SV to MAXDAT_READ_ONLY;


--Replace fact view
create or replace view F_NYHIX_MFD_BY_DATE_SV as
-- First day plus interpolate days until before the next day with an update.
select
  FNMFDBD_ID,
  BUCKET_START_DATE D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  SLA_SATISFIED_COUNT
from F_NYHIX_MFD_BY_DATE
where
  D_DATE >= (select min(D_DATE) from BPM_D_DATES)
  and CREATION_COUNT = 1
union all
(
-- First day (again) and all days with interpolated days in-between, except completion day.
select
  FNMFDBD_ID,
  bdd.D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  SLA_SATISFIED_COUNT
from 
  F_NYHIX_MFD_BY_DATE,
  BPM_D_DATES bdd
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE < BUCKET_END_DATE
minus
-- Remove duplicate first day.
select
  FNMFDBD_ID,
  bdd.D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  0 CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE
where
  bdd.D_DATE = BUCKET_START_DATE
  and CREATION_COUNT = 1
)
union all
-- Completion day when not completed on the first day.
select
  FNMFDBD_ID,
  bdd.D_DATE,
  NYHIX_MFD_BI_ID,
  DNMFDDT_ID,
  DNMFDDS_ID,
  DNMFDES_ID,
  DNMFDDST_ID,
  DNMFDFT_ID,
  DNMFDTS_ID,
  DNMFDIS_ID,
  INSTANCE_STATUS_DT,
  DOCUMENT_STATUS_DT,
  ENVELOPE_STATUS_DT,
  SCAN_DT,
  RELEASE_DT,
  JEOPARDY_FLAG,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  SLA_SATISFIED_COUNT
from
  BPM_D_DATES bdd,
  F_NYHIX_MFD_BY_DATE
where
  bdd.D_DATE >= BUCKET_START_DATE
  and bdd.D_DATE = BUCKET_END_DATE
  and CREATION_COUNT = 0
  and COMPLETION_COUNT = 1
with read only;

create or replace public synonym F_NYHIX_MFD_BY_DATE_SV for F_NYHIX_MFD_BY_DATE_SV;
grant select on F_NYHIX_MFD_BY_DATE_SV to MAXDAT_READ_ONLY;