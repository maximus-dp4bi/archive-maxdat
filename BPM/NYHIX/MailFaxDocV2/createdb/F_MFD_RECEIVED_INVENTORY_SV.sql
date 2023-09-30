-- NYHIX-35000
-- Drop semantic view
declare  c int;
begin
    select count(*) into c from user_views where view_name ='F_MFD_RECEIVED_INVENTORY_SV';
    if c = 1 then
       execute immediate 'drop view MAXDAT.F_MFD_RECEIVED_INVENTORY_SV cascade constraints';
    end if;
end;
/

Create or replace view MAXDAT.F_MFD_RECEIVED_INVENTORY_SV as
SELECT d.nyhix_mfd_bi_id,
       bdd.d_date,
       CASE WHEN (bdd.D_DATE != TRUNC(d.COMPLETE_DT) OR d.COMPLETE_DT is NULL) THEN 1 ELSE 0 END AS received_inventory
FROM   maxdat.BPM_D_DATES bdd 
       JOIN maxdat.D_NYHIX_MFD_CURRENT_V2 d
          on (bdd.D_DATE >= TRUNC(D.Received_Dt) 
          and bdd.D_DATE <= nvl(TRUNC(coalesce(d.COMPLETE_DT,d.cancel_dt)),sysdate))
with read only;

Grant select on MAXDAT.F_MFD_RECEIVED_INVENTORY_SV to MAXDAT_READ_ONLY;
