
-- Deleting from BPM EVENT model --

delete from BPM_ATTRIBUTE_STAGING_TABLE
where ba_id=579;

delete from bpm_instance_attribute
where ba_id=579;

delete from BPM_ATTRIBUTE
where bal_id=465;

delete from BPM_ATTRIBUTE_LKUP
where bal_id=465;

Commit;


-- Deleting from SEMANTIC model --

alter table F_PI_BY_DATE drop (DPIID_ID) ;

drop table D_PI_INCIDENT_DESC ;

drop public synonym D_PI_INCIDENT_DESC ;

drop view D_PI_INCIDENT_DESC_SV;

alter table D_PI_CURRENT drop ("Cur Incident Description") ;

Commit;

-- Recreating views ---

create or replace view D_PI_CURRENT_SV as
select * from D_PI_CURRENT
with read only;

create or replace view F_PI_BY_DATE_SV as
select
         FPIBD_ID,
	 bdd.D_DATE,
	 BUCKET_START_DATE, 
	 BUCKET_END_DATE,
	 PI_BI_ID, 
	 DPIIS_ID,
	 DPIIA_ID,
	 DPIIR_ID,
	-- DPIID_ID,
     DPIISS_ID,
     DPIJS_ID,
     DPIES_ID,
     DPIUB_ID,
     DPITI_ID, 
     INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by PI_BI_ID order by PI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  BPM_D_DATES bdd,
  F_PI_BY_DATE fpibd
where
  bdd.D_DATE >= fpibd.BUCKET_START_DATE 
  and bdd.D_DATE < fpibd.BUCKET_END_DATE
union all
select
     FPIBD_ID,
	 bdd.D_DATE,
	 BUCKET_START_DATE, 
	 BUCKET_END_DATE,
	 PI_BI_ID, 
	 DPIIS_ID,
	 DPIIA_ID,
	 DPIIR_ID,
	-- DPIID_ID,
     DPIISS_ID,
     DPIJS_ID,
     DPIES_ID,
     DPIUB_ID,
     DPITI_ID, 
	 INVENTORY_COUNT,
  case 
    when dense_rank() over (partition by PI_BI_ID order by PI_BI_ID asc, bdd.D_DATE asc) = 1 then 1
    else 0
    end CREATION_COUNT,
  COMPLETION_COUNT, 
  "Incident Status Date",
  "Last Update Date"
from 
  BPM_D_DATES bdd,
  F_PI_BY_DATE fpibd
where
  bdd.D_DATE = fpibd.BUCKET_START_DATE 
  and bdd.D_DATE = fpibd.BUCKET_END_DATE
with read only;

create or replace view INCIDENT_DESC_SV as
select incident_id, incident_description from corp_etl_process_incidents
with read only;
