--Replace fact view 
Create or replace view F_NYHIX_MFD_BY_DATE_SV_V2
as
Select 
d.NYHIX_MFD_BI_ID,
bdd.D_DATE,
CASE WHEN bdd.D_DATE = TRUNC(d.CREATE_DT) THEN 1 else 0 END AS CREATION_COUNT,
CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS INVENTORY_COUNT,
CASE WHEN bdd.D_DATE = TRUNC(d.COMPLETE_DT) THEN 1 else 0 END AS COMPLETION_COUNT,
CASE WHEN bdd.D_DATE = trunc(d.ENV_STATUS_DT)
            AND d.env_status_cd = 'COMPLETEDRELEASED'
            AND d.cancel_dt is null
     THEN 1 
     ELSE 0
END AS SLA_SATISFIED_COUNT
FROM BPM_D_DATES bdd JOIN D_NYHIX_MFD_CURRENT_V2 d on (bdd.D_DATE >= TRUNC(D.INSTANCE_START_DATE) and bdd.D_DATE <= nvl(TRUNC(D.INSTANCE_END_DATE),sysdate));
