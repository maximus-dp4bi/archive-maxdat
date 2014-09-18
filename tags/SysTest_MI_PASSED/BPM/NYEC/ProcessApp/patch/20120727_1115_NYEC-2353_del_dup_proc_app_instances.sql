-- Delete duplicate NYEC Process App instances.
-- Fixes issue NYEC-2353 on NYECMXDU db.
-- (first loaded duplicate instance deleted)

delete from BPM_INSTANCE_ATTRIBUTE where BI_ID in 
(select bi.BI_ID
from 
  BPM_INSTANCE bi,
  (select 
     bi.IDENTIFIER,
     min(bi.CREATION_DATE) min_creation_date
   from 
     BPM_INSTANCE bi,
     (select IDENTIFIER
      from BPM_INSTANCE
      where BEM_ID = 2
      group by IDENTIFIER
      having count(*) > 1) dupIdentifiers
   where bi.IDENTIFIER = dupIdentifiers.IDENTIFIER
   group by bi.IDENTIFIER) dupInstances
where
  bi.IDENTIFIER = dupInstances.IDENTIFIER 
  and bi.CREATION_DATE = dupInstances.min_creation_date);

commit;
  
delete from BPM_UPDATE_EVENT where BI_ID in 
(select bi.BI_ID
from 
  BPM_INSTANCE bi,
  (select 
     bi.IDENTIFIER,
     min(bi.CREATION_DATE) min_creation_date
   from 
     BPM_INSTANCE bi,
     (select IDENTIFIER
      from BPM_INSTANCE
      where BEM_ID = 2
      group by IDENTIFIER
      having count(*) > 1) dupIdentifiers
   where bi.IDENTIFIER = dupIdentifiers.IDENTIFIER
   group by bi.IDENTIFIER) dupInstances
where
  bi.IDENTIFIER = dupInstances.IDENTIFIER 
  and bi.CREATION_DATE = dupInstances.min_creation_date);

commit;
  
delete from BPM_INSTANCE where BI_ID in 
(select bi.BI_ID
from 
  BPM_INSTANCE bi,
  (select 
     bi.IDENTIFIER,
     min(bi.CREATION_DATE) min_creation_date
   from 
     BPM_INSTANCE bi,
     (select IDENTIFIER
      from BPM_INSTANCE
      where BEM_ID = 2
      group by IDENTIFIER
      having count(*) > 1) dupIdentifiers
   where bi.IDENTIFIER = dupIdentifiers.IDENTIFIER
   group by bi.IDENTIFIER) dupInstances
where
  bi.IDENTIFIER = dupInstances.IDENTIFIER 
  and bi.CREATION_DATE = dupInstances.min_creation_date);

commit;