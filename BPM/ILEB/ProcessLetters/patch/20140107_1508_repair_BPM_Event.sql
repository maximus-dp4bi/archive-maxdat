Prompt Creating table BPM_INSTANCE_CLEANUP

Insert into BPM_INSTANCE_CLEANUP 
( BI_ID,  BEM_ID,  BSL_ID,  BIL_ID,  IDENTIFIER,  SOURCE_ID,  START_DATE,  END_DATE,  CREATION_DATE,  LAST_UPDATE_DATE ,  DATACORRECTION_DATE , PROCESSED_FLAG )
select bi_id, bem_id, bsl_id , bil_id, identifier, source_id, start_date, end_date, creation_date, last_update_date, sysdate DataCorrection_date , 'N' Processed_flag
  from bpm_instance i
 where BSL_ID IN (12)
   and exists ( select 1 from  bpm_update_event_queue q
               where q.old_data is null
                 and q.bsl_id = i.bsl_id
                 and q.bil_id = i.bil_id
                 and q.identifier = i.identifier
                 and trunc(q.event_date) != trunc(sysdate)
               );
        

        
DECLARE
 v_step varchar2(100) := 'Start';
 v_num number := 0;                
BEGIN

For instance_rec in ( Select bi_id, bem_id, bsl_id , bil_id, identifier from BPM_INSTANCE_CLEANUP Where Processed_flag = 'N')
Loop

BEGIN

v_step := 'Delete Attributes';
delete from bpm_instance_attribute where bi_id = instance_rec.bi_id ;

v_step := 'Update Event Queue';
update BPM_UPDATE_EVENT_QUEUE
   set PROCESS_BUEQ_ID = null
       ,BUE_ID = null
       ,wrote_bpm_event_date = null
where BSL_ID = instance_rec.bsl_id
  and BIL_ID = instance_rec.bil_id 
  and IDENTIFIER = instance_rec.identifier ;

v_step := 'Delete events';
delete from bpm_update_event where bi_id = instance_rec.bi_id ;

v_step := 'Delete Instance';
delete from bpm_instance where bi_id = instance_rec.bi_id ;

v_step := 'Update Cleanup record';
update BPM_INSTANCE_CLEANUP set Processed_flag = 'Y' where bi_id = instance_rec.bi_id ;
commit;

Exception 
 when others then
   dbms_output.put_line('ERROR: ' || SqlErrM || ' For Instance : '|| instance_rec.bi_id || ' - ' ||v_step);
   rollback;
END;

End Loop;
END;   

/