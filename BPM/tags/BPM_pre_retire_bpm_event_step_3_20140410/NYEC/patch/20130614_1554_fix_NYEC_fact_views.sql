create or replace view F_NYEC_IR_BY_DATE_SV as
select
  FNIRBD_ID,
  bdd.D_DATE,
  NYEC_IR_BI_ID,
  DNIRCI_ID,
  "Authorization End Date",
  case
    when dense_rank() over (partition by NYEC_IR_BI_ID order by NYEC_IR_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_IR_BY_DATE fnirbd
where
  bdd.D_DATE >= fnirbd.BUCKET_START_DATE 
  and bdd.D_DATE < fnirbd.BUCKET_END_DATE
union all
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
  F_NYEC_IR_BY_DATE fnirbd
where
  bdd.D_DATE = fnirbd.BUCKET_START_DATE
  and bdd.D_DATE = fnirbd.BUCKET_END_DATE
with read only;

create or replace view F_NYEC_PAMI_BY_DATE_SV as
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  case 
    when dense_rank() over (partition by NYEC_PAMI_BI_ID order by NYEC_PAMI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE fnpamibd
where
  bdd.D_DATE >= fnpamibd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpamibd.BUCKET_END_DATE
union all
select
  FNPAMIBD_ID,
  bdd.D_DATE,
  NYEC_PAMI_BI_ID,
  DNPAMIIS_ID,
  DNPAMIISP_ID,
  DNPAMIRS_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT, 
  "MI Item Status Date", 
  "RFE Status Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PAMI_BY_DATE fnpamibd
where
  bdd.D_DATE = fnpamibd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpamibd.BUCKET_END_DATE
with read only;

create or replace view F_NYEC_PAMI_BY_DATE_SV as
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  case 
    when dense_rank() over (partition by NYEC_PMI_BI_ID order by NYEC_PMI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE fnpmibd
where
  bdd.D_DATE >= fnpmibd.BUCKET_START_DATE 
  and bdd.D_DATE < fnpmibd.BUCKET_END_DATE
union all
select
  FNPMIBD_ID,
  bdd.D_DATE,
  NYEC_PMI_BI_ID,
  DNPMIAI_ID,
  DNPMILS_ID,
  DNPMIIMIT_ID,
  DNPMIPMIT_ID,
  DNPMIQTI_ID,
  DNPMIRR_ID,
  DNPMIRTI_ID,
  DNPMISRTI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from 
  BPM_D_DATES bdd,
  F_NYEC_PMI_BY_DATE fnpmibd
where
  bdd.D_DATE = fnpmibd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpmibd.BUCKET_END_DATE 
with read only;

create or replace view F_NYEC_SR_BY_DATE_SV as
select
  FNSRBD_ID,
  bdd.D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  case 
    when dense_rank() over (partition by NYEC_SR_BI_ID order by NYEC_SR_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SR_BY_DATE fnsrbd
where
  bdd.D_DATE >= fnsrbd.BUCKET_START_DATE
  and bdd.D_DATE < fnsrbd.BUCKET_END_DATE
union all
select
  FNSRBD_ID,
  bdd.D_DATE,
  NYEC_SR_BI_ID,
  DNSRRSF_ID,
  DNSRSAI_ID,
  DNSRHAS_ID,
  DNSRASG_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SR_BY_DATE fnsrbd
where
  bdd.D_DATE = fnsrbd.BUCKET_START_DATE
  and bdd.D_DATE = fnsrbd.BUCKET_END_DATE
with read only;

create or replace view F_NYEC_SITP_BY_DATE_SV as
select
  FNSITPBD_ID,
  bdd.D_DATE,
  NYEC_SITP_BI_ID,
  case 
    when dense_rank() over (partition by NYEC_SITP_BI_ID order by bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE fnsitpbd
where
  bdd.D_DATE >= fnsitpbd.BUCKET_START_DATE
  and bdd.D_DATE < fnsitpbd.BUCKET_END_DATE
union all
select
  FNSITPBD_ID,
  bdd.D_DATE,
  NYEC_SITP_BI_ID,
  CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT
from
  BPM_D_DATES bdd,
  F_NYEC_SITP_BY_DATE fnsitpbd
where
  bdd.D_DATE = fnsitpbd.BUCKET_START_DATE
  and bdd.D_DATE = fnsitpbd.BUCKET_END_DATE
with read only;