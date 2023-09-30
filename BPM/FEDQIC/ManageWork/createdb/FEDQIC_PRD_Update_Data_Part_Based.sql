--update fedqic_maxdat_stg so that c_status = part based combo id
update maxdat.fedqic_maxdat_stg
set c_status = 
CASE WHEN appeal_part = 'Part A' then to_number(c_status || 1578)
     WHEN appeal_part = 'Part C' then to_number(c_status || 1579)
     WHEN appeal_part = 'Part D-Drug' then to_number(c_status || 1580)
     WHEN appeal_part = 'Part D-LEP' then to_number(c_status || 1581)
     WHEN appeal_part = 'DME' then to_number(c_status || 9286944)
     ELSE c_status
     END;

--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;

--update corp_etl_mw so that task_type_id = part based combo id
update maxdat.corp_etl_mw
set task_type_id = 
CASE WHEN part = 'Part A' then to_number(task_type_id || 1578)
     WHEN part = 'Part C' then to_number(task_type_id || 1579)
     WHEN part = 'Part D-Drug' then to_number(task_type_id || 1580)
     WHEN part = 'Part D-LEP' then to_number(task_type_id || 1581)
     WHEN part = 'DME' then to_number(task_type_id || 9286944)
     ELSE task_type_id
     END;

     
 --update d_mw_task_instance so that task_type_id = part based combo id
update maxdat.d_mw_task_instance
set task_type_id = 
CASE WHEN part = 'Part A' then to_number(task_type_id || 1578)
     WHEN part = 'Part C' then to_number(task_type_id || 1579)
     WHEN part = 'Part D-Drug' then to_number(task_type_id || 1580)
     WHEN part = 'Part D-LEP' then to_number(task_type_id || 1581)
     WHEN part = 'DME' then to_number(task_type_id || 9286944)
     ELSE task_type_id
     END;    
         
-reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;    

-------------------------------------------------------------------------
--undo

--update fedqic_maxdat_stg so that c_status = part based combo id
update maxdat.fedqic_maxdat_stg
set c_status = 
CASE WHEN appeal_part = 'Part A' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN appeal_part = 'Part C' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN appeal_part = 'Part D-Drug' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN appeal_part = 'Part D-LEP' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 4))
     WHEN appeal_part = 'DME' then to_number(SUBSTR(to_char(c_status), 0, LENGTH(to_char(c_status)) - 7))
     ELSE c_status
     END;

--disable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw DISABLE ALL TRIGGERS;

--update corp_etl_mw
update maxdat.corp_etl_mw
set task_type_id = 
CASE WHEN part = 'Part A' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part C' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part D-Drug' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part D-LEP' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'DME' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 7))
     ELSE task_type_id
     END; part = 'DME' then to_number(task_type_id || 9286944)
     ELSE task_type_id
     END;

     
 --update d_mw_task_instance
update maxdat.d_mw_task_instance
set task_type_id = 
CASE WHEN part = 'Part A' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part C' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part D-Drug' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'Part D-LEP' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 4))
     WHEN part = 'DME' then to_number(SUBSTR(to_char(task_type_id), 0, LENGTH(to_char(task_type_id)) - 7))
     ELSE task_type_id
     END;  
         
-reenable triggers on corp_etl_mw
ALTER TABLE corp_etl_mw ENABLE ALL TRIGGERS;    


