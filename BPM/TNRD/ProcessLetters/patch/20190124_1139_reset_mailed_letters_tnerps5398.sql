UPDATE corp_etl_proc_letters
SET stage_done_date = null
  ,complete_dt = null
WHERE status IN('Voided','Mailed','Errored')
AND instance_status = 'Active'
AND stage_done_date IS NOT NULL;

UPDATE corp_etl_proc_letters
SET stage_done_date = stg_last_update_date
WHERE instance_status = 'Complete'
AND stage_done_date is  null;

--2/1/19 update other active instances with stage done date populated
update corp_etl_proc_letters
set stage_done_date = null
where  instance_status = 'Active'
and stage_done_date is not null;

--set Voided letters to Complete instance status
--these letters do not have a VOID status history record in ATS that is why the Process Letters ETL cannot complete them
BEGIN
FOR x IN(select letter_request_id, COALESCE(s.letter_update_ts,status_dt) letter_update_ts,COALESCE(s.letter_updated_by,'TNERPS-5398') letter_updated_by
         from corp_etl_proc_letters l
           join letters_stg s ON l.letter_request_id = s.letter_id           
          where status = 'Voided'
          and instance_status = 'Active') LOOP          
  UPDATE corp_etl_proc_letters
  SET cancel_dt = x.letter_update_ts
      ,cancel_by = x.letter_updated_by 
      ,status_dt = x.letter_update_ts
      ,complete_dt = x.letter_update_ts
      ,instance_status = 'Complete'
      ,stage_done_date = sysdate
  WHERE letter_request_id = x.letter_request_id    ;
END LOOP;
END;
/


COMMIT;