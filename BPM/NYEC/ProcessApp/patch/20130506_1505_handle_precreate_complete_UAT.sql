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
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 and INVENTORY_COUNT = 0 then 0
    when dense_rank() over (partition by NYEC_PA_BI_ID order by NYEC_PA_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  INVENTORY_COUNT,
  COMPLETION_COUNT,
  DNPACIN_ID,
  DNPAFPBPST_ID,
  DNPAHIAI_ID,
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
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
  "Invoiceable Date",
  DNPAHCS_ID,
  DNPARI_ID, 
  DNPARR_ID,
  DNPARB_ID,
  DNPARN_ID,
  DNPAMC_ID,
  DNPAML_ID,
  DNPAONF_ID,
  DNPAOLS_ID,
  DNPASAR_ID,
  DNPAWRI_ID,
  DNPAQI_ID,
  "Reactivation Date"
from 
  BPM_D_DATES bdd,
  F_NYEC_PA_BY_DATE fnpabd
where
  bdd.D_DATE = fnpabd.BUCKET_START_DATE 
  and bdd.D_DATE = fnpabd.BUCKET_END_DATE
with read only;

update BPM_UPDATE_EVENT_QUEUE
set PROCESS_BUEQ_ID = null
where 
  BUEQ_ID  in (17067193,17075558)
  and bsl_id = 2
  and PROCESS_BUEQ_ID is not null;
  
commit;
