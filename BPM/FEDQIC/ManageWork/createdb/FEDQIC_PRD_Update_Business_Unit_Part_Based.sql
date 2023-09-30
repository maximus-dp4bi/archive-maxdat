--update fedqic_maxdat_stg
update maxdat.fedqic_maxdat_stg
set part_id = 
CASE WHEN appeal_part = 'Part A' then 1578
     WHEN appeal_part = 'Part C' then 1579
     WHEN appeal_part = 'Part D-Drug' then 1580
     WHEN appeal_part = 'Part D-LEP' then 1581
     WHEN appeal_part = 'DME' then 9286944
     ELSE part_id
     END;
commit;
--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;
commit;
--update corp_etl_mw
update maxdat.corp_etl_mw
set business_unit_id = 
CASE WHEN part = 'Part A' then 1578
     WHEN part = 'Part C' then 1579
     WHEN part = 'Part D-Drug' then 1580
     WHEN part = 'Part D-LEP' then 1581
     WHEN part = 'DME' then 9286944
     ELSE business_unit_id
     END;
commit;
-reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS; 
commit;     
 --update d_mw_task_instance so that task_type_id = part based combo id
update maxdat.d_mw_task_instance
set curr_business_unit_id = 
CASE WHEN part = 'Part A' then 1578
     WHEN part = 'Part C' then 1579
     WHEN part = 'Part D-Drug' then 1580
     WHEN part = 'Part D-LEP' then 1581
     WHEN part = 'DME' then 9286944
     ELSE curr_business_unit_id
     END;    
 commit;

 --update d_mw_task_history
update maxdat.d_mw_task_history th
set th.business_unit_id = (select ti.curr_business_unit_id from d_mw_task_instance ti where ti.MW_BI_ID = th.MW_BI_ID);
commit;       
   