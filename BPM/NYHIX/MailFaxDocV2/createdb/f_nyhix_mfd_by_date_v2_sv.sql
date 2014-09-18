--Semantic views Fact NYHIX MFD

Create or replace view F_NYHIX_MFD_BY_DATE_V2_SV
as
Select 
d.NYHIX_MFD_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT,
CASE WHEN bdd.D_DATE = trunc(d.ENV_STATUS_DT)
            AND d.env_status = 'COMPLETEDRELEASED'
            AND d.cancel_dt is null
     THEN 1 
     ELSE 0
END AS SLA_SATISFIED_COUNT
FROM BPM_D_DATES bdd JOIN D_NYHIX_MFD_CURRENT_V2 d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));

--Semantic view History

create or replace view D_NYHIX_MFD_HISTORY_V2_SV
as
SELECT
  h.DMFDBD_ID,
  bdd.D_DATE,
  h.NYHIX_MFD_BI_ID,
  h.DNMFDDT_ID,
  h.DNMFDDS_ID,
  h.DNMFDES_ID,
  h.DNMFDFT_ID,
  h.DNMFDTS_ID,
  h.DNMFDIS_ID,
  h.DOC_STATUS_DT,
  h.ENV_STATUS_DT,
  h.AGE_IN_BUSINESS_DAYS,
  h.AGE_IN_CALENDAR_DAYS
FROM D_NYHIX_MFD_HISTORY_V2 h JOIN BPM_D_DATES bdd on (bdd.D_DATE >= h.BUCKET_START_DATE AND bdd.D_DATE <= h.BUCKET_END_DATE);

--Semantic view current


Create or replace view D_NYHIX_MFD_CURRENT_V2_SV
As
Select * from D_NYHIX_MFD_CURRENT_V2;
